package com.management.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Component
public class JwtTokenProvider {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private long expiration;

    @Value("${jwt.refresh-expiration:604800000}")
    private long refreshExpiration;

    private final RedisTemplate<String, Object> redisTemplate;

    public JwtTokenProvider(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    public String createAccessToken(String userId, String username, Map<String, Object> claims) {
        return buildToken(userId, username, claims, expiration);
    }

    public String createRefreshToken(String userId, String username) {
        String refreshToken = buildToken(userId, username, null, refreshExpiration);
        redisTemplate.opsForValue().set("refresh_token:" + userId, refreshToken,
                refreshExpiration, TimeUnit.MILLISECONDS);
        return refreshToken;
    }

    private String buildToken(String userId, String username, Map<String, Object> claims, long expiryMs) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + expiryMs);

        Map<String, Object> tokenClaims = new HashMap<>();
        tokenClaims.put("userId", userId);
        tokenClaims.put("username", username);
        tokenClaims.put("jti", UUID.randomUUID().toString());
        if (claims != null) {
            tokenClaims.putAll(claims);
        }

        return Jwts.builder()
                .claims(tokenClaims)
                .subject(username)
                .issuedAt(now)
                .expiration(expiryDate)
                .signWith(getSigningKey())
                .compact();
    }

    public Claims parseToken(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public String getUsernameFromToken(String token) {
        return parseToken(token).getSubject();
    }

    public String getUserIdFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("userId", String.class);
    }

    public String getJtiFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.get("jti", String.class);
    }

    public boolean isTokenExpired(String token) {
        try {
            Claims claims = parseToken(token);
            return claims.getExpiration().before(new Date());
        } catch (Exception e) {
            return true;
        }
    }

    public boolean isTokenBlacklisted(String token) {
        try {
            String jti = getJtiFromToken(token);
            return Boolean.TRUE.equals(redisTemplate.hasKey("token_blacklist:" + jti));
        } catch (Exception e) {
            return true;
        }
    }

    public void blacklistToken(String token) {
        try {
            String jti = getJtiFromToken(token);
            Claims claims = parseToken(token);
            long remainingMs = claims.getExpiration().getTime() - System.currentTimeMillis();
            if (remainingMs > 0) {
                redisTemplate.opsForValue().set("token_blacklist:" + jti, "1",
                        remainingMs, TimeUnit.MILLISECONDS);
            }
        } catch (Exception ignored) {
        }
    }

    public boolean validateRefreshToken(String userId, String refreshToken) {
        String storedToken = (String) redisTemplate.opsForValue().get("refresh_token:" + userId);
        return storedToken != null && storedToken.equals(refreshToken) && !isTokenExpired(refreshToken);
    }

    public void revokeRefreshToken(String userId) {
        redisTemplate.delete("refresh_token:" + userId);
    }

    public boolean validateToken(String token) {
        try {
            parseToken(token);
            return !isTokenBlacklisted(token);
        } catch (Exception e) {
            return false;
        }
    }
}