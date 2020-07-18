package com.lin.logistics.test;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lin.logistics.pojo.User;
import com.lin.logistics.pojo.UserExample;
import com.lin.logistics.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

/**
 * @author LINx_x
 * @date 2019/9/26 13:43:03
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    public void deleteByPrimaryKey() {
    }

    @Test
    public void insert() {
    }

    @Test
    public void selectByExample() {
    }

    @Test
    public void selectByPrimaryKey() {
        System.out.println(userService.selectByPrimaryKey(1L));
    }

    @Test
    public void updateByPrimaryKeySelective() {
    }

    @Test
    public void testQuery(){
        String keyword="min";
        Integer pageNum = 1;
        Integer pageSize = 10;

        //开启分页（注意一定要方在查询代码之前执行）
        PageHelper.startPage(pageNum,pageSize);

        UserExample example = new UserExample();
        //条件
        UserExample.Criteria criteria = example.createCriteria();
        criteria.andRealnameLike("%"+keyword+"%");

        //查询结果（没有分页钱数据）
        List<User> users = userService.selectByExample(example);
        /**创建分页对象
         *把没有分页查询的数据创建一个分页对象
         *此对象封装了分页的所有数据
         *1.数据集合
         *2.总条数
         *3.下一页
         *4.每页条数
         *5.当前页
         *等等等
         */
        PageInfo<User> pageInfo = new PageInfo<>(users);

        System.out.println("每页结果集 :"+pageInfo.getList());
        System.out.println("总记录数 :"+pageInfo.getTotal());
        System.out.println("当前页 :"+pageInfo.getPageNum());
        System.out.println("每页条数 :"+pageInfo.getPageSize());
        System.out.println("下一页 :"+pageInfo.getNextPage());
    }

}
