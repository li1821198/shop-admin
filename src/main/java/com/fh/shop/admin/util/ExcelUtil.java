package com.fh.shop.admin.util;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ExcelUtil {

    public static XSSFWorkbook buidExcel(List dataList,String[]headNameArr,String[]props,String title){
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(title);
        XSSFRow headRow = sheet.createRow(0);
        //创建表头行
        for(int i=0;i<headNameArr.length;i++){
            XSSFCell cell = headRow.createCell(i);
            cell.setCellValue(headNameArr[i]);
        }
        try {
            //创建一个日期格式的单元格样式
            XSSFCellStyle cellStyle = workbook.createCellStyle();
            XSSFDataFormat format= workbook.createDataFormat();
            cellStyle.setDataFormat(format.getFormat("yyyy年MM月dd日"));
            //创建一个价格格式的单元格样式
            XSSFCellStyle priceCellStyle = workbook.createCellStyle();
            priceCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
            for(int i=0;i<dataList.size();i++){
                //获取循环出来的对象
                Object o = dataList.get(i);
                //通过对象.getClass()来获取该“类”
                Class<?> aClass = o.getClass();
                XSSFRow row = sheet.createRow(i + 1);
                for(int j=0;j<props.length;j++){
                    //获取属性的长度
                    //获取属性
                    Field declaredField = aClass.getDeclaredField(props[j]);
                    //暴力访问，因为属性是私有的无法访问
                    declaredField.setAccessible(true);
                    //根据属性名获取
                    Object o1 = declaredField.get(o);
                    Class fileType = o1.getClass();
                    XSSFCell cell = row.createCell(j);
                    if(fileType == java.lang.Integer.class){
                        cell.setCellValue((Integer)o1);
                    }
                    if(fileType == java.lang.String.class){
                        cell.setCellValue((String)o1);
                    }
                    if(fileType == java.lang.Long.class){
                        cell.setCellValue((Long)o1);
                    }
                    if(fileType == java.lang.Double.class){
                        cell.setCellValue((Double)o1);
                    }
                    if(fileType == java.util.Date.class){
                        cell.setCellValue((Date)o1);
                        cell.setCellStyle(cellStyle);
                    }
                    if(fileType == java.math.BigDecimal.class){
                        cell.setCellValue(new BigDecimal(o1.toString()).doubleValue());
                        cell.setCellStyle(priceCellStyle);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return workbook;
    }
}
