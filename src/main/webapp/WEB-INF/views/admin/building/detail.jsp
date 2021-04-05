<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingURL" value="/admin/building-detail"/>
<html>
<head>
    <title>Thông tin tòa nhà</title>
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
                    <a href="/admin/building-list?page=1&limit=6">Home</a>
                </li>
                <li class="active">Thông tin tòa nhà</li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-sm-7">
<%--                    <c:if test="${not empty messageResponse}">--%>
<%--                        <div class="alert alert-block alert-${alert}">--%>
<%--                            <button type="button" class="close" data-dismiss="alert">--%>
<%--                                <i class="ace-icon fa fa-times"></i>--%>
<%--                            </button>--%>
<%--                                ${messageResponse}--%>
<%--                        </div>--%>
<%--                    </c:if>--%>
                    <form:form cssClass="form-horizontal" commandName="model" >
                        <table id="simple-table" class="table table-striped table-bordered table-hover">
                            <tbody>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Tên tòa nhà</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.name}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Nhân viên quản lý</label>
                                </td>
                                <td class="hidden-480-not-user">
                                        ${model.managerName}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Địa chỉ</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.district}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">tỉnh</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.ward}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Đường</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.street}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Kết cấu</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.structure}
                                </td>
                            </tr>
                            <td class="hidden-480-not-user">
                                <label class="control-label">Số tầng hầm</label>
                            </td>

                            <td class="hidden-480-not-user">
                                    ${model.numberOfBasement}
                            </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Diện tích sàn</label>
                                </td>
                                <td class="hidden-480-not-user">
                                        ${model.floorArea}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Hướng</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.direction}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Xếp hạng tòa nhà</label>
                                </td>
                                <td class="hidden-480-not-user">
                                        ${model.level}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Mô tả diện tích</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.rentAreaDescription}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Mô tả giá</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.costDescription}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Phí dịch vụ</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.serviceCost}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Phí ô tô</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.carCost}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Phí xe máy</label>
                                </td>
                                <td class="hidden-480-not-user">
                                        ${model.motorCost}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Phí ngoài giờ</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.overtimeCost}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Tiền điện</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.electricBill}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Tiền dặt cọc</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.deposit}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Phương thức thanh toán</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.payment}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Thời hạn hợp đồng</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.timeRent}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Thời gian trang trí</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.timeDecorator}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Tên quản lý</label>
                                </td>

                                <td class="hidden-480-not-user">
                                        ${model.managerName}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Số điện thoại quản lý</label>
                                </td>
                                <td class="hidden-480-not-user">
                                        ${model.managerPhone}
                                </td>
                            </tr>
                            <tr>
                                <td class="hidden-480-not-user">
                                    <label class="control-label">Loại tòa nhà</label>
                                </td>
                                <td class="hidden-480-not-user">
                                    <form:checkboxes path="buildingTypes" items="${types}" element="li" disabled="true"/></tr>
                                </td>
                            </tr>
<%--                            <tr>--%>
<%--                                <td class="hidden-480-not-user">--%>
<%--                                    <label class="control-label">Liên kết</label>--%>
<%--                                </td>--%>
<%--                                <td class="hidden-480-not-user">--%>
<%--                                        ${model.link}--%>
<%--                                </td>--%>
<%--                            </tr>--%>
<%--                            <tr>--%>
<%--                                <td class="hidden-480-not-user">--%>
<%--                                    <label class="control-label"><spring:message--%>
<%--                                            code="label.building.location"/></label>--%>
<%--                                </td>--%>

<%--                                <td class="hidden-480-not-user">--%>
<%--                                        ${model.location}--%>
<%--                                </td>--%>
<%--                            </tr>--%>
                            </tbody>
                        </table>
                    </form:form>
                </div>
                <div class="col-sm-5">
                    <div class="row text-center">
<%--                        <c:if test="${not empty model.image}">--%>
<%--                            <c:set var="image" value="/repository${model.image}"/>--%>
<%--                            <img src="${image}" id="viewImage" class="responsive-img-desktop">--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${empty model.image}">--%>
                            <img src="<c:url value='/image/no-image.png'/>" id="viewImage" class="responsive-img-desktop"/>
<%--                        </c:if>--%>
                    </div>
                    <div class="hr hr-double hr-dotted hr18"></div>
<%--                    <div class="row text-center padding-6">--%>
<%--                        <div class="form-group">--%>
<%--                            <label class="control-label pull-left"><spring:message--%>
<%--                                    code="label.note"/></label>--%>
<%--                            <div class="col-sm-9">--%>
<%--                                ${model.note}--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
            </div>
<%--            <div class="hr hr-double hr-dotted hr18"></div>--%>
<%--            <div class="row">--%>
<%--                <c:if test="${not empty model.location}">--%>
<%--                    <iframe width="100%" height="450" frameborder="0" style="border:0"--%>
<%--                            src="https://www.google.com/maps/embed/v1/place?q=${model.location}&amp;key=AIzaSyBOIBSBA3kGNZK6dHil5Kqh5j8puN9bScY"></iframe>--%>
<%--                </c:if>--%>
<%--            </div>--%>
        </div>
    </div>
</div>
</div>


<!-- New York, NY, USA (40.7127837, -74.00594130000002) -->
<%--Find here: https://www.latlong.net/--%>

</body>
</html>
