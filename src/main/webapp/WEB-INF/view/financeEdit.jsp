<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>    
    
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>

<base href="<%=basePath%>">

<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<style type="text/css">
	.order_detail{
		background-color: #eaf6ff;
		border: 1px solid black;
		border-right: 0; 
		height: 40px;
		line-height: 40px;
	}
	.order_detail input{
		height: 30px;
		text-align: center;
	}
	.order_add{
		border: 1px solid black;
	}
	#order_detail{
		text-align: center;
	}

</style>
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.min.css" />
</head>
<body>

<article class="page-container">


	<div class="row cl">
		<div class="col-xs-12 col-sm-12 col-xs-offset-4 col-sm-offset-5">
			<button class="btn btn-primary radius" onclick="exportPdf()"  style="color: yellow">导出PDF</button>
		</div>
	</div>





	<form class="form form-horizontal" method="post"  id="orderForm">
	<!-- 隐藏域 ，订单状态-->
	<input type="hidden" name="orderStatus" value="2">

	<input type="hidden" name="orderId" value="${order.orderId}">


		<div class="row cl">

			<label class="form-label col-xs-4 col-sm-1" style="color: cornflowerblue">订单明细：</label>

		</div>


		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">收货地址：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.shippingAddress}" required="required"  placeholder="请输入收货地址" id="shippingAddress" name="shippingAddress">
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">收货人：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.shippingName}" required="required"   placeholder="请输入收货人" id="shippingName" name="shippingName">
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">收货电话：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.shippingPhone}" required="required"  placeholder="请输入收货电话" id="shippingPhone" name="shippingPhone">
				</div>
			</div>
		</div>

		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">取件地址：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.takeAddress}"   placeholder="请输入取件地址" id="customerName" name="takeAddress">
				</div>
			</div>

			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">取件联系人：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.takeName}"   placeholder="请输入取件联系人" id="takeName" name="takeName">
				</div>
			</div>

			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">取件电话：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<input readonly type="text" class="input-text" value="${order.takePhone}"   placeholder="请输入取件电话" id="takePhone" name="takePhone">
				</div>
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">业务员：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<select disabled name="userId" >
						<c:forEach items="${users}" var="userEach">
							<option ${userEach.userId eq order.userId ? 'selected':''} value="${userEach.userId}">${userEach.realname}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">客户：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<select disabled name="customerId" id="customer">
						<c:forEach items="${customers}" var="customerEach">
							<!--
							html5 可以自定义 属性

							语法 ： data-xxx
							data-：固定语法
							xxx ：具体属性，见名知意
							如 ：
							data-customer_id : 客户id
							data-custoemr_name :客户名称

							-->

							<option data-base_name="${customerEach.baseName}" data-base_id="${customerEach.baseId}" ${customerEach.customerId eq order.customerId ? 'selected':''} value="${customerEach.customerId}">${customerEach.customerName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">到达区域：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<select disabled id="interval" name="intervalId">
						<c:forEach items="${intervals}" var="intervalEach">
							<option ${intervalEach.baseId eq order.intervalId ? 'selected':''} value="${intervalEach.baseId}">${intervalEach.baseName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>






		<div class="row cl">
		<div class="col-xs-4 col-sm-4">
			<label class="form-label col-xs-4 col-sm-4">付款方式：</label>
			<div class="formControls col-xs-8 col-sm-8">
				<select disabled name="paymentMethodId">
					<c:forEach items="${payments}" var="paymentEach">
						<option ${paymentEach.baseId eq order.paymentMethodId ? 'selected':''}  value="${paymentEach.baseId}">${paymentEach.baseName}</option>
					</c:forEach>
				</select>
			</div>
		</div>
			<div class="col-xs-4 col-sm-4">
			<label class="form-label col-xs-4 col-sm-4">货运方式：</label>
			<div class="formControls col-xs-8 col-sm-8">
				<select disabled name="freightMethodId" id="freightMethod">
					<c:forEach items="${freights}" var="freightEach">
						<option ${freightEach.baseId eq order.freightMethodId ? 'selected':''} data-base_id="${freightEach.baseId}" value="${freightEach.baseId}">${freightEach.baseName}</option>
					</c:forEach>
				</select>
			</div>
		</div>

			<div class="col-xs-4 col-sm-4">
			<label class="form-label col-xs-4 col-sm-4">取件方式：</label>
			<div class="formControls col-xs-8 col-sm-8">
				<select disabled name="takeMethodId">
					<c:forEach items="${fetchTypes}" var="fetchTypeEach">
						<option  ${fetchTypeEach.baseId eq order.takeMethodId ? 'selected':''}  value="${fetchTypeEach.baseId}">${fetchTypeEach.baseName}</option>
					</c:forEach>
				</select>
			</div>
		</div>




	</div>


		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-4">入库选择：</label>
				<div class="formControls col-xs-8 col-sm-8">
					<select disabled name="warehouseId">
						<c:forEach items="${warehouses}" var="warehouseEach">
							<option  ${warehouseEach.baseId eq order.warehouseId ? 'selected':''}  value="${warehouseEach.baseId}">${warehouseEach.baseName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>



		<div class="row cl">

			<hr>

		</div>



        <div class="row cl">


            <div class="col-xs-4 col-sm-4">
                <label class="form-label col-xs-4 col-sm-4">收件人：</label>
                <div class="formControls col-xs-8 col-sm-8">
                    <input type="text" class="input-text"  value="钱仓管"  placeholder=""  disabled>
                </div>
            </div>

            <div class="col-xs-4 col-sm-4">
                <label class="form-label col-xs-4 col-sm-4">收件地址：</label>
                <div class="formControls col-xs-8 col-sm-8">
                    <input type="text" class="input-text"  value="广州市白云区机场"  placeholder=""  disabled>
                </div>
            </div>

            <div class="col-xs-4 col-sm-4">
                <label class="form-label col-xs-4 col-sm-4">联系电话：</label>
                <div class="formControls col-xs-8 col-sm-8">
                    <input type="text" class="input-text"  value="18866668888"  placeholder=""  disabled>
                </div>
            </div>
        </div>

		<div class="row cl">
			<hr >

		</div>


		<div class="row cl">

			    <label class="form-label col-xs-4 col-sm-1" style="color: #dd514c">费用明细：</label>

		</div>



		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">体积收费（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${volumeTotal * order.volumeRate}"  id="volumeMoney" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">总体积（m³）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${volumeTotal}" id="volumeTotal" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">体积费率（元/千克）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${order.volumeRate}"  id="volumeRate" >
				</div>
			</div>
		</div>

		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">重量收费（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${weightTotal * order.weightRate}" id="weightMoney" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">总重量（kg）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${weightTotal}" id="weightTotal" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">重量费率（元/千克）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${order.weightRate}" id="weightRate" >
				</div>
			</div>
		</div>

		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">过关税费（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${order.freightMethodId eq 9 ? moneyTotal * 0.07 : 0.0}" id="taxMoney" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">总价值（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${moneyTotal}"  id="moneyTotal" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">税率：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${order.freightMethodId eq 9 ? 0.07 : 0.0}" id="taxRate" >
				</div>
			</div>
		</div>

		<div class="row cl">
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">取件费用（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="${order.takeMoney}" id="takeMoney" >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6">其他费用（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text" class="input-text" value="0"  >
				</div>
			</div>
			<div class="col-xs-4 col-sm-4">
				<label class="form-label col-xs-4 col-sm-6"  style="color: #dd514c" >总费用（元）：</label>
				<div class="formControls col-xs-8 col-sm-6">
					<input readonly type="text"   class="input-text" value="${order.takeMoney + (order.freightMethodId eq 9 ? moneyTotal * 0.07 : 0.0) + weightTotal * order.weightRate + volumeTotal * order.volumeRate}" required="required"  id="totalMoney" >
				</div>
			</div>
		</div>



	
	
	<div  id="order_detail" class="row cl">
		<div>
			<div  class="col-xs-2 col-sm-2 order_detail">货物名称</div>
			<div  class="col-xs-2 col-sm-1 order_detail">数量</div>
			<div  class="col-xs-2 col-sm-1 order_detail">单位</div>
			<div  class="col-xs-2 col-sm-1 order_detail">长（cm）</div>
			<div  class="col-xs-2 col-sm-1 order_detail">宽（cm）</div>
			<div  class="col-xs-2 col-sm-1 order_detail">高（cm）</div>
			<div  class="col-xs-2 col-sm-2 order_detail">体积(m³)</div>
			<div  class="col-xs-2 col-sm-1 order_detail">重量（kg）</div>
			<div  class="col-xs-2 col-sm-2 order_detail order_add">总价值（元）</div>

		</div>

		<%--<c:if test="${empty order.orderDetails}">
			<div id="goods_detail">

				<input type="hidden" name="orderDetails[][orderDetailId]" value="${orderDetail.orderDetailId}">

				<div  class="col-xs-2 col-sm-2 order_detail">
					<input type="text" name="orderDetails[][goodsName]" value="${orderDetail.goodsName}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input type="text" size="3"  name="orderDetails[][goodsNumber]" value="${orderDetail.goodsNumber}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<select name="orderDetails[][goodsUnit]">
						<c:forEach items="${units}" var="unitEach">
							<option    ${unitEach.baseId eq orderDetail.goodsUnit ? 'selected':''}  value="${unitEach.baseId}">${unitEach.baseName}</option>
						</c:forEach>
					</select>
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input type="text"   name="orderDetails[][goodsLength]" value="${orderDetail.goodsLength}">

				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input type="text" name="orderDetails[][goodsWidth]" value="${orderDetail.goodsWidth}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input type="text" name="orderDetails[][goodsHeight] " value="${orderDetail.goodsHeight}">
				</div>
				<div  class="col-xs-2 col-sm-2 order_detail">
					<input type="text" name="orderDetails[][goodsVolume] " value="${orderDetail.goodsVolume}">
				</div>
				<div  class="col-xs-2 col-sm-2 order_detail">
					<input type="text" name="orderDetails[][goodsWeight] " value="${orderDetail.goodsWeight}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail order_add">
				<span style="cursor: pointer;color: red"
					  class="glyphicon glyphicon-remove"
					  onclick="remove_goods_detail(this);"
				></span>
				</div>
			</div>
		</c:if>--%>
		
		<c:forEach items="${order.orderDetails}" var="orderDetail">
			<div id="goods_detail">

				<input type="hidden" name="orderDetails[][orderDetailId]" value="${orderDetail.orderDetailId}">

				<div  class="col-xs-2 col-sm-2 order_detail">
					<input readonly type="text" name="orderDetails[][goodsName]" value="${orderDetail.goodsName}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input readonly type="text" size="3"  onkeyup="operationVolume(this);" name="orderDetails[][goodsNumber]" value="${orderDetail.goodsNumber}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<select disabled name="orderDetails[][goodsUnit]">
						<c:forEach items="${units}" var="unitEach">
							<option    ${unitEach.baseId eq orderDetail.goodsUnit ? 'selected':''}  value="${unitEach.baseId}">${unitEach.baseName}</option>
						</c:forEach>
					</select>
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input readonly type="text"  size="3"  onkeyup="operationVolume(this);"  name="orderDetails[][goodsLength]" value="${orderDetail.goodsLength}">

				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input readonly type="text"  size="3" onkeyup="operationVolume(this);" name="orderDetails[][goodsWidth]" value="${orderDetail.goodsWidth}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input readonly type="text" size="3" onkeyup="operationVolume(this);" name="orderDetails[][goodsHeight]" value="${orderDetail.goodsHeight}">
				</div>
				<div  class="col-xs-2 col-sm-2 order_detail">
					<input readonly type="text"  name="orderDetails[][goodsVolume]" value="${orderDetail.goodsVolume}">
				</div>
				<div  class="col-xs-2 col-sm-1 order_detail">
					<input readonly type="text"  size="3" name="orderDetails[][goodsWeight]" value="${order.freightMethodId eq 10 ? orderDetail.goodsWeight:0}"    >
				</div>

				<div  class="col-xs-2 col-sm-2 order_detail order_add">
					<input readonly type="text"  name="orderDetails[][goodsTotal]" value="${orderDetail.goodsTotal}">
				</div>



			</div>
		</c:forEach>
		
	</div>
	
	


	</form>

</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.11.3/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/bootstrap-table/bootstrap-table.min.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script> 
<script type="text/javascript" src="lib/jquery/jquery.serializejson.min.js"></script>

<script src="lib/js/html2canvas.min.js"></script>
<script src="lib/js/jspdf.min.js"></script>

<script type="text/javascript">


	function exportPdf() {
		var element = document.getElementById("orderForm");
		html2canvas(element, {
			logging:false
		}).then(function(canvas) {
			var pdf = new jsPDF('l', 'mm', 'a4');    //A4纸，纵向
			var ctx = canvas.getContext('2d'),
					a4w = 260, a4h = 190,    //A4大小，210mm x 297mm，四边各保留10mm的边距，显示区域190x277
					imgHeight = Math.floor(a4h * canvas.width / a4w),    //按A4显示比例换算一页图像的像素高度
					renderedHeight = 0;

			while(renderedHeight < canvas.height) {
				var page = document.createElement("canvas");
				page.width = canvas.width;
				page.height = Math.min(imgHeight, canvas.height - renderedHeight);//可能内容不足一页

				//用getImageData剪裁指定区域，并画到前面创建的canvas对象中
				page.getContext('2d').putImageData(ctx.getImageData(0, renderedHeight, canvas.width, Math.min(imgHeight, canvas.height - renderedHeight)), 0, 0);
				pdf.addImage(page.toDataURL('image/jpeg', 1.0), 'JPEG', 10, 10, a4w, Math.min(a4h, a4w * page.height / page.width));    //添加图像到页面，保留10mm边距

				renderedHeight += imgHeight;
				if(renderedHeight < canvas.height)
					pdf.addPage();//如果后面还有内容，添加一个空页
				delete page;
			}
			pdf.save("${order.orderId}"+"-"+"${order.shippingName}"+".pdf");
		});

	}

/*
//计算每一个订单明细 单价*数量=总价，并且将总价设置到文本框中
function operationVolume(obj){
	//1.获取当前文本框的父元素的父元素（最外层的div）
	var boxDiv = $(obj).parent().parent();
	//2.获取所有的input标签
	var inputs = boxDiv.find("input");
	
	//获取数据量的input
	var numberValue = inputs[2].value;
	
	//获取长的input
	var lengthValue = inputs[3].value;
	//获取宽的input
	var widthValue = inputs[4].value;
	//获取高的input
	var heightValue = inputs[5].value;

	if(numberValue !="" && lengthValue !=""&& widthValue !=""&& heightValue !=""){
		//计算并设置总价的值
		inputs[6].value = numberValue * lengthValue * widthValue * heightValue;
	}
}


//添加货品详情
function add_goods_detail(){
	//克隆商品详情

	var goodsDetail = $("#goods_detail").clone();
	
	//清除表单的数据
	goodsDetail.find("input").val("");
	
	var order_detail = $("#order_detail");
	
	//将克隆的商品详情追加到订单明细div中
	order_detail.append(goodsDetail);
}
//删除商品详情
function remove_goods_detail(obj){
	
	$(obj).parent().parent().remove();
}

/!*
 * 客户变化的时候修改对应的区域函数
 *!/
function customerChanagerUpdateInterval(){
	
	//1.获取当前选中客户对应的option
	var option = $("#customer option:selected");
	
	//2.获取当前客户下拉框的 区间id值: baseId和区间名称 base_name
	var intervalId = option.data("base_id");
	
	//3.获取所有的区间数据
	var intervalOptions = $("#interval option");
	//console.log(intervalOptions);
	for(var i = 0; i<intervalOptions.length;i++){
		//获取的每个option 是 原生DOM对象
		var intervalOption = intervalOptions[i];
		//获取区间id 
		var baseId = $(intervalOption).val();
		
		//先清除选中效果
		$(intervalOption).attr("selected",false);
		
		//判断客户的区间id值和 循环每次baseId是否相等，相等就选中
		if(intervalId == baseId){
			$(intervalOption).attr("selected",true);
		}
	}
	
}

//运输方式改变锁定重量窗口
function freightMethodChanager(){

	//1.获取当前选中客户对应的option
	var option = $("#freightMethod option:selected");

	//2.获取当前客户下拉框的 区间id值: baseId和区间名称 base_name
	var freightMethodId = option.data("base_id");


	if(freightMethodId == 10){
		$("input[name='orderDetails[][goodsWeight]']").removeAttr('readonly');

	}else {
		$("input[name='orderDetails[][goodsWeight]']").attr('readonly','readonly');
	}

}
$(function(){
	
	//页面加载触发 根据客户显示选择对应的区域
	customerChanagerUpdateInterval();

	freightMethodChanager();

	//为客户的下拉框绑定change函数
	
	$("#customer").change(function(){
		customerChanagerUpdateInterval();
	});

	$("#freightMethod").change(function(){
		freightMethodChanager();
	});
	
})





$(function(){
	
	
	
	
	$("#orderForm").validate({

		rules:{
			shippingAddress:"required",
			shippingName:"required",
			shippingPhone:"required",
			takeAddress:"required",
			takeName:"required",
			takePhone:"required",



		},
		messages:{
			shippingAddress:"收货地址不能为空",
			shippingName:"收货人不能为空",
			shippingPhone:"收货人电话不能为空",
			takeAddress:"取件地址不能为空",
			takeName:"取件人姓名不能为空",
			takePhone:"取件人电话不能为空",

		},
	
		submitHandler:function(form){
			
			//将表单序列化成JSON对象
			var serializeJSON = $(form).serializeJSON();
			console.log(typeof serializeJSON,serializeJSON);
			
			//将json对象转换成json字符串
			var jsonData = JSON.stringify(serializeJSON);
			console.log(typeof jsonData,jsonData)
			
			//发送ajax请求
			$.ajax({
				   type: "POST",
				   url: "order/update.do",
				   contentType: "application/json; charset=utf-8",
				   data: jsonData,
				   success: function(data){
					   layer.msg(data.msg,{icon:data.code,time:2000},function(){
							//让父层页面重新刷新一下（重新加载一下）
							window.parent.refreshTable();
							//关闭当前弹出层
							parent.layer.closeAll();
						});
				   }
			});
			
		}
	});
});*/
</script> 
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>