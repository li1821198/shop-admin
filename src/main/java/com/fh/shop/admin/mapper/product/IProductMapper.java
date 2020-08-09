package com.fh.shop.admin.mapper.product;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.ProductParam;
import com.fh.shop.admin.po.Product;

import java.util.List;

public interface IProductMapper extends BaseMapper<Product> {

    Long findCount(ProductParam productParam);

    List<Product> findPageList(ProductParam productParam);

    Product findById(Long id);
}
