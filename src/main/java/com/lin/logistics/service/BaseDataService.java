package com.lin.logistics.service;

import com.lin.logistics.pojo.BaseData;
import com.lin.logistics.pojo.BaseDataExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface BaseDataService {


    int deleteByExample(BaseDataExample example);

    int deleteByPrimaryKey(Long baseDataId);

    int insert(BaseData record);

    int insertSelective(BaseData record);

    List<BaseData> selectByExample(BaseDataExample example);

    BaseData selectByPrimaryKey(Long baseDataId);

    int updateByExampleSelective(@Param("record") BaseData record, @Param("example") BaseDataExample example);

    int updateByExample(@Param("record") BaseData record, @Param("example") BaseDataExample example);

    int updateByPrimaryKeySelective(BaseData record);

    int updateByPrimaryKey(BaseData record);

}
