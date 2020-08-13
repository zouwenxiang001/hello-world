package com.atzwx.ssm_crud1.service;

import com.atzwx.ssm_crud1.bean.Employee;
import com.atzwx.ssm_crud1.bean.EmployeeExample;
import com.atzwx.ssm_crud1.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工信息
     * @param employee
     */
    public void saveEmp(Employee employee) {

        employeeMapper.insertSelective(employee);
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return true ： 可用； false ： 不可用
     */
    public boolean checkUser(String empName) {

        // 构建查询条件
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 通过员工 id 查询员工信息
     * @param id
     * @return
     */
    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 保存修改的员工数据
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 单个删除员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除员工
     * @param ids
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        // delete from xxx where emp_id in(1, 2, 3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
