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
                            let btnDelete = ``;
                            let btnEdit = ``;
                            let btnView = `<button class="btn btn-info btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Deal.Add('${data}', true)">
                            <i class="ri-eye-line text-white"></i>
                        </button>`;
                            if (row.isShowEditBtn) {

                                btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.Deal.Add('${data}')">
                            <i class="ri-pencil-line text-white"></i>
                        </button>`;
                            }

                            if (row.isShowDelBtn) {
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.Deal.Delete('${data}')" title="De Activate User">

                            <i class="ri-delete-bin-line text-white"></i>
                        </button>`;
                            }
                            return btnEdit + btnDelete + btnView;
                        }
                    }

                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Deal.Option.Table.ajax.reload();
    }

    this.Add = function (id = '', isView = false) {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Deal/_Details/" + id + "?isView=" + isView),
            success: function (data) {
                $("#common-lg-dialogContent").html(data);
                //$(".select2").select2();
                $.validator.unobtrusive.parse($("#DealMasterForm"));
                //$('#multipleSelect').select2();
                $('#multipleSelect').select2({
                    dropdownParent: $('#common-lg-dialog')
                });
                //$('.datepicker').datepicker({
                //    autoclose: true,
                //    format: 'mm/dd/yyyy',
                //    todayHighlight: true,
                //});
                // flatpicker();
                CFP.Common.InitDatePicker();
                if (id != '') {
                    CFP.Deal.GetDealDocList();
                }
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
            title: '<h4>Are you sure want to delete this deal?</h4>',
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
                    url: UrlContent("Deal/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Common.ToastrSuccess(result.message);
                            CFP.Deal.Search();
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }

    this.SaveDocument = function () {
        $(".preloader").show();
        var index = 0;
        var formdata = new FormData();
        var fileInput = $('#PictureofProblemId')[0]; // Get the file input element

        if (fileInput != null) {
            for (var i = 0; i < fileInput.files.length; i++) {
                formdata.append('PictureofProblemList', fileInput.files[i]);
                index++;
            }
        }
        $(".form-control").each(function (x, y) {
            formdata.append($(y).attr("name"), $(y).val());
        });
        if (index > 0) {
            $.ajax({
                type: "Post",
                url: UrlContent("Deal/SaveDoc/"),
                data: formdata,
                contentType: false,
                processData: false,
                success: function (data) {
                    $(".preloader").hide();
                    if (data.isSuccess) {
                        $('#PictureofProblemId').val(null);
                        CFP.Deal.GetDealDocList();

                    } else {
                        CFP.Common.ToastrError(data.message);
                    }
                },
            });

        }
        else {
            $(".preloader").hide();
            CFP.Common.ToastrError("Select a Document");
        }
    }

    this.GetDealDocList = function () {
        debugger;
        var isView = $("#isViewId").val() === "true";

        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Deal/_DealDocList/"),
            data: {
                id: $("#txtEncId").val(),
                isView: isView
            },
            success: function (data) {
                $("#PictureofProblemDivId").empty();
                $("#PictureofProblemDivId").html(data);
                $(".preloader").hide();
            }
        })
    }

    this.DeleteDocument = function (id) {

        let msg = '<h4>Are you sure you want to delete documents?</h4>';
        let title = 'Delete Document';
        let type = 'danger';
        Swal.fire({
            html: `
             <div class="mt-3">
                 <lord-icon
                     src="https://cdn.lordicon.com/gsqxdxog.json"
                     trigger="loop"
                     colors="primary:#f7b84b,secondary:#f06548"
                     style="width:100px;height:100px">
                 </lord-icon>
                 <div class="mt-4 pt-2 fs-15 mx-5">
                     <h4>Delete Document ?</h4>
                     <p class="text-muted mx-4 mb-0">Are you sure you want to delete documents?</p>
                 </div>
             </div>
             `,
            showCancelButton: true,
            confirmButtonText: '<i class="ri-delete-bin-6-line"></i> Yes, Delete It!',
            cancelButtonText: '<i class="ri-close-line"></i> Close',
            customClass: {
                confirmButton: 'btn btn-primary w-xs me-2 mb-1',
                cancelButton: 'btn btn-danger w-xs mb-1'
            },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                $(".preloader").show();
                $.ajax({
                    type: "GET",
                    url: UrlContent("Deal/DeleteDoc/"),
                    data: {
                        id: id,
                        EncId: $("#txtEncId").val(),
                    },
                    success: function (data) {
                        $(".preloader").hide();
                        if (data.isSuccess) {
                            CFP.Common.ToastrSuccess(data.message);
                            CFP.Deal.GetDealDocList();
                        } else {
                            CFP.Common.ToastrError(data.message);
                            CFP.Deal.GetDealDocList();
                        }


                    }
                })
            }
        });

    }

}