package com.fh.shop.admin.biz.area;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.area.IAreaMapper;
import com.fh.shop.admin.po.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("areaService")
public class AreaServiceImpl implements IAreaService{

    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public ServerResponse findList() {
        List<Area> areas = areaMapper.selectList(null);
        return ServerResponse.success(areas);
    }

    @Override
    public void addArea(Area area) {
         areaMapper.insert(area);
    }

    @Override
    public void deleteArea(List<Long> idList) {
        areaMapper.deleteBatchIds(idList);
    }

    @Override
    public Area findById(long id) {
        return areaMapper.selectById(id);
    }

    @Override
    public void editArea(Area area) {
          areaMapper.updateById(area);
    }

    @Override
    public ServerResponse findChilds(Long id) {
        QueryWrapper<Area> queryWrapper = new QueryWrapper();
        queryWrapper.eq("fid",id);
        List<Area> areas = areaMapper.selectList(queryWrapper);
        return ServerResponse.success(areas);
    }
}
