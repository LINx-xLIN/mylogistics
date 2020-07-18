package com.lin.logistics.service.impl;

import com.lin.logistics.mapper.OrderDetailMapper;
import com.lin.logistics.pojo.OrderDetail;
import com.lin.logistics.pojo.OrderDetailExample;
import com.lin.logistics.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:24:59
 */

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
    @Autowired
    private OrderDetailMapper orderDetailMapper;

    @Override
    public int deleteByExample(OrderDetailExample example) {
        return orderDetailMapper.deleteByExample(example);
    }

    @Override
    public int deleteByPrimaryKey(Long orderDetailId) {
        return orderDetailMapper.deleteByPrimaryKey(orderDetailId);
    }

    @Override
    public int insert(OrderDetail record) {
        return orderDetailMapper.insert(record);
    }

    @Override
    public int insertSelective(OrderDetail record) {
        return orderDetailMapper.insertSelective(record);
    }

    @Override
    public List<OrderDetail> selectByExample(OrderDetailExample example) {
        return orderDetailMapper.selectByExample(example);
    }

    @Override
    public OrderDetail selectByPrimaryKey(Long orderDetailId) {
        return orderDetailMapper.selectByPrimaryKey(orderDetailId);
    }

    @Override
    public int updateByExampleSelective(OrderDetail record, OrderDetailExample example) {
        return orderDetailMapper.updateByExampleSelective(record,example);
    }

    @Override
    public int updateByExample(OrderDetail record, OrderDetailExample example) {
        return orderDetailMapper.updateByExample(record,example);
    }

    @Override
    public int updateByPrimaryKeySelective(OrderDetail record) {
        return orderDetailMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(OrderDetail record) {
        return orderDetailMapper.updateByPrimaryKey(record);
    }
}
