package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService implements IUserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserConverter userConverter;

    @Override
    public UserDTO findOneByUserNameAndStatus(String name, int status) {
        return userConverter.convertToDto(userRepository.findOneByUserNameAndStatus(name, status));
    }

    @Override
    public UserDTO findOne(Long id) {
        return userConverter.convertToDto(userRepository.findOne(id));
    }

    @Override
    public Map<Long, String> getStaffMap() {
        Map<Long, String> result = new HashMap<>();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1,"STAFF");
        StaffResponseDTO responseDTO = new StaffResponseDTO();
        for(UserEntity item :staffs){
            result.put(item.getId(), item.getFullName());
            responseDTO.setStaffId(item.getId());
            responseDTO.setFullName(item.getFullName());
        }

        return result;
    }

    @Override
    public List<UserDTO> findAll(UserDTO model) {
        List<UserEntity> entities = userRepository.findAll();
        List<UserDTO> result = new ArrayList<>();
        for(UserEntity entity : entities){
            result.add(userConverter.convertToDto(entity));
        }
        return result;
    }
}
