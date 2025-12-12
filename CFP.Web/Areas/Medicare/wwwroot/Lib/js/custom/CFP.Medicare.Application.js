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
                        data: "encJobApplicationId", orderable: false, className: "text-center col-1",
                        render: function (data, type, row) {

                            let btnView = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="View" type="button" onclick="CFP.Medicare.Application.ApplicationSummary('${data}')">
                            <i class="ri-eye-line text-white"></i>
                        </button>`;

                          
                            return btnView;
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
            data: {id:id},
            success: function (data) {
                $("#common-xl-dialogContent").html(data);
               
                $("#common-xl-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

}