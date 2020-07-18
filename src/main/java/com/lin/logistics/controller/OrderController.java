package com.lin.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.mo.MessageObject;
import com.lin.logistics.pojo.*;
import com.lin.logistics.service.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/26 15:27:33
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderDetailService orderDetailService;
    @Autowired
    private UserService userService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private BaseDataService baseDataService;

    @RequestMapping("/financePage")
    @RequiresPermissions("order:financePage")
    public String financePage(){
        return "financePage";
    }


    @RequestMapping("/checkOrderPage")
    @RequiresPermissions("order:checkOrderPage")
    public String checkOrderPage(){
        return "checkOrderPage";
    }

    @RequestMapping("/orderPage")
    @RequiresPermissions("order:orderPage")
    public String orderPage(){
        return "orderPage";
    }

    @RequestMapping("/detail")
    @ResponseBody
    public List<OrderDetail> detail(Long orderId){

        OrderDetailExample example = new OrderDetailExample();
        OrderDetailExample.Criteria criteria = example.createCriteria();
        criteria.andOrderIdEqualTo(orderId);

        List<OrderDetail> orderDetails = orderDetailService.selectByExample(example);
        return orderDetails;
    }

    @RequestMapping("/list")
    @ResponseBody
    @RequiresPermissions("order:list")
    public PageInfo<Order> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        OrderExample example = new OrderExample();
        example.setOrderByClause("a.order_id");



        if(StringUtils.isNotBlank(keyword)){
            OrderExample.Criteria criteria = example.createCriteria();
            criteria.andShippingNameLike("%"+keyword+"%");
            OrderExample.Criteria criteria1 = example.createCriteria();
            criteria1.andTakeNameLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<Order> orders = orderService.selectByExample(example);
        PageInfo<Order> pageInfo = new PageInfo<>(orders);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("order:delete")
    public MessageObject delete(Long orderId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = orderService.deleteByPrimaryKey(orderId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions("order:batchDelete")
    public MessageObject batchDelete(@RequestParam(value="orderIds[]") List<Long> orderIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        OrderExample orderExample = new OrderExample();

        OrderExample.Criteria criteria = orderExample.createCriteria();
        criteria.andOrderIdIn(orderIds);
        int row = orderService.deleteByExample(orderExample,orderIds);
        if(row == orderIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long orderId){

        if(orderId != null){

            Order order = orderService.selectByPrimaryKey(orderId);



            m.addAttribute("order",order);

        }
        //业务员
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andRoleIdEqualTo(3L);
        List<User> users = userService.selectByExample(userExample);
        m.addAttribute("users",users);
        //客户
        CustomerExample customerExample = new CustomerExample();
        CustomerExample.Criteria customerExampleCriteria = customerExample.createCriteria();
        List<Customer> customers = customerService.selectByExample(customerExample);
        m.addAttribute("customers",customers);
        //到达区域
        BaseDataExample baseDataExample = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria = baseDataExample.createCriteria();
        baseDataExampleCriteria.andParentIdEqualTo(1L);
        List<BaseData> intervals = baseDataService.selectByExample(baseDataExample);
        m.addAttribute("intervals",intervals);
        //付款方式
        BaseDataExample baseDataExample1 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria1 = baseDataExample1.createCriteria();
        baseDataExampleCriteria1.andParentIdEqualTo(12L);
        List<BaseData> payments = baseDataService.selectByExample(baseDataExample1);
        m.addAttribute("payments",payments);
        //货运方式
        BaseDataExample baseDataExample2 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria2 = baseDataExample2.createCriteria();
        baseDataExampleCriteria2.andParentIdEqualTo(8L);
        List<BaseData> freights = baseDataService.selectByExample(baseDataExample2);
        m.addAttribute("freights",freights);
        //取件方式
        BaseDataExample baseDataExample3 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria3 = baseDataExample3.createCriteria();
        baseDataExampleCriteria3.andParentIdEqualTo(5L);
        List<BaseData> fetchTypes = baseDataService.selectByExample(baseDataExample3);
        m.addAttribute("fetchTypes",fetchTypes);
        //单位
        BaseDataExample baseDataExample4 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria4 = baseDataExample4.createCriteria();
        baseDataExampleCriteria4.andParentIdEqualTo(16L);
        List<BaseData> units = baseDataService.selectByExample(baseDataExample4);
        m.addAttribute("units",units);


        return "orderEdit";
    }

    @RequestMapping("/checkEdit")
    public String checkEdit(Model m, Long orderId){

        if(orderId != null){

            Order order = orderService.selectByPrimaryKey(orderId);



            m.addAttribute("order",order);

        }
        //业务员
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andRoleIdEqualTo(3L);
        List<User> users = userService.selectByExample(userExample);
        m.addAttribute("users",users);
        //客户
        CustomerExample customerExample = new CustomerExample();
        CustomerExample.Criteria customerExampleCriteria = customerExample.createCriteria();
        List<Customer> customers = customerService.selectByExample(customerExample);
        m.addAttribute("customers",customers);
        //到达区域
        BaseDataExample baseDataExample = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria = baseDataExample.createCriteria();
        baseDataExampleCriteria.andParentIdEqualTo(1L);
        List<BaseData> intervals = baseDataService.selectByExample(baseDataExample);
        m.addAttribute("intervals",intervals);
        //付款方式
        BaseDataExample baseDataExample1 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria1 = baseDataExample1.createCriteria();
        baseDataExampleCriteria1.andParentIdEqualTo(12L);
        List<BaseData> payments = baseDataService.selectByExample(baseDataExample1);
        m.addAttribute("payments",payments);
        //货运方式
        BaseDataExample baseDataExample2 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria2 = baseDataExample2.createCriteria();
        baseDataExampleCriteria2.andParentIdEqualTo(8L);
        List<BaseData> freights = baseDataService.selectByExample(baseDataExample2);
        m.addAttribute("freights",freights);
        //取件方式
        BaseDataExample baseDataExample3 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria3 = baseDataExample3.createCriteria();
        baseDataExampleCriteria3.andParentIdEqualTo(5L);
        List<BaseData> fetchTypes = baseDataService.selectByExample(baseDataExample3);
        m.addAttribute("fetchTypes",fetchTypes);
        //单位
        BaseDataExample baseDataExample4 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria4 = baseDataExample4.createCriteria();
        baseDataExampleCriteria4.andParentIdEqualTo(16L);
        List<BaseData> units = baseDataService.selectByExample(baseDataExample4);
        m.addAttribute("units",units);
        //仓库
        BaseDataExample baseDataExample5 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria5 = baseDataExample5.createCriteria();
        baseDataExampleCriteria5.andParentIdEqualTo(40L);
        List<BaseData> warehouses = baseDataService.selectByExample(baseDataExample5);
        m.addAttribute("warehouses",warehouses);


        return "checkOrderEdit";
    }


    @RequestMapping("/financeEdit")
    public String financeEdit(Model m, Long orderId){
        Order order=null;
        if(orderId != null){

            order = orderService.selectByPrimaryKey(orderId);



            m.addAttribute("order",order);

        }
        //业务员
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andRoleIdEqualTo(3L);
        List<User> users = userService.selectByExample(userExample);
        m.addAttribute("users",users);
        //客户
        CustomerExample customerExample = new CustomerExample();
        CustomerExample.Criteria customerExampleCriteria = customerExample.createCriteria();
        List<Customer> customers = customerService.selectByExample(customerExample);
        m.addAttribute("customers",customers);
        //到达区域
        BaseDataExample baseDataExample = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria = baseDataExample.createCriteria();
        baseDataExampleCriteria.andParentIdEqualTo(1L);
        List<BaseData> intervals = baseDataService.selectByExample(baseDataExample);
        m.addAttribute("intervals",intervals);
        //付款方式
        BaseDataExample baseDataExample1 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria1 = baseDataExample1.createCriteria();
        baseDataExampleCriteria1.andParentIdEqualTo(12L);
        List<BaseData> payments = baseDataService.selectByExample(baseDataExample1);
        m.addAttribute("payments",payments);
        //货运方式
        BaseDataExample baseDataExample2 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria2 = baseDataExample2.createCriteria();
        baseDataExampleCriteria2.andParentIdEqualTo(8L);
        List<BaseData> freights = baseDataService.selectByExample(baseDataExample2);
        m.addAttribute("freights",freights);
        //取件方式
        BaseDataExample baseDataExample3 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria3 = baseDataExample3.createCriteria();
        baseDataExampleCriteria3.andParentIdEqualTo(5L);
        List<BaseData> fetchTypes = baseDataService.selectByExample(baseDataExample3);
        m.addAttribute("fetchTypes",fetchTypes);
        //单位
        BaseDataExample baseDataExample4 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria4 = baseDataExample4.createCriteria();
        baseDataExampleCriteria4.andParentIdEqualTo(16L);
        List<BaseData> units = baseDataService.selectByExample(baseDataExample4);
        m.addAttribute("units",units);
        //仓库
        BaseDataExample baseDataExample5 = new BaseDataExample();
        BaseDataExample.Criteria baseDataExampleCriteria5 = baseDataExample5.createCriteria();
        baseDataExampleCriteria5.andParentIdEqualTo(40L);
        List<BaseData> warehouses = baseDataService.selectByExample(baseDataExample5);
        m.addAttribute("warehouses",warehouses);


        if(order.getOrderStatus().equals(1)){
            return "unfinance";

        }
        Double volumeTotal = 0.0;
        Double weightTotal = 0.0;
        Long moneyTotal = 0L;
        for(OrderDetail orderDetail:order.getOrderDetails()){
             volumeTotal += orderDetail.getGoodsVolume();
            weightTotal += orderDetail.getGoodsWeight();
            moneyTotal += orderDetail.getGoodsTotal();
        }
        m.addAttribute("volumeTotal",volumeTotal);
        m.addAttribute("weightTotal",weightTotal);
        m.addAttribute("moneyTotal",moneyTotal);

        return "financeEdit";

    }



    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("order:insert")
    public MessageObject insert(@RequestBody Order order){
        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = orderService.insert(order);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("order:update")
    public MessageObject update(@RequestBody Order order){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        int row = orderService.updateByPrimaryKeySelective(order);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }



}


