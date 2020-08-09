package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.area.IAreaService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Area;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("area")
public class AreaController {

    @Resource(name="areaService")
    private IAreaService areaService;

    @RequestMapping("index")
    public String index(){
        return "area/index";
    }

    @RequestMapping("findList")
    @ResponseBody
    public ServerResponse findList(){
        return areaService.findList();
    }
    @RequestMapping("addArea")
    @ResponseBody
    public ServerResponse addArea(Area area){
       areaService.addArea(area);
        return ServerResponse.success(area.getId());
    }
    @RequestMapping("deleteArea")
    @ResponseBody
    public ServerResponse deleteArea(@RequestParam("idList[]") List<Long> idList){
        areaService.deleteArea(idList);
        return ServerResponse.success();
    }
    @RequestMapping("findById")
    @ResponseBody
    public ServerResponse findById(long id){
        Area a = areaService.findById(id);
        return ServerResponse.success(a);
    }
    @RequestMapping("editArea")
    @ResponseBody
    public ServerResponse editArea(Area area){
       areaService.editArea(area);
        return ServerResponse.success();
    }
    @RequestMapping("findChilds")
    @ResponseBody
    public ServerResponse findChilds(Long id){

        return areaService.findChilds(id);
    }
}
