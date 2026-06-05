package com.management.controller;

import com.management.common.Result;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.RuntimeMXBean;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/monitor")
@RequiredArgsConstructor
public class MonitorController {

    private final RedisTemplate<String, Object> redisTemplate;

    @PreAuthorize("@ss.hasPermi('system:monitor:server')")
    @GetMapping("/server")
    public Result<Map<String, Object>> serverInfo() {
        Map<String, Object> result = new HashMap<>();

        OperatingSystemMXBean osBean = ManagementFactory.getOperatingSystemMXBean();
        Map<String, Object> os = new HashMap<>();
        os.put("name", osBean.getName());
        os.put("arch", osBean.getArch());
        os.put("version", osBean.getVersion());
        os.put("availableProcessors", osBean.getAvailableProcessors());
        if (osBean instanceof com.sun.management.OperatingSystemMXBean sunOsBean) {
            os.put("systemLoadAverage", String.format("%.2f", sunOsBean.getSystemLoadAverage() * 100));
            os.put("totalPhysicalMemory", formatBytes(sunOsBean.getTotalPhysicalMemorySize()));
            os.put("freePhysicalMemory", formatBytes(sunOsBean.getFreePhysicalMemorySize()));
            os.put("usedPhysicalMemory", formatBytes(sunOsBean.getTotalPhysicalMemorySize() - sunOsBean.getFreePhysicalMemorySize()));
        }
        result.put("os", os);

        Runtime runtime = Runtime.getRuntime();
        Map<String, Object> jvm = new HashMap<>();
        MemoryMXBean memoryBean = ManagementFactory.getMemoryMXBean();
        jvm.put("maxMemory", formatBytes(runtime.maxMemory()));
        jvm.put("totalMemory", formatBytes(runtime.totalMemory()));
        jvm.put("freeMemory", formatBytes(runtime.freeMemory()));
        jvm.put("usedMemory", formatBytes(runtime.totalMemory() - runtime.freeMemory()));
        jvm.put("heapInit", formatBytes(memoryBean.getHeapMemoryUsage().getInit()));
        jvm.put("heapUsed", formatBytes(memoryBean.getHeapMemoryUsage().getUsed()));
        jvm.put("heapMax", formatBytes(memoryBean.getHeapMemoryUsage().getMax()));
        jvm.put("nonHeapInit", formatBytes(memoryBean.getNonHeapMemoryUsage().getInit()));
        jvm.put("nonHeapUsed", formatBytes(memoryBean.getNonHeapMemoryUsage().getUsed()));
        result.put("jvm", jvm);

        RuntimeMXBean runtimeBean = ManagementFactory.getRuntimeMXBean();
        Map<String, Object> jvmInfo = new HashMap<>();
        jvmInfo.put("name", runtimeBean.getVmName());
        jvmInfo.put("version", runtimeBean.getVmVersion());
        jvmInfo.put("startTime", runtimeBean.getStartTime());
        jvmInfo.put("uptime", runtimeBean.getUptime());
        jvmInfo.put("inputArguments", runtimeBean.getInputArguments());
        result.put("jvmInfo", jvmInfo);

        File[] roots = File.listRoots();
        Map<String, Object> disk = new HashMap<>();
        for (File root : roots) {
            Map<String, Object> diskInfo = new HashMap<>();
            diskInfo.put("total", formatBytes(root.getTotalSpace()));
            diskInfo.put("free", formatBytes(root.getFreeSpace()));
            diskInfo.put("used", formatBytes(root.getTotalSpace() - root.getFreeSpace()));
            disk.put(root.getPath(), diskInfo);
        }
        result.put("disk", disk);

        return Result.success(result);
    }

    @PreAuthorize("@ss.hasPermi('system:monitor:cache')")
    @GetMapping("/cache")
    public Result<Map<String, Object>> cacheInfo() {
        Map<String, Object> result = new HashMap<>();
        Set<String> keys = redisTemplate.keys("*");
        result.put("totalKeys", keys != null ? keys.size() : 0);
        result.put("onlineUsers", keys != null ? keys.stream().filter(k -> k.startsWith("token:")).count() : 0);
        result.put("blacklistedTokens", keys != null ? keys.stream().filter(k -> k.startsWith("token_blacklist:")).count() : 0);
        return Result.success(result);
    }

    private String formatBytes(long bytes) {
        if (bytes < 1024) return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(1024));
        String pre = "KMGTPE".charAt(exp - 1) + "";
        return String.format("%.1f %sB", bytes / Math.pow(1024, exp), pre);
    }
}