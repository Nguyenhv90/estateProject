package com.laptrinhjavaweb.controller.admin.api;

import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.service.ICustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api/customer")
public class CustomerAPI {

    @Autowired
    ICustomerService customerService;

    @PostMapping
    public CustomerDTO createCustomer(@RequestBody CustomerDTO newCustomer){
        customerService.save(newCustomer);
        return newCustomer;
    }
    @PutMapping("/{id}")
    public CustomerDTO updateCustomer(@RequestBody CustomerDTO updateCustomer, @PathVariable("id") Long id ) {
        updateCustomer.setId(id);
        customerService.update(updateCustomer);
        return updateCustomer;
    }

    @DeleteMapping
    public void deleteBuilding(@RequestBody Long[] ids ) { ;
        customerService.delete(ids);
    }
}
