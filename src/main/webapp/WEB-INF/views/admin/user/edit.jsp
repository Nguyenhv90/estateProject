<%@include file="/common/taglib.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="editbuildingURL" value="/admin/building-edit"/>
<c:url var="buildingListURL" value="/admin/building-list"/>
<html>
<head>
    <title>Chỉnh sửa tòa nhà</title>
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
                    <a href="${buildingListURL}?page=1&limit=6">Home</a>
                </li>
                <li class="active">Chỉnh sửa tòa nhà</li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <c:if test="${not empty message}">
                    <div class="alert alert-${message.get("alert")}">
                            ${message.get("message")}
                    </div>
                </c:if>
                <div class="col-xs-12">
                    <form:form modelAttribute="modelEdit" cssClass="form-horizontal" action="${editbuildingURL}" id="formEdit" method="GET">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="name">Tên tòa nhà</label>
                            <div class="col-sm-9">
                                <form:input path="name" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" >Người quản lý tòa nhà</label>
                            <div class="col-sm-9">
                                <label class="control-label"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="district">Quận hiện có</label>
                            <form:select cssClass="col-sm-3" path="district">
                                <form:option value="" label="---Chọn quận---"/>
                                <form:options items="${district}"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="ward">Phường</label>
                            <div class="col-sm-9">
                                <form:input path="ward" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="street">Đường</label>
                            <div class="col-sm-9">
                                <form:input path="street" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="structure">Kết cấu</label>
                            <div class="col-sm-9">
                                <form:input path="structure" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="numberOfBasement">Số tầng hầm</label>
                            <div class="col-sm-9">
                                <input type="number" id="numberOfBasement" class="form-control" name="numberOfBasement" value="${modelEdit.numberOfBasement}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="floorArea">Diện tích sàn</label>
                            <div class="col-sm-9">
                                <input type="number" id="floorArea" class="form-control" name="floorArea"  value="${modelEdit.floorArea}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="direction">Hướng</label>
                            <div class="col-sm-9">
                                <form:input path="direction" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="level">Hạng</label>
                            <div class="col-sm-9">
                                <form:input path="level" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="rentArea">Diện tích thuê</label>
                            <div class="col-sm-9">
                                <input type="text" id="rentArea" class="form-control" name="rentArea" value="${modelEdit.rentArea}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="rentAreaDescription">Mô tả diện tích</label>
                            <div class="col-sm-9">
                                <form:input path="rentAreaDescription" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="rentCost">Giá thuê</label>
                            <div class="col-sm-9">
                                <input type="number" id="rentCost" class="form-control" name="rentCost" value="${modelEdit.rentCost}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="costDescription">Mô tả giá</label>
                            <div class="col-sm-9">
                                <form:input path="costDescription" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="serviceCost">Phí dịch vụ</label>
                            <div class="col-sm-9">
                                <form:input path="serviceCost" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="carCost">Phí ô tô</label>
                            <div class="col-sm-9">
                                <form:input path="carCost" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="motorCost">Phí mô tô</label>
                            <div class="col-sm-9">
                                <form:input path="motorCost" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="overtimeCost">Phí ngoài giờ</label>
                            <div class="col-sm-9">
                                <form:input path="overtimeCost" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="electricBill">Tiền điện</label>
                            <div class="col-sm-9">
                                <form:input path="electricBill" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="deposit">Đặt cọc</label>
                            <div class="col-sm-9">
                                <form:input path="deposit" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="payment">Thanh toán</label>
                            <div class="col-sm-9">
                                <form:input path="payment" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="timeRent">Thời hạn thuê</label>
                            <div class="col-sm-9">
                                <form:input path="timeRent" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="timeDecorator">Thời gian trang trí</label>
                            <div class="col-sm-9">
                                <form:input path="timeDecorator" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="managerName" class="col-sm-3 control-label no-padding-right"><b>Tên quản lý</b></label>
                            <div class="col-sm-9">
                                <form:input path="managerName" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="managerPhone">SĐT quản lý</label>
                            <div class="col-sm-9">
                                <form:input path="managerPhone" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-sm-3 control-label no-padding-right" for="buildingTypes">Loại tòa nhà</label>
                            <div class="col-sm-9">
                                <form:checkboxes path="buildingTypes" items="${types}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="image">Chọn ảnh</label>
                            <div class="col-sm-3">
                                <input type="file" name="image" id="image"/>
                            </div>
                            <div class="col-sm-6">
                                <c:if test="${not empty model.image}">
                                    <c:set var="image" value="${model.image}"/>
                                    <img src="${image}" id="viewImage" class="responsive-img-desktop">
                                </c:if>
                                <c:if test="${empty model.image}">
                                    <img src="<c:url value='/image/no-image.png'/>" id="viewImage" class="responsive-img-desktop">
                                </c:if>
                            </div>
                        </div>
                        <form:hidden path="id" id ="id"/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" ></label>
                            <div class="col-sm-9">
                                <c:if test="${not empty modelEdit.id}">
                                    <button type="button" class="btn btn-primary" id="btnAddBuilding" >Sửa tòa nhà</button>
                                </c:if>
                                <c:if test="${empty modelEdit.id}">
                                    <button type="button" class="btn btn-primary" id="btnAddBuilding">Thêm tòa nhà</button>
                                </c:if>
                                <button type="button" class="btn btn-warning" onclick="location.href='${buildingListURL}'">Hủy</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div><!-- /.row -->
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<!-- basic scripts -->
<script>
    $(document).ready(function () {
        $('#image').change(function () {
            openImage(this, "viewImage");
        });
    });

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $('#btnAddBuilding').click(function (e) {
        e.preventDefault();
        var data ={};
        var buildingTypes =[];
        var file = $('#image')[0].files[0];
        var id = $('#id').val();
        var formData = $('#formEdit').serializeArray();
        $.each(formData, function (index, v) {
            if(v.name == "buildingTypes"){
                buildingTypes.push(v.value);
            }else{
                data[""+v.name+""] = v.value;
            }
        });
        data["buildingTypes"] = buildingTypes;
        if (files != undefined) {
            dataArray["image"] = files.name;
            var reader = new FileReader();
            reader.onload = function (e) {
                dataArray["base64"] = e.target.result;
                if ($('#id').val() != "") {
                    updateBuilding(dataArray, id);
                }
                else {
                    addBuilding(dataArray);
                }
            };
            reader.readAsDataURL(files);
        } else {
            if (id != "") {
                updateBuilding(dataArray, id);
            }
            else {
                addBuilding(dataArray);
            }
        }
    });
    function updateBuilding(data, id) {
        $.ajax({
            type: 'PUT',
            url: '${buildingAPI}/'+id,
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/JSON",
            success: function (result) {
                console.log("success");
                window.location.href="${editbuildingURL}?id="+id+"&message=update_success";
            },
            error: function (error) {
                console.log("failed");
                window.location.href="${editbuildingURL}?id="+id+"&message=error_system";
            }
        });
    }
    function addBuilding(data) {
        $.ajax({
            type: 'POST',
            url: '${buildingAPI}',
            data: JSON.stringify(data),
            dataType: "JSON",
            contentType: "application/JSON",
            success: function (result) {
                console.log("success");
                window.location.href="${buildingListURL}?page=1&limit=6&message=insert_success";
            },
            error: function (error) {
                console.log("failed");
                window.location.href="${buildingListURL}?page=1&limit=6&message=error_system";
            }
        });
    }

</script>
</body>
</html>
