package com.lin.logistics.service.impl;

import com.lin.logistics.mapper.BaseDataMapper;
import com.lin.logistics.pojo.BaseData;
import com.lin.logistics.pojo.BaseDataExample;
import com.lin.logistics.service.BaseDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:24:59
 */

@Service
public class BaseDataServiceImpl implements BaseDataService {
    @Autowired
    private BaseDataMapper baseDataMapper;

    @Override
    public int deleteByExample(BaseDataExample example) {
        return baseDataMapper.deleteByExample(example);
    }

    @Override
    public int deleteByPrimaryKey(Long baseDataId) {
        return baseDataMapper.deleteByPrimaryKey(baseDataId);
    }

    @Override
    public int insert(BaseData record) {
        return baseDataMapper.insert(record);
    }

    @Override
    public int insertSelective(BaseData record) {
        return baseDataMapper.insertSelective(record);
    }

    @Override
    public List<BaseData> selectByExample(BaseDataExample example) {
        return baseDataMapper.selectByExample(example);
    }

    @Override
    public BaseData selectByPrimaryKey(Long baseDataId) {
        return baseDataMapper.selectByPrimaryKey(baseDataId);
    }

    @Override
    public int updateByExampleSelective(BaseData record, BaseDataExample example) {
        return baseDataMapper.updateByExampleSelective(record,example);
    }

    @Override
    public int updateByExample(BaseData record, BaseDataExample example) {
        return baseDataMapper.updateByExample(record,example);
    }

    @Override
    public int updateByPrimaryKeySelective(BaseData record) {
        return baseDataMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(BaseData record) {
        return baseDataMapper.updateByPrimaryKey(record);
    }
}
