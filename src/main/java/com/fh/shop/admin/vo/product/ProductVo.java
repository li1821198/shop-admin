package com.fh.shop.admin.vo.product;

import lombok.Data;

import java.io.Serializable;

@Data
public class ProductVo implements Serializable {

    private Long id;

    private String productName;

    private String price;

    private String brandName;

    private String insertDate;

    private String updateDate;

    private String createDate;

    private String image;

    private Integer isHot;

    private Integer status;

      private Long stock;
    private Long brandId;


    }
