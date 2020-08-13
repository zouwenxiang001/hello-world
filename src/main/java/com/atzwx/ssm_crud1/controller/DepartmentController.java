package com.atzwx.ssm_crud1.controller;


import com.atzwx.ssm_crud1.bean.Department;
import com.atzwx.ssm_crud1.bean.Msg;
import com.atzwx.ssm_crud1.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理 部门 CRUD
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDeptWithJson(){

        // 根据员工 dID 查询其所在部门
        List<Department> list = departmentService.getAll();

        return Msg.success().add("depts", list);
    }
}
