package com.lin.logistics.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.mo.MessageObject;
import com.lin.logistics.pojo.*;
import com.lin.logistics.service.PermissionService;
import com.lin.logistics.service.RoleService;
import com.lin.logistics.service.PermissionService;
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
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;
    @Autowired
    private RoleService roleService;

    @RequestMapping("/permissionPage")
    @RequiresPermissions("permission:permissionPage")
    public String permissionPage(){
        return "permissionPage";
    }

    @RequestMapping("/list")
    @ResponseBody
    @RequiresPermissions("permission:list")
    public PageInfo<Permission> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        PermissionExample example = new PermissionExample();



        if(StringUtils.isNotBlank(keyword)){
            PermissionExample.Criteria criteria = example.createCriteria();
            criteria.andNameLike("%"+keyword+"%");
            PermissionExample.Criteria criteria1 = example.createCriteria();
            criteria1.andTypeLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<Permission> permissions = permissionService.selectByExample(example);
        PageInfo<Permission> pageInfo = new PageInfo<>(permissions);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("permission:delete")
    public MessageObject delete(Long permissionId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = permissionService.deleteByPrimaryKey(permissionId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @ResponseBody
    @RequiresPermissions("permission:batchDelete")
    public MessageObject batchDelete(@RequestParam(value="permissionIds[]") List<Long> permissionIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        PermissionExample permissionExample = new PermissionExample();
        PermissionExample.Criteria criteria = permissionExample.createCriteria();
        criteria.andPermissionIdIn(permissionIds);
        int row = permissionService.deleteByExample(permissionExample);
        if(row == permissionIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long permissionId){

        if(permissionId != null){
            Permission permission = permissionService.selectByPrimaryKey(permissionId);
            m.addAttribute("permission",permission);

        }
        PermissionExample example = new PermissionExample();
        List<Permission> permissions = permissionService.selectByExample(example);
        m.addAttribute("permissions",permissions);


        return "permissionEdit";
    }
    @RequestMapping("/checkPermissionname")
    @ResponseBody
    public boolean checkPermissionname(String name){
        PermissionExample example = new PermissionExample();
        PermissionExample.Criteria criteria = example.createCriteria();
        criteria.andNameEqualTo(name);
        List<Permission> permissions = permissionService.selectByExample(example);
        return !(permissions.size()>0);
    }
    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("permission:insert")
    public MessageObject insert(Permission permission){
        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = permissionService.insert(permission);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("permission:update")
    public MessageObject update(Permission permission){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        int row = permissionService.updateByPrimaryKeySelective(permission);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }
    @RequestMapping("/getAllPermission")
    @ResponseBody
    public List<Permission> getAllPermission(){
        PermissionExample example = new PermissionExample();
        List<Permission> permissions = permissionService.selectByExample(example);
        return permissions;
    }


}


