package com.management.aspectj;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.management.annotation.Log;
import com.management.entity.TLog;
import com.management.service.ITLogService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@Aspect
@Component
@RequiredArgsConstructor
public class LogAspect {

    private final ITLogService tLogService;
    private final ObjectMapper objectMapper;

    @AfterReturning(pointcut = "@annotation(controllerLog)", returning = "jsonResult")
    public void doAfterReturning(JoinPoint joinPoint, Log controllerLog, Object jsonResult) {
        handleLog(joinPoint, controllerLog, null, jsonResult);
    }

    @AfterThrowing(pointcut = "@annotation(controllerLog)", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Log controllerLog, Exception e) {
        handleLog(joinPoint, controllerLog, e, null);
    }

    private void handleLog(JoinPoint joinPoint, Log controllerLog, Exception e, Object jsonResult) {
        try {
            TLog tLog = new TLog();
            tLog.setId(UUID.randomUUID().toString().replace("-", ""));
            tLog.setLogType(controllerLog.businessType());
            tLog.setCreateTime(LocalDateTime.now());
            tLog.setIsError(e == null ? 0 : 1);

            StringBuilder content = new StringBuilder();
            content.append("[").append(controllerLog.module()).append("] ");
            content.append(controllerLog.description());

            if (e != null) {
                content.append(" 失败: ").append(e.getMessage());
            } else {
                content.append(" 成功");
            }

            tLog.setLogContent(content.toString());

            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attributes != null) {
                HttpServletRequest request = attributes.getRequest();
                tLog.setClientIp(getIpAddress(request));
            }

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                tLog.setAccountNumber(authentication.getName());
                tLog.setRealname(authentication.getName());
            }

            tLogService.save(tLog);
        } catch (Exception ex) {
            log.error("记录操作日志失败", ex);
        }
    }

    private String getIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
