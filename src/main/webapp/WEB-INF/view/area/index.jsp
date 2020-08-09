<%--
  Created by IntelliJ IDEA.
  User: sss
  Date: 2020/6/29
  Time: 12:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<link href="/js/dataTable/DataTables-1.10.20/css/jquery.dataTables.min.css" rel="stylesheet"/>
<link href="/js/bootstrap3/css/bootstrap.min.css" rel="stylesheet">
<link href="/js/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script src="/js/jquery.min.js"></script>
<script src="/js/dataTable/DataTables-1.10.20/js/jquery.dataTables.js"></script>
<script src="/js/bootstrap3/js/bootstrap.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.min.js"></script>
<script src="/js/bootstrap3/js/bootbox.locales.min.js"></script>
<script type="text/javascript" src="/js/zTree/js/jquery.ztree.all.js"></script>

<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">地区
            <button class="btn btn-primary btn-sm" onclick="showAdd()">
                <span class="glyphicon glyphicon-plus"></span> 新增
            </button>
            <button class="btn btn-primary btn-sm" onclick="showUpdate()">
                <span class="glyphicon glyphicon-pencil"></span> 修改
            </button>
            <button class="btn btn-primary btn-sm" onclick="batchDelete()">
                <span class="glyphicon glyphicon-pencil"></span> 删除
            </button>
        </h3>
    </div>
    <div class="panel-body">

        <ul id="areaTree" class="ztree"></ul>
    </div>
</div>


<!-- 新增DIV -->
<div id="addDiv" style="display:none">
    <!-- 新增权限form -->
    <form id="addForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">地区名称:</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="addName" />
            </div>
        </div>
    </form>
</div>

<!--修改DIV -->
<div id="updateDiv" style="display:none">
    <!-- 新增权限form -->
    <form id="updateForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">地区名称:</label>
            <div class="col-sm-8">
                <input type="text" class="form-control" id="updateName" />
            </div>
        </div>
    </form>
</div>
</body>
<script>
    var zTreeObj;
    var setting={
        view: {
            selectedMulti: false
        },
        data:{
            simpleData:{
                enable:true,
                pIdKey:"fid",
            },
            key:{
                name:"areaName"
            }
        }
    };
     var addHTML;
     var updateHTML;
    $(function(){
        addHTML = $("#addDiv").html();
        updateHTML = $("#updateDiv").html();
        jump();
    })
    function jump(){
        $.ajax({
            url:"/area/findList.jhtml",
            dataType:"json",
            type:"post",
            success:function(result){
                if(result.code==200){
                    console.log(result);
                    zTreeObj = $.fn.zTree.init($("#areaTree"),setting,result.data)
                }else{
                    alert("查询失败")
                }
            },
            error:function(){
                alert("查询失败")
            }
        })
    }

    function showAdd() {
         var selectedNodes = zTreeObj.getSelectedNodes();
         var selectedNode = selectedNodes[0];
         if(selectedNodes.length==1){
             var addAreaHtml =  bootbox.confirm({
                 title:"添加地区",
                 message:$("#addDiv").children(),
                 buttons:{
                     confirm:{
                         label:"确认"
                     },
                     cancel:{
                         label:"取消",
                         className:"btn btn-danger"
                     }
                 },
                 callback:function(result){
                     if(result){
                         var v_id = selectedNode.id;
                         var v_name = $("#addName").val();
                         $.ajax({
                             url:"/area/addArea.jhtml",
                             data:{"areaName":v_name,"fid":v_id},
                             type:"post",
                             success:function(result){
                                 var newNode = {id:result.data,areaName:$("#addName",addAreaHtml).val(),fid:v_id};
                                 zTreeObj.addNodes(selectedNode, newNode);
                             },
                             error:function(){
                                 alert("添加失败")
                             }
                         })
                     }
                     $("#addDiv").html(addHTML);
                 }
             })
         }else if(selectedNodes.length>1){
             alert("请选择一个节点！！！")
         }else{
             alert("请选择一个节点！！！")
        }

    }
    function  batchDelete() {
        var selected = zTreeObj.getSelectedNodes();
        if(selected.length>0){
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
                        var node = selected[0];
                        //根据树本身的查询子孙的方法放入选中的节点
                        var nodeArr = zTreeObj.transformToArray(node);
                        var ids=[];
                        for(var i=0;i<nodeArr.length;i++){
                            ids.push(nodeArr[i].id);
                        }

                        $.ajax({
                            url:"/area/deleteArea.jhtml",
                            dataType:"json",
                            data:{"idList":ids},
                            type:"post",
                            success:function(result){
                                if(result.code==200){
                                    var nodes = zTreeObj.getSelectedNodes();
                                    for (var i=0; i < nodes.length; i++) {
                                        zTreeObj.removeNode(nodes[i]);
                                    }
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


        }else{
            alert("请至少选择一个")
        }

    }
    function showUpdate(){
        var selecteList = zTreeObj.getSelectedNodes();
        if(selecteList.length>0){
            var node = selecteList[0];
            $.ajax({
                url:"/area/findById.jhtml",
                data:{"id":node.id},
                type:"post",
                success:function(result){
                    if(result.code==200){
                        var data = result.data;
                        $("#updateName").val(data.areaName)
                    }
                },
                error:function(){
                    alert("回显失败")
                }
            })
            bootbox.confirm({
                title:"修改",
                message:$("#updateDiv").children(),
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
                        var name = $("#updateName").val();
                        var v_id  = node.id;
                        $.ajax({
                            url:"/area/editArea.jhtml",
                            data:{"id":v_id,
                                "areaName":name},
                            type:"post",
                            success:function(result){
                                if(result.code==200){
                                    node.areaName=name;
                                    zTreeObj.updateNode(node);
                                }
                            },
                            error:function(){
                                alert("修改失败")
                            }
                        })
                    }
                    $("#updateDiv").html(updateHTML);
                }
            })
        }else{
            alert("请先选中要修改的节点！！！")
        }
    }
</script>
</html>
