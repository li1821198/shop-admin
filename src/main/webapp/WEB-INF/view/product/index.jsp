<%--
  Created by IntelliJ IDEA.
  User: sss
  Date: 2020/6/30
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
<link href="/js/bootstrap3/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
<script src="/js/jquery.min.js"></script>
<script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
<link href="/js/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet"/>
<body>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">条件查询</h3>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" method="post" id="returnQuery" nctype="multipart/form-data">
            <div class="form-group">
                <label  class="col-sm-2 control-label">商品名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="productName" placeholder="请输入商品名...">
                </div>
                <label  class="col-sm-2 control-label">生产日期</label>
                <div class="col-sm-4">
                    <div class="input-group">
                        <input type="text" class="form-control"  id="minDate" placeholder="...">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-arrow-right"></i> </span>
                        <input type="text" class="form-control" id="maxDate" placeholder="...">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">价格</label>
                <div class="col-sm-4">
                    <div class="input-group">
                        <input type="text" class="form-control"  id="minPrice" placeholder="...">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-arrow-right"></i> </span>
                        <input type="text" class="form-control" id="maxPrice" placeholder="...">
                    </div>
                </div>
                <div id="areaDiv">
                    <label  class="col-sm-2 control-label">品牌</label>

                </div>
            </div>
            <div style="text-align: center;">
                <button type="button" class="btn btn-primary" onclick="search();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-refresh"></i>重置</button>
            </div>
        </form>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">展示页面</h3>
            </div>
            <div class="panel-body">
                <button type="button"  onclick="toAdd()" class=" btn-sm btn btn-success"><i class="glyphicon glyphicon-plus"></i>添加</button>
                <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox">
                        </th>
                        <th>商品名</th>
                        <th>价格</th>
                        <th>创建日期</th>
                        <th>品牌</th>
                        <th>生产日期</th>
                        <th>修改日期</th>
                        <th>logo</th>
                        <th>是否热销</th>
                        <th>是否上架</th>
                        <th>库存</th>
                        <th>操做</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
<script src="/js/bootstrap3/bootstrap-datetimepicker/js/moment-with-locales.js"></script>
<script src="/js/bootstrap3/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="/js/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="/js/bootstrap-fileinput/js/locales/zh.js"></script>
</body>
<script>
    $(function(){
        inintTable();
        initDate("minDate");
        initDate("maxDate");
        initBrand();
    });
    //初始化品牌
    function initBrand() {

        $.ajax({
            type:"get",
            url:"/brand/findList.jhtml",
            success:function (res) {
                if(res.code==200){
                    var brandList = res.data;
                        var brandHtml="<div class='col-md-3'><select class='form-control' id='brandSelect'><option value='-1'>--------请选择-------</option>"
                        for(let brand of brandList){
                            brandHtml+="<option value='"+brand.id+"'>"+brand.brandName+"</option>"
                        }
                            brandHtml+="</select></div>"
                        $("#areaDiv").append(brandHtml);

                }else{
                    alert("查询失败")
                }
            }
        })
    }



    function initDate(elment){
        $("#"+elment).datetimepicker({
            format:"YYYY-MM-DD",
            locale:"zh-CN",
        });
    }
    var productTable;
    function inintTable(){
        productTable =  $('#productTable').DataTable( {
            "language": {
                "url": "/js/Chinese.json"
            },
            "searching":false,
            "lengthMenu": [3,10,15,20],
            "processing": true,
            "serverSide": true,
            "ajax":{
                url:"/product/findList.jhtml",
                type:"POST"
            },
            "columns": [
                {"data": "id",
                    render:function(data, type, row, meta) {
                        var html = "<input type='checkbox' name='id' value='"+data+"'>";
                        return html;
                    }},
                { "data": "productName"
                   },
                { "data": "price",
                    },
                { "data": "createDate",

                },
                { "data": "brandName",

                },
                { "data": "insertDate",
                },
                { "data": "updateDate" },
                { "data": "image",
                    render:function (data) {
                        return "<img width='40' height='30' src='"+data+"' />";
                    }
                    },
                { "data": "isHot",
                    render:function (data) {
                      return data==0?"不热销":"热销";
                    }
                },
                { "data": "status",
                    render:function (data) {
                        return data==0?"下架":"上架";
                    }
                },
                { "data": "stock" },
                {
                    data: "id",

                    render:function (data, type, row) {

                        var isHot = row.isHot;
                        var status = row.status;
                        var v_text="";
                        var v_icon = "";
                        var v_color="";
                        var v_hot_status = "";
                        var isupStatus ="";
                        var text="";
                        var icon = "";
                        var color="";
                        if(isHot==1){
                            v_text="非热销";
                            v_color="btn btn-warning";
                            v_icon="glyphicon glyphicon-map-marker";
                            v_hot_status="0";
                        }else{
                            v_text="热销";
                            v_color="btn btn-success";
                            v_icon="glyphicon glyphicon-fire";
                            v_hot_status="1";
                        };
                        if(status==1){
                            text="下架";
                            color="btn btn-warning";
                            icon="glyphicon glyphicon-cloud-download";
                            isupStatus="0";
                        }else{
                            text="上架";
                            color="btn btn-danger";
                            icon="glyphicon glyphicon-cloud-upload";
                            isupStatus="1";
                        };
                        var buttonHTML = "";
                        buttonHTML += '<div class="btn-group btn-group-xs">';
                        buttonHTML += '<button type="button" onclick="deleteProduct(' + data + ')" class="btn btn-danger">';
                        buttonHTML += '<span class="glyphicon glyphicon-trash"></span>&nbsp;删除';
                        buttonHTML += '</button>'
                        buttonHTML += '<button type="button" onclick="showUpdate(' + data + ')" class="btn btn-primary">';
                        buttonHTML += '<span class="glyphicon glyphicon-pencil"></span>&nbsp;修改';
                        buttonHTML += '</button>';
                        buttonHTML += '<button type="button" onclick="updateIsHotStatus(' + data + ','+v_hot_status+')" class="'+v_color+'">';
                        buttonHTML += '<span class="'+v_icon+'"></span>&nbsp;'+v_text+'';
                        buttonHTML += '</button>'; buttonHTML += '<button type="button" onclick="updatesStatus(' + data + ','+isupStatus+')" class="'+color+'">';
                        buttonHTML += '<span class="'+icon+'"></span>&nbsp;'+text+'';
                        buttonHTML += '</button>';

                        return buttonHTML;
                    }
                }
            ],
        } );
    }
    function updateIsHotStatus(id,status) {
        $.ajax({
            type: "post",
            url: "/product/updateIsHotStatus.jhtml?id=" + id + "&status=" + status,
            success: function (result) {
                if (result.code = 200) {
                    productTable.ajax.reload();
                }
            },
            error: function () {
                alert("失败")
            }
        })
    }
    function updatesStatus(id,status){
        $.ajax({
            type:"post",
            url:"/product/updatesStatus.jhtml?id="+id+"&status="+status,
            success:function(result){
                if(result.code=200){
                    productTable.ajax.reload();
                }
            },
            error:function(){
                alert("失败")
            }
        })
    }
    function search() {
        var v_param = {};
        v_param.productName = $("#productName").val();
        v_param.minPrice = $("#minPrice").val();
        v_param.maxPrice = $("#maxPrice").val();
        v_param.minDate = $("#minDate").val();
        v_param.maxDate = $("#maxDate").val();
        v_param.brandId = $("#brandSelect").val();
        productTable.settings()[0].ajax.data = v_param;
        productTable.ajax.reload();
    }


    function toAdd(){
        event.stopPropagation();
        location.href="/product/toAdd.jhtml"
    }
    function showUpdate(id){
        event.stopPropagation();
        location.href="/product/toUpdate.jhtml?id="+id;
    }
    function deleteProduct(id){
        bootbox.confirm({
            title:"删除提示",
            message:"是否要删除这些数据",
            buttons:{
                //設置確定按鈕的文字和樣式
                confirm:{
                    label:"确认",
                    className:"btn btn-success"
                },
                //設置取消按鈕的文字和樣式
                cancel:{
                    label:"取消",
                    className:"btn btn-danger"
                }
            },
            callback:function(result){
                if(result){
                    $.ajax({
                        url:"/product/deleteProduct.jhtml",
                        dataType:"json",
                        data:{"id":id},
                        success:function(result){
                            if(result.code==200){
                                alert("删除成功")
                                search();
                            }else{
                                alert("后台失败")
                            }
                        },error:function(){
                            alert("删除失败")
                        }
                    })
                }
            }

        })


    }

</script>
</html>
