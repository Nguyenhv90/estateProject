package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;

import java.util.List;

public interface ICustomerService {
    List<CustomerDTO> findCustomer(CustomerDTO customerDTO);
    void save(CustomerDTO customerDTO);
    void update(CustomerDTO customerDTO);
    CustomerDTO findOne(Long id);
    void delete(Long[] ids);
}
