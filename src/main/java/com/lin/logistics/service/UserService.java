package com.lin.logistics.service;

import com.lin.logistics.pojo.User;
import com.lin.logistics.pojo.UserExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface UserService {


    int deleteByPrimaryKey(Long userId);

    int insert(User record);

    int deleteByExample(UserExample example);

    int updateByExampleSelective(@Param("record") User record, @Param("example") UserExample example);

    List<User> selectByExample(UserExample example);

    User selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(User record);

}
