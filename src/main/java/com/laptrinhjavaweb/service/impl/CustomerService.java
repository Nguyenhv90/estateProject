package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.converter.CustomerConverter;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.repository.CustomerRepository;
import com.laptrinhjavaweb.service.ICustomerService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
@Service
public class CustomerService implements ICustomerService {
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private CustomerConverter customerConverter;

    @Override
    public List<CustomerDTO> findCustomer(CustomerDTO customerDTO) {
        List<CustomerDTO> results = new ArrayList<>();
        List<CustomerEntity> entities = customerRepository.findAll(customerDTO);
        for(CustomerEntity item: entities){
            customerDTO = customerConverter.convertToDto(item);
            results.add(customerDTO);
        }
        return results;
    }

    @Override
    @Transactional
    public void save(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = customerConverter.convertToEntity(customerDTO);
        customerRepository.save(customerEntity);
    }

    @Override
    @Transactional
    public void update(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = customerConverter.convertToEntity(customerDTO);
        customerRepository.save(customerEntity);
    }

    @Override
    @Transactional
    public CustomerDTO findOne(Long id) {
        CustomerEntity entities = customerRepository.findOne(id);
        return customerConverter.convertToDto(entities);
    }

    @Override
    @Transactional
    public void delete(Long[] ids) {
        try{
            for (long id: ids){
                customerRepository.delete(id);
            }
        }catch (Exception e){
            throw e;
        }
    }
}
