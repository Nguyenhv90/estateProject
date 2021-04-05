package com.laptrinhjavaweb.repository.jdbc.impl;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.CustomerDTO;
import com.laptrinhjavaweb.repository.jdbc.ICustomerRepository;
import org.apache.commons.lang3.StringUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepositoryJdbcImpl implements ICustomerRepository {
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

    public CustomerDTO saveCustomer(CustomerDTO customerDTO) {
        StringBuilder sql = new StringBuilder("INSERT INTO customer (fullname, phone, email, createddate, modifieddate, createdby,modifiedby)");
        sql.append("VALUES('"+customerDTO.getFullName()+"','"+customerDTO.getPhone()+"','"+customerDTO.getEmail()+"',null,null,null,null);");
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
    public List<CustomerDTO> findCustomer(CustomerDTO model) {
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
        List<CustomerDTO> results = new ArrayList<>();
        Connection connection = null;
        PreparedStatement pre = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            pre = connection.prepareStatement(sql.toString());
            resultSet = pre.executeQuery();
            while (resultSet.next()) {
                CustomerDTO customerDTO = new CustomerDTO();
                customerDTO.setFullName(resultSet.getString("fullname"));
                customerDTO.setPhone(resultSet.getString("phone"));
                results.add(customerDTO);
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
}
