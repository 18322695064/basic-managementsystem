package com.management.common;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class PageResult<T> implements Serializable {

    private Long total;
    private List<T> rows;

    public PageResult(Long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }
}
