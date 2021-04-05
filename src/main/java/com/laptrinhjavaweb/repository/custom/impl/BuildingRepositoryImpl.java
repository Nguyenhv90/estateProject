package com.laptrinhjavaweb.repository.custom.impl;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.repository.custom.BuildingRepositoryCustom;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.awt.print.Pageable;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<BuildingEntity> findAll(BuildingDTO model) {
        StringBuilder sql = new StringBuilder("select DISTINCT  * from building b ");
        if(model.getStaffId() != null){
            sql.append("left join assignmentbuilding ab on ab.buildingid = b.id ");
        }
        sql.append("where 1=1 ");
        sql = buildSqlSpecial( model, sql);
        sql = builSqlCommon(model,sql);
        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        return query.setFirstResult((model.getPage()-1)*model.getLimit())
                .setMaxResults(model.getLimit())
                .getResultList();
    }
    @Override
    public BigInteger getTotalItems(BuildingDTO model) {
        StringBuilder sql = new StringBuilder("Select count(b.id) from building b ");
        if(model.getStaffId() != null){
            sql.append("left join assignmentbuilding ab on ab.buildingid = b.id ");
        }
        sql.append("where 1=1 ");
        sql = buildSqlSpecial( model, sql);
        sql = builSqlCommon(model,sql);

        sql.append(";");
        Query query = entityManager.createNativeQuery(sql.toString());
        return (BigInteger) query.getSingleResult();
    }

    private StringBuilder builSqlCommon(BuildingDTO model, StringBuilder sql) {
        try {
            Field[] fields = BuildingDTO.class.getDeclaredFields();
            for(Field field : fields){
                field.setAccessible(true);
                if(!field.getName().equals("buildingTypes") && !field.getName().equals("staffId")
                        && !field.getName().startsWith("areaRent") && !field.getName().startsWith("costRent") && field.get(model) != null){
                    if(field.getType().getName().equals("java.lang.String") && StringUtils.isNotBlank(field.get(model).toString())){
                        sql.append(" and b."+field.getName().toLowerCase()+" like '%"+field.get(model)+"%' ");
                    }else if(field.getType().getName().equals("java.lang.Integer")){
                        sql.append(" and b."+field.getName().toLowerCase()+" ="+field.get(model));
                    }
                }
            }
            return sql;
        }catch (Exception e){
            return null;
        }
    }

    private StringBuilder buildSqlSpecial(BuildingDTO model, StringBuilder sql) {
        if(model.getAreaRentFrom() != null  || model.getAreaRentTo() != null){
            sql.append("and EXISTS (SELECT * FROM rentarea ra WHERE ra.buildingid = b.id " );
            if(model.getAreaRentFrom() != null ){
                sql.append("and ra.value >= "+model.getAreaRentFrom()+" ");
            }
            if(model.getAreaRentTo() != null ){
                sql.append("and ra.value <= "+model.getAreaRentTo()+" ");
            }
            sql.append("}");
        }
        if (model.getBuildingTypes().length > 0){
            sql.append(" and ( ");
//            int i=1;
//            for (String item :model.getBuildingTypes() ){
//                model.getBuildingTypes()[i] = "b.type like '%"+item+"%' ";
//                i++;
//            }
//            String sqltypes = String.join(" OR ", model.getBuildingTypes());
//            sql.append(sqltypes);
            String sqlType = Arrays.stream(model.getBuildingTypes())
                    .map(item -> "b.type like '%"+item+"%' ")
                    .collect(Collectors.joining(" OR "));
            sql.append(sqlType);
            sql.append(" )");
        }
        if(model.getCostRentFrom() != null  ) {
            sql.append(" and b.rentcost >="+model.getCostRentFrom()+" ");
        }
        if(model.getCostRentTo() != null  ) {
            sql.append(" and b.rentcost <="+model.getCostRentTo()+" ");
        }
        if(model.getStaffId() != null ) {
            sql.append(" and ab.staffid ="+model.getStaffId()+"");
        }

        return sql;
    }
    @Override
    public void saveAssignmentBuilding(StaffResponseDTO staff) {
        String sql = "insert into assignmentbuilding(buildingid, staffid) values ("+ staff.getBuildingId()+","+staff.getStaffId()+")";
        Query query = entityManager.createQuery(sql.toString());
        query.executeUpdate();
    }
    @Override
    public List<BigInteger> findAssgmentStaff(Long id) {
        String sql = "select ab.staffid from assignmentbuilding ab where ab.buildingid = "+id +" group by ab.staffid;";
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList();
    }

}
