package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;

import java.awt.print.Pageable;
import java.util.List;
import java.util.Map;

public interface IBuildingService {
    List<BuildingDTO> findAll(BuildingDTO model);
    List<BuildingDTO> findAll(Map<String, String> params, String[] types) ;
    BuildingDTO findOne(Long id);
    Map<String, String> getDistrictMap();
    Map<String, String> getTypeMap();
    List<StaffResponseDTO> getStaff(long id);
    BuildingDTO save(BuildingDTO buildingDTO);
    void delete(Long[] ids);
    Boolean checkStaff(Long id, Long staffId);
    int getTotalItems(BuildingDTO buildingDTO);
    StaffResponseDTO assgmentStaff(StaffResponseDTO responseDTO);

}
