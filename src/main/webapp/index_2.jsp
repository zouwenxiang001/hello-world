<%--
  Created by IntelliJ IDEA.
  User: zwx001
  Date: 2020/7/8
  Time: 0:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TestBoostrap</title>

    <script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>

    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" />

    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(function(){
            $(".btn-primary").click(function(){
                alert("hello");
            });
        });
    </script>

</head>
<body>

    <form action="">

        <div class="container" id="1">

            <div class="row" id="2">
                <div class="col-md-4" id="3">
                    <button type="button" class="btn-default">默认</button>
                </div>
                <div class="col-md-4" id="4">
                    <button class="btn btn-primary">submit</button>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-warning">warning</button>
                </div>
            </div>

        </div>

    </form>

    <script type="text/javascript">
        $("form").removeClass();
    </script>

</body>
</html>
