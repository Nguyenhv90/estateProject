<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="userListURL" value="/admin/user-list"/>
<html>
<head>
    <title>Danh sách tài khoản</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="${userListURL}?page=1&limit=6">Home</a>
                </li>
                <li class="active">Danh sách tài khoản</li>
            </ul><!-- /.breadcrumb -->
        </div>

        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty message}">
                        <div class="alert alert-${message.get("alert")}">
                                ${message.get("message")}
                        </div>
                    </c:if>
                    <div class="widget-box">
                        <div class="widget-header">
                            <h4 class="widget-title">Tìm kiếm</h4>

                            <div class="widget-toolbar">
                                <a href="#" data-action="collapse">
                                    <i class="ace-icon fa fa-chevron-up"></i>
                                </a>

                                <a href="#" data-action="close">
                                    <i class="ace-icon fa fa-times"></i>
                                </a>
                            </div>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main form-horizontal">
                                <form:form commandName="model" action="${userListURL}" id="listForm" method="GET">
                                        <div class="form-group">
                                            <!-- PAGE CONTENT BEGINS -->
                                            <div class="col-sm-6">
                                                <div>
                                                    <label for="userName"><b>Tên tài khoản</b></label>
                                                    <form:input path="userName" cssClass="form-control"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
<%--                                            <security:authorize access="hasRole('MANAGER')">--%>
<%--                                                <div class="col-sm-4">--%>
<%--                                                    <label for="staffId"><b>Chọn nhân viên phụ trách</b></label>--%>
<%--                                                    <form:select path="staffId" cssClass="col-sm-8">--%>
<%--                                                        <form:option value="" label="---chọn nhân viên---"/>--%>
<%--                                                        <form:options items="${staffMaps}"/>--%>
<%--                                                    </form:select>--%>
<%--                                                </div>--%>
<%--                                            </security:authorize>--%>
                                        </div>
<%--                                        <div class="form-group ">--%>
<%--                                            <label for="buildingTypes"><b>Loại tòa nhà</b></label>--%>
<%--                                           <form:checkboxes path="buildingTypes" items="${types}"/>--%>
<%--                                        </div>--%>
                                        <div class="form-group">
                                            <div class="pull-left col-sm-4 ">
                                                <button class="btn btn-info btn-white btn-bold" id="btnSearch" name="btnSearch">
                                                    <i class="fa fa-search" area-hidden="true"></i>
                                                    Tìm kiếm
                                                </button>
                                            </div>
                                        </div><!-- /.col -->
                                </form:form>
                            </div>
                        </div><!-- /.widget-body -->
                    </div>
                </div>
            </div><!-- /.row -->
            </br>
            </br>
            <div class="row">
                <div class="col-xs-12">
                    <div class="pull-right">
                        <button type="button" class="btn btn-success btn-white btn-bold" data-toggle="tooltip"
                                onclick="location.href='${buildingEditURL}'" name="addBuilding" title="Thêm tòa nhà">
                            <i class="fa fa-plus-circle" area-hidden="true"></i>
                        </button>
                        <button type="button"  class="btn btn-warning btn-white btn-bold"  data-toggle="tooltip" onclick="deleteBuildingWarning()" id = "delete" title="Xóa tòa nhà">
                            <i class="fa fa-trash" aria-hidden="true"></i>
                        </button>
                    </div>
                </div><!-- /.col -->
            </div><!-- /.row -->

            <div class="row">
                <form:form commandName="users" id="formSubmit" action="${userListURL}" method="get">
                    <div class="col-xs-12">
                        <table id="buildingList" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">
                                    <label class="pos-rel">
                                        <input type="checkbox" class="ace" id="checkAll" />
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th>Tên tài khỏa</th>
                                <th>Fullname</th>
                                <th>Email</th>
                                <th>Chức vụ</th>
                                <th>Tình trạng</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="item" items="${users}" >
                                <tr>
                                    <td class="center">
                                        <label class="pos-rel">
                                            <input type="checkbox" class="ace" id="checkbox_${item.id}" value="${item.id}" />
                                            <span class="lbl"></span>
                                        </label>
                                    </td>
                                    <td>${item.userName}</td>
                                    <td>${item.fullName}</td>
                                    <td>${item.email}</td>
                                    <td>${item.roles.hashCode()}</td>
                                    <td>${item.status}</td>
                                    <td>
                                        <button type="button" class="btn btn-xs btn-success" data-toggle="tooltip"title="Xem chi tiết"
                                                onclick="location.href='${buildingDetail}?id=${item.id}'">
                                            <i class="fa fa-eye" aria-hidden="true"></i>
                                        </button>

                                        <button type="button" class="btn btn-xs btn-info" data-toggle="tooltip" name="updateBuilding" id ="updateBuilding"
                                                onclick="location.href='${buildingEditURL}?id=${item.id}'" title="Sửa thông tin tòa nhà" > <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                                        </button>
                                        <security:authorize access="hasRole('MANAGER')">
                                            <button type="button" class="btn btn-xs btn-warning" data-toggle="tooltip" title="Giao tòa nhà"
                                                    onclick="assignmentBuilding(${item.id})">
                                                <i class="fa fa-user" aria-hidden="true"></i>
                                            </button>
                                        </security:authorize>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <ul class="pagination" id="pagination">
                        </ul>
<%--                        <form:hidden path="page" id ="page"/>--%>
<%--                        <form:hidden path="limit" id ="limit"/>--%>
                    </div>
                </form:form>
            </div>
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<script>
    var totalPages = ${model.totalPage};
    var currentPages = ${model.page};
    var limit = 6;
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 10,
            startPage: currentPages,
            onPageClick: function (event, page) {
                if (currentPages != page) {
                    $('#limit').val(limit);
                    $('#page').val(page);
                    $('#formSubmit').submit();
                }
            }
        });
    });
    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    });
    function deleteBuildingWarning() {
        swal({
                title: "Are you sure?",
                text: "Bạn có chắc chắn muốn xóa hay không!",
                type: "warning",
                showCancelButton: true,
                cancelButtonClass: "btn-warning",
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Xác nhận!",
                cancelButtonText: "Hủy",
            }).then(function(isConfirm){
                if(isConfirm.value == true) {
                    var buildingIds = $('#buildingList').find('tbody input[type=checkbox]:checked').map(function () {
                        return $(this).val();
                    }).get();
                    deleteBuilding(buildingIds);
                    swal("Shortlisted!", "Candidates are successfully shortlisted!", "success");
                }else{
                    swal("Cancelled", "Your imaginary file is safe :)", "error");
                    e.preventDefault();
                }
            });
    }
    function deleteBuilding(data) {
        $.ajax({
            type: "DELETE",
            url: "${buildingAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                console.log("success");
                window.location.href="${buildingListURL}?page=1&limit=6&message=delete_success";
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
                window.location.href="${buildingListURL}?page=1&limit=6&message=error_system";
            }
        });
    }
</script>
</body>
</html>
