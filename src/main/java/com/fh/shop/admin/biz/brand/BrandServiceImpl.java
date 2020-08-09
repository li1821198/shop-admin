package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.controller.BrandController;
import com.fh.shop.admin.mapper.brand.IBrandMapper;
import com.fh.shop.admin.po.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements IBrandService{

    @Autowired
    private IBrandMapper brandMapper;


    @Override
    public List<Brand> findList() {
        List<Brand> brandControllers = brandMapper.selectList(null);
        return brandControllers;
    }
}
