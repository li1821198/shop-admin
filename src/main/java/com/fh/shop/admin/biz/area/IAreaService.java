package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Area;

import java.util.List;

public interface IAreaService {
    ServerResponse findList();

    void addArea(Area area);

    void deleteArea(List<Long> idList);

    Area findById(long id);

    void editArea(Area area);

    ServerResponse findChilds(Long id);
}
