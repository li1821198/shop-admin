package com.fh.shop.admin.controller;

import com.fh.shop.admin.biz.member.IMemberService;
import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.MemberParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("member")
public class MemberController {
    @Resource(name="mem")
    private IMemberService memberService;


    @RequestMapping("index")
    public String index(){
        return "member/index";
    }

    @RequestMapping("findList")
    @ResponseBody
    public DataTableResult findList(MemberParam memberParam){
        DataTableResult dataTableResult = memberService.findList(memberParam);
        return dataTableResult;
    }
}
