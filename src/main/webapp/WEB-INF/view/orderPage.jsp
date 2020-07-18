<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
    <script type="text/javascript" src="lib/html5shiv.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="lib/bootstrap-table/bootstrap-table.css" />
    <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="lib/jquery/1.11.3/jquery.min.js"></script>
    <script type="text/javascript" src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript" src="lib/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="lib/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
    <script type="application/javascript" src="lib/layer/2.4/layer.js"></script>

    <script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
    <script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->


    <title>订单管理</title>
</head>
<body>
<div class="pd-20">

    <table id="orderTable" class="table table-border table-bordered table-bg">

    <span class="l">
        <shiro:hasPermission name="order:batchDelete">
           <a href="javascript:;" onclick="batch_del()" class="btn btn-danger radius"><i class="icon-trash"></i> 批量删除</a>
        </shiro:hasPermission>

        <shiro:hasPermission name="order:insert">
           <a href="javascript:;" onclick="order_add()" class="btn btn-primary radius"><i class="icon-plus"></i> 添加订单</a>
        </shiro:hasPermission>
    </span>



    </table>

    <div id="pageNav" class="pageNav"></div>
</div>


<script type="application/javascript">
    $(function() {
        $('#orderTable').bootstrapTable({
            url: 'order/list.do',//ajax请求的url地址
            /*
                ajax请求以后回调函数的处理
                后台使用返回的PageInfo对象中的 结果 级的key是list，总条数是total
                而前台bootstrapTable插件需要的数据的key叫做rows ，总条数也是叫做total
                那么出现一个问题 : 总条数的key能对上，结果集对不上，就需要在ajax请求完成回调
                responseHandler 这个函数方法处理一下
                并且在自定义一个 json,rows做为key，返回json的 list作为值
                    total：还是total
                这样才能满足 bootstrapTable插件数据的需要
            */
            responseHandler: function(res) {
                /*
                    res: 后台分页对象PageInfo返回对应的json对象
                    res.list : 结果集
                    res.total : 总记录数
                */
                var data =  {rows: res.list,total: res.total};
                return data;
            },
            pagination: true,
            toolbar: "#toolbar",//顶部显示的工具条（添加和批量删除的）
            contentType: 'application/x-www-form-urlencoded',//条件搜索的时候ajax请求给后台数据的数据类型（条件搜索post提交必须设置）
            search: true,//是否显示搜索框
            pageNumber: 1,//默认的页面 第一页
            pageSize: 10,//默认的每页条数
            //pageList:[10,25,50,100],//每页能显示的条数
            sidePagination: "server",//是否是服务器分页，每次请求都是对应的10条数据，下一页发送ajax请求
            paginationHAlign: 'right', //底部分页条
            showToggle: true, //是否显示详细视图和列表视图的切换按钮
            cardView: false, //是否显示详细视图
            showColumns: true, //是否显示所有的列
            showRefresh: true, //是否显示刷新按钮

            detailView: true,//父子表

            columns: [ //表格显示数据对应的表头设置，
                { checkbox: true},//是否显示前台的复选框（多选）
                /*
                    每列数据的表头的设置
                    filed:返回json数据对应数据的key
                    title:表头要显示的名
                */
                {field: 'orderId',title: '编号'},
                {field: 'shippingName',title: '发货人'},
                {field: 'shippingPhone',title: '发货电话'},
                {field: 'takeName',title: '取件人'},
                {field: 'takePhone',title: '取件电话'},
                {field: 'orderRemark',title: '订单描述'},
                {field: 'orderStatus',title: '订单状态',formatter:orderFormatter},
                {field: 'realname',title: '业务员'},
                {field: 'customerName',title: '客户名'},
                {field: 'paymentMethod',title: '付款方式'},
                {field: 'interval',title: '到达区域'},
                {field: 'takeMethod',title: '取件方式'},
                {field: 'freightMethod',title: '货运方式'},
                //操作列的设置（删除，修改）
                /*
                formatter: 格式化这一行，回调一个函数
                */
                {
                    field:'orderId',
                    title:'操作',
                    align:'center',
                    formatter:operationFormatter

                }],
            /*发送请求的参数，
                params: bootstrapTable的插件内部参数对象包含如下参数
                limit, offset, search, sort
                limit：每页条数
                offset：每页的结束位置
                search:搜索框对应的值
                sort：排序
            */
            queryParams: function(params) {
                //此方法在用户分页或者搜索的时候回自动发送ajax请求调用，并把对应的参数传递给后台
                return {
                    pageNum: params.offset / params.limit + 1, //页码
                    pageSize: params.limit, //页面大小
                    keyword: params.search
                };
            },
            onExpandRow:function(index,row,$detail){
                var orderId = row.orderId;

                var cur_table = $detail.html('<table></table>').find('table');

                $(cur_table).bootstrapTable({
                    url:"order/detail.do",
                    method:'get',
                    contentType:'application/json;charset=UTF-8',
                    dataType:'json',
                    queryParams:{orderId:orderId},
                    clickToSelect:true,
                    columns:[

                        {field:'orderDetailId',title:'订单明细编号'},
                        {field:'goodsName',title:'货品名称'},
                        {field:'goodsNumber',title:'获取数量'},
                        {field:'goodsTotal',title:'总价'},
                        {field:'goodsRemark',title:'货品描述'}

                        ]
                })
            }
        })

    });



    function orderFormatter(value,row,index){
        if("1"==value){
            return "取件";
        }else if("2"==value){
            return "运送中";
        }
        return"完成";
    }



    /*
        操作行格式化对应的函数
        value: 当前列的值
        row：当前行的值
        index：索引位置
    */

    function operationFormatter(value,row,index){
        var html = '<shrio:hasPermission name="order:update">';
        html +='<a title="编辑" href="javascript:;" onclick="order_edit('+row.orderId+')" style="text-decoration:none;color: #00B83F"><i class="Hui-iconfont"></i></a>&nbsp;&nbsp;&nbsp;';
        html += '</shrio:hasPermission>';
        html += '<shrio:hasPermission name="order:delete">';
        html += '<a title="删除" href="javascript:;" onclick="order_del('+row.orderId+')" class="ml-5" style="text-decoration:none;color: red"><i class="Hui-iconfont"></i></a>';
        html += '</shrio:hasPermission>';
        return html;
    }

</script>
<script type="application/javascript">
    function refreshTable() {
        $("#orderTable").bootstrapTable("refresh");

    }

    function batch_del() {

        layer.confirm('确认要删除吗？',function (index) {
            var ids = $('#orderTable').bootstrapTable('getAllSelections');
            var orderIds = new Array();
            for (var i=0;i<ids.length;i++){
                orderIds.push(ids[i].orderId);
            }

            $.post("order/batchDelete.do",{'orderIds':orderIds},function (data) {
                layer.msg(data.msg,{time:1000,icon:data.code});
                if (data.code == 1){
                    refreshTable();
                }
            })
        })

    }

    function order_edit(id) {
        /*layer_show("修改订单","order/edit.do?orderId="+id,800,500);*/
        layer.open(
            {
                type:2,
                title:"修改订单",
                shade:[0],
                area:['100%','100%'],
                content:["order/edit.do?orderId="+id,'yes'] //iframe的url，no代表不显示滚动条

            }
        )
    }

    function order_add(){
        /*layer_show("添加订单","order/edit.do",800,500);*/
        layer.open(
            {
                type:2,
                title:"添加订单",
                shade:[0],
                area:['100%','100%'],
                content:['order/edit.do','yes'] //iframe的url，no代表不显示滚动条

            }
        )
    }

    function order_del(id) {
        layer.confirm('确认要删除吗？',function (index) {
            $.post("order/delete.do",{orderId:id},function (data) {
                layer.msg(data.msg,{time:1000,icon:data.code});
                if (data.code == 1){
                    refreshTable();
                }
            })
        })

    }
</script>





</body>
</html>

