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
    <meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
    <form  class="form form-horizontal" action="${empty user ?'admin/insert.do' : 'admin/update.do'}" id="userForm">
        <!-- 修改用户隐藏域 id -->
        <input type="hidden" name="userId" value="${user.userId}">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员账号：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text"  ${user == null ? '' :'disabled'}   value="${user.username}" placeholder="请输入账号" id="username" name="username">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>真实姓名：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${user.realname}" placeholder="" id="realname" name="realname">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>初始密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="password" class="input-text" autocomplete="off" value="" placeholder="密码" id="password" name="password">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="password" class="input-text" autocomplete="off" value=""  placeholder="确认新密码" id="password2" name="password2">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3">角色：</label>
            <div class="formControls col-xs-8 col-sm-9"> <span class="select-box" style="width:150px;">
			<select class="select" name="roleId" size="1">
				<option value="0">请选择</option>
				<c:forEach items="${roles}" var="role">
                    <option  ${user.roleId eq role.roleId ? 'selected':''} value="${role.roleId}">${role.rolename}</option>
                </c:forEach>
			</select>
			</span> </div>
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
<script type="text/javascript">
    $(function(){

        /*
            使用jquery.validate 进行表单校验
        */
        $("#userForm").validate({
            rules:{
                username:{
                    required:true,
                    minlength:5,
                    remote: {
                        url: "admin/checkUsername.do",     //后台处理程序
                        type: "post",               //数据发送方式
                        dataType: "json",           //接受数据格式
                        data: {                     //要传递的数据
                            username: function() {
                                return $("#username").val();
                            }
                        }
                    }
                },
                realname:{
                    required:true,
                    minlength:2,
                    isChinese:true
                },
                <c:if test="${user == null}">
                password:"required",
                password2:{
                    equalTo:"#password"
                },
                </c:if>
                roleId:{
                    min:1
                }

            },
            messages:{
                username:{
                    required:"账号不能为空",
                    minlength:"账号最少5位数",
                    remote: "账号已经存在"
                },
                realname:{
                    required:"真实姓名不能为空",
                    minlength:"真实姓名最少两位数",
                    isChinese:"真实姓名必须是中文"
                },
                <c:if test="${user == null}">
                password:"密码不能为空",
                password2:{
                    equalTo:"确认密码必须和密码相等"
                },
                </c:if>
                roleId:{
                    min:"请选择角色"
                }
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