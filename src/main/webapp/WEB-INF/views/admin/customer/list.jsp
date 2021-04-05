<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="customerListURL" value="/admin/customer-list"/>
<c:url var="customerEditURL" value="/admin/customer-edit"/>
<c:url var="customerAPI" value="/api/customer"/>
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
                    <a href="#">Home</a>
                </li>
                <li class="active">Danh sách khách hàng</li>
            </ul><!-- /.breadcrumb -->
        </div>

        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
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
                                <form:form commandName="customerSearch" action="${customerListURL}" id="listForm" method="GET">
                                        <div class="form-group">
                                            <!-- PAGE CONTENT BEGINS -->
                                            <div class="col-sm-4">
                                                <label for="fullName"><b>Tên khách hàng</b></label>
                                                <form:input path="fullName" cssClass="form-control"/>
                                            </div>
                                            <div class="col-sm-4">
                                                <label for="email"><b>Email</b></label>
                                                <form:input path="email" cssClass="form-control"/>
                                            </div>
                                            <div class="col-sm-4">
                                                <label for="phone"><b>Di động</b></label>
                                                <form:input path="phone" cssClass="form-control"/>
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-4">
                                                <label for="staffId"><b>Chọn nhân viên phụ trách</b></label>
                                                <form:select path="staffId" cssClass="col-sm-8">
                                                    <form:option value="" label="---chọn nhân viên---"/>
                                                    <form:options items="${staffMaps}"/>
                                                </form:select>
                                            </div>
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
                        <button class="btn btn-info btn-white btn-bold" data-toggle="tooltip"
                                onclick="location.href='${customerEditURL}'" name="addBuilding" title="Thêm khách hàng">
                            <i class="fa fa-plus-circle" area-hidden="true"></i>
                        </button>
                        <button class="btn btn-warning btn-white btn-bold" onclick="deleteCustomerWarning()" data-toggle="tooltip" title="Xóa khách hàng">
                            <i class="fa fa-trash" aria-hidden="true"></i>
                        </button>
                    </div>
                </div><!-- /.col -->
            </div><!-- /.row -->

            <div class="row">
                <div class="col-xs-12">
                    <table id="customerList" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th class="center">
                                <label class="pos-rel">
                                    <input type="checkbox" class="ace" id="checkAll" />
                                    <span class="lbl"></span>
                                </label>
                            </th>
                            <th>Tên</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
                            <th>Nhu cầu</th>
                            <th>Người nhập</th>
                            <th>Ngày nhập</th>
                            <th>Tình trạng</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${customers}" >
                            <tr>
                                <td class="center">
                                    <label class="pos-rel">
                                        <input type="checkbox" class="ace" id="checkbox_${item.id}" value="${item.id}" />
                                        <span class="lbl"></span>
                                    </label>
                                </td>
                                <td>${item.fullName}</td>
                                <td>${item.phone}</td>
                                <td>${item.email}</td>
                                <td>${item.note}</td>
                                <td>${item.createdBy}</td>
                                <td>${item.createdDate}</td>
                                <td>111</td>
                                <td>
                                    <button class="btn btn-xs btn-success" data-toggle="tooltip" title="Xem chi tiết">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </button>

                                    <button class="btn btn-xs btn-info" data-toggle="tooltip" title="Sửa thông tin khách hàng"
                                    onclick="location.href='${customerEditURL}?id=${item.id}'">
                                        <i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
                                    </button>

                                    <button class="btn btn-xs btn-warning" data-toggle="tooltip" title="Giao khách hàng"
                                            onclick="assignmentCustomer(${item.id})">
                                        <i class="fa fa-user" aria-hidden="true"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<!-- /assignment Building Modal -->
<div class="modal fade" id="assignmentCustomerModal" role="dialog">
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
                <input type="hidden" value="" id="customerId" name ="customerId" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnAssignCustomer">Giao khách hàng</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
<script>
    function assignmentCustomer(customerId) {
        openModalAssignmentCustomer();
        // loadStaff();
        $('#customerId').val(customerId);
        console.log($('#customerId').val());
    }
    // function loadStaff(){
    //     var id = $('#customerList').find('#id').val();
    //     $.ajax({
    //         type: "GET",
    //         url: "url",
    //         //data: JSON.stringify(data),
    //         dataType: "json",
    //         //contentType: "application/json",
    //         success: function (response) {
    //             console.log("success");
    //             var row = '';
    //             $.each(response.data, function (index, item) {
    //                 row += '<tr>';
    //                 row += '<td class="text-center"><input type="checkbox" value=' + item.staffId + ' id="checkbox_' + item.staffId + '" class="check-box-element" ' + item.checked + '/></td>';
    //                 row += '<td class="text-center">' + item.fullName + '</td>';
    //                 row += '</tr>';
    //             });
    //             $('#staffList tbody').html(row);
    //         },
    //         error: function (response) {
    //             console.log("failed");
    //             console.log(response);
    //         }
    //     });
    // }
    function openModalAssignmentCustomer() {
        $('#assignmentCustomerModal').modal();
    }
    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    });
    $('#btnAssignCustomer').click(function (e) {
        e.preventDefault();
        var data ={};
        data['customerId'] = $('#customerId').val();
        //$('#staffList').find('tbody input[type=checkbox]')
        var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['staffs'] = staffs;
        assignStaff(data);
    });
    function assignStaff(data) {
        $.ajax({
            type: "POST",
            url: "url",
            data: JSON.stringify(data),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log("success");
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
            }
        });
    }
    function deleteCustomerWarning() {
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
            if(isConfirm) {
                var customerIds = $('#customerList').find('tbody input[type=checkbox]:checked').map(function () {
                    return $(this).val();
                }).get();
                deleteCustomer(customerIds);
            }
        });
    }
    function deleteCustomer(data) {
        $.ajax({
            type: "DELETE",
            url: "${customerAPI}",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                console.log("success");
                window.location.href="${customerListURL}";
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
                window.location.href="${customerListURL}";
            }
        });
    }
</script>
</body>
</html>
