package com.laptrinhjavaweb.service.impl;

import com.laptrinhjavaweb.converter.BuildingConverter;
import com.laptrinhjavaweb.converter.RentAreaConverter;
import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.entity.BuildingEntity;
import com.laptrinhjavaweb.entity.RentAreaEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.enums.DistrictEnum;
import com.laptrinhjavaweb.enums.TypeEnum;
import com.laptrinhjavaweb.repository.BuildingRepository;
import com.laptrinhjavaweb.repository.RentAreaRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.util.SecurityUtils;
import com.laptrinhjavaweb.service.IBuildingService;
import com.laptrinhjavaweb.util.UploadFileUntil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.math.BigInteger;
import java.util.*;

@Service
public class BuildingService implements IBuildingService {
    @Autowired
    private BuildingRepository buildingRepository;
    @Autowired
    private UserConverter userConverter;

    @Autowired
    private UploadFileUntil uploadFileUntil;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BuildingConverter buildingConverter;

    public final String root = "/usr/var";

    @Override
    public List<BuildingDTO> findAll(BuildingDTO model) {
        List<BuildingDTO> results = new ArrayList<>();
        List<String> roles = SecurityUtils.getAuthorities();
        if (roles.contains("ROLE_STAFF")){
            model.setStaffId(SecurityUtils.getPrincipal().getId().intValue());
        }
        List<BuildingEntity> entities = buildingRepository.findAll(model);
        for(BuildingEntity item: entities){
            BuildingDTO buildingDTO = buildingConverter.convertToDto(item);
            results.add(buildingDTO);
        }
        return results;
    }
    @Override
    public BuildingDTO findOne(Long id) {
        BuildingEntity entities = buildingRepository.findOne(id);
        BuildingDTO buildingDTO = buildingConverter.convertToDto(entities);
        buildingDTO.setRentArea(StringUtils.join(rentAreaRepository.findValue(id),","));
        if(buildingDTO.getType() != null){
            buildingDTO.setBuildingTypes(buildingDTO.getType().split(","));
        }
        return buildingDTO;
    }

    @Override
    public Map<String, String> getDistrictMap() {
        Map<String, String> result = new LinkedHashMap<>();
        for(DistrictEnum item :DistrictEnum.values()){
            result.put(item.name(), item.getValue());
        }
        return result;
    }

    @Override
    public Map<String, String> getTypeMap() {
        Map<String, String> result = new LinkedHashMap<>();
        for(TypeEnum item :TypeEnum.values()){
            result.put(item.name(), item.getValue());
        }
        return result;
    }

    @Override
    public List<StaffResponseDTO> getStaff(long id) {
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1,"STAFF");
        List<StaffResponseDTO> responseDTO = new ArrayList<>();
        List<BigInteger> lst = buildingRepository.findAssgmentStaff(id);
        for(UserEntity item :staffs){
            UserDTO userDTO= userConverter.convertToDto(item);
            StaffResponseDTO staffResponseDTO = userConverter.convertToStaffDto(userDTO);
            if (buildingRepository.existsByIdAndStaffs_Id(id, item.getId())){
                staffResponseDTO.setChecked("checked");
            }
            responseDTO.add(staffResponseDTO);
        }
        return responseDTO;
    }

    @Override
    @Transactional
    public BuildingDTO save(BuildingDTO buildingDTO) {
        try{
            buildingDTO.setType(StringUtils.join(buildingDTO.getBuildingTypes(),","));
            BuildingEntity buildingEntity = buildingConverter.convertToEntity(buildingDTO);
            if(StringUtils.isNotBlank(buildingDTO.getRentArea())){
                buildingEntity.setRentAreas(rentAreaEntities(buildingEntity, buildingDTO.getRentArea()));
            }
            buildingRepository.save(buildingEntity);
            return new BuildingDTO();
        }catch (Exception e){
            throw e;
        }
    }

    @Override
    @Transactional
    public void delete(Long[] ids)  {
        try{
            for (long id: ids){
                rentAreaRepository.deleteByBuilding_Id(id);
                buildingRepository.delete(id);
            }
        }catch (Exception e){
            throw e;
        }
    }

    @Override
    public Boolean checkStaff(Long id, Long staffId) {
        if (buildingRepository.existsByIdAndStaffs_Id(id, staffId)){
            return true;
        }
        return false;
    }

    @Override
    public int getTotalItems(BuildingDTO buildingDTO) {
        List<String> roles = SecurityUtils.getAuthorities();
        if (roles.contains("ROLE_STAFF")){
            buildingDTO.setStaffId(SecurityUtils.getPrincipal().getId().intValue());
        }
        return buildingRepository.getTotalItems(buildingDTO).intValue();
    }

    @Override
    @Transactional
    public StaffResponseDTO assgmentStaff(StaffResponseDTO responseDTO) {
        BuildingEntity buildingEntity = buildingRepository.findOne(responseDTO.getBuildingId());
        List<UserEntity> userEntity = new ArrayList<>();
        for (long item : responseDTO.getStaffs()){
            UserEntity userEntity1 = userRepository.findOne(item);
            userEntity.add(userEntity1);
        }
        buildingEntity.setStaffs(userEntity);
        buildingRepository.save(buildingEntity);
        return new StaffResponseDTO();
    }

    @Override
    public List<BuildingDTO> findAll(Map<String, String> params, String[] types) {
        BuildingDTO model = convertMapToDTO(params, types);
        List<BuildingDTO> results = new ArrayList<>();
        List<BuildingEntity> entities = buildingRepository.findAll(model);
        for (BuildingEntity item: entities) {
            BuildingDTO buildingDTO = buildingConverter.convertToDto(item);
            results.add(buildingDTO);
        }
        return results;
    }

    private BuildingDTO convertMapToDTO(Map<String, String> params, String[] types) {
        BuildingDTO result = new BuildingDTO();
        result.setName(StringUtils.isNotBlank(params.get("name")) ?(String) params.get("name") : null);
        if(StringUtils.isNotBlank(params.get("numberofbasement"))){
            result.setNumberOfBasement(Integer.parseInt(params.get("numberofbasement")));
        }
        if(StringUtils.isNotBlank(params.get("floorarea"))){
            result.setFloorArea(Integer.parseInt(params.get("floorarea")));
        }
        result.setBuildingTypes(types != null ? types :null);
        return result;
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
    @Transactional
    public void deleteRent(Long ids)  {
        try{
            List<Long> id1 = rentAreaRepository.findIdByBuilding_Id(ids);
            for (long id : id1){
                rentAreaRepository.delete(id);
            }
        }catch (Exception e){
            throw e;
        }
    }
    private void saveImage(BuildingEntity buildingEntity, BuildingDTO buildingDTO) {
        if (buildingDTO.getBase64() != null) {
            String path = "/thumbnail/" + buildingDTO.getName();
            if (StringUtils.isNotBlank(buildingEntity.getImage())) {
                if (!path.equals(buildingEntity.getImage())) {
                    File file = new File(root + buildingEntity.getImage());
                    file.delete();
                }
            }
            byte[] decodeBase64 = Base64.getDecoder().decode(buildingDTO.getBase64().getBytes());
            uploadFileUntil.writeOrUpdate(decodeBase64,path);
            buildingEntity.setImage(path);
        }
    }
}
