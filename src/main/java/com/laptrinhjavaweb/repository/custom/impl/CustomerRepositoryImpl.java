package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.entity.CustomerEntity;
import com.laptrinhjavaweb.repository.custom.CustomerRepositoryCustom;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<CustomerEntity> findAll(CustomerDTO model) {
        StringBuilder sql = new StringBuilder("select * from customer c ");
        if (model.getStaffId() != null) {
            sql.append("left join assignmentbuilding ab on ab.customerid = c.id ");
        }
        if (StringUtils.isNotEmpty(model.getFullName()) && StringUtils.isNotBlank(model.getFullName())) {
            sql.append(" where c.fullname like '%" + model.getFullName() + "%' ");
        }
        if (StringUtils.isNotEmpty(model.getPhone()) && StringUtils.isNotBlank(model.getPhone())) {
            sql.append("and c.phone like '%" + model.getPhone() + "%' ");
        }
        if (StringUtils.isNotBlank(model.getEmail()) && StringUtils.isNotEmpty(model.getEmail())) {
            sql.append(" and c.email like '%" + model.getEmail() + "%' ");
        }
        if (model.getStaffId() != null) {
            sql.append(" and ab.staffid ==" + model.getStaffId() + "");
        }
        sql.append(" group by c.id;");
        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }
    @Override
    public void saveCustomer(CustomerEntity customerEntity) {
        entityManager.persist(customerEntity);
    }
}
