CFP.Location = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.Location.Option.Table = $("#locationTableId").DataTable(
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
                    url: UrlContent("Location/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        dtParms.Status= $("#ddStatus").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "locationName", name: "LocationName", autoWidth: true },
                    { data: "addresssLine1", name: "AddresssLine1", autoWidth: true },
                    { data: "addresssLine2", name: "AddresssLine2", autoWidth: true },
                    { data: "city", name: "City", autoWidth: true },
                    { data: "stateName", name: "StateName", autoWidth: true, orderable:false, },
                    { data: "zipcode", name: "Zipcode", autoWidth: true },
                    {
                        data: "isActive", name: "IsActive", className: "col-1  text-center",
                        render: function (data, type, row) {
                            if (data) {
                                return '<span class="badge bg-success  font-14">Active<span>';
                            } else {
                                return '<span class="badge bg-danger  font-14">In-Active<span>';
                            }
                        }
                    },
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnEdit = ``;
                            let btnDelete = ``;
                            let btnReActive = ``;
                            if (row.isActive) {
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.Location.Delete('${data}')" title="De Activate Location"><i class="ri-delete-bin-line text-white" ></i></button>`;
                                btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Location.Add('${data}')"><i class="ri-pencil-line text-white" ></i></button>`;
                            }
                            else {
                                btnReActive = `<button class="btn btn-primary btn-sm mr-1 ml-1" type="button" onclick="CFP.Location.ReActivate('${data}')" title="Re Activate Location"><i class="ri-check-line text-white" ></i></button>`;
                            }
                            return btnEdit + btnDelete + btnReActive;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Location.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Location/_Details/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data); 
                $.validator.unobtrusive.parse($("#LocationForm"));
                CFP.Common.InitMask();
                $("#common-md-dialog").modal('show');
            }
        })
    }

    this.Save = function () {
        if ($("#LocationForm").valid()) {
            $(".preloader").show();
            var formdata = $("#LocationForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Location/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Location.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to delete this Location?</h4>',
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
                    url: UrlContent("Location/ChangeStatus"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Location.Option.Table.ajax.reload();
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

    this.ReActivate = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to Re Activate this Location?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#7460ee',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-check"></i> Activate',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Location/ChangeStatus"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Location.Option.Table.ajax.reload();
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


}