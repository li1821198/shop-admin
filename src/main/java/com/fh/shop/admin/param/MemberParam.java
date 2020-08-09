package com.fh.shop.admin.param;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class MemberParam extends Page{
    private String memberName;

    private String realName;


    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

   private Long shengId;

   private Long shiId;

   private Long xianId;
}
