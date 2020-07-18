package com.lin.logistics.service;

import com.lin.logistics.pojo.Role;
import com.lin.logistics.pojo.RoleExample;
import com.lin.logistics.pojo.User;
import com.lin.logistics.pojo.UserExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface RoleService {

    int deleteByExample(RoleExample example);

    int deleteByPrimaryKey(Long roleId);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Long roleId);

    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

}
