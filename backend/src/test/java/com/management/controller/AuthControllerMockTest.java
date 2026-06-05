package com.management.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.management.common.Result;
import com.management.entity.SysUser;
import com.management.security.JwtTokenProvider;
import com.management.security.UserDetailsServiceImpl;
import com.management.service.ISysLoginLogService;
import com.management.service.ISysMenuService;
import com.management.service.ISysUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@DisplayName("AuthController MockMvc 测试")
class AuthControllerMockTest {

    private MockMvc mockMvc;
    private final ObjectMapper objectMapper = new ObjectMapper();

    private AuthenticationManager authenticationManager;
    private JwtTokenProvider jwtTokenProvider;
    private ISysUserService userService;
    private ISysLoginLogService loginLogService;
    private PasswordEncoder passwordEncoder;
    private RedisTemplate<String, Object> redisTemplate;
    private ValueOperations<String, Object> valueOperations;
    private UserDetailsServiceImpl userDetailsService;
    private ISysMenuService menuService;

    private SysUser testUser;

    @BeforeEach
    @SuppressWarnings("unchecked")
    void setUp() {
        authenticationManager = mock(AuthenticationManager.class);
        jwtTokenProvider = mock(JwtTokenProvider.class);
        userService = mock(ISysUserService.class);
        loginLogService = mock(ISysLoginLogService.class);
        passwordEncoder = mock(PasswordEncoder.class);
        redisTemplate = mock(RedisTemplate.class);
        valueOperations = mock(ValueOperations.class);
        userDetailsService = mock(UserDetailsServiceImpl.class);
        menuService = mock(ISysMenuService.class);

        when(redisTemplate.opsForValue()).thenReturn(valueOperations);

        AuthController controller = new AuthController(
                authenticationManager, jwtTokenProvider, userService,
                loginLogService, passwordEncoder, redisTemplate,
                userDetailsService, menuService);

        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();

        testUser = new SysUser();
        testUser.setId("u-001");
        testUser.setAccountNumber("admin");
        testUser.setNickName("管理员");
        testUser.setPassword("encoded-pass");
        testUser.setActivateStatus("1");
        testUser.setEmail("admin@test.com");
        testUser.setAddTime(LocalDateTime.now());
    }

    @Nested
    @DisplayName("验证码")
    class CaptchaTests {

        @Test
        @DisplayName("获取验证码 - 返回 uuid 和 base64 图片")
        void captchaImage_ShouldReturnUuidAndImage() throws Exception {
            mockMvc.perform(get("/auth/captchaImage"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200))
                    .andExpect(jsonPath("$.data.uuid").isNotEmpty())
                    .andExpect(jsonPath("$.data.img").isString());

            verify(valueOperations).set(startsWith("captcha:"), anyString(), eq(2L), eq(TimeUnit.MINUTES));
        }
    }

    @Nested
    @DisplayName("登录")
    class LoginTests {

        @Test
        @DisplayName("登录成功 - 返回 token")
        void login_ShouldReturnToken_WhenSuccess() throws Exception {
            Authentication auth = mock(Authentication.class);
            when(auth.getName()).thenReturn("admin");
            when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class)))
                    .thenReturn(auth);
            when(userService.selectUserByAccountNumber("admin")).thenReturn(testUser);
            when(valueOperations.get(contains("captcha:"))).thenReturn("ABCD");
            when(jwtTokenProvider.createAccessToken(eq("u-001"), eq("admin"), anyMap()))
                    .thenReturn("access-token-123");
            when(jwtTokenProvider.createRefreshToken("u-001", "admin"))
                    .thenReturn("refresh-token-123");

            String body = objectMapper.writeValueAsString(Map.of(
                    "username", "admin",
                    "password", "pass123",
                    "code", "ABCD",
                    "uuid", "test-uuid"
            ));

            mockMvc.perform(post("/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.code").value(200))
                    .andExpect(jsonPath("$.data.token").value("access-token-123"))
                    .andExpect(jsonPath("$.data.refreshToken").value("refresh-token-123"));

            verify(loginLogService).save(any());
        }

        @Test
        @DisplayName("登录失败 - 用户名或密码错误")
        void login_ShouldReturnError_WhenBadCredentials() throws Exception {
            when(valueOperations.get(contains("captcha:"))).thenReturn("ABCD");
            when(authenticationManager.authenticate(any()))
                    .thenThrow(new BadCredentialsException("Bad credentials"));
            when(userService.selectUserByAccountNumber("admin")).thenReturn(testUser);
            when(valueOperations.increment(anyString())).thenReturn(1L);
            when(redisTemplate.expire(anyString(), anyLong(), any())).thenReturn(true);

            String body = objectMapper.writeValueAsString(Map.of(
                    "username", "admin",
                    "password", "wrong",
                    "code", "ABCD",
                    "uuid", "test-uuid"
            ));

            mockMvc.perform(post("/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.msg").value("用户名或密码错误"));
        }

        @Test
        @DisplayName("登录失败 - 验证码错误")
        void login_ShouldReturnError_WhenWrongCaptcha() throws Exception {
            when(valueOperations.get(contains("captcha:"))).thenReturn("XYZW");

            String body = objectMapper.writeValueAsString(Map.of(
                    "username", "admin",
                    "password", "pass123",
                    "code", "ABCD",
                    "uuid", "test-uuid"
            ));

            mockMvc.perform(post("/auth/login")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.msg").value("验证码错误或已过期"));
        }
    }
}
