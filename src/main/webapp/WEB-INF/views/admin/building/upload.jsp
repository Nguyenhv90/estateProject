<%@include file="/common/taglib.jsp" %>
<c:url var="buildingList" value="/admin/building-list"/>
<c:url var="uploadBuilding" value="/api/building/file"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload tòa nhà</title>
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
                    <a href="${buildingURLMain}?page=1&limit=6">Home</a>
                </li>
                <li class="active">Dashboard</li>
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
                    <h2>Upload và lưu tòa nhà </h2>
                    <p>--------------------------------------------------------------</p>
                    <form  style="margin-left: 30px" enctype = "multipart/form-data" id="formUpload">
                        <div class="form-group">
                            <h3>Vui lòng chọn file upload (Excel)</h3>
                            <input type = "file" name = "file" id="file" value = "Chọn tệp" data-allowed-file-extensions='["xls", "xlsx"]'/> <br />
                            <input type = "submit" class="btn btn-primary" id="btnUpload" value = "Upload" title="Click để upload tòa nhà"/> <br />
                        </div>
                    </form>
                </div>
            </div><!-- /.row -->
        </div><!-- /.page-content -->
    </div>
</div><!-- /.main-content -->
<script>
    $('#btnUpload').click(function (e) {
        e.preventDefault();
        var file = $('#file');
        if (!isExcel(file.val())) {
            window.alert("Select excel File please");
            return;
        }else{
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "${uploadBuilding}",
                data: new FormData($('#formUpload')[0]),
                processData: false,
                contentType: false,
                cache: false,
                success: function (response) {
                    console.log("success");
                    window.location.href="${buildingList}?page=1&limit=6&message=upload_success";
                },
                error: function (response) {
                    console.log("failed");
                    window.location.href="${buildingList}?page=1&limit=6&message=error_system";
                }
            });
        }

    });
    function getExtension(filename) {
        var parts = filename.split('.');
        return parts[parts.length - 1];
    }
    function isExcel(filename) {
        var ext = getExtension(filename);
        switch (ext.toLowerCase()) {
            case 'xlsx':
            case 'xls':
                return true;
        }
        return false;
    }
</script>
</body>
</html>

