package com.fh.shop.admin.common;

import javax.servlet.http.HttpServletRequest;

public class WebContext {

     public  static  ThreadLocal<HttpServletRequest> threadLocalLog = new ThreadLocal<>();

     public  static void set(HttpServletRequest servletRequest){
         threadLocalLog.set(servletRequest);
     }
     public  static  HttpServletRequest  get(){
         return  threadLocalLog.get();
     }

     public  static  void del(){
         threadLocalLog.remove();
     }
}
