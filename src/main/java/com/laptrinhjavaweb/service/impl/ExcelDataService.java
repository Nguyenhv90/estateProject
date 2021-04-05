package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.converter.BuildingConverter;
import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.RentAreaEntity;
import com.laptrinhjavaweb.repository.BuildingRepository;
import com.laptrinhjavaweb.service.IExcelDataService;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static org.springframework.security.access.SecurityConfig.createList;

@Service
public class ExcelDataService implements IExcelDataService {
    @Value("${app.upload.file:${user.home}")
    public String excelFilePath;

    @Autowired
    BuildingRepository buildingRepository;

    @Autowired
    private BuildingConverter buildingConverter;

    @Override
    public boolean uploadFile(MultipartFile file) {
        boolean isFlag = false;
        String extention = FilenameUtils.getExtension(file.getOriginalFilename());
        if(extention.equalsIgnoreCase("xls") || extention.equalsIgnoreCase("xlsx")){
            isFlag = readDataFromExcel(file);
        }
        return  isFlag;
    }

    private boolean readDataFromExcel(MultipartFile file) {
        Workbook workbook = getWorkBook(file);
        Sheet sheet = workbook.getSheetAt(0);
        Iterator<Row> rows = sheet.rowIterator();
        rows.next();
        while (rows.hasNext()){
            Row row = rows.next();
            saveExcelData(row);
        }
        return  true;
    }

    private void saveExcelData(Row row) {
        BuildingRequestDTO building = new BuildingRequestDTO();
        int i = 0;
        if(row.getCell(0) != null && row.getCell(0).getCellType() == Cell.CELL_TYPE_STRING){
            building.setName(row.getCell(0).getStringCellValue());
        }
        if(row.getCell(1) != null && row.getCell(1).getCellType() == Cell.CELL_TYPE_STRING){
            building.setWard(row.getCell(1).getStringCellValue());
        }
        if( row.getCell(2) != null && row.getCell(2).getCellType() == Cell.CELL_TYPE_STRING){
            building.setStreet(row.getCell(2).getStringCellValue());
        }
        if(row.getCell(3) != null && row.getCell(3).getCellType() == Cell.CELL_TYPE_STRING){
            building.setStructure(row.getCell(3).getStringCellValue());
        }
        if( row.getCell(4) != null && row.getCell(4).getCellType() == Cell.CELL_TYPE_NUMERIC){
            building.setNumberOfBasement((int) row.getCell(4).getNumericCellValue());
        }
        if(row.getCell(5) != null && row.getCell(5).getCellType() == Cell.CELL_TYPE_NUMERIC){
            building.setFloorArea((int) row.getCell(5).getNumericCellValue());
        }
        if(row.getCell(6) != null && row.getCell(6).getCellType() == Cell.CELL_TYPE_STRING){
            building.setDirection(row.getCell(6).getStringCellValue());
        }
        if(row.getCell(7) != null && row.getCell(7).getCellType() == Cell.CELL_TYPE_STRING){
            building.setLevel(row.getCell(7).getStringCellValue());
        }
        if(row.getCell(8) != null && row.getCell(8).getCellType() == Cell.CELL_TYPE_STRING){
            building.setRentArea(row.getCell(8).getStringCellValue());
        }
        if(row.getCell(9) != null && row.getCell(9).getCellType() == Cell.CELL_TYPE_STRING){
            building.setRentAreaDescription(row.getCell(9).getStringCellValue());
        }
        if(row.getCell(10) != null && row.getCell(10).getCellType() == Cell.CELL_TYPE_STRING){
            building.setDistrict(row.getCell(10).getStringCellValue());
        }
        if(row.getCell(11) != null && row.getCell(11).getCellType() == Cell.CELL_TYPE_NUMERIC){
            building.setRentCost((int) row.getCell(11).getNumericCellValue());
        }
        if(row.getCell(12) != null && row.getCell(12).getCellType() == Cell.CELL_TYPE_STRING){
            building.setCostDescription(row.getCell(12).getStringCellValue());
        }
        if(row.getCell(13) != null && row.getCell(13).getCellType() == Cell.CELL_TYPE_STRING){
            building.setServiceCost(row.getCell(13).getStringCellValue());
        }
        if(row.getCell(14) != null && row.getCell(14).getCellType() == Cell.CELL_TYPE_STRING){
            building.setCarCost(row.getCell(14).getStringCellValue());
        }
        if(row.getCell(15) != null && row.getCell(15).getCellType() == Cell.CELL_TYPE_STRING){
            building.setCarCost(row.getCell(15).getStringCellValue());
        }
        if(row.getCell(16) != null && row.getCell(16).getCellType() == Cell.CELL_TYPE_STRING){
            building.setMotorCost(row.getCell(16).getStringCellValue());
        }
        if(row.getCell(17) != null && row.getCell(17).getCellType() == Cell.CELL_TYPE_STRING){
            building.setOvertimeCost(row.getCell(17).getStringCellValue());
        }
        if(row.getCell(18) != null && row.getCell(18).getCellType() == Cell.CELL_TYPE_STRING){
            building.setType(row.getCell(18).getStringCellValue());
        }
        if(row.getCell(19) != null && row.getCell(19).getCellType() == Cell.CELL_TYPE_STRING){
            building.setElectricBill(row.getCell(19).getStringCellValue());
        }
        if(row.getCell(20) != null && row.getCell(20).getCellType() == Cell.CELL_TYPE_STRING){
            building.setDeposit(row.getCell(20).getStringCellValue());
        }
        if(row.getCell(21) != null && row.getCell(21).getCellType() == Cell.CELL_TYPE_STRING){
            building.setPayment(row.getCell(21).getStringCellValue());
        }
        if(row.getCell(22) != null && row.getCell(22).getCellType() == Cell.CELL_TYPE_STRING){
            building.setTimeRent(row.getCell(22).getStringCellValue());
        }
        if(row.getCell(23) != null && row.getCell(23).getCellType() == Cell.CELL_TYPE_STRING){
            building.setTimeDecorator(row.getCell(23).getStringCellValue());
        }
        if(row.getCell(24) != null && row.getCell(24).getCellType() == Cell.CELL_TYPE_STRING){
            building.setManagerName(row.getCell(24).getStringCellValue());
        }
        if(row.getCell(25) != null && row.getCell(25).getCellType() == Cell.CELL_TYPE_STRING){
            building.setManagerPhone(row.getCell(25).getStringCellValue());
        }
        BuildingEntity buildingEntity = buildingConverter.convertToEntity(building);
        if(StringUtils.isNotBlank(building.getRentArea())){
            buildingEntity.setRentAreas(rentAreaEntities(buildingEntity, building.getRentArea()));
        }
        buildingRepository.save(buildingEntity);

    }
    List<RentAreaEntity> rentAreaEntities(BuildingEntity buildingEntity, String rent){
        List<RentAreaEntity> areaEntities = new ArrayList<>();
        for (String item :rent.split(",")) {
            RentAreaEntity rentAreaEntity = new RentAreaEntity();
            rentAreaEntity.setBuilding(buildingEntity);
            rentAreaEntity.setValue(Integer.parseInt(item));
            areaEntities.add(rentAreaEntity);
        }
        return areaEntities;
    }

    private Workbook getWorkBook(MultipartFile file) {
        Workbook workbook = null;
        String extention = FilenameUtils.getExtension(file.getOriginalFilename());
        try {
            if(extention.equalsIgnoreCase("xlsx")){
                workbook = new XSSFWorkbook(file.getInputStream());

            }else if(extention.equalsIgnoreCase("xls")){
                workbook = new HSSFWorkbook(file.getInputStream());
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return  workbook;
    }
}
