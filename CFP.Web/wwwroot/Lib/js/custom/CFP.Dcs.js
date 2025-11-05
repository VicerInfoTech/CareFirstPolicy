CFP.Dcs = new function () {
    var SelectedRecordArray = [];

    this.Option = {
        Table: null,
    }

    this.Init = function () {
        CFP.Dcs.Option.Table = $("#dcstableId").DataTable(
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
                    url: UrlContent("Dcs/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let renderResult = '<div class="form-check"><input type="checkbox" class="deleteAll mr-2 mb-1 fs-14 form-check-input link-primary" value="' + row.dcsorderId + '" onChange="CFP.Dcs.OnSelectRecord()"/>'
                            let btnConfirm = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Confirm" type="button" onclick="CFP.Dcs.Confirm('${data}')"><i class="ri-check-line text-white" ></i></button>`;
                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Dcs.Add('${data}')"><i class="ri-pencil-line text-white" ></i></button>`;
                            let btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1"title="Delete" type="button" onclick="CFP.Dcs.Delete('${data}')"><i class="ri-delete-bin-line text-white" ></i></button>`;
                            return renderResult + btnConfirm + btnEdit + btnDelete + "</div>";
                        }
                    },
                    { data: "orderNumber", name: "OrderNumber", autoWidth: true },
                    { data: "firstName", name: "FirstName", autoWidth: true },
                    { data: "lastName", name: "LastName", autoWidth: true },
                    { data: "email", name: "Email", autoWidth: true },
                    { data: "phone", name: "Phone", autoWidth: true, className: "col-1", },
                    { data: "address", name: "Address", autoWidth: true },
                    { data: "cityStateZip", name: "CityStateZip", autoWidth: true },
                    { data: "kitName", name: "KitName", autoWidth: true },
                ],
                order: [[0, "DESC"]],
            });

    }

    this.Search = function () {
        CFP.Dcs.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Dcs/_Details/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-lg-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#dcsForm"));
                CFP.Common.InitMask();
                $("#common-lg-dialog").modal('show');
            }
        })
    }

    this.Save = function () {
        if ($("#dcsForm").valid()) {
            $(".preloader").show();
            var formdata = $("#dcsForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Dcs/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Dcs.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-lg-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }

    this.Delete = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to delete this order?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#f33c02',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-trash-can"></i> Delete',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Dcs/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Dcs.Option.Table.ajax.reload();
                            CFP.Common.ToastrSuccess(result.message);
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }
    this.Confirm = function (id = '') {
        Swal.fire({
            title: '<h4>Are you sure want to confirm the order?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#7460ee',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="ri-check-line"></i> Yes',
            cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Dcs/ConfirmOrder"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Dcs.Option.Table.ajax.reload();
                            CFP.Common.ToastrSuccess(result.message);
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }

    this.OnSelectRecord = function () {
        var totalRowLength = $(".deleteAll").length;
        var totalSelectedRowLength = $(".deleteAll:checked").length;

        if (parseInt(totalRowLength) == parseInt(totalSelectedRowLength)) {
            $(".selectAll").prop("checked", true);
        }
        else {
            $(".selectAll").prop("checked", false);
        }
        if (totalSelectedRowLength > 0) {
            $("#btnBulkConfirmOrder").removeClass("hide")
        }
        else {
            $("#btnBulkConfirmOrder").addClass("hide")
        }
    }

    $('.selectAll').change(function () {
        var ischecked = $('.selectAll').is(':checked');
        if (ischecked) {
            $('.deleteAll').prop('checked', true);
        }
        if (!ischecked) {
            $('.deleteAll').prop('checked', false);
        }
        var totalSelectedRowLength = $(".deleteAll:checked").length;
        if (totalSelectedRowLength > 0) {
            $("#btnBulkConfirmOrder").removeClass("hide")
        }
        else {
            $("#btnBulkConfirmOrder").addClass("hide")
        }
    });
    this.BulkConfirmOrder = function () {
        SelectedRecordArray = [];
        $('.deleteAll:checked').each(function () {
            SelectedRecordArray.push($(this).attr('value'));
        });
        var count = SelectedRecordArray.length;
        if (count > 0) {
            Swal.fire({
                title: '<h4><b>Are you sure want to confirm ' + count + ' order(s)? <b></h4>',
                html: '',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#7460ee',
                cancelButtonColor: '#a1aab2',
                confirmButtonText: '<i class="ri-check-line"></i> Yes',
                cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
            }).then((result) => {
                if (result.value) {
                    $('.preloader').show();
                    $.ajax({
                        type: "POST",
                        url: UrlContent("Dcs/BulkConfirmOrder"),
                        data: {
                            ids: SelectedRecordArray,
                        },
                        success: function (result) {
                            $('.preloader').hide();
                            if (result.isSuccess) {
                                $('.selectAll').prop('checked', false);
                                CFP.Dcs.Option.Table.ajax.reload();
                                SelectedRecordArray = [];
                                $('#btnBulkConfirmOrder').addClass("hide");
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Success',
                                    html: result.message,
                                })
                            }
                            else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error',
                                    html: result.message,
                                })
                            }
                        }
                    })
                }
            });

        }
    }
}