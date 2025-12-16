CFP.Medicare.Application = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function (options) {
        CFP.Medicare.Application.Option.Table = $("#jobApplicationTableId").DataTable(
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
                    url: UrlContent("GetList", "Application", "Medicare"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "firstName", name: "FirstName", autoWidth: true },
                    { data: "lastName", name: "LastName", autoWidth: true },
                    { data: "email", name: "Email", autoWidth: true },
                    { data: "phoneNo", name: "PhoneNo", autoWidth: true },
                    { data: "dobString", name: "DobString", autoWidth: true },
                    { data: "stateLicence", name: "StateLicence", autoWidth: true },
                    { data: "createdOnString", name: "CreatedOnString", autoWidth: true },
                    {
                        data: "status", name: "Status", className: "col-1  text-center",
                        render: function (data, type, row) {
                            if (data == 1) {
                                return '<span class="badge bg-warning  font-14">Pending<span>';
                            } else if (data == 2) {
                                return '<span class="badge bg-success  font-14">Approved<span>';
                            }
                            else {
                                return '<span class="badge bg-danger  font-14">Rejected<span>';
                            }
                        }
                    },
                    {
                        data: "encJobApplicationId", orderable: false, className: "text-center col-1",
                        render: function (data, type, row) {
                            let btnAccept = "";
                            let btnReject = "";
                            let btnView = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="View" type="button" onclick="CFP.Medicare.Application.ApplicationSummary('${data}')">
                            <i class="ri-eye-line text-white"></i>
                        </button>`;

                            if (row.status == 1) {

                                btnAccept = `
        <button class="btn btn-success btn-sm mr-1 ml-1"
                title="Approved"
                type="button"
                onclick="CFP.Medicare.Application.UpdateStatus('${row.encJobApplicationId}', 2)">
            <i class="ri-check-line text-white"></i>
        </button>`;

                                btnReject = `
        <button class="btn btn-danger btn-sm mr-1 ml-1"
                title="Reject"
                type="button"
                onclick="CFP.Medicare.Application.UpdateStatus('${row.encJobApplicationId}', 3)">
            <i class="ri-close-line text-white"></i>
        </button>`;
                            }



                            return btnView + btnAccept + btnReject;
                        }
                    }
                ],
                order: [[0, "ASC"]],
            });
    }

    this.Search = function () {
        CFP.Medicare.Application.Option.Table.ajax.reload();
    }
    this.ApplicationSummary = function (id = '') {
        debugger;
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("_ApplicationSummary", "Application", "Medicare"),
            data: { id: id },
            success: function (data) {
                $("#common-xl-dialogContent").html(data);

                $("#common-xl-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }
    this.UpdateStatus = function (id, status) {
        debugger;
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("_UpdateStatus", "Application", "Medicare"),
            data: {
                id: id,
                status: status
            },
            success: function (data) {
                $("#common-md-dialogContent").html(data);

                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.SaveApplicationStatus = function () {
        var comment = $("#statusComment").val();
        if (comment == null || comment == '') {
            CFP.Medicare.Common.ToastrError("Please enter the comment");
            return;
        }
        $(".preloader").show();
        var formdata = $("#updateStatusForm").serialize();
        $.ajax({
            type: "Post",
            url: UrlContent("SaveStatus", "Application", "Medicare"),
            data: formdata,
            success: function (result) {
                $(".preloader").hide();
                if (result.isSuccess) {
                    CFP.Medicare.Application.Option.Table.ajax.reload();
                    CFP.Medicare.Common.ToastrSuccess(result.message);
                    $("#common-md-dialog").modal('hide');
                } else {
                    CFP.Medicare.Common.ToastrError(result.message);
                }
            },
        })

    }
}