package com.lin.logistics.service;

import com.lin.logistics.pojo.OrderDetail;
import com.lin.logistics.pojo.OrderDetailExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface OrderDetailService {


    int deleteByExample(OrderDetailExample example);

    int deleteByPrimaryKey(Long orderDetailId);

    int insert(OrderDetail record);

    int insertSelective(OrderDetail record);

    List<OrderDetail> selectByExample(OrderDetailExample example);

    OrderDetail selectByPrimaryKey(Long orderDetailId);

    int updateByExampleSelective(@Param("record") OrderDetail record, @Param("example") OrderDetailExample example);

    int updateByExample(@Param("record") OrderDetail record, @Param("example") OrderDetailExample example);

    int updateByPrimaryKeySelective(OrderDetail record);

    int updateByPrimaryKey(OrderDetail record);

}
