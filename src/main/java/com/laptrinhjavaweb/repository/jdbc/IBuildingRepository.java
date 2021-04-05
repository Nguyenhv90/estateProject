package com.laptrinhjavaweb.repository.jdbc;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.RentAreaDTO;

import java.util.List;

public interface IBuildingRepository {
    List<BuildingDTO> findAllJDBC(BuildingDTO buildingDTO);
    BuildingDTO saveBuildingJDBC( BuildingDTO buildingDTO);
    RentAreaDTO saveRentAreaJDBC(RentAreaDTO rentAreaDTO);
}
