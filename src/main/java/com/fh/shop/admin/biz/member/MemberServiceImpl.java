package com.fh.shop.admin.biz.member;

import com.fh.shop.admin.mapper.member.IMemberMapper;
import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.MemberParam;
import com.fh.shop.admin.po.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("mem")
public class MemberServiceImpl implements IMemberService{

    @Autowired
    private IMemberMapper memberMapper;

    @Override
    public DataTableResult findList(MemberParam memberParam) {
        // 获取总条数
        Long totalCount = memberMapper.findCount(memberParam);
        // 获取分页列表
        List<Member> list = memberMapper.findPageList(memberParam);
        DataTableResult dataTableResult =   new DataTableResult(memberParam.getDraw(),totalCount,totalCount,list);
        return dataTableResult;
    }
}
 