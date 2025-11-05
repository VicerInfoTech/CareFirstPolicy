
CFP.Common = new function () {

    this.ToastrSuccess = function (msg) {
        toastr.success(msg);
    }

    this.ToastrError = function (msg) {
        toastr.error(msg);
    }

    this.ToastrRemove = function () {
        toastr.remove();
    }

    this.InitMask = function () {
        $(".fax-inputmask").inputmask("999 999-9999");
        $(".phone-inputmask").inputmask("(999) 999-9999");
        $(".ssn-inputmask").inputmask("999-99-9999");
        $(".zipcode-inputmask").inputmask("99999-9999");
        $(".zipcode-inputmaskCostom").inputmask("99999");
        $(".otp-inputmask").inputmask("999999");
        $(".kitid-inputmask").inputmask({
            mask: "******-######-******-####", 
            definitions: {
                '*': {
                    validator: '[A-Za-z0-9]',
                    cardinality: 1,
                },
                '#': {
                    validator: '[0-9]',
                    cardinality: 1
                }
            },
            onBeforePaste: function (pastedValue, opts) {
                return pastedValue.replace("-", "");
            },
        });

        $(".email-inputmask").inputmask({
            mask: "*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[.*{2,6}][.*{1,2}]",
            greedy: false,
            onBeforePaste: function (pastedValue, opts) {
                return pastedValue.replace("mailto:", "");
            },
            definitions: {
                '*': {
                    validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~\-]",
                    cardinality: 1
                }
            }
        });
    }

    this.ChangePassword = function () {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Common/ChangePassword/"),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#ChangePwdForm"));
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


    this.SavePassword = function () {
        if ($("#ChangePwdForm").valid()) {
            $(".preloader").show();
            var formdata = $("#ChangePwdForm").serialize();
            $.ajax({
                type: "POST",
                url: UrlContent("Common/ChangePassword/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        window.location.href = UrlContent("Account/Logout");
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

    this.MenuLink = function (link) {
        var url = window.location.protocol + "//" + window.location.host + link;
        var path = url.replace(window.location.protocol + "//" + window.location.host + "/", "");
        var element = $('ul#sidebarnav a').filter(function () {
            return this.href === url || this.href === path;// || url.href.indexOf(this.href) === 0;
        });
        element.parentsUntil(".sidebar-nav").each(function (index) {
            if ($(this).is("li") && $(this).children("a").length !== 0) {
                $(this).children("a").addClass("active");
                $(this).parent("ul#sidebarnav").length === 0
                    ? $(this).addClass("active")
                    : $(this).addClass("selected");
            }
            else if (!$(this).is("ul") && $(this).children("a").length === 0) {
                $(this).addClass("selected");

            }
            else if ($(this).is("ul")) {
                $(this).addClass('in');
            }

        });

    }


    this.DownloadTestResult = function (fileName) {
        window.location = UrlContent("Common/DownloadTestResult?fileName=" + fileName);
    }

    this.UpdateTestDownloadStatus = function (id) {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Common/UpdateTestDownloadStatus/" + id),
            success: function (data) {
                $(".preloader").hide();
                if (data.isSuccess) {
                    CFP.Common.GetNotificationList();
                    setTimeout(function () {
                        window.location = UrlContent("Common/DownloadTestResult?fileName=" + data.result);
                    }, 100);
                } else {
                    CFP.Common.ToastrError(data.message);
                }
            }
        })
    }

    this.GetNotificationList = function () {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("PatientHome/_NotificationList/"),
            success: function (data) {
                $("#divNotiicationList").html(data);
                $(".preloader").hide();
            }
        })
        $.ajax({
            type: "GET",
            url: UrlContent("Common/GetNotificationCount/"),
            success: function (data) {
                if (parseInt(data) > 0) {
                    $("#lblNotificationCount").removeClass("hide");
                    $("#lblNotificationCount").text(data);
                } else {
                    $("#lblNotificationCount").addClass("hide");
                }
            }
        })
    }

    this.SetNotificationPreference = function () {
        Swal.fire({
            text: 'Do you want to receive updates on your registered mobile number?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Yes',
            denyButtonText: 'No',
            icon: "question",
        }).then((result) => {
            if (result.isConfirmed) {
                CFP.Common.UpdateNotificationPreference(true);
            } else if (result.isDenied) {
                CFP.Common.UpdateNotificationPreference(false);
            }
        })
    }

    this.UpdateNotificationPreference = function (status) {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Common/UpdateNotificationPreference/"),
            data: { preference: status },
            success: function (result) {
                $(".preloader").hide();
                if (result.isSuccess) {
                    CFP.Common.GetNotificationList();
                    CFP.Common.ToastrSuccess(result.message);
                }
                else {
                    CFP.Common.ToastrError(result.message);
                }
            }
        })
    }

    this.GetTestStatusHTML = function (data) {
        if (data == CFP.Enum.TestStatus.New) {
            return '<span class="badge bg-primary  font-14">New</span>';
        }
        else if (data == CFP.Enum.TestStatus.Order_Confirmed) {
            return '<span class="badge bg-primary  font-14">Order Confirmed</span>';
        }
        else if (data == CFP.Enum.TestStatus.Appointment_Booked) {
            return '<span class="badge bg-info text-black font-14">Appointment Booked</span>';
        }
        else if (data == CFP.Enum.TestStatus.Appointment_ReScheduled) {
            return '<span class="badge bg-info text-black font-14">Re-Scheduled</span>';
        }
        else if (data == CFP.Enum.TestStatus.CheckedIn) {
            return '<span class="badge bg-dark font-14">Checked-In</span>';
        }
        else if (data == CFP.Enum.TestStatus.Fulfillment_Complete) {
            return '<span class="badge bg-warning text-black font-14">Fulfillment Completed</span>';
        }
        else if (data == CFP.Enum.TestStatus.Sample_Shipped_To_Patient) {
            return '<span class="badge bg-danger font-14">Item Shipped To Patient</span>';
        }
        else if (data == CFP.Enum.TestStatus.Sample_Received_At_Patient) {
            return '<span class="badge bg-danger font-14">Item Delivered To Patient</span>';
        }
        else if (data == CFP.Enum.TestStatus.Kit_Registred) {
            return '<span class="badge bg-warning font-14">Kit Registred</span>';
        }
        else if (data == CFP.Enum.TestStatus.Sample_Collected) {
            return '<span class="badge bg-secondary font-14">Sample Collected</span>';
        }
        else if (data == CFP.Enum.TestStatus.Sample_Shipped_To_Lab) {
            return '<span class="badge bg-primary font-14">Sample Shipped To Lab</span>';
        }
        else if (data == CFP.Enum.TestStatus.Sample_Received_At_Lab) {
            return '<span class="badge bg-danger font-14">Sample Received At Lab</span>';
        }
        else if (data == CFP.Enum.TestStatus.Re_Processing) {
            return '<span class="badge bg-light text-black font-14">Re-Processing</span>';
        }
        else if (data == CFP.Enum.TestStatus.In_Process) {
            return '<span class="badge bg-secondary  font-14">In Lab Processing</span>';
        }
        else if (data == CFP.Enum.TestStatus.Complete) {
            return '<span class="badge bg-success  font-14">Completed</span>';
        }
        else {
            return '';
        }
    }

    this.GetAppointmentStatusHTML = function (data) {
        if (data == CFP.Enum.AppointmentStatus.Pending) {
            return `<span class="badge bg-secondary ">Pending</span>`;
        }
        else if (data == CFP.Enum.AppointmentStatus.Booked) {
            return `<span class="badge bg-primary">Booked</span>`;
        }
        else if (data == CFP.Enum.AppointmentStatus.ReSchedule) {
            return `<span class="badge bg-warning">Re-Scheduled</span>`;
        }
        else if (data == CFP.Enum.AppointmentStatus.Cancel) {
            return `<span class="badge bg-danger ">Cancel</span>`;
        }
        else if (data == CFP.Enum.AppointmentStatus.Completed) {
            return `<span class="badge bg-success">Completed</span>`;
        } else {
            '';
        }
    }

    this.GoToCurrentTable = function (orderType, testStatus, roleId) {
        var tablePath = "";
        if (orderType == CFP.Enum.TestType.InPerson || orderType == CFP.Enum.TestType.WalkIn) {
            if (testStatus == CFP.Enum.TestStatus.New) tablePath = "/Order/AppointmentBooking";
            else if (testStatus == CFP.Enum.TestStatus.Order_Confirmed) tablePath = "/Order/AppointmentBooking";
            else if (testStatus == CFP.Enum.TestStatus.Appointment_Booked) tablePath = "/Order/CheckIn";
            else if (testStatus == CFP.Enum.TestStatus.Appointment_ReScheduled) tablePath = "/Order/CheckIn";
            else if (testStatus == CFP.Enum.TestStatus.CheckedIn) tablePath = "/Order/SampleCollection";
            else if (testStatus == CFP.Enum.TestStatus.Fulfillment_Complete) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Shipped_To_Patient) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Received_At_Patient) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Kit_Registred) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Collected) tablePath = "/Order/LabProcessing";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Shipped_To_Lab) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Received_At_Lab) tablePath = "/Order/LabProcessing";
            else if (testStatus == CFP.Enum.TestStatus.Re_Processing) tablePath = "/Order/CheckIn";
            else if (testStatus == CFP.Enum.TestStatus.In_Process) tablePath = "/Order/LabProcessing";
            else if (roleId == 1 && testStatus == CFP.Enum.TestStatus.Complete) tablePath = "/Order/Completed";
            else tablePath = "/Order/Index";
        }
        else if (orderType == CFP.Enum.TestType.AtHome || orderType == CFP.Enum.TestType.DCS) {
            if (testStatus == CFP.Enum.TestStatus.New) tablePath = "/Order/Fulfillment";
            else if (testStatus == CFP.Enum.TestStatus.Order_Confirmed) tablePath = "/Order/Fulfillment";
            else if (testStatus == CFP.Enum.TestStatus.Appointment_Booked) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Appointment_ReScheduled) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.CheckedIn) tablePath = "/Order/Index";
            else if (testStatus == CFP.Enum.TestStatus.Fulfillment_Complete) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Shipped_To_Patient) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Received_At_Patient) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Kit_Registred) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Collected) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Shipped_To_Lab) tablePath = "/Order/Shipment";
            else if (testStatus == CFP.Enum.TestStatus.Sample_Received_At_Lab) tablePath = "/Order/LabProcessing";
            else if (testStatus == CFP.Enum.TestStatus.Re_Processing) tablePath = "/Order/Fulfillment";
            else if (testStatus == CFP.Enum.TestStatus.In_Process) tablePath = "/Order/LabProcessing";
            else if (roleId == 1 && testStatus == CFP.Enum.TestStatus.Complete) tablePath = "/Order/Completed";
            else tablePath = "/Order/Index";
        }
        else {
            tablePath = "/Order/Index";
        }
        window.location = window.location.protocol + "//" + window.location.host + tablePath;
    }

    this.SendScreeningQuestionMail = function (id, walkInOrderId) {
        Swal.fire({
            title: '<h4>Are you sure want to send screening question link?</h4>',
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
                    url: UrlContent("Common/SendScreeningQuestionMail"),
                    data: {
                        id: id,
                        walkInOrderId: walkInOrderId,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
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

    this.ScreeningQuestion = function (id = '',walkInOrderId='') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_ScreeningQuestion/"),
            data: {
                id: id,
                walkInId: walkInOrderId,
            },
            success: function (data) {
                $("#common-lg-dialogContent").html(data);
                $("#common-lg-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }
    this.SaveScreeningQuestions = function () {
        if ($("#screeningQuestionsForm").valid()) {
            $(".preloader").show();
            var formdata = $("#screeningQuestionsForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Order/SaveScreeningQuestion/"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        $("#common-lg-dialog").modal('hide');
                        /* CFP.Common.ToastrSuccess(response.message);*/
                        CFP.Order.Option.Table.ajax.reload();
                    } else {
                        CFP.Common.ToastrError(IsSuccess.message);
                    }
                }
            })
        }
    }
}