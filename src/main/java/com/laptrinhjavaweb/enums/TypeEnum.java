package com.laptrinhjavaweb.enums;

public enum TypeEnum {
    TANG_TRET("Tầng trệt"), NGUYEN_CAN("Nguyên căn"),NOI_THAT("Nội thất");
    private String value = null;
    TypeEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
