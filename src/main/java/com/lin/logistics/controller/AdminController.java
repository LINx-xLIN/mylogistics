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

import net.sf.jsqlparser.statement.select.First;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.mybatis.generator.codegen.ibatis2.model.ExampleGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.management.snmp.AdaptorBootstrap;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author LINx_x
 * @date 2019/9/26 15:27:33
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;


    @RequestMapping("/login")
    public String login(HttpServletRequest req,Model m){

        String shiroLoginFailure = (String) req.getAttribute("shiroLoginFailure");

        System.out.println(shiroLoginFailure);

        if(shiroLoginFailure!=null){
            if(UnknownAccountException.class.getName().equals(shiroLoginFailure)){
                m.addAttribute("errorMsg","亲，帐号不存在");
            }else if(IncorrectCredentialsException.class.getName().equals(shiroLoginFailure)){
                m.addAttribute("errorMsg","亲，密码错误");
            }
        }
        return "forward:/login.jsp";
    }





    @RequestMapping("/adminPage")
    @RequiresPermissions("admin:adminPage")
    public String adminPage(){
        return "adminPage";
    }

    @RequestMapping("/list")
    @RequiresPermissions("admin:list")
    @ResponseBody
    public PageInfo<User> list(String keyword, @RequestParam(defaultValue = "1") Integer pageNum,@RequestParam(defaultValue = "10")Integer pageSize){
        PageHelper.startPage(pageNum,pageSize);
        UserExample example = new UserExample();



        if(StringUtils.isNotBlank(keyword)){
            UserExample.Criteria criteria = example.createCriteria();
            criteria.andUsernameLike("%"+keyword+"%");
            UserExample.Criteria criteria1 = example.createCriteria();
            criteria1.andRealnameLike("%"+keyword+"%");
            example.or(criteria1);

        }
        List<User> users = userService.selectByExample(example);
        PageInfo<User> pageInfo = new PageInfo<>(users);
        return pageInfo;

    }

    @RequestMapping("/delete")
    @RequiresPermissions("admin:delete")
    @ResponseBody
    public MessageObject delete(Long userId){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        int row = userService.deleteByPrimaryKey(userId);
        if(row == 1){
             mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/batchDelete")
    @RequiresPermissions("admin:batchDelete")
    @ResponseBody
    public MessageObject batchDelete(@RequestParam(value="userIds[]") List<Long> userIds){
        MessageObject mo = new MessageObject(0, "删除数据失败，请联系管理员");
        UserExample userExample = new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUserIdIn(userIds);
        int row = userService.deleteByExample(userExample);
        if(row == userIds.size()){
            mo = new MessageObject(1, "删除数据成功");
        }
        return mo;
    }

    @RequestMapping("/edit")
    public String edit(Model m, Long userId){

        if(userId != null){
            User user = userService.selectByPrimaryKey(userId);
            m.addAttribute("user",user);

        }
        RoleExample example = new RoleExample();
        List<Role> roles = roleService.selectByExample(example);
        m.addAttribute("roles",roles);


        return "adminEdit";
    }
    @RequestMapping("/checkUsername")
    @ResponseBody
    public boolean checkUsername(String username){
        UserExample example = new UserExample();
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andUsernameEqualTo(username);
        List<User> users = userService.selectByExample(example);
        return !(users.size()>0);
    }
    @RequestMapping("/insert")
    @ResponseBody
    @RequiresPermissions("admin:insert")
    public MessageObject insert(User user){
        user.setCreateDate(new Date());

        //加密密码   MD5（原密码 + 盐）* 散列三次
        //生成盐（随机数）5位
        String salt = UUID.randomUUID().toString().substring(0, 5);
        //设置user对象的盐 salt
        user.setSalt(salt);

        //使用md5加密
        Md5Hash saltPassword = new Md5Hash(user.getPassword(), salt, 3);

        //修改密码
        user.setPassword(saltPassword.toString());


        MessageObject mo = new MessageObject(0, "新增数据失败，请联系管理员");
        int row = userService.insert(user);
        if(row == 1){
             mo = new MessageObject(1, "新增数据成功");
        }
        return  mo;
    }
    @RequestMapping("/update")
    @ResponseBody
    @RequiresPermissions("admin:update")
    public MessageObject update(User user){
        MessageObject mo = new MessageObject(0, "修改数据失败，请联系管理员");

        if(StringUtils.isBlank(user.getPassword())) {
            user.setPassword(null);
        }


        if(StringUtils.isNotBlank(user.getPassword())) {

            //加密密码   MD5（原密码 + 盐）* 散列三次
            //生成盐（随机数）5位
            String salt = UUID.randomUUID().toString().substring(0, 5);
            //设置user对象的盐 salt
            user.setSalt(salt);

            //使用md5加密
            Md5Hash saltPassword = new Md5Hash(user.getPassword(), salt, 3);

            //修改密码
            user.setPassword(saltPassword.toString());

        }



        int row = userService.updateByPrimaryKeySelective(user);
        if(row==1){
             mo = new MessageObject(1, "修改数据成功");
        }
        return mo;
    }
}


