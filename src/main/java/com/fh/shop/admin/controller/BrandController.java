package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.brand.IBrandService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Brand;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("brand")
public class BrandController {
    @Resource(name="brandService")
    private IBrandService brandService;

    @RequestMapping("findList")
    @ResponseBody
    public ServerResponse findList(){
        List<Brand> list = brandService.findList();
        return ServerResponse.success(list);
    }
}
