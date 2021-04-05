package com.laptrinhjavaweb.controller.admin.api;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.TestUploadDTO;
import com.laptrinhjavaweb.dto.request.BuildingRequestDTO;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.service.impl.ExcelDataService;
import com.laptrinhjavaweb.util.SecurityUtils;
import com.laptrinhjavaweb.util.UploadFileUntil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.util.Base64;
import java.util.List;
import java.util.Map;

@RestController(value = "buildingAPIOfAdmin")
@RequestMapping("api/building")
public class BuildingAPI {
    @Autowired
    private IBuildingService buildingService;
    @Autowired
    private IUserService userService;
    @Autowired
    ExcelDataService dataService;
    @Autowired
    UploadFileUntil uploadFileUntil;

    @PostMapping
    public ResponseDTO createBuilding(@RequestBody BuildingDTO newBuilding) {
        ResponseDTO result = new ResponseDTO();
        result.setData(buildingService.save(newBuilding));
        result.setMessage("success");
        result.setDetail("");
        return result;
    }
    @PutMapping("/{id}")
    public ResponseDTO updateBuilding(@RequestBody BuildingDTO updateBuilding, @PathVariable("id") Long id ) {
        ResponseDTO result = new ResponseDTO();
        updateBuilding.setId(id);
        result.setData(buildingService.save(updateBuilding));
        result.setMessage("success");
        result.setDetail("");
        return result;
    }

    @DeleteMapping
    public ResponseDTO deleteBuilding(@RequestBody Long[] ids ) {
        ResponseDTO result = new ResponseDTO();
        List<String> roles = SecurityUtils.getAuthorities();
        if (roles.contains("ROLE_STAFF")){
            result.setMessage("fail");
        }else{
            buildingService.delete(ids);
            result.setMessage("success");
        }

        result.setDetail("");
        return result;
    }

    @GetMapping
    public List<BuildingDTO> getBuilding(@RequestParam Map<String, String> requestParam,
                                         @RequestParam(value = "buildingTypes", required = false) String[] types) {
        return buildingService.findAll(requestParam,types);
    }
    @GetMapping("/{id}")
    public BuildingDTO getOne(@PathVariable("id") long id) {
        return buildingService.findOne(id);
    }
    @GetMapping("/{id}/staffs")
    public ResponseDTO getStaff(@PathVariable("id") long id) {
        ResponseDTO result = new ResponseDTO();
        result.setData(buildingService.getStaff(id));
        result.setMessage("success");
        result.setDetail("");
        return result;
    }
    @PostMapping("/staffs")
    public ResponseDTO assgmentStaff(@RequestBody StaffResponseDTO responseDTO) {
        ResponseDTO result = new ResponseDTO();
        result.setData(buildingService.assgmentStaff(responseDTO));
        result.setMessage("success");
        result.setDetail("");
        return result;
    }
    @PostMapping("/image")
    public ResponseEntity<Void> uploadImg(@RequestBody TestUploadDTO testUploadDTO){
        byte[] decodeBase64 = Base64.getDecoder().decode(testUploadDTO.getBase64().getBytes());
        uploadFileUntil.writeOrUpdate(decodeBase64,"/thumbnail/" + testUploadDTO.getName());
        return ResponseEntity.noContent().build();
    }
    @PostMapping(value = "/file")
    public void uploadFile(@ModelAttribute BuildingRequestDTO buildingRequestDTO) {
        dataService.uploadFile(buildingRequestDTO.getFile());
    }
}
