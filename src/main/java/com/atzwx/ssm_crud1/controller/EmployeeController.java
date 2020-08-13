package com.atzwx.ssm_crud1.controller;

import com.atzwx.ssm_crud1.bean.Employee;
import com.atzwx.ssm_crud1.bean.Msg;
import com.atzwx.ssm_crud1.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.security.provider.MD2;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工 CRUD 请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     *单个、批量 二合一
     * 批量： 1-2-3
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids) {
        if (ids.contains("-")) {
            List<Integer> delIds = new ArrayList<>();
            String[] strIds = ids.split("-");
            // 组装 id 的集合
            for (String id : strIds) {
                delIds.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(delIds);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 如果直接发送 ajax=PUT 形式的请求
     * 封装的数据 Employee 只有 带有路径传入的值 empId, 其他的均为 null
     * 问题： 请求体中有数据， 但是 Employee 对象封装不上。
     *     update tbl_emp (null) where emp_id = #{empId,jdbcType=INTEGER}
     *
     * 原因：
     *      Tomcat：
     *              1、将请求体中的数据， 封装一个 map
     *              2、request.getParameter("empName")， 就会从这个 map 中取值
     *              3、SpringMVC 封装 POJO 对象的时候， 会把 POJO 中每一个属性的值，
     *                 通过 request.getParameter("email") 方法拿到
     *      ajax 发送 PUT 请求引起的血案：
     *              PUT 请求， 请求体中的数据， request.getParameter("empName") 拿不到
     *              Tomcat 一看是 PUT 请求， 不会封装请求体中的数据为 map， 只有 POST
     *              请求才封装请求体为 map
     *
     *      org.apache.catalina.connector.Request--parseParameters()
     *
     *      protectd String parseBodyMethods = "POST";
     *      if( !getConnector().isParseBodyMethod(getMethod()) ) {
     *          success = true;
     *          return;
     *      }
     *
     * 解决方案：
     *      要能支持直接发送 PUT 之类的请求还要封装请求体中的数据
     *      配置上 HttpPutFormContentFilter 过滤器
     *      其作用： 将请求体中的数据解析包装成一个 map
     *      request 被重新包装， request.getParameter() 被重写， 就会从自己封装的 map 中取数据
     * 保存修改的员工数据
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveUpdateEmp(Employee employee) {

        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 通过员工 id 查询员工信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpById(@PathVariable("id")Integer id) {

        Employee employee = employeeService.getEmpById(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){

        // 先判断用户名是否为合法的表达式
        String regEx = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regEx)) {
            return Msg.fail().add("va_msg", "用户名必须是以2-5个中文，或者以5-16个英文和数字组成！");
        }

        // 数据库用户名重复校验
        boolean flag = employeeService.checkUser(empName);
        if (flag){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户不可用");
        }
    }

    /**
     * @ResponseBody 要能正常工作，需要导入 Jackson 包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson( @RequestParam(value = "pn", defaultValue = "1")Integer pn){

        // 引入 PageHelper 分页插件， 在查询之前只需要调用， 传入页码， 以及每页的大小
        PageHelper.startPage(pn, 5);

        // startPage 后面紧跟的这个查询就是一个分页查询
        List<Employee>  emps =  employeeService.getAll();

        // 使用 pageInfo 包装查询后的结果， 只需要将 pageInfo 交给页面就行
        // 封装了详细的分页信息， 包括有我们查询出来的数据， 传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 保存员工基本信息
     * 1、支持 JSR303校验
     * 2、导入 Hibernate-Validator
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult){

        if (bindingResult.hasErrors()) {
            // 校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError fieldError : errors) {
//                System.out.println("错误的字段" + fieldError.getField());
//                System.out.println("错误的信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
    // @RequestMapping("/emps")
//    public String getEmps(
//            @RequestParam(value = "pn", defaultValue = "1")Integer pn, Model model){
//
//        // 引入 PageHelper 分页插件， 在查询之前只需要调用， 传入页码， 以及每页的大小
//        PageHelper.startPage(pn, 5);
//
//        // startPage 后面紧跟的这个查询就是一个分页查询
//        List<Employee>  emps =  employeeService.getAll();
//
//        // 使用 pageInfo 包装查询后的结果， 只需要将 pageInfo 交给页面就行
//        // 封装了详细的分页信息， 包括有我们查询出来的数据， 传入连续显示的页数
//        PageInfo page = new PageInfo(emps, 5);
//
//        // 保存到 model 中， 用于页面显示数据
//        model.addAttribute("pageInfo", page);
//
//        return "list";
//    }
}
