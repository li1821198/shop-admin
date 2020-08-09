package com.fh.shop.admin.biz.product;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.ProductParam;
import com.fh.shop.admin.po.Product;

public interface IProductService {
    DataTableResult findList(ProductParam productParam);

    void addProduct(Product product);

    void updateProduct(Product product);


    void deleteProduct(Long id);

    ServerResponse findById(Long id);

    Product findBProductyId(Long id);

    void updateIsHotStatus(Long id, int status);

    void updatesStatus(Long id, int status);


}
