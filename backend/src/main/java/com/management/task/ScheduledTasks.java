package com.management.task;

import com.management.service.ISysLoginLogService;
import com.management.service.ITLogService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Set;

@Slf4j
@Component
@EnableScheduling
@RequiredArgsConstructor
public class ScheduledTasks {

    private final RedisTemplate<String, Object> redisTemplate;
    private final ITLogService tLogService;
    private final ISysLoginLogService loginLogService;

    /**
     * 每天凌晨2点清理过期Redis key
     */
    @Scheduled(cron = "0 0 2 * * ?")
    public void cleanExpiredRedisKeys() {
        log.info("开始清理过期Redis key");
        try {
            Set<String> keys = redisTemplate.keys("*");
            if (keys != null) {
                for (String key : keys) {
                    Long ttl = redisTemplate.getExpire(key);
                    if (ttl != null && ttl <= 0) {
                        redisTemplate.delete(key);
                    }
                }
            }
            log.info("过期Redis key清理完成");
        } catch (Exception e) {
            log.error("清理过期Redis key失败", e);
        }
    }

    /**
     * 每天凌晨3点清理30天前的操作日志
     */
    @Scheduled(cron = "0 0 3 * * ?")
    public void cleanOldOperLogs() {
        log.info("开始清理过期操作日志");
        try {
            tLogService.cleanOperLogs();
            loginLogService.cleanLoginLogs();
            log.info("过期操作日志清理完成");
        } catch (Exception e) {
            log.error("清理过期操作日志失败", e);
        }
    }
}
