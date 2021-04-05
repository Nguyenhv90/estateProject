package com.laptrinhjavaweb.enums;

public enum BuildingType {
    TANG_TRET("Tầng trệt"), NGUYEN_CAN("Nguyên căn"),NOI_THAT("Nội thất");
    private String buildingType = null;
    BuildingType(String buildingType) {
        this.buildingType = buildingType;
    }

    public String getBuildingType() {
        return buildingType;
    }
}
