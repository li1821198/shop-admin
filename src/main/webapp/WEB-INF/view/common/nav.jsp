<%--
  Created by IntelliJ IDEA.
  User: lichuan
  Date: 2019/11/12
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 导航栏 -->
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">商品管理系统</a>
        </div>

            <ul class="nav navbar-nav navbar-left">

            </ul>

</nav>
<script>
     $(function(){
         initMethodNav();
     })
    function initMethodNav(){
         var s = location.hash.substring(1);
         $("#li_"+s).addClass("active");
    }
</script>
