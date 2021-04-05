package com.laptrinhjavaweb.repository.jdbc;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.RentAreaDTO;

import java.util.List;

public interface IRentAreaRepository {
    RentAreaDTO saveBuildingJDBC(RentAreaDTO rentAreaDTO);
}
