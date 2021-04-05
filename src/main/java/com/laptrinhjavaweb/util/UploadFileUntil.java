package com.laptrinhjavaweb.util;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

@Component
public class UploadFileUntil {
    public final String root = "/usr/var";
    public void writeOrUpdate(byte[] bytes , String path){
        File file = new File(StringUtils.substringBeforeLast(root+path,"/"));
        if (!file.exists()){
            file.mkdir();
        }
        try(FileOutputStream fileOutputStream = new FileOutputStream(root+path);) {
            fileOutputStream.write(bytes);
        }catch (IOException e){
            e.printStackTrace();
        }

    }
}
