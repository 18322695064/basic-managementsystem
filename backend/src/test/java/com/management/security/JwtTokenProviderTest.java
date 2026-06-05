package com.management.security;

import io.jsonwebtoken.Claims;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("JwtTokenProvider 单元测试")
class JwtTokenProviderTest {

    @Mock
    private RedisTemplate<String, Object> redisTemplate;

    @Mock
    private ValueOperations<String, Object> valueOperations;

    @InjectMocks
    private JwtTokenProvider jwtTokenProvider;

    private static final String TEST_SECRET = "ThisIsATestSecretKeyForJWTTokenGenerationMustBeLongEnough256Bits!!";
    private static final String USER_ID = "test-user-123";
    private static final String USERNAME = "admin";

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(jwtTokenProvider, "secret", TEST_SECRET);
        ReflectionTestUtils.setField(jwtTokenProvider, "expiration", 7200000L);
        ReflectionTestUtils.setField(jwtTokenProvider, "refreshExpiration", 604800000L);
        when(redisTemplate.opsForValue()).thenReturn(valueOperations);
    }

    @Test
    @DisplayName("创建 AccessToken 并成功解析")
    void createAccessToken_ShouldReturnValidToken() {
        Map<String, Object> claims = new HashMap<>();
        claims.put("role", "admin");

        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, claims);

        assertThat(token).isNotNull().isNotEmpty();
        Claims parsed = jwtTokenProvider.parseToken(token);
        assertThat(parsed.getSubject()).isEqualTo(USERNAME);
        assertThat(parsed.get("userId", String.class)).isEqualTo(USER_ID);
        assertThat(parsed.get("role", String.class)).isEqualTo("admin");
    }

    @Test
    @DisplayName("解析 Token 获取用户名")
    void getUsernameFromToken_ShouldReturnCorrectUsername() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        assertThat(jwtTokenProvider.getUsernameFromToken(token)).isEqualTo(USERNAME);
    }

    @Test
    @DisplayName("解析 Token 获取用户ID")
    void getUserIdFromToken_ShouldReturnCorrectUserId() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        assertThat(jwtTokenProvider.getUserIdFromToken(token)).isEqualTo(USER_ID);
    }

    @Test
    @DisplayName("解析 Token 获取 JTI")
    void getJtiFromToken_ShouldReturnNonNullJti() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        assertThat(jwtTokenProvider.getJtiFromToken(token)).isNotNull().isNotEmpty();
    }

    @Test
    @DisplayName("有效 Token 未过期")
    void isTokenExpired_ShouldReturnFalse_ForValidToken() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        assertThat(jwtTokenProvider.isTokenExpired(token)).isFalse();
    }

    @Test
    @DisplayName("过期 Token 返回 true")
    void isTokenExpired_ShouldReturnTrue_ForExpiredToken() {
        ReflectionTestUtils.setField(jwtTokenProvider, "expiration", -1000L);
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        assertThat(jwtTokenProvider.isTokenExpired(token)).isTrue();
    }

    @Test
    @DisplayName("无效 Token 解析异常应返回 true")
    void isTokenExpired_ShouldReturnTrue_ForInvalidToken() {
        assertThat(jwtTokenProvider.isTokenExpired("invalid-token")).isTrue();
    }

    @Test
    @DisplayName("验证有效 Token 返回 true")
    void validateToken_ShouldReturnTrue_ForValidToken() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        when(redisTemplate.hasKey(anyString())).thenReturn(false);

        assertThat(jwtTokenProvider.validateToken(token)).isTrue();
    }

    @Test
    @DisplayName("验证黑名单 Token 返回 false")
    void validateToken_ShouldReturnFalse_ForBlacklistedToken() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        when(redisTemplate.hasKey(anyString())).thenReturn(true);

        assertThat(jwtTokenProvider.validateToken(token)).isFalse();
    }

    @Test
    @DisplayName("验证格式错误 Token 返回 false")
    void validateToken_ShouldReturnFalse_ForMalformedToken() {
        assertThat(jwtTokenProvider.validateToken("not-a-jwt")).isFalse();
    }

    @Test
    @DisplayName("Token 加入黑名单")
    void blacklistToken_ShouldStoreInRedis() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        jwtTokenProvider.blacklistToken(token);
        verify(valueOperations).set(anyString(), eq("1"), anyLong(), eq(TimeUnit.MILLISECONDS));
    }

    @Test
    @DisplayName("创建 RefreshToken 并存入 Redis")
    void createRefreshToken_ShouldStoreInRedis() {
        String refreshToken = jwtTokenProvider.createRefreshToken(USER_ID, USERNAME);
        assertThat(refreshToken).isNotNull().isNotEmpty();
        verify(valueOperations).set(
                eq("refresh_token:" + USER_ID), eq(refreshToken), anyLong(), eq(TimeUnit.MILLISECONDS));
    }

    @Test
    @DisplayName("验证有效 RefreshToken 返回 true")
    void validateRefreshToken_ShouldReturnTrue_ForMatchingToken() {
        String refreshToken = jwtTokenProvider.createRefreshToken(USER_ID, USERNAME);
        when(valueOperations.get("refresh_token:" + USER_ID)).thenReturn(refreshToken);

        assertThat(jwtTokenProvider.validateRefreshToken(USER_ID, refreshToken)).isTrue();
    }

    @Test
    @DisplayName("验证不匹配 RefreshToken 返回 false")
    void validateRefreshToken_ShouldReturnFalse_ForMismatchedToken() {
        when(valueOperations.get("refresh_token:" + USER_ID)).thenReturn("different-token");
        assertThat(jwtTokenProvider.validateRefreshToken(USER_ID, "some-other-token")).isFalse();
    }

    @Test
    @DisplayName("撤销 RefreshToken 应从 Redis 删除")
    void revokeRefreshToken_ShouldDeleteFromRedis() {
        jwtTokenProvider.revokeRefreshToken(USER_ID);
        verify(redisTemplate).delete("refresh_token:" + USER_ID);
    }

    @Test
    @DisplayName("AccessToken 与 RefreshToken 应为不同 Token")
    void accessTokenAndRefreshToken_ShouldBeDifferent() {
        String accessToken = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        String refreshToken = jwtTokenProvider.createRefreshToken(USER_ID, USERNAME);
        assertThat(accessToken).isNotEqualTo(refreshToken);
    }

    @Test
    @DisplayName("黑名单 Token 验证应检测 hasKey")
    void isTokenBlacklisted_ShouldCallRedisHasKey() {
        String token = jwtTokenProvider.createAccessToken(USER_ID, USERNAME, null);
        when(redisTemplate.hasKey(anyString())).thenReturn(true);
        assertThat(jwtTokenProvider.isTokenBlacklisted(token)).isTrue();
    }
}
