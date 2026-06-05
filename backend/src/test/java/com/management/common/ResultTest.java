package com.management.common;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("Result 单元测试")
class ResultTest {

    @Test
    @DisplayName("success() 无参返回 code=200")
    void success_WithNoData_ShouldReturnCode200() {
        Result<Void> result = Result.success();

        assertThat(result.getCode()).isEqualTo(200);
        assertThat(result.getMsg()).isEqualTo("操作成功");
        assertThat(result.getData()).isNull();
    }

    @Test
    @DisplayName("success(data) 返回 code=200 并携带数据")
    void success_WithData_ShouldReturnCode200AndData() {
        String data = "test-data";

        Result<String> result = Result.success(data);

        assertThat(result.getCode()).isEqualTo(200);
        assertThat(result.getMsg()).isEqualTo("操作成功");
        assertThat(result.getData()).isEqualTo(data);
    }

    @Test
    @DisplayName("success(null) 返回 code=200 data=null")
    void success_WithNullData_ShouldReturnCode200AndNullData() {
        Result<Object> result = Result.success(null);

        assertThat(result.getCode()).isEqualTo(200);
        assertThat(result.getData()).isNull();
    }

    @Test
    @DisplayName("error(msg) 返回默认 code=500")
    void error_WithMessage_ShouldReturnCode500() {
        Result<Void> result = Result.error("错误信息");

        assertThat(result.getCode()).isEqualTo(500);
        assertThat(result.getMsg()).isEqualTo("错误信息");
        assertThat(result.getData()).isNull();
    }

    @Test
    @DisplayName("error(code, msg) 返回自定义 code")
    void error_WithCodeAndMessage_ShouldReturnCustomCode() {
        Result<Void> result = Result.error(401, "未授权");

        assertThat(result.getCode()).isEqualTo(401);
        assertThat(result.getMsg()).isEqualTo("未授权");
        assertThat(result.getData()).isNull();
    }

    @Test
    @DisplayName("success 带对象数据")
    void success_WithObject_ShouldPreserveObject() {
        PageResult<String> pageResult = new PageResult<>(100L, java.util.List.of("a", "b"));

        Result<PageResult<String>> result = Result.success(pageResult);

        assertThat(result.getCode()).isEqualTo(200);
        assertThat(result.getData().getTotal()).isEqualTo(100L);
        assertThat(result.getData().getRows()).hasSize(2);
    }

    @Test
    @DisplayName("error 空消息")
    void error_WithEmptyMessage_ShouldReturnNullMsg() {
        Result<Void> result = Result.error("");

        assertThat(result.getCode()).isEqualTo(500);
        assertThat(result.getMsg()).isEmpty();
    }
}
