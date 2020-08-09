package com.fh.shop.admin.param;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class ProductParam extends Page{

    private String productName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    private BigDecimal minPrice;

    private BigDecimal maxPrice;

    private Long brandId;
}
