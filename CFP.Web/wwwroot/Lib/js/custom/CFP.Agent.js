CFP.Agent = new function () {
    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.Agent.Option.Table = $("#userTableId").DataTable(
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
                    url: UrlContent("Agent/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "firstName", name: "FirstName", autoWidth: true },
                    { data: "lastName", name: "LastName", autoWidth: true },
                    { data: "email", name: "Email", autoWidth: true },
                    { data: "roleName", name: "RoleName", autoWidth: true },

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
                        data: "encId", orderable: false, className: "text-center col-1",
                        render: function (data, type, row) {

                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Agent.Add('${data}')">
                            <i class="ri-pencil-line text-white"></i>
                        </button>`;

                            let btnChangePassword = `<button class="btn btn-warning btn-sm mr-1 ml-1" title="Change Password" type="button" onclick="CFP.Agent.Reset('${row.userMasterId}')">
                                    <i class="ri-key-line text-white"></i>
                                </button>`;

                            let btnDelete = ``;
                            let btnReActive = ``;

                            if (row.isActive) {
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.Agent.Delete('${data}')" title="De Activate User">
                            <i class="ri-delete-bin-line text-white"></i>
                        </button>`;
                            }
                            else {
                                btnReActive = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" onclick="CFP.Agent.ReActivate('${data}')" title="Re Activate User">
                                <i class="ri-check-line text-white"></i>
                           </button>`;
                            }

                            return btnEdit + btnChangePassword + btnDelete + btnReActive;
                        }
                    }

                ],
                order: [[0, "ASC"]],
            });
    }

    this.Search = function () {
        CFP.Agent.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Agent/_Details/" + id),
            success: function (data) {
                $("#common-lg-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#AgentMasterForm"));
                $("#common-lg-dialog").modal('show');
                CFP.Common.InitDatePicker();
                $(".preloader").hide();
            }
        })
    }

    this.Save = function () {
        if ($("#AgentMasterForm").valid()) {
            $(".preloader").show();
            var formdata = $("#AgentMasterForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Agent/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Agent.Option.Table.ajax.reload();
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
                    url: UrlContent("Agent/DeActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Agent.Option.Table.ajax.reload();
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
                    url: UrlContent("Agent/ReActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Agent.Option.Table.ajax.reload();
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

    this.SavePassword = function () {
        if ($("#resetPwdForm").valid()) {
            $(".preloader").show();
            var formdata = $("#resetPwdForm").serialize();
            $.ajax({
                type: "POST",
                url: UrlContent("Agent/ResetPassword/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal("hide");
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
                error: function (textStatus, errorThrown) {
                }
            });
        }
    }

    this.Reset = function (id) {
        $.ajax({
            type: "GET",
            url: UrlContent("Agent/_Reset/" + id),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#resetPwdForm"));
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
            }
        })
    }
}