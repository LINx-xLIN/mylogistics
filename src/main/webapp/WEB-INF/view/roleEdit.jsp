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
    <form  class="form form-horizontal" action="${empty role ?'role/insert.do' : 'role/update.do'}" id="roleForm">
        <!-- 修改用户隐藏域 id -->
        <input type="hidden" name="roleId" value="${role.roleId}">
        <!-- 隐藏域，权限的id数据  -->
        <input id="permissionIds" type="hidden" name="permissionIds">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>角色名称：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text"  ${role == null ? '' :'disabled'}   value="${role.rolename}" placeholder="请输入角色名称" id="rolename" name="rolename">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>角色描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea name="remark" cols="" rows="" class="textarea" placeholder="请输入角色描述">${role.remark}</textarea>
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>角色权限：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <!-- zTree生成树的列表 -->
                <ul id="permissionTree" class="ztree"></ul>
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

    var setting = {
        check:{enable:true},
        data:{simpleData:{enable:true}},
        async:{
            enable:true,
            url:"permission/getAllPermission.do",
        },
        callback:{
            onAsyncSuccess:zTreeOnAsyncSuccess,

        }



    };
    function zTreeOnAsyncSuccess(event,treeId,treeNode,msg){

        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        treeObj.expandAll(true);

        var permissionIds = "${role.permissionIds}";
        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");

        var permissionIdsArr = permissionIds.split(",");
        for(var i=1;i<permissionIdsArr.length;i++){
            var permissionId = permissionIdsArr[i-1];
            var node = treeObj.getNodeByParam("id",permissionId,null);
            if(node.children == undefined){
                treeObj.checkNode(node,true,true);
            }
        }
    }


    $(function () {
        $.fn.zTree.init($("#permissionTree"),setting);



    })

















    $(function(){

        /*
            使用jquery.validate 进行表单校验
        */
        $("#roleForm").validate({
            rules:{
                rolename:{
                    required:true,
                    remote: {
                        url: "role/checkRolename.do",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            rolename: function() {
                                return $("#rolename").val();
                            }
                        }
                    }
                },
                remark:{
                    required:true
                },



            },
            messages:{
                rolename:{
                    required:"角色名称不能为空",
                    remote: "角色名称已经存在"
                },
                remark:{
                    required:"角色描述不能为空"
                },

            },
            submitHandler:function(form){
                //form ： 是原生js dom对象
                /*
                    原生js对象转jquery对象    $(dom对象)
                    jq对象转原生对象  jq对象[0]
                */
                getCheckedData();
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

    function getCheckedData() {
        var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
        var nodes = treeObj.getCheckedNodes(true);
        var permissionIdsArr = [];
        for(var i=0;i<nodes.length;i++){
            var node = nodes[i];
            var permissionId = node.id;

            permissionIdsArr.push(permissionId);
        }

        var permissionIds = permissionIdsArr.join(",");

        $("#permissionIds").val(permissionIds);
    }
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>