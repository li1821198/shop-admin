package com.fh.shop.admin.mapper.member;

import com.fh.shop.admin.param.MemberParam;
import com.fh.shop.admin.po.Member;

import java.util.List;

public interface IMemberMapper {
    Long findCount(MemberParam memberParam);

    List<Member> findPageList(MemberParam memberParam);
}
