<%--
  Created by IntelliJ IDEA.
  User: sss
  Date: 2019/12/13
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet"/>
<link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>
<script src="/js/jquery.min.js"></script>
<body>
    <div class="container">
       <div class="row">
           <div class="col-md-12">
              <form class="form-horizontal" >
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品名</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="productName" placeholder="请输入商品名...">
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品价格</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="price" placeholder="请输入商品价格...">
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品品牌</label>
                      <div class="col-sm-10" id="brandDiv">

                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">是否热销</label>
                      <div class="col-sm-10">
                          <input type="radio"  name="isHot" value="1">热销
                          <input type="radio"  name="isHot" value="0">非热销
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">生产日期</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="createDate" placeholder="请输入生产日期...">
                      </div>
                  </div>

                  <div class="form-group">
                      <label class="col-sm-2 control-label">是否上架</label>
                      <div class="col-sm-10">
                          <input type="radio"  name="status" value="1">上架
                          <input type="radio"  name="status" value="0">下架
                      </div>
                  </div>
                  <input type="text" id="addFilePath" />
                  <div class="form-group">
                      <label class="col-sm-2 control-label">商品图片</label>
                      <div class="col-sm-10">
                          <input type="file" class="form-control" multiple id="cover" name="image" >
                      </div>
                  </div>
                  <div class="form-group">
                      <label class="col-sm-2 control-label">库存</label>
                      <div class="col-sm-10">
                          <input type="text" class="form-control" id="stock" placeholder="请输入生产日期...">
                      </div>
                  </div>
                  <div style="text-align: center;">
                      <button type="button" class="btn btn-primary" onclick="addProduct();"><i class="glyphicon glyphicon-ok"></i> 增加</button>
                      <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
                  </div>
              </form>
           </div>
       </div>
    </div>
    <script src="/js/bootstrap3/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
    <script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/js/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/js/bootstrap-fileinput/js/locales/zh.js"></script>
</body>
   <script>


               function addProduct(){

                   var v_name = $("#productName").val();
                   var v_price = $("#price").val();
                   var v_brandId = $("#selectId").val();
                   var v_param = {};
                   v_param.productName=v_name;
                   v_param.price=v_price;
                   v_param.brandId = v_brandId;
                   v_param.createDate = $("#createDate").val();
                   v_param.image = $("#addFilePath").val();
                   v_param.stock = $("#stock").val();
                   v_param.isHot = $("[name='isHot']:checked").val();
                   v_param.status = $("[name='status']:checked").val();
                   alert(v_param.status)
                   $.ajax({
                       url:"/product/addProduct.jhtml",
                       data:v_param,
                       type:"post",
                       success:function(result){
                           if(result.code==200){
                               location.href="/product/index.jhtml"
                           }

                       },
                       error:function(){
                           alert("添加失败")
                       }
                   })
               }
$(function(){
    initBrand();
    showDate();
    //初始化新增用户表单中的用户图片文件域
    $("#cover").fileinput({
        language:"zh",//设置语言选项
        maxFileCount:1,//设置最大上传文件个数
        //设置文件上传的地址
        uploadUrl:"/uploadFile/uploadFile.jhtml"
    });
    $("#cover").on("fileuploaded",function(a,b,c,d){
        //其中b就代表服务器返回的数据
        var result = b.response;
        if(result.code == 200){
            console.log(result.data.image)
            //将图片上传后的相    //设置文件上传之后的回调函数
            //对路径放入新增用户表单中的用于存放图片相对路径的隐藏域中
            $("#addFilePath").val(result.data);
        }
    });
})
               function initBrand(){
                   $.ajax({
                       url:"/brand/findList.jhtml",
                       type:"post",
                       data:{},
                       success:function(result){
                                var b_html="<select id='selectId' class=\"form-control\"><option value='-1'>-----请选择-----</option>"
                           if(result.code==200){
                               var brandList = result.data;
                               console.log(brandList);
                             for(var i=0;i<brandList.length;i++){
                                var v_brand =  brandList[i];
                                 b_html+="<option value='"+v_brand.id+"'>"+v_brand.brandName+"</option>"
                             }
                               b_html+="</select>"
                               $("#brandDiv").html(b_html);
                           }
                       }
                   })
               }
               function showDate(){
                   $("#createDate").datetimepicker({
                       format:"YYYY-MM-DD",
                       locale:"zh-CN",
                   });
               }
   </script>
</html>
