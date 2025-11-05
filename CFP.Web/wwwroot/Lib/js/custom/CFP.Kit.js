CFP.Kit = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.Kit.Option.Table = $("#kitTableId").DataTable(
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
                    url: UrlContent("Kit/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    {
                        data: "kitName", name: "KitName", autoWidth: true,
                        render: function (data, type, row) {
                            if (row.isAllowUniqueId) {
                                return `<a style="text-decoration:underline;" href="/UniqueKey/UniqueId?id=${row.encId}">${data}</a>`;
                            } else {
                                return data;
                            }
                        }
                    },
                    { data: "sku", name: "Sku", autoWidth: true },

                    {
                        data: "testTimeFrame", name: "TestTimeFrame", className: "col-1 text-center", render: function (data, type, row) {
                            return data > 0 ? data + " Hours" : " - ";
                        }
                    },
                    {
                        data: "isNoReturnProduct", name: "IsNoReturnProduct", className: "col-1 text-center", render: function (data, type, row) {
                            if (data) {
                                return '<i class="ri-checkbox-circle-line text-danger " style="font-size:22px;"></i>';
                            } else {
                                return '';
                            }
                        }
                    },
                    {
                        data: "isAllowUniqueId", name: "IsAllowUniqueId", autoWidth: true, className: "text-center col-1", render: function (data, type, row) {
                            if (data) {
                                return '<i class="ri-checkbox-circle-fill text-success " style="font-size:22px;"></i>';
                            } else {
                                return '';
                            }
                        }
                    },
                    { data: "createdOnString", name: "CreatedOn", className: "col-2" },
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnAddNewSerial = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Generate New Unique Id" type="button" onclick="CFP.Kit.GoToOrder('${data}',true)"><i class="mdi mdi-plus text-white" ></i></button>`;
                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Kit.Add('${data}')"><i class="ri-pencil-line text-white" ></i></button>`;
                            let btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1"title="Delete" type="button" onclick="CFP.Kit.Delete('${data}')"><i class="ri-delete-bin-line text-white" ></i></button>`;

                            return btnEdit + btnDelete;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Kit.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Kit/_Details/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#KitForm"));
                $("#common-md-dialog").modal('show');
            }
        })
    }

    this.Save = function () {
        if ($("#KitForm").valid()) {
            $(".preloader").show();
            var formdata = $("#KitForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Kit/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Kit.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }

    this.Delete = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to delete this Kit?</h4>',
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
                    url: UrlContent("Kit/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Kit.Option.Table.ajax.reload();
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


    this.GoToOrder = function (KitId, IsAdd = false) {
        $.ajax({
            type: "Post",
            url: UrlContent("Dashboard/SaveTempFilter"),
            data: {
                KitId: KitId,
            },
            success: function (result) {
                window.location.href = UrlContent("Order/Index");
            }
        })
    }

}