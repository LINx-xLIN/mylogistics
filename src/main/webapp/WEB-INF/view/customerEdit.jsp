<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    // http://localhost:8080/logistics/
%>
<!DOCTYPE HTML>
<html>
<head>
    <!-- 设置页面的 基本路径，页面所有资源引入和页面的跳转全部基于 base路径 -->
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
    <link rel="stylesheet" type="text/css" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" />
    <meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
    <form  class="form form-horizontal" action="${empty customer ?'customer/insert.do' : 'customer/update.do'}" id="customerForm" method="post">
        <!-- 修改用户隐藏域 id -->
        <input type="hidden" name="customerId" value="${customer.customerId}">

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户名称：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text"  ${customer == null ? '' :'disabled'}   value="${customer.customerName}" placeholder="请输入客户名称" id="customerName" name="customerName">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户电话：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" name="phone" id="phone" class="input-text" value="${customer.phone}"/>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">客户邮箱：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" name="email" id="email" class="input-text" value="${customer.email}"/>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">客户地址：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" name="address" id="address" class="input-text" value="${customer.address}"/>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">客户身份证：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" name="idCard" id="idCard" class="input-text" value="${customer.idCard}"/>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户性别：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <div class="radio-box">
                    <input name="gender" type="radio" id="type-1"  ${customer.gender eq '1' ? 'checked':''} value='1'>
                    <label for="type-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="type-2" name="gender"  ${customer.gender eq '2' ? 'checked':''} value='2'>
                    <label for="type-2">女</label>
                </div>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>业务员：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <select class="select" name="userId" size="1">
                    <c:forEach items="${users}" var="userEach">
                        <option ${userEach.userId eq customer.userId ? 'selected':''} value="${userEach.userId}">${userEach.realname}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户区间：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <select class="select" name="baseId" size="1">
                    <c:forEach items="${baseDatas}" var="baseDataEach">
                        <option ${baseDataEach.baseId eq customer.baseId ? 'selected':''} value="${baseDataEach.baseId}">${baseDataEach.baseName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户备注：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea name="remark" cols="" rows="" class="textarea" placeholder="请输入客户备注">${customer.remark}</textarea>
            </div>
        </div>

        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">





    $(function(){

        /*
            使用jquery.validate 进行表单校验
        */
        $("#customerForm").validate({
            rules:{
                customerName:{
                    required:true,
                    remote: {
                        url: "customer/checkCustomername.do",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            name: function() {
                                return $("#customerName").val();
                            }
                        }
                    }
                },
                phone:{
                    required:true
                },
                idCard:{
                    required:true
                },

                gender:"required"



            },
            messages:{
                customerName:{
                    required:"客户名称不能为空",
                    remote: "客户名称已经存在"
                },
                phone:{
                    required:"电话不能为空"
                },
                idCard:{
                    required:"身份证不能为空"
                },
                gender:"性别不能为空"

            },
            submitHandler:function(form){
                //form ： 是原生js dom对象
                /*
                    原生js对象转jquery对象    $(dom对象)
                    jq对象转原生对象  jq对象[0]
                */

                //将表单转换成jq对象
                var jqForm = $(form);
                console.log(jqForm);


                //使用jquery表单异步提交
                jqForm.ajaxSubmit(function(data){

                    layer.msg(data.msg,{icon:data.code,time:2000},function(){
                        //让父层页面重新刷新一下（重新加载一下）
                        window.parent.refreshTable();
                        //关闭当前弹出层
                        parent.layer.closeAll();
                    });
                });

            }

        });


    });


</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>