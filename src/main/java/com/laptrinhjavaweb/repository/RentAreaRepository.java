package com.laptrinhjavaweb.repository;

import com.laptrinhjavaweb.entity.RentAreaEntity;
import com.laptrinhjavaweb.repository.custom.RentAreaRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RentAreaRepository extends JpaRepository<RentAreaEntity, Long>, RentAreaRepositoryCustom {
    //RentAreaEntity findByBuildingid(Long buidingid);
    List<Long> findIdByBuilding_Id(Long building);
    void deleteByBuilding_Id(Long buidingid);
}
