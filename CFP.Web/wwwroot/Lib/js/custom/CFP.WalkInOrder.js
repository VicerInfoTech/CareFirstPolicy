CFP.WalkInOrder = new function () {
    this.Option = {
        Table: null,
    }

    this.Init = function () {
        CFP.WalkInOrder.Option.Table = $("#walkInOrdertableId").DataTable(
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
                    url: UrlContent("WalkInOrder/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "referenceId", name: "ReferenceId", autoWidth: true },
                    { data: "firstName", name: "FirstName", autoWidth: true },
                    { data: "lastName", name: "LastName", autoWidth: true },
                    { data: "email", name: "Email", autoWidth: true },
                    { data: "phoneNo", name: "PhoneNo", autoWidth: true, className: "col-1", },
                    { data: "address", name: "Address", autoWidth: true },
                    { data: "cityStateZip", name: "CityStateZip", autoWidth: true },
                    { data: "kitName", name: "KitName", autoWidth: true },
                    {
                        data: "encId", orderable: false, className: "text-center col-2", orderable: false,
                        render: function (data, type, row) {
                            let ScreeningQuestion = "", btnsend = "";
                            let btnConfirm = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Confirm" type="button" onclick="CFP.WalkInOrder.Confirm('${data}')"><i class="ri-check-line text-white" ></i></button>`;
                            let btnEdit = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Edit" type="button" onclick="CFP.WalkInOrder.Add('${data}')"><i class="ri-pencil-line text-white" ></i></button>`;
                            let btnDelete = `<button class="btn btn-danger btn-sm mr-1 ml-1"title="Delete" type="button" onclick="CFP.WalkInOrder.Delete('${data}')"><i class="ri-delete-bin-line text-white" ></i></button>`;
                            if (row.isScreeningQuestion) {
                                btnsend = `<button class="btn btn-info btn-sm mr-1 ml-1"title="Send Screening Question" type="button" onclick="CFP.Common.SendScreeningQuestionMail('','${data}')"><i class="ri-mail-send-line text-white" ></i></button>`;
                                ScreeningQuestion = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Screening Question" type="button" onclick="CFP.Common.ScreeningQuestion('','${data}')"><i class="ri-question-mark" ></i></button>`;;
                            } return btnConfirm + btnEdit + btnDelete + btnsend + ScreeningQuestion;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });

    }

    this.Search = function () {
        CFP.WalkInOrder.Option.Table.ajax.reload();
    }

    this.Add = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("WalkInOrder/_Details/" + id),
            success: function (data) {
                $("#common-lg-dialogContent").html(data);
                CFP.Common.InitMask();
                CFP.WalkInOrder.OnPaymentTypeChanges();
                flatpicker();
                $.validator.unobtrusive.parse($("#walkInOrderForm"));
                $("#common-lg-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }
    this.Save = function () {
        if ($("#walkInOrderForm").valid()) {
            $(".preloader").show();
            var formdata = $("#walkInOrderForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("WalkInOrder/Save/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.WalkInOrder.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to delete this wealk in order?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#f33c02',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="ri-delete-bin-line"></i> Delete',
            cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("WalkInOrder/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.WalkInOrder.Option.Table.ajax.reload();
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
            title: '<h4>Are you sure want to confirm this order? <br> If "Yes", Patient will receive OTP in phone & email.</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#11D1B7',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="ri-check-line"></i> Yes',
            cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $(".preloader").show();
                $.ajax({
                    type: "GET",
                    url: UrlContent("WalkInOrder/_Confirm/" + id),
                    success: function (data) {
                        $("#common-md-dialogContent").html(data);
                        CFP.Common.InitMask();
                        $.validator.unobtrusive.parse($("#walkInOTPForm"));
                        $("#common-md-dialog").modal('show');
                        $(".preloader").hide();
                    }
                })
            }
        });
    }
    this.SendWalkInOTP = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("WalkInOrder/SendWalkInOTP/" + id),
            success: function (result) {
                $(".preloader").hide();
                if (result.isSuccess) {
                    CFP.Common.ToastrSuccess(result.message);
                } else {
                    CFP.Common.ToastrError(result.message);
                }
            }
        })
    }
    this.ConfirmOrder = function () {
        if ($("#walkInOTPForm").valid()) {
            $(".preloader").show();
            var formdata = $("#walkInOTPForm").serialize();
            $.ajax({
                type: "POST",
                url: UrlContent("WalkInOrder/ConfirmOrder/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.WalkInOrder.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }
    this.OnPaymentTypeChanges = function () {
        var id = $("#paymentTypeId").val()
        if (id == 2) {
            $("#insuredPaymentTypeDivId").removeClass("hide")
        } else {
            $("#insuredPaymentTypeDivId").addClass("hide")
        }
    }

}