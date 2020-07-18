package com.lin.logistics.service.impl;

import com.fasterxml.jackson.databind.annotation.JsonAppend;
import com.lin.logistics.mapper.PermissionMapper;
import com.lin.logistics.mapper.RoleMapper;
import com.lin.logistics.pojo.Permission;
import com.lin.logistics.pojo.PermissionExample;
import com.lin.logistics.pojo.Role;
import com.lin.logistics.pojo.RoleExample;
import com.lin.logistics.service.PermissionService;
import com.lin.logistics.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:24:59
 */

@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public int deleteByExample(PermissionExample example) {
        return permissionMapper.deleteByExample(example);
    }

    @Override
    public int deleteByPrimaryKey(Long permissionId) {
        return permissionMapper.deleteByPrimaryKey(permissionId);
    }

    @Override
    public int insert(Permission record) {
        return permissionMapper.insert(record);
    }

    @Override
    public int insertSelective(Permission record) {
        return permissionMapper.insertSelective(record);
    }

    @Override
    public List<Permission> selectByExample(PermissionExample example) {
        return permissionMapper.selectByExample(example);
    }

    @Override
    public Permission selectByPrimaryKey(Long permissionId) {
        return permissionMapper.selectByPrimaryKey(permissionId);
    }

    @Override
    public int updateByExampleSelective(Permission record, PermissionExample example) {
        return permissionMapper.updateByExampleSelective(record,example);
    }

    @Override
    public int updateByExample(Permission record, PermissionExample example) {
        return permissionMapper.updateByExample(record,example);
    }

    @Override
    public int updateByPrimaryKeySelective(Permission record) {
        return permissionMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Permission record) {
        return permissionMapper.updateByPrimaryKey(record);
    }
}
