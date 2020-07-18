package com.lin.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.mo.MessageObject;
import com.lin.logistics.pojo.Role;
import com.lin.logistics.pojo.RoleExample;
import com.lin.logistics.pojo.User;
import com.lin.logistics.pojo.UserExample;
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

import java.util.Date;
import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/26 15:27:33
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @RequestMapping("/rolePage")
    @RequiresPermissions("role:rolePage")
    public String adminPage(){
        return "rolePage";
    }

    @RequestMapping("/list")
    @ResponseBody
    @RequiresPermissions("role:list")
    public PageInfo<Role> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum,@RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        RoleExample example = new RoleExample();



        if(StringUtils.isNotBlank(keyword)){
            RoleExample.Criteria criteria = example.createCriteria();
            criteria.andRolenameLike("%"+keyword+"%");
            RoleExample.Criteria criteria1 = example.createCriteria();
            criteria1.andRemarkLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<Role> roles = roleService.selectByExample(example);
        PageInfo<Role> pageInfo = new PageInfo<>(roles);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("role:delete")
    public MessageObject delete(Long roleId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = roleService.deleteByPrimaryKey(roleId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions("role:batchDelete")
    public MessageObject batchDelete(@RequestParam(value="roleIds[]") List<Long> roleIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria = roleExample.createCriteria();
        criteria.andRoleIdIn(roleIds);
        int row = roleService.deleteByExample(roleExample);
        if(row == roleIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long roleId){

        if(roleId != null){
            Role role = roleService.selectByPrimaryKey(roleId);
            m.addAttribute("role",role);

        }
        RoleExample example = new RoleExample();
        List<Role> roles = roleService.selectByExample(example);
        m.addAttribute("roles",roles);


        return "roleEdit";
    }
    @RequestMapping("/checkRolename")
    @ResponseBody
    public boolean checkRolename(String rolename){
        RoleExample example = new RoleExample();
        RoleExample.Criteria criteria = example.createCriteria();
        criteria.andRolenameEqualTo(rolename);
        List<Role> users = roleService.selectByExample(example);
        return !(users.size()>0);
    }
    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("role:insert")
    public MessageObject insert(Role role){

        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = roleService.insert(role);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("role:update")
    public MessageObject update(Role role){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        int row = roleService.updateByPrimaryKeySelective(role);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }
}


