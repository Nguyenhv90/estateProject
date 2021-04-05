package com.laptrinhjavaweb.service;

import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IExcelDataService {
//    List<BuildingRequestDTO> getExcelDataAsList(MultipartFile multipartFile);
//    int saveExcelData(List<BuildingRequestDTO> requestDTOS);
    public boolean uploadFile(MultipartFile multipartFile);
}
