<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="customerAPI" value="/api/customer"/>
<c:url var="customerURL" value="/admin/customer-edit"/>
<c:url var="customerMain" value="/admin/customer-list"/>
<html>
<head>
    <title>Thêm khách hàng</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Home</a>
                </li>
                <li class="active">Dashboard</li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <form:form modelAttribute="modelEdit" cssClass="form-horizontal" action="${customerURL}" id="formEdit" method="GET">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="fullName">Tên đầy đủ</label>
                            <div class="col-sm-9">
                                <form:input path="fullName" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="phone">Số điện thoại</label>
                            <div class="col-sm-9">
                                <form:input path="phone" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="email">Email</label>
                            <div class="col-sm-9">
                                <form:input path="email" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="commanyName">Tên công ty</label>
                            <div class="col-sm-9">
                                <form:input path="commanyName" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="demand">Nhu cầu</label>
                            <div class="col-sm-9">
                                <<form:input path="demand" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="note">Ghi chú</label>
                            <div class="col-sm-9">
                                <form:input path="note" cssClass="form-control"/>
                            </div>
                        </div>
                        <form:hidden path="id" id ="id"/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" ></label>
                            <div class="col-sm-9">
                                <c:if test="${not empty modelEdit.id}">
                                    <button type="button" class="btn btn-primary" id="btnAddCustomer" >Sửa thông tin khách hàng</button>
                                </c:if>
                                <c:if test="${empty modelEdit.id}">
                                    <button type="button" class="btn btn-primary" id="btnAddCustomer">Thêm khách hàng</button>
                                </c:if>
                                <button type="button" class="btn btn-warning" onclick="location.href='${customerMain}'">Hủy</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div><!-- /.row -->

        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<div class="footer">
    <div class="footer-inner">
        <div class="footer-content">
            <span class="bigger-120">
                <span class="blue bolder">Ace</span>
                Application &copy; 2013-2014
            </span>
            <span class="action-buttons">
                <a href="#"><i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i></a>
                <a href="#"><i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i></a>
                <a href="#"> <i class="ace-icon fa fa-rss-square orange bigger-150"></i></a>
            </span>
        </div>
    </div>
</div>
<!-- basic scripts -->
<script>
    $('#btnAddCustomer').click(function (e) {
        e.preventDefault();
        var data ={};
        var formData = $('#formEdit').serializeArray();
        var id = $('#id').val();
        $.each(formData, function (index, v) {
            data[""+v.name+""] = v.value;
        });
        $.ajax({
            type: 'POST',
            url: '${customerAPI}',
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/JSON",
            success: function (response) {
                console.log("success");
            },
            error: function (response) {
              console.log("failed");
              console.log(response);
              }
        });
        if (id == ""){
            $.ajax({
                type: 'POST',
                url: '${customerAPI}',
                data: JSON.stringify(data),
                dataType: "JSON",
                contentType: "application/JSON",
                success: function (response) {
                    console.log("success");
                    window.location.href="${customerURL}?id="+id;
                },
                error: function (response) {
                    console.log("failed");
                    console.log(response);
                    window.location.href="${customerMain}";
                }
            });
        }else{
            $.ajax({
                type: 'PUT',
                url: '${customerAPI}/'+id,
                data: JSON.stringify(data),
                dataType: "JSON",
                contentType: "application/JSON",
                success: function (response) {
                    console.log("success");
                    window.location.href="${customerURL}?id="+id;
                },
                error: function (response) {
                    console.log("failed");
                    console.log(response);
                    window.location.href="${customerURL}?id="+id;
                }
            });
        }
    });
</script>
</body>
</html>
