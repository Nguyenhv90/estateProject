<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="buildingListURL" value="/admin/building-list"/>
<c:url var="buildingDetail" value="/admin/building-detail"/>
<c:url var="buildingEditURL" value="/admin/building-edit"/>
<c:url var="buildingUploadURL" value="/admin/building-upload"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
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
                    <a href="${buildingListURL}?page=1&limit=6">Home</a>
                </li>
                <li class="active">Danh sách tòa nhà</li>
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
                                <form:form commandName="model" action="${buildingListURL}" id="listForm" method="GET">
                                        <div class="form-group">
                                            <!-- PAGE CONTENT BEGINS -->
                                            <div class="col-sm-6">
                                                <div>
                                                    <label for="name"><b>Tên tòa nhà</b></label>
                                                    <form:input path="name" cssClass="form-control"/>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <div>
                                                    <label for="floorArea"><b>Diện tích sàn</b></label>
                                                    <input type="number" id="floorArea" class="form-control" name="floorArea" value="${model.floorArea}" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <label for="district"><b>Quận hiện có</b></label></br>
                                                <form:select path="district">
                                                    <form:option value="" label="---Chọn quận---"/>
                                                    <form:options items="${district}"/>
                                                </form:select>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="ward"><b>Phường</b></label>
                                                    <form:input path="ward" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="street"><b>Đường</b></label>
                                                    <form:input path="street" cssClass="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="numberOfBasement"><b>Số tầng hầm</b></label>
                                                    <input type="number" id="numberOfBasement" class="form-control" name="numberOfBasement" value="${model.numberOfBasement}"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="direction"><b>Hướng</b></label>
                                                    <form:input path="direction" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="level"><b>Hạng</b></label>
                                                    <form:input path="level" cssClass="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="areaRentFrom"><b>Diện tích từ</b></label>
                                                    <input type="number" id="areaRentFrom" class="form-control" name="areaRentFrom" value="${model.areaRentFrom}"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="areaRentTo"><b>Diện tích đến</b></label>
                                                    <input type="number" id="areaRentTo" class="form-control" name="areaRentTo" value="${model.areaRentTo}"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="costRentFrom"><b>Giá thuê từ</b></label>
                                                    <input type="number" id="costRentFrom" class="form-control" name="costRentFrom" value="${model.costRentFrom}"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div>
                                                    <label for="costRentTo"><b>Giá thuê đến</b></label>
                                                    <input type="number" id="costRentTo" class="form-control" name="costRentTo" value="${model.costRentTo}"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="managerName"><b>Tên quản lý</b></label>
                                                    <form:input path="managerName" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div>
                                                    <label for="managerPhone"><b>Điện thoại quản lý</b></label>
                                                    <form:input path="managerPhone" cssClass="form-control"/>
                                                </div>
                                            </div>
                                            <security:authorize access="hasRole('MANAGER')">
                                                <div class="col-sm-4">
                                                    <label for="staffId"><b>Chọn nhân viên phụ trách</b></label>
                                                    <form:select path="staffId" cssClass="col-sm-8">
                                                        <form:option value="" label="---chọn nhân viên---"/>
                                                        <form:options items="${staffMaps}"/>
                                                    </form:select>
                                                </div>
                                            </security:authorize>
                                        </div>

                                        <div class="form-group ">
                                            <label for="buildingTypes"><b>Loại tòa nhà</b></label>
                                           <form:checkboxes path="buildingTypes" items="${types}"/>
                                        </div>
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
                        <security:authorize access="hasRole('MANAGER')">
                            <button type="button" class="btn btn-success btn-white btn-bold" data-toggle="tooltip"
                                    onclick="location.href='${buildingEditURL}'" name="addBuilding" title="Thêm tòa nhà">
                                <i class="fa fa-plus-circle" area-hidden="true"></i>
                            </button>
                            <button type="button"  class="btn btn-info btn-white btn-bold" data-toggle="tooltip"
                                    onclick="location.href='${buildingUploadURL}'" name="uploadBuilding" title="Upload tòa nhà">
                                <i class="fa fa-upload" aria-hidden="true"></i>
                            </button>
                            <button type="button"  class="btn btn-warning btn-white btn-bold"  data-toggle="tooltip" onclick="deleteBuildingWarning()" id = "delete" title="Xóa tòa nhà">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </security:authorize>
                        <security:authorize access="hasRole('STAFF')">
                            <button type="button" class="btn btn-success btn-white btn-bold" disabled data-toggle="tooltip"
                                    onclick="location.href='${buildingEditURL}'" name="addBuilding" title="Thêm tòa nhà">
                                <i class="fa fa-plus-circle" area-hidden="true"></i>
                            </button>
                            <button type="button"  class="btn btn-info btn-white btn-bold" data-toggle="tooltip"
                                    onclick="location.href='${buildingUploadURL}'" name="uploadBuilding" disabled title="Upload tòa nhà">
                                <i class="fa fa-upload" aria-hidden="true"></i>
                            </button>
                            <button type="button"  class="btn btn-warning btn-white btn-bold" disabled data-toggle="tooltip" onclick="deleteBuildingWarning()" id = "delete" title="Xóa tòa nhà">
                                <i class="fa fa-trash" aria-hidden="true"></i>
                            </button>
                        </security:authorize>
                    </div>
                </div><!-- /.col -->
            </div><!-- /.row -->

            <div class="row">
                <form:form commandName="model" id="formSubmit" action="${buildingListURL}" method="get">
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
                                <th>Tên tòa nhà</th>
                                <th>Số tầng hầm</th>
                                <th>Địa chỉ</th>
                                <th>Tên quản lý</th>
                                <th>Số điện thoại</th>
                                <th>Diện tích sàn</th>
                                <th>Giá thuê</th>
                                <th>Phí dịch vụ</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="item" items="${buildings}" >
                                <tr>
                                    <td class="center">
                                        <label class="pos-rel">
                                            <input type="checkbox" class="ace" id="checkbox_${item.id}" value="${item.id}" />
                                            <span class="lbl"></span>
                                        </label>
                                    </td>
                                    <td>${item.name}</td>
                                    <td>${item.numberOfBasement}</td>
                                    <td>${item.street} ${item.ward}</td>
                                    <td>${item.managerName}</td>
                                    <td>${item.managerPhone}</td>
                                    <td>${item.floorArea}</td>
                                    <td>${item.costDescription}</td>
                                    <td>${item.serviceCost}$</td>
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
<%--                                        <security:authorize access="hasRole('STAFF')">--%>
<%--                                            <button type="button" class="btn btn-xs btn-warning" data-toggle="tooltip" disabled title="Giao tòa nhà"--%>
<%--                                                    onclick="assignmentBuilding(${item.id})">--%>
<%--                                                <i class="fa fa-user" aria-hidden="true"></i>--%>
<%--                                            </button>--%>
<%--                                        </security:authorize>--%>

                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <ul class="pagination" id="pagination">
                        </ul>
                        <form:hidden path="page" id ="page"/>
                        <form:hidden path="limit" id ="limit"/>
                    </div>
                </form:form>
            </div>
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<!-- /assignment Building Modal -->
<div class="modal fade" id="assignmentBuildingModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table id="staffList" class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="center">Chọn nhân viên</th>
                        <th>Tên nhân viên</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <input type="hidden" value="" id="buildingId" name ="buildingId" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnAssignBuilding">Giao tòa nhà</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
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

    function assignmentBuilding(buildingId) {
        openModalAssignmentBuilding();
        loadStaff(buildingId);
        $('#buildingId').val(buildingId);
        console.log($('#buildingId').val());
    }
    function loadStaff(buildingId){
        $.ajax({
            type: "GET",
            url: "${buildingAPI}/"+buildingId+"/staffs",
            dataType: "json",
            success: function (response) {
                console.log("success");
                var row = '';
                $.each(response.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="text-center"><input type="checkbox" value=' + item.staffId +' id ="checkbox_' + item.staffId + '" class="check-box-element" ' + item.checked + '/></td>';
                    row += '<td class="text-center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
            }
        });
    }
    function openModalAssignmentBuilding() {
        $('#assignmentBuildingModal').modal();
    }
    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    });
    $('#btnAssignBuilding').click(function (e) {
        e.preventDefault();
        var data ={};
        data['buildingId'] = $('#buildingId').val();
        var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['staffs'] = staffs;
        assignStaff(data);
    });
    function assignStaff(data) {
        $.ajax({
            type: "POST",
            url: "${buildingAPI}/staffs",
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log("success");
                swal("Thông báo!", "Giao tòa nhà thành công!", "success");
            },
            error: function (response) {
                swal("Thông báo!", "Giao tòa nhà thất bại:)", "error");
                console.log(response);
            }
        });
    }
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
