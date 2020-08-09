package com.fh.shop.admin.biz.member;

import com.fh.shop.admin.param.DataTableResult;
import com.fh.shop.admin.param.MemberParam;

public interface IMemberService {
    DataTableResult findList(MemberParam memberParam);
}
