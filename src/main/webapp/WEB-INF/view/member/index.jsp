<%--
  Created by IntelliJ IDEA.
  User: sss
  Date: 2019/12/13
  Time: 16:13
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
                <label  class="col-sm-2 control-label">会员名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="memberName" placeholder="请输入会员名...">
                </div>
                <label  class="col-sm-2 control-label">出生日期</label>
                <div class="col-sm-4">
                    <div class="input-group">
                        <input type="text" class="form-control"  id="minDate" placeholder="...">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-arrow-right"></i> </span>
                        <input type="text" class="form-control" id="maxDate" placeholder="...">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-2 control-label">真实姓名</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="realName" placeholder="请输入真实姓名...">
                </div>

            </div>
            <div class="form-group" id="areaDiv">
                <label  class="col-sm-2 control-label">地区</label>

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
                <table id="memTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox">
                        </th>
                        <th>会员名</th>
                        <th>真实姓名</th>
                        <th style="width: 150px">出生日期</th>
                        <th style="width: 200px">邮箱</th>
                        <th>手机号</th>
                        <th>地区</th>
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
              initArea(1);
          });


      function initArea(id,obj) {
          if(obj){
              $(obj).parent().nextAll().remove();
          }
          $.ajax({
              type:"get",
              url:"/area/findChilds.jhtml",
              data:{"id":id},
              success:function (res) {
                  if(res.code==200){
                      var areaList = res.data;
                      if(areaList.length>0){
                          var areaHtml="<div class='col-md-3'><select class='form-control' name='areaSelect' onchange='initArea(this.value,this)'><option value='-1'>--------请选择-------</option>"
                          for(let area of areaList){
                              areaHtml+="<option value='"+area.id+"'>"+area.areaName+"</option>"
                          }
                          areaHtml+="</select></div>"
                          $("#areaDiv").append(areaHtml);
                      }
                  }else{
                      alert("查询失败")
                  }
              }
          })
      }
          function initDate(e1ment){
              $("#"+elmen+t).datetimepicker({
                  format:"YYYY-MM-DD",
                  locale:"zh-CN",
              });
          }
          var memTable;
          function inintTable(){
              memTable =  $('#memTable').DataTable( {
                  "language": {
                      "url": "/js/Chinese.json"
                  },
                  "searching":false,
                  "lengthMenu": [3,10,15,20],
                  "processing": true,
                  "serverSide": true,
                  "ajax":{
                      url:"/member/findList.jhtml",
                      type:"POST"
                  },
                  "columns": [
                      {"data": "id",
                          render:function(data, type, row, meta) {
                              var html = "<input type='checkbox' name='id' value='"+data+"'>";
                              return html;
                          }},
                      { "data": "memberName",
                          width:'100px'},
                      { "data": "realName",
                          width:'100px'},
                      { "data": "birthday",
                         width:'100px'
                      },
                      { "data": "mail",
                          width:'160px'},
                      { "data": "phone" },
                      { "data": "areaName",
                          width:'300px'},
                      {
                          data: "id",
                          render:function (data, type, row) {
                              var buttonHTML = "";
                              buttonHTML += '<div class="btn-group btn-group-xs">';
                              buttonHTML += '<button type="button" onclick="deleteProduct(' + data + ')" class="btn btn-danger">';
                              buttonHTML += '<span class="glyphicon glyphicon-trash"></span>&nbsp;删除';
                              buttonHTML += '</button>';
                              buttonHTML += '<button type="button" onclick="showUpdate(' + data + ')" class="btn btn-primary">';
                              buttonHTML += '<span class="glyphicon glyphicon-pencil"></span>&nbsp;修改';
                              buttonHTML += '</button>';
                              return buttonHTML;
                          }
                      }
                  ],
              } );
          }
          function search() {
              var v_param = {};
              v_param.memberName = $("#memberName").val();
              v_param.realName = $("#realName").val();
              v_param.minDate = $("#minDate").val();
              v_param.maxDate = $("#maxDate").val();
              v_param.shengId = $($("select[name='areaSelect']")[0]).val();
              v_param.shiId = $($("select[name='areaSelect']")[1]).val();
              v_param.xianId = $($("select[name='areaSelect']")[2]).val();
              memTable.settings()[0].ajax.data = v_param;
              memTable.ajax.reload();
          }




      </script>
</html>
