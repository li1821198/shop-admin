package com.fh.shop.admin.common;

public enum  ReposeEnum {
    PASSWORD_IS_ERROR(1002,"密码错误"),
    SPE_IS_NULL(2000,"规格不正确"),
    USERNAME_IS_NOT_EXISTS(1001,"用户名不存在"),
    ERROR_IS_NOT_COUNT(1003,"用户已被锁定"),
    USERNAME_PASSWORD_IS_NULL(1000,"用户名或密码为空");

    private int code;

    private String msg;

    ReposeEnum(int code,String msg){
        this.code=code;
        this.msg=msg;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
