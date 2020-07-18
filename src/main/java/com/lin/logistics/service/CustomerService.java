package com.lin.logistics.service;

import com.lin.logistics.pojo.Customer;
import com.lin.logistics.pojo.CustomerExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author LINx_x
 * @date 2019/9/25 20:22:59
 */
public interface CustomerService {


    int deleteByExample(CustomerExample example);

    int deleteByPrimaryKey(Long customerId);

    int insert(Customer record);

    int insertSelective(Customer record);

    List<Customer> selectByExample(CustomerExample example);

    Customer selectByPrimaryKey(Long customerId);

    int updateByExampleSelective(@Param("record") Customer record, @Param("example") CustomerExample example);

    int updateByExample(@Param("record") Customer record, @Param("example") CustomerExample example);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);

}
