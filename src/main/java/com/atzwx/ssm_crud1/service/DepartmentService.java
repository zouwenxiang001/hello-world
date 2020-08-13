package com.atzwx.ssm_crud1.service;

import com.atzwx.ssm_crud1.bean.Department;
import com.atzwx.ssm_crud1.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    // 查询所有部门
    public List<Department> getAll(){

        return departmentMapper.selectByExample(null);
    }
}
