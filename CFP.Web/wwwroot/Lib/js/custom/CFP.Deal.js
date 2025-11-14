CFP.Deal = new function () {
    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.Deal.Option.Table = $("#userTableId").DataTable(
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
                    url: UrlContent("Deal/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "dealIdString", name: "DealIdString", autoWidth: true },
                    { data: "fullName", name: "FullName", autoWidth: true },
                    { data: "careerName", name: "CareerName", autoWidth: true },
                    { data: "closeDateString", name: "CloaseDateString", autoWidth: true },
                    { data: "agentName", name: "Username", autoWidth: true },
                    {
                        data: null,
                        name: "CreatedInfo",
                        render: function (data, type, row) {
                            return `
            <div>
                <div><strong>${row.createdByString}</strong></div>
                <div><small style="font-size: 0.75em;">${row.createdOnString}</small></div>
            </div>
        `;
                        },
                        autoWidth: true
                    },

                    //{
                    //    data: "isActive", name: "IsActive", className: "col-1  text-center",
                    //    render: function (data, type, row) {
                    //        if (data) {
                    //            return '<span class="badge bg-success  font-14">Active<span>';
                    //        } else {
                    //            return '<span class="badge bg-danger  font-14">In-Active<span>';
                    //        }
                    //    }
                    //},
                    {
                        data: "encId", orderable: false, className: "text-center col-1",
                        render: function (data, type, row) {

                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Deal.Add('${data}')">
                            <i class="ri-pencil-line text-white"></i>
                        </button>`;
                            let btnDelete = ``;
                            let btnReActive = ``;

                            if (row.isActive) {
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.Deal.Delete('${data}')" title="De Activate User">
                            <i class="ri-delete-bin-line text-white"></i>
                        </button>`;
                            }
                            else {
                                btnReActive = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" onclick="CFP.Deal.ReActivate('${data}')" title="Re Activate User">
                                <i class="ri-check-line text-white"></i>
                           </button>`;
                            }

                            return btnEdit + btnDelete + btnReActive;
                        }
                    }

                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Deal.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Deal/_Details/" + id),
            success: function (data) {
                $("#common-lg-dialogContent").html(data);
                //$(".select2").select2();
                $.validator.unobtrusive.parse($("#DealMasterForm"));
                $('#multipleSelect').select2();
                //$('.datepicker').datepicker({
                //    autoclose: true,
                //    format: 'mm/dd/yyyy',
                //    todayHighlight: true,
                //});
                // flatpicker();
                CFP.Common.InitDatePicker();
                $("#common-lg-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.Save = function () {
        if ($("#DealMasterForm").valid()) {
            $(".preloader").show();
            var formdata = $("#DealMasterForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Deal/Save/"),
                data: formdata,
                success: function (result) {
                    debugger;
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Deal.Option.Table.ajax.reload();
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
                    url: UrlContent("Deal/DeActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Deal.Option.Table.ajax.reload();
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