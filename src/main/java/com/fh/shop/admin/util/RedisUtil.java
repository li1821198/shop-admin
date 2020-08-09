package com.fh.shop.admin.util;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    public static void set(String key, String value) {
       Jedis jedis=null;
        try {
            jedis = RedisPool.getResource();
            jedis.set(key,value);
        } catch (Exception e) {
            e.printStackTrace();
             throw  new RuntimeException(e);
        } finally {
           if (null!=jedis){
               jedis.close();
           }
        }
    }

    public static String get(String key) {
        Jedis jedis=null;
        try {
            jedis = RedisPool.getResource();
            String res = jedis.get(key);
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            throw  new RuntimeException(e);
        } finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }

    public static void del(String key){
        Jedis jedis=null;
        try {
            jedis = RedisPool.getResource();
             jedis.del(key);

        } catch (Exception e) {
            e.printStackTrace();
            throw  new RuntimeException(e);
        } finally {
            if (null!=jedis){
                jedis.close();
            }
        }
    }
}
