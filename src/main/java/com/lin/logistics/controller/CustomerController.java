package com.lin.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.mo.MessageObject;
import com.lin.logistics.pojo.*;
import com.lin.logistics.service.BaseDataService;
import com.lin.logistics.service.CustomerService;
import com.lin.logistics.service.RoleService;
import com.lin.logistics.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/26 15:27:33
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;
    @Autowired
    private UserService userService;
    @Autowired
    private BaseDataService baseDataService;

    @RequestMapping("/customerPage")
    @RequiresPermissions("customer:customerPage")
    public String customerPage(){
        return "customerPage";
    }

    @RequestMapping("/list")
    @ResponseBody
    @RequiresPermissions("customer:list")
    public PageInfo<Customer> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        CustomerExample example = new CustomerExample();



        if(StringUtils.isNotBlank(keyword)){
            CustomerExample.Criteria criteria = example.createCriteria();
            criteria.andCustomerNameLike("%"+keyword+"%");
            CustomerExample.Criteria criteria1 = example.createCriteria();
            criteria1.andRemarkLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<Customer> customers = customerService.selectByExample(example);
        PageInfo<Customer> pageInfo = new PageInfo<>(customers);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("customer:delete")
    public MessageObject delete(Long customerId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = customerService.deleteByPrimaryKey(customerId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions("customer:batchDelete")
    public MessageObject batchDelete(@RequestParam(value="customerIds[]") List<Long> customerIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        CustomerExample customerExample = new CustomerExample();
        CustomerExample.Criteria criteria = customerExample.createCriteria();
        criteria.andCustomerIdIn(customerIds);
        int row = customerService.deleteByExample(customerExample);
        if(row == customerIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long customerId){

        if(customerId != null){
            Customer customer = customerService.selectByPrimaryKey(customerId);
            m.addAttribute("customer",customer);

        }


        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdEqualTo(3L);
        List<User> users = userService.selectByExample(example);
        m.addAttribute("users",users);

        BaseDataExample example1 = new BaseDataExample();
        BaseDataExample.Criteria criteria1 = example1.createCriteria();
        criteria1.andParentIdEqualTo(1L);
        List<BaseData> baseDatas = baseDataService.selectByExample(example1);
        m.addAttribute("baseDatas",baseDatas);



        return "customerEdit";
    }
    @RequestMapping("/checkCustomername")
    @ResponseBody
    public boolean checkCustomername(String name){
        CustomerExample example = new CustomerExample();
        CustomerExample.Criteria criteria = example.createCriteria();
        criteria.andCustomerNameEqualTo(name);
        List<Customer> customers = customerService.selectByExample(example);
        return !(customers.size()>0);
    }
    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("customer:insert")
    public MessageObject insert(Customer customer){
        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = customerService.insert(customer);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("customer:update")
    public MessageObject update(Customer customer){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        int row = customerService.updateByPrimaryKeySelective(customer);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }
    @RequestMapping("/getAllCustomer")
    @ResponseBody
    public List<Customer> getAllCustomer(){
        CustomerExample example = new CustomerExample();
        List<Customer> customers = customerService.selectByExample(example);
        return customers;
    }


}


