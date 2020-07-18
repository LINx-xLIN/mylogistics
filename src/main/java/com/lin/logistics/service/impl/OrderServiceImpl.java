package com.lin.logistics.service.impl;

import com.lin.logistics.mapper.OrderDetailMapper;
import com.lin.logistics.mapper.OrderMapper;
import com.lin.logistics.pojo.Order;
import com.lin.logistics.pojo.OrderDetail;
import com.lin.logistics.pojo.OrderDetailExample;
import com.lin.logistics.pojo.OrderExample;
import com.lin.logistics.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:24:59
 */

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;


    @Override
    public int deleteByExample(OrderExample example,List<Long> orderIds) {

        int row = orderMapper.deleteByExample(example);

        OrderDetailExample orderDetailExample = new OrderDetailExample();
        OrderDetailExample.Criteria criteria = orderDetailExample.createCriteria();
        criteria.andOrderIdIn(orderIds);
        orderDetailMapper.deleteByExample(orderDetailExample);



        return row;
    }

    @Override
    public int deleteByPrimaryKey(Long orderId) {
        int row = orderMapper.deleteByPrimaryKey(orderId);

        OrderDetailExample orderDetailExample = new OrderDetailExample();
        OrderDetailExample.Criteria criteria = orderDetailExample.createCriteria();
        criteria.andOrderIdEqualTo(orderId);
        orderDetailMapper.deleteByExample(orderDetailExample);

        return row;
    }

    @Override
    public int insert(Order record) {
        int row = orderMapper.insert(record);
        Long orderId = record.getOrderId();
        for(OrderDetail orderDetail:record.getOrderDetails()){
            orderDetail.setOrderId(orderId);
            orderDetailMapper.insert(orderDetail);
        }

        return row;
    }

    @Override
    public int insertSelective(Order record) {
        return orderMapper.insertSelective(record);
    }

    @Override
    public List<Order> selectByExample(OrderExample example) {
        return orderMapper.selectByExample(example);
    }

    @Override
    public Order selectByPrimaryKey(Long orderId) {

        Order order = orderMapper.selectByPrimaryKey(orderId);

        OrderDetailExample orderDetailExample = new OrderDetailExample();
        OrderDetailExample.Criteria criteria = orderDetailExample.createCriteria();
        criteria.andOrderIdEqualTo(orderId);
        List<OrderDetail> orderDetails = orderDetailMapper.selectByExample(orderDetailExample);
        order.setOrderDetails(orderDetails);

        return order;
    }

    @Override
    public int updateByExampleSelective(Order record, OrderExample example) {
        return orderMapper.updateByExampleSelective(record,example);
    }

    @Override
    public int updateByExample(Order record, OrderExample example) {
        return orderMapper.updateByExample(record,example);
    }

    @Override
    public int updateByPrimaryKeySelective(Order record) {

        int row = orderMapper.updateByPrimaryKeySelective(record);




        for(OrderDetail orderDetail:record.getOrderDetails()){
            orderDetailMapper.updateByPrimaryKeySelective(orderDetail);
        }


        return row;
    }

    @Override
    public int updateByPrimaryKey(Order record) {
        return orderMapper.updateByPrimaryKey(record);
    }
}
