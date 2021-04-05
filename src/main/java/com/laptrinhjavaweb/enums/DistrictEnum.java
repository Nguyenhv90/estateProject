package com.laptrinhjavaweb.enums;

import java.util.EnumMap;

public enum DistrictEnum {
    QUAN_1("Quận 1"), QUAN_2("Quận 2"),QUAN_3("Quận 3"), QUAN_4("Quận 4");
    private String value = null;
    DistrictEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
