package com.laptrinhjavaweb.repository.custom;

import com.laptrinhjavaweb.entity.RentAreaEntity;

import java.util.List;

public interface RentAreaRepositoryCustom {
    List<Integer> findValue(Long id);
    List<Long> findIdByBuildingid(Long id);
    void saveRentArea(RentAreaEntity rentAreaEntity);
}
