package com.management.annotation;

import java.lang.annotation.*;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimit {
    /**
     * 限流时间窗口（秒）
     */
    int time() default 60;

    /**
     * 时间窗口内允许的请求次数
     */
    int count() default 10;

    /**
     * 限流提示信息
     */
    String message() default "请求过于频繁，请稍后再试";
}