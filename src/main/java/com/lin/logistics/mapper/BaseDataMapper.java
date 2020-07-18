package com.lin.logistics.mapper;

import com.lin.logistics.pojo.BaseData;
import com.lin.logistics.pojo.BaseDataExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BaseDataMapper {
    int deleteByExample(BaseDataExample example);

    int deleteByPrimaryKey(Long baseId);

    int insert(BaseData record);

    int insertSelective(BaseData record);

    List<BaseData> selectByExample(BaseDataExample example);

    BaseData selectByPrimaryKey(Long baseId);

    int updateByExampleSelective(@Param("record") BaseData record, @Param("example") BaseDataExample example);

    int updateByExample(@Param("record") BaseData record, @Param("example") BaseDataExample example);

    int updateByPrimaryKeySelective(BaseData record);

    int updateByPrimaryKey(BaseData record);
}