package com.fh.shop.admin.mapper.area;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.Area;

public interface IAreaMapper extends BaseMapper<Area> {
    void addArea(Area area);
}
