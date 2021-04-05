package com.laptrinhjavaweb.repository.jdbc;

import com.laptrinhjavaweb.dto.CustomerDTO;

import java.util.List;

public interface ICustomerRepository {
    List<CustomerDTO> findCustomer(CustomerDTO customerDTO);
    CustomerDTO saveCustomer(CustomerDTO customerDTO);
}
