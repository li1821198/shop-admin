package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Brand;

import java.util.List;

public interface IBrandService {
    List<Brand> findList();
}
