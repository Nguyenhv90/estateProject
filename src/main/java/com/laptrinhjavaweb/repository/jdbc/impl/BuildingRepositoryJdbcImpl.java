package com.laptrinhjavaweb.repository.jdbc.impl;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.dto.RentAreaDTO;
import com.laptrinhjavaweb.repository.jdbc.IBuildingRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Repository
public class BuildingRepositoryJdbcImpl implements IBuildingRepository {
    RentAreaDTO rentAreaDTO = new RentAreaDTO();
    public Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/springbootweb92020";
            String user = "root";
            String password = "230698";
            return DriverManager.getConnection(url, user, password);
        }catch (Exception e) {
            return null;
        }

    }
    public List<BuildingDTO> findAllJDBC(BuildingDTO model) {
        StringBuilder sql = new StringBuilder("select * from building b ");
        if(model.getStaffId() != null){
            sql.append("left join assignmentbuilding ab on ab.buildingid = b.id ");
        }
        if(StringUtils.isNotBlank(model.getName()) && StringUtils.isNotEmpty(model.getName())){
            sql.append("where b.name like '%"+model.getName()+"%' ");
        }
        if(StringUtils.isNotBlank(model.getDistrict()) && StringUtils.isNotEmpty(model.getDistrict())){
            sql.append("and b.district like '%"+model.getDistrict()+"%' ");
        }
        if(model.getNumberOfBasement() != null  ) {
            sql.append(" and b.numberofbasement ="+model.getNumberOfBasement()+" ");
        }
        if(model.getAreaRentFrom() != null  || model.getAreaRentTo() != null){
            sql.append("and EXISTS (SELECT * FROM rentarea ra WHERE ra.buildingid = b.id " );
            if(model.getAreaRentFrom() != null ){
                sql.append("and "+model.getAreaRentFrom()+" ");
            }
            if(model.getAreaRentTo() != null ){
                sql.append("and "+model.getAreaRentTo()+" ");
            }
            sql.append("}");
        }
        if (model.getBuildingTypes().length > 0){
            sql.append(" and ( ");
            int i=1;
            for (String item :model.getBuildingTypes() ){
                sql.append("b.type like '%"+item+"%' ");
                if (i < model.getBuildingTypes().length ){
                    sql.append(" or ");
                    i++;
                }
            }
            sql.append(" )");
        }
        if(model.getStaffId() != null ) {
            sql.append(" and ab.staffid >="+model.getStaffId()+"");
        }
        sql.append(" group by b.id;");
        List<BuildingDTO> results = new ArrayList<>();
        Connection connection = null;
        PreparedStatement pre = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql.toString());
            resultSet = pre.executeQuery();
            while (resultSet.next()) {
                BuildingDTO builder = new BuildingDTO();
                builder.setName(resultSet.getString("name"));
                builder.setNumberOfBasement(resultSet.getInt("numberofbasement"));
                builder.setDistrict(resultSet.getString("district"));
                results.add(builder);
            }
            return results;
        } catch (SQLException e) {
            return null;
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (pre != null) {
                    pre.close();
                }
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e) {
                return null;
            }
        }
    }
    public BuildingDTO saveBuildingJDBC( BuildingDTO buildingDTO) {
        StringBuilder sql = new StringBuilder("INSERT INTO building (createdby, createddate, modifiedby, modifieddate, carcost, costdescription,");
        sql.append("deposit, direction, district, electricbill, floorarea, level, managername, managerphone, ");
        sql.append("motorcost, name, numberofbasement, overtimecost, payment, rentareadescription, rentcost,");
        sql.append("servicecost, street, structure, timedecorator, timerent, type, ward) ");
        sql.append("VALUES(null,null,null,null,null,null,null,null,");
        if (StringUtils.isNotBlank(buildingDTO.getDistrict()) && StringUtils.isNotEmpty(buildingDTO.getDistrict())) {
            sql.append("'" + buildingDTO.getDistrict() + "',");
        }else{
            sql.append("null,");
        }
        sql.append("null,null,null,null,null,null,");
        if (StringUtils.isNotBlank(buildingDTO.getName()) && StringUtils.isNotEmpty(buildingDTO.getName())) {
            sql.append("'" + buildingDTO.getName() + "',");
        }else{
            sql.append("null,");
        }
        if (buildingDTO.getNumberOfBasement() != null) {
            sql.append("'" + buildingDTO.getNumberOfBasement()+ "',");
        }else{
            sql.append("null,");
        }
        sql.append("null,null,null,null,null,null,null,null,null,'"+buildingDTO.getType()+"',null);");
        ResultSet resultSet = null;
            Connection connection = null;
            PreparedStatement pre = null;
            Long id = null;
            try {
                connection = getConnection();
                connection.setAutoCommit(false);
                pre = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
                pre.executeUpdate();
                resultSet = pre.getGeneratedKeys();
                if (resultSet.next()) {
                    id = resultSet.getLong(1);
                }
                connection.commit();
                for(String item : buildingDTO.getRentArea().split(",")){
                    rentAreaDTO.setBuildingId(id);
                    rentAreaDTO.setValue(Integer.parseInt(item));
                    saveRentAreaJDBC(rentAreaDTO);
                }
            } catch (SQLException e) {
                if (connection != null) {
                    try {
                        connection.rollback();
                    } catch (SQLException e1) {
                        e1.printStackTrace();
                    }
                }
            } finally {
                try {
                    if (connection != null) {
                        connection.close();
                    }
                    if (pre != null) {
                        pre.close();
                    }
                    if (resultSet != null) {
                        resultSet.close();
                    }
                } catch (SQLException e2) {
                    e2.printStackTrace();
                }
            }
            return null;
        }
    public RentAreaDTO saveRentAreaJDBC( RentAreaDTO rentAreaDTO) {
        StringBuilder sql = new StringBuilder("INSERT INTO rentarea (createdby, createddate, modifiedby, modifieddate, value, buildingid)");
        sql.append("VALUES(null,null,null,null,"+rentAreaDTO.getValue()+", "+rentAreaDTO.getBuildingId()+");");
        ResultSet resultSet = null;
        Connection connection = null;
        PreparedStatement pre = null;
        Long id = null;
        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            pre = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
            pre.executeUpdate();
            resultSet = pre.getGeneratedKeys();
            if (resultSet.next()) {
                id = resultSet.getLong(1);
            }
            connection.commit();
        }catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
                if (pre != null) {
                    pre.close();
                }
                if (resultSet != null) {
                    resultSet.close();
                }
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }
        return null;
    }
}
