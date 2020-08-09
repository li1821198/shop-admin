package com.fh.shop.admin.biz.product;

import com.fh.shop.admin.common.DateUtil;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.product.IProductMapper;
import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.ProductParam;
import com.fh.shop.admin.po.Product;
import com.fh.shop.admin.util.AliyunOSSUtil;
import com.fh.shop.admin.vo.product.ProductVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("productService")
public class ProductServiceImpl implements IProductService{

    @Autowired
    private IProductMapper productMapper;

    @Override
    public DataTableResult findList(ProductParam productParam) {
       Long count = productMapper.findCount(productParam);
        List<Product> list = productMapper.findPageList(productParam);
       /*  DataTableResult dataTableResult = new DataTableResult(productParam.getDraw(), count, count, list);

        return dataTableResult;*/
        List<ProductVo>productVoList = new ArrayList();
        for(Product product:list){
            ProductVo productVo  = new ProductVo();
            productVo.setId(product.getId());
            productVo.setProductName(product.getProductName());
            productVo.setPrice(product.getPrice().toString());
            productVo.setBrandName(product.getBrandName());
            productVo.setCreateDate(DateUtil.se2te(product.getCreateDate(),DateUtil.Y_M_D));
            productVo.setInsertDate(DateUtil.se2te(product.getInsertDate(),DateUtil.FULL_TIME));
            productVo.setUpdateDate(DateUtil.se2te(product.getUpdateDate(),DateUtil.FULL_TIME));
            productVo.setImage(product.getImage());
            productVo.setIsHot(product.getIsHot());
            productVo.setStatus(product.getStatus());
            productVo.setStock(product.getStock());
            productVoList.add(productVo);
        }
        DataTableResult dataTableResult =   new DataTableResult(productParam.getDraw(),count,count,productVoList);
        return dataTableResult;
    }



    @Override
    public void deleteProduct(Long id) {
        Product oldProduct = productMapper.selectById(id);
        AliyunOSSUtil.deleteFile(oldProduct.getImage());;
        productMapper.deleteById(id);


    }

    @Override
    public ServerResponse findById(Long id) {
        Product product = productMapper.findById(id);
        ProductVo productVo  = new ProductVo();
        productVo.setId(product.getId());
        productVo.setBrandId(product.getBrandId());
        productVo.setProductName(product.getProductName());
        productVo.setPrice(product.getPrice().toString());
        productVo.setBrandName(product.getBrandName());
        productVo.setCreateDate(DateUtil.se2te(product.getCreateDate(),DateUtil.Y_M_D));
        productVo.setInsertDate(DateUtil.se2te(product.getInsertDate(),DateUtil.FULL_TIME));
        productVo.setUpdateDate(DateUtil.se2te(product.getUpdateDate(),DateUtil.FULL_TIME));
        productVo.setImage(product.getImage());
        productVo.setIsHot(product.getIsHot());
        productVo.setStatus(product.getStatus());
        productVo.setStock(product.getStock());
        return ServerResponse.success(productVo);
    }

    @Override
    public Product findBProductyId(Long id) {
        return productMapper.findById(id);
    }

    @Override
    public void updateProduct(Product product) {
        product.setUpdateDate(new Date());
       Product oldProduct = productMapper.selectById(product.getId());
            if(!product.getImage().equals(oldProduct.getImage())){
                AliyunOSSUtil.deleteFile(oldProduct.getImage());
        }
        productMapper.updateById(product);
    }



    @Override
    public void addProduct(Product product) {

        product.setInsertDate(new Date());
        productMapper.insert(product);
    }
    @Override
    public void updateIsHotStatus(Long id, int status) {
        Product product = new Product();
        product.setId(id);
        product.setIsHot(status);
        productMapper.updateById(product);
    }

    @Override
    public void updatesStatus(Long id, int status) {
        Product product = new Product();
        product.setId(id);
        product.setStatus(status);
        productMapper.updateById(product);
    }



}
