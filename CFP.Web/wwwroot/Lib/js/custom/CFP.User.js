CFP.User = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.User.Option.Table = $("#userTableId").DataTable(
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
                    url: UrlContent("Users/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        dtParms.Status = $("#ddStatus").val();
                        dtParms.RoleId = $("#ddRole").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "firstName", name: "FirstName", autoWidth: true },
                    { data: "lastName", name: "LastName", autoWidth: true },
                    { data: "username", name: "Username", autoWidth: true },
                    {
                        data: "roleName", name: "RoleName", className: "col-1 text-left",
                        render: function (data, type, row) {
                            if (data == CFP.Enum.Role.Administrator) {
                                return '<span class="badge bg-danger-subtle text-danger font-14">' + data + '<span>';
                            }
                            else if (data == CFP.Enum.Role.Sample_Collector_PSC) {
                                return '<span class="badge bg-warning-subtle text-black font-14">' + data + '<span>';
                            }
                            else if (data == CFP.Enum.Role.Lab_Assistant) {
                                return '<span class="badge bg-success-subtle text-success font-14">' + data + '<span>';
                            }
                            else if (data == CFP.Enum.Role.Sample_Collector_InHome) {
                                return '<span class="badge bg-info-subtle text-black font-14">' + data + '<span>';
                            }
                            else if (data == CFP.Enum.Role.Fulfillment_Manager) {
                                return '<span class="badge bg-primary-subtle text-primary font-14">' + data + '<span>';
                            } else {
                                return data;
                            }
                        }
                    },
                    { data: "lastLoginTimeString", name: "LastLoginTime", orderable: false },
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
                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.User.Add('${data}')"><i class="ri-pencil-line text-white" ></i></button>`;
                            let btnDelete = ``;
                            let btnReActive = ``;
                            let btnResetAndSendPassword = '';
                            if (row.isActive) {
                            btnResetAndSendPassword = `<button class="btn btn-info btn-sm mr-1 ml-1" type="button" onclick="CFP.User.ResetAndSendPassword('${data}')" title="Send reset password link to user"><i class="ri-key-line text-white" ></i></button>`;
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.User.Delete('${data}')" title="De Activate User's Account"><i class="ri-delete-bin-line text-white" ></i></button>`;
                            }
                            else
                                btnReActive = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" onclick="CFP.User.ReActivate('${data}')" title="Re Activate User's Account"><i class="ri-check-line text-white" ></i></button>`;

                            return btnEdit + btnDelete + btnReActive + btnResetAndSendPassword;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.User.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Users/_Details/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#userForm"));
                $("#common-md-dialog").modal('show');

                $(".password").click(function () {
                    if ($(this).children().hasClass("ri-eye-line")) {
                        $(this).children().removeClass().addClass("ri-eye-off-line");
                        $(this).parent().next().attr("type", "text");
                    }
                    else {
                        $(this).children().removeClass().addClass("ri-eye-line");
                        $(this).parent().next().attr("type", "password");
                    }
                });


                $(".preloader").hide();
            }
        })
    }

    this.Save = function () {
        if ($("#userForm").valid()) {
            $(".preloader").show();
            var formdata = $("#userForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Users/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.User.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to De-Activate this User?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#f33c02',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-trash-can"></i> De-Activate',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Users/DeActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.User.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to Re Activate this User?</h4>',
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
                    url: UrlContent("Users/ReActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.User.Option.Table.ajax.reload();
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

    this.ResetAndSendPassword = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to reset password of this user and sent it to them?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#7460ee',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-check"></i> Yes',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Users/ResetAndSendPassword"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.User.Option.Table.ajax.reload();
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