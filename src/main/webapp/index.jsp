<%--
  Created by IntelliJ IDEA.
  User: zwx001
  Date: 2020/7/11
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>
    <!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
    http://localhost:3306/crud
-->
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>

    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />

    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


</head>
<body>
    <!-- 使用 Bootstrap 搭建显示页面 -->

    <!-- 员工修改 Modal （模态框） -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >员工修改</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" >
                        <!-- 员工基本信息 -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email_update_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atzwx.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="dId" id="deptName_update_select"></select>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
                </div>
            </div>
        </div>
    </div>


    <!-- 员工新增 Modal （模态框） -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" >
                        <!-- 员工基本信息 -->
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atzwx.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="dId" id="deptName_add_select"></select>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>

        <!-- 按钮 -->
        <div class="row">
            <div>
                <!-- myWebsiteBackgroundMusic.mp3 cottonCandy.mp3 -->
                <audio src="${APP_PATH}/music/myWebsiteBackgroundMusic.mp3"
                       autoplay="autoplay" controls="controls" loop="loop" >
                </audio>
            </div>
            <div class="col-md-3 col-md-offset-9">
                <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
            </div>
        </div>

        <!-- 表格 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover table-bordered" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox", id="check_all"/>
                            </th>
                            <th class="text-center">#</th>
                            <th class="text-center">empName</th>
                            <th class="text-center">gender</th>
                            <th class="text-center">email</th>
                            <th class="text-center">deptName</th>
                            <th class="text-center">操作</th>
                        </tr>
                    </thead>

                    <tbody class="text-center">

                    </tbody>

                </table>
            </div>
        </div>
        <!-- 分页信息 -->
        <div class="row">

            <!--分页文字信息  -->
            <div class="col-md-6" id="page_info_area">

            </div>

            <!-- 分页条信息 -->
            <div class="col-md-6" id="page_nav_area">

            </div>

        </div>
    </div>

<%--    <a href="https://www.baidu.com" target="_blank">123</a>--%>

    <script type="text/javascript">

        // 员工总记录数, 当前页面
        var tatolEmpRecord, currentPage;

        // 1、页面加载完成以后， 直接去发送 ajax 请求，获取分页数据
        $(function () {
            to_page(1);
        });

        function to_page(pn){
            // 去除之前全选的效果
            $("#check_all").prop("checked", false);
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    // console.log(result)
                    // 1、解析并显示员工数据
                    build_emps_table(result);

                    // 2、解析并显示分页信息
                    build_page_info(result);

                    // 3、解析并显示分页数据
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result) {
            // 清空 emps_table 表格的 tbody
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, item) {
            //     alert(item.empName);
                // append 方法执行完成以后还是返回原来的元素
                var checkBoxTd = $("<th><input type='checkbox', class='check_item'/></th>")
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender);
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);

                 // <button class="">
                 // <span class="glyphicon glyphicon-pencil"></span>
                 // 编辑
                 // </button>

                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                // 为编辑按钮添加一个自定义的属性， 来表示当前员工 id
                editBtn.attr("edit-id", item.empId);

                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                // 为删除按钮添加一个自定义的属性， 来表示当前删除的员工 id
                delBtn.attr("del-id", item.empId);

                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");

            });

        }

        function build_page_info(result) {
            // 清空 page_info_area 的内容
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页\n"+
                "总页"+result.extend.pageInfo.pages+"\n"+
                "记录数"+result.extend.pageInfo.total);
            tatolEmpRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        function build_page_nav(result) {
            // 清空 page_nav_area 的内容
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");

            // .attr("href","https://www.baidu.com")
            // .attr("target", "_blank"));
            // 1、首页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页")
                .attr("href", "#"));

            // 3、前一页
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                firstPageLi.click(function () {
                    to_page(1);
                });

                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum - 1);
                })
            }

            // 6、添加 首页和前一页
            ul.append(firstPageLi).append(prePageLi);

            // 5、数字选项页
            var numberPages = result.extend.pageInfo.navigatepageNums;
            $.each(numberPages, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));

                // 当前分页显示
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                });

                ul.append(numLi);
            })

            // 4、后一页
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            // 2、末页
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页")).attr("href", "#");

            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum + 1);

                });

                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);

                })
            }

            // 7、添加 后一页和末页
            ul.append(nextPageLi).append(lastPageLi);

            // 8、把 ul 添加到 navEle
            var navEle = $("<nav></nav>").append(ul);

            // 9、添加到 page_nav_area
            navEle.appendTo("#page_nav_area");

        }

        function reset_form(ele) {
            // 清除表单数据
            $(ele)[0].reset();
            // 清除表单样式
            // $(ele).removeClass("has-success has-error");

            $(ele).find(".help-block").text("");

        }

        // 点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            // 清空表单数据及样式（表单完全重置）
            reset_form("#empAddModal form");
            // 发送 ajax 请求， 获取部门信息
            getDepts("#deptName_add_select");

            // 弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        function getDepts(ele) {
            // 清空下拉列表之前的值
            $(ele).empty();

            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success:function (result) {
                    // console.log(result);
                    // 遍历部门信息
                    $.each(result.extend.depts, function () {

                        // 将部门信息添加到下拉列表中
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo(ele);

                    });
                }
            });

        }

        function validDate_add_form(){
            // 1、校验用户名
            var empName = $("#empName_add_input").val();
            // 注意 【|】 两边不能有空格
            var regEmpNane = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if (!regEmpNane.test(empName)){
                // alert("用户名以2-5个中文，或者以5-16个英文和数字组成！");
                show_validate_msg("#empName_add_input", "error", "用户名以2-5个中文，或者以5-16个英文和数字组成！");
                return false;
            }else{
                show_validate_msg("#empName_add_input", "success","");
            }

            // 2、校验邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式错误!");
                show_validate_msg("#email_add_input", "error", "邮箱格式错误!");
                return false;
            }else{
                show_validate_msg("#email_add_input",  "success", "");
            }

            return true;
        }

        // 显示填写表单的错误提示信息
        function show_validate_msg(eleName, status, msg){
            // 每次都清空 eleName 父元素的 ”has-success“ 和 ”has-error“
            $(eleName).parent().removeClass("has-success has-error");
            // alert($(eleName).parent()[0]);
            if("success" == status){
                $(eleName).parent().addClass("has-success");
                $(eleName).next("span").text(msg);
            }else if("error" == status){
                $(eleName).parent().addClass("has-error");
                $(eleName).next("span").text(msg);
            }
        }

        // 校验用户名是否可用
        $("#empName_add_input").change(function () {
            var empName = this.value;
            // 发送 ajax 请求校验用户名是否可用
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"empName="+empName,
                type:"POST",
                success:function(result) {
                    // alert(result.code);
                    if (result.code == 100) {
                        show_validate_msg("#empName_add_input", "success", "用户名可用");
                        $("#emp_save_btn").attr("ajax-validate", "success");
                    }else {
                        show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-validate", "error");
                    }

                }
            });
        });

        // 点击模态框中的【保存】按钮， 将员工基本信息保存到数据库中
        $("#emp_save_btn").click(function () {
            // 序列化表格元素 (类似 '.serialize()' 方法) 返回 JSON 数据结构数据。
            // $("#empAddModal form").serialize()

            // 1、先对要提交给服务器的数据进行校验
            if (!validDate_add_form()){
                return false;
            }

            // 判断之前的 ajax 用户名校验是否成功。
            if ($(this).attr("ajax-validate") == "error"){
                return false;
            }

            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    if (result.code == 100){
                        // 关闭（隐藏）模态框
                        // alert(result.msg);
                        $("#empAddModal").modal('hide');
                        // 在分页条的末页显示刚新增的记录
                        // 发送 ajax 请求显示最后一页数据即可
                        to_page(tatolEmpRecord);
                    }else {
                        // 显示失败信息
                        // console.log(result);
                        // 有哪个字段的错误信息就显示哪个字段的
                            if (undefined != result.extend.errorFields.email) {
                                show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                            }

                            if (undefined != result.extend.errorFields.empName) {
                                show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                            }
                    }


                }
            });
        });

        // 二、点击编辑按钮，弹出员工修改模态框
        // 使用 on 对后来添加的元素绑定事件
        $(document).on("click", ".edit_btn", function() {
            // alert("edit");

            // 1、查出部门信息， 并显示部门下拉列表
            // 发送 ajax 请求， 获取部门信息
            getDepts("#deptName_update_select");

            // 2、查出员工信息，显示员工信息
            getEmp($(this).attr("edit-id"));

            // 3、把员工的 id 传递给模态框的修改按钮
            $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

            // 4、弹出员工修改模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });

        });

        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function(result) {
                    console.log(result);
                    // 显示 员工信息
                    $("#empName_update_static").text(result.extend.emp.empName);
                    $("#email_update_input").val(result.extend.emp.email);
                    $("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
                    $("#deptName_update_select").val([result.extend.emp.dId]);
                }
            });
        }

        // 点击修改， 修改员工信息
        $("#emp_update_btn").click(function() {
            // 1、验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(email)){
                // alert("邮箱格式错误!");
                show_validate_msg("#email_update_input", "error", "邮箱格式错误!");
                return false;
            }else{
                show_validate_msg("#email_update_input",  "success", "");
            }

            // 2、发送 ajax 请求保存修改的员工数据
            // 序列化表格元素 (类似 '.serialize()' 方法) 返回 JSON 数据结构数据。
            // $("#empUpdateModal form").serialize()
            // alert("修改");
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                // type:"POST",
                // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    // alert(result.msg);
                    // 1、关闭对话框
                    $("#empUpdateModal").modal("hide");
                    // 2、回到本页面
                    to_page(currentPage);
                }
            });

        });

        // delete_btn
        // 三、点击删除按钮，删除员工

        // 单个删除
        $(document).on("click", ".delete_btn", function() {
            // 1、弹出是否确认删除对话框
            var empName = $(this).parents("tr").find("td:eq(1)").text();
            // alert($(this).parents("tr").find("td:eq(1)").text());
            var empId = $(this).attr("del-id");

            if(confirm("确认删除【"+empName+"】吗？")) {
                // 确认删除， 发送 ajax 请求删除即可
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        // 回到本页
                        to_page(currentPage);
                    }
                });
            }
        });

        // 完成全选 或 全不选
        $("#check_all").click(function () {
            // attr 获取 checked 是 undefined ， 是用来获取自定义属性的值
            // prop 修改和读取 dom 原生属性的值
            $(".check_item").prop("checked", $(this).prop("checked"));
        });

        $(document).on("click", ".check_item", function () {
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked", flag);
        });

        // 点击全部删除， 就进行批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var empIds = "";
            $.each($(".check_item:checked"), function () {
                empNames += $(this).parents("tr").find("td:eq(1)").text() + ",";
                empIds += $(this).parents("tr").find("td:eq(0)").text() + "-";
            });
            // 去除 empNames 多余的 ,
            empNames = empNames.substring(0, empNames.length - 1);
            // 去除 empIds 多余的 -
            empIds = empIds.substring(0, empIds.length - 1);
            if (confirm("确认删除【"+empNames+"】吗？")) {
                // true， 就发送 ajax 请求
                $.ajax({
                    url:"${APP_PATH}/emp/"+empIds,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });

    </script>

</body>
</html>
