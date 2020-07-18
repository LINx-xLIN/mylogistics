package com.lin.logistics.service;

import com.lin.logistics.pojo.Order;
import com.lin.logistics.pojo.OrderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface OrderService {


    int deleteByExample(OrderExample example,List<Long> orderIds);

    int deleteByPrimaryKey(Long orderId);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Long orderId);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

}
