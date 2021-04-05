<%@include file="/common/taglib.jsp" %>
<c:url var="uploadBuilding" value="/api/building/image"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Imas</title>
</head>
<body>
<div class="form-group">
    <label class="col-sm-3 control-label no-padding-right" for="image">Chọn ảnh</label>
    <div class="col-sm-9">
        <input type="file" id="image" class="form-control" name="image" />
        <input type = "submit" class="btn btn-primary" id="btnUpload" value = "Upload" title="Click để upload tòa nhà"/>
    </div>
</div>
<script>
    $('#btnUpload').click(function (e) {
        var dataArray ={};
        var file = $('#image')[0].files[0];
        if(file != undefined){
            var reader = new FileReader()
            reader.onload = function (e) {
                dataArray['base64'] = e.target.result;
                dataArray['name'] = file.name;
                uploadFile(dataArray);
            }
            reader.readAsDataURL(file)
        }
    });
    function uploadFile(data) {
        $.ajax({
            type: "POST",
            url: "${uploadBuilding}",
            contentType: "application/JSON",
            data: JSON.stringify(data),
            success: function (response) {
                console.log("success");
            },
            error: function (response) {
                console.log("failed");
            }
        });
    }
</script>
</body>
</html>
