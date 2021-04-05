package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.entity.RentAreaEntity;
import com.laptrinhjavaweb.repository.custom.RentAreaRepositoryCustom;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class RentAreaRepositoryImpl implements RentAreaRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Integer> findValue(Long id) {
        String sql = "Select ra.value from rentarea as ra where ra.buildingid="+id+";";
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList();
    }

    @Override
    public List<Long> findIdByBuildingid(Long id) {
        String sql = "Select ra.id from rentarea as ra where ra.buildingid="+id+";";
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList();
    }

    @Override
    public void saveRentArea(RentAreaEntity rentAreaEntity) {
        entityManager.persist(rentAreaEntity);
    }
}
