package com.management.exception;

import com.management.common.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e) {
        log.error("业务异常: {}", e.getMessage());
        return Result.error(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(BadCredentialsException.class)
    public Result<Void> handleBadCredentialsException(BadCredentialsException e) {
        log.error("认证失败: {}", e.getMessage());
        return Result.error(401, "用户名或密码错误");
    }

    @ExceptionHandler(AccessDeniedException.class)
    public Result<Void> handleAccessDeniedException(AccessDeniedException e) {
        log.error("权限不足: {}", e.getMessage());
        return Result.error(403, "权限不足");
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getFieldError() != null ? 
            e.getBindingResult().getFieldError().getDefaultMessage() : "参数校验失败";
        log.error("参数校验失败: {}", message);
        return Result.error(message);
    }

    @ExceptionHandler(BindException.class)
    public Result<Void> handleBindException(BindException e) {
        String message = e.getFieldError() != null ? 
            e.getFieldError().getDefaultMessage() : "参数绑定失败";
        log.error("参数绑定失败: {}", message);
        return Result.error(message);
    }

    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public Result<Void> handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
        log.error("请求方式不支持: {}", e.getMessage());
        return Result.error("请求方式不支持");
    }

    @ExceptionHandler(Exception.class)
    public Result<Void> handleException(Exception e) {
        log.error("系统异常: ", e);
        return Result.error("系统内部错误");
    }
}
