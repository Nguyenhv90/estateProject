package com.laptrinhjavaweb.repository.jdbc.impl;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.RentAreaDTO;
import com.laptrinhjavaweb.repository.jdbc.IBuildingRepository;
import com.laptrinhjavaweb.repository.jdbc.IRentAreaRepository;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Repository
public class RentAreaRepositoryJdbcImpl implements IRentAreaRepository {
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

    public RentAreaDTO saveBuildingJDBC( RentAreaDTO rentAreaDTO) {
        StringBuilder sql = new StringBuilder("INSERT INTO rentarea (createdby, createddate, modifiedby, modifieddate, value, buildingid,");
        sql.append("VALUES(null,null,null,null,"+rentAreaDTO.getValue()+", "+rentAreaDTO.getBuildingId()+"");
        ResultSet resultSet = null;
            Connection connection = null;
            PreparedStatement pre = null;
            PreparedStatement pre1 = null;
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
}
