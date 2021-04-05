package com.laptrinhjavaweb.repository.custom;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;

import java.awt.print.Pageable;
import java.math.BigInteger;
import java.util.List;

public interface BuildingRepositoryCustom {
    List<BuildingEntity> findAll(BuildingDTO model);
    BigInteger getTotalItems(BuildingDTO model);
    List<BigInteger> findAssgmentStaff(Long id);
    void saveAssignmentBuilding(StaffResponseDTO requestDTO);
}
