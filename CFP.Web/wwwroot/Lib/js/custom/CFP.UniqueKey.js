CFP.UniqueKey = new function () {

    this.Option = {
        Table: null,
        UniqueIdTable: null,
    }

    this.Init = function (options) {
        CFP.UniqueKey.Option.Table = $("#kitTableId").DataTable(
            {
                searching: false,
                paging: true,
                serverSide: "true",
                processing: true,
                bPaginate: true,
                bLengthChange: false,
                bInfo: true,
                ajax: {
                    type: "Post",
                    url: UrlContent("UniqueKey/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    {
                        data: "kitName", name: "KitName", autoWidth: true, render: function (data, type, row) {
                            return `<a style="text-decoration: underline;" href="/UniqueKey/UniqueId?id=${row.encId}">${data}</a>`;
                        }
                    },
                    { data: "sku", name: "Sku", autoWidth: true },
                    {
                        data: "totalSerials", name: "TotalSerials", className: "text-center col-1",
                        render: function (data, type, row) {
                            return `<a href="/UniqueKey/UniqueId?id=${row.encId}">${data}</a>`;
                        }
                    },
                    { data: "used", name: "Used", className: "text-center col-1" },
                    { data: "remaining", name: "Remaining", className: "text-center col-1" },
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Generate New Unique Id" type="button" onclick="CFP.UniqueKey.Add('${data}')"><i class="mdi mdi-plus text-white" ></i></button>`;
                            return btnEdit;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.UniqueKey.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("UniqueKey/_Details/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#KitForm"));
                $("#common-md-dialog").modal('show');
                flatpicker();
            }
        })
    }

    this.Save = function () {
        if ($("#KitForm").valid()) {
            $(".preloader").show();
            var formdata = $("#KitForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("UniqueKey/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        if (CFP.UniqueKey != null && CFP.UniqueKey.Option != null && CFP.UniqueKey.Option.Table != null) {
                            CFP.UniqueKey.Option.Table.ajax.reload();
                        }
                        if (CFP.UniqueKey != null && CFP.UniqueKey.Option != null && CFP.UniqueKey.Option.UniqueIdTable != null) {
                            CFP.UniqueKey.Option.UniqueIdTable.ajax.reload();
                        }
                        CFP.Common.ToastrSuccess(result.message);
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }
    this.InitUniqueId = function (options) {
        CFP.UniqueKey.Option.UniqueIdTable = $("#uniqueIdTableId").DataTable(
            {
                searching: false,
                paging: true,
                serverSide: "true",
                processing: true,
                bPaginate: true,
                bLengthChange: false,
                bInfo: true,
                ajax: {
                    type: "Post",
                    url: UrlContent("UniqueKey/GetUniqueIdList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        dtParms.KitId = $("#hidkitId").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "uniqueId", name: "UniqueId", autoWidth: true },
                    { data: "barcode", name: "Barcode", autoWidth: true },
                    { data: "gtin", name: "GTIN", autoWidth: true },
                    { data: "mfgDateString", name: "MfgDateString", autoWidth: true },
                    { data: "expDateString", name: "ExpDateString", autoWidth: true },
                    { data: "lotNo", name: "LotNo", autoWidth: true },
                    { data: "trackingNo", name: "TrackingNo", className: "text-center col-1", },
                    {
                        data: "isUsed", name: "IsUsed", className: "text-center col-1",
                        render: function (data, type, row) {
                            if (data) {
                                return '<span class="badge bg-success-subtle text-success font-14">Yes</span>';
                            } else {
                                let btnEdit = `<button class="btn btn-primary btn-sm ml-1" title=" Edit" type="button" onclick="CFP.UniqueKey.EditUniqueId('${row.encId}')"><i class="ri-pencil-line text-white" ></i></button>`;
                                return '<span class="badge bg-warning-subtle text-black font-14">No</span>' + btnEdit;
                            }
                        }
                    },

                ],
                order: [[0, "DESC"]],
            });
    }
    this.SearchUnique = function () {
        CFP.UniqueKey.Option.UniqueIdTable.ajax.reload();
    }

    this.DownloadUniqueId = function () {
        $(".preloader").show();
        $.ajax({
            url: UrlContent("UniqueKey/DownloadUniqueId"),
            type: "POST",
            data: {
                KitId: $("#hidkitId").val(),
            },
            success: function (response) {
                $(".preloader").hide();
                if (response.isSuccess) {
                    window.location.href = UrlContent("ExtraFiles/Downloads/" + response.message);
                } else {
                    CFP.Common.ToastrError(response.message);
                }
            }
        });
    }

    this.Upload = function (id) {
        $('.preloader').show();
        $.ajax({
            type: "POST",
            url: UrlContent("UniqueKey/_UploadData"),
            data: { id: id },
            success: function (data) {
                $('.preloader').hide();
                $("#common-md-dialogContent").html(data);
                $("#common-md-dialog").modal('show');
            }

        })

    }
    this.ImportData = function () {
        $("#divMsg").addClass("hide");
        $("#btnDownloadError").addClass("hide");
        var fileUpload = $("#fileUpload").get(0);
        var files = fileUpload.files;
        $(".preloader").show();
        var formdata = new FormData();
        for (var i = 0; i < files.length; i++) {
            formdata.append("ImportFile", files[i]);
        }
        $.ajax({
            type: "POST",
            url: UrlContent("UniqueKey/ImportData"),
            data: formdata,
            contentType: false,
            processData: false,
            success: function (response) {
                $(".preloader").hide();
                $("#btnDownloadError").addClass("hide");
                $("#divMsg").addClass("hide");
                $("#fileUpload").val(null);
                if (response.isSuccess) {
                    $("#divMsg").removeClass("hide");
                    $("#lblMsg").html(response.message);
                    if (response.result != null && response.result != "" && typeof response.result != "undefined") {
                        $("#btnDownloadError").attr("href", response.result);
                        $("#btnDownloadError").removeClass("hide");
                    }

                } else {
                    $("#divMsg").removeClass("hide");
                    $("#lblMsg").html(response.message);
                }

            },
            error: function (textStatus, errorThrown) {
            }
        });
    }

    this.EditUniqueId = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("UniqueKey/_EditUniqueId/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#uniqueForm"));
                $("#common-md-dialog").modal('show');
                flatpicker();
            }
        })
    }

    this.SaveUniqueId = function () {
        if ($("#uniqueForm").valid()) {
            $(".preloader").show();
            var formdata = $("#uniqueForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("UniqueKey/SaveKitSerial/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.UniqueKey.Option.UniqueIdTable.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }
}