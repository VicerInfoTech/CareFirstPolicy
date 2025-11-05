CFP.Patient = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function () {
        CFP.Patient.Option.Table = $("#patientTableId").DataTable(
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
                    url: UrlContent("Patient/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        dtParms.Status = $("#ddStatus").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "firstName", name: "FirstName", },
                    { data: "lastName", name: "LastName", },
                    { data: "email", name: "Email", orderable: false },
                    { data: "contactNumber", name: "ContactNumber", className: "col-1 text-center", orderable: false },
                    //{
                    //    data: "numberOfKit", name: "NumberOfKit", className: "col-1 text-center", orderable: false, render: function (data, type, row) {
                    //        return `<span class="text-info clickable" onclick="CFP.Patient.GoToKitRegistrations('${row.encId}')" ><b>${data}</b><span>`;
                    //    }
                    //},
                    { data: "createdOnString", name: "CreatedOn", className: "col-2" },
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
                            let btnDelete = '';
                            let btnReActive = '';
                            let btnResetAndSendPassword = '';
                            if (row.isActive) {

                                btnResetAndSendPassword = `<button class="btn btn-info btn-sm mr-1 ml-1" type="button" onclick="CFP.Patient.ResetAndSendPassword('${data}')" title="Reset password & sent it to user"><i class="ri-key-line text-white" ></i></button>`;
                                btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" onclick="CFP.Patient.Delete('${data}')" title="De Activate User's Account"><i class="mdi mdi-trash-can text-white" ></i></button>`;
                            }
                            else
                                btnReActive = `<button class="btn btn-primary btn-sm mr-1 ml-1" type="button" onclick="CFP.Patient.ReActivate('${data}')" title="Re Activate User's Account"><i class="mdi mdi-check text-white" ></i></button>`;

                            return btnDelete + btnReActive + btnResetAndSendPassword
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Patient.Option.Table.ajax.reload();
    }

    this.Delete = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to De Activate this Patient?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#f33c02',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-trash-can"></i> De Activate',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Patient/DeActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Patient.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to Re Activate this Patient?</h4>',
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
                    url: UrlContent("Patient/ReActivate"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Patient.Option.Table.ajax.reload();
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

    this.GoToKitRegistrations = function (UserId) {
        $.ajax({
            type: "Post",
            url: UrlContent("Dashboard/SaveTempFilter"),
            data: {
                UserId: UserId,
            },
            success: function (result) {
                window.location.href = UrlContent("Order/Index");
            }
        })
    }


    this.ResetAndSendPassword = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to reset password of this patient and sent it to them?</h4>',
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
                    url: UrlContent("Users/ResetAndSendPasswordForPatient"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Patient.Option.Table.ajax.reload();
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