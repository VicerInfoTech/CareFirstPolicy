CFP.Order = new function () {

    this.Option = {
        Table: null,
        CompleteTable: null,
    }

    this.Init = function (OrderListType, RoleId) {
        CFP.Order.Option.Table = $("#OrderTableId").DataTable(
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
                    url: UrlContent("Order/GetList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        dtParms.KitId = $("#ddKitList").val();
                        dtParms.Status = $("#ddTestStatus").val();
                        dtParms.TestType = $("#ddTestType").val();
                        dtParms.OrderListType = OrderListType;
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "orderMasterId", name: "OrderMasterId", autoWidth: true, visible: false },
                    { data: "orderNumber", name: "OrderNumber", autoWidth: true, className: "text-center" },
                    { data: "kitName", name: "KitName", autoWidth: true },
                    {
                        data: "orderType", name: "OrderType", autoWidth: true, className: "text-center col-1", render: function (data, type, row) {
                            if (data == CFP.Enum.TestType.AtHome) {
                                return '<span class="badge bg-success font-14">At Home</span>';
                            }
                            else if (data == CFP.Enum.TestType.InPerson) {
                                return '<span class="badge bg-primary font-14">In Person</span>';
                            }
                            else if (data == CFP.Enum.TestType.WalkIn) {
                                return '<span class="badge bg-warning font-14">Walk-In</span>';
                            }
                            else if (data == CFP.Enum.TestType.DCS) {
                                return '<span class="badge bg-secondary font-14">DCS</span>';
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    { data: "kitUniqueId", name: "KitUniqueId", autoWidth: true },
                    { data: "patientName", name: "PatientName", autoWidth: true },
                    { data: "emailAddress", name: "EmailAddress", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.All || CFP.Enum.OrderListType.AppointmentBooking || CFP.Enum.OrderListType.CheckIn },
                    { data: "phoneNo", name: "PhoneNo", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.CheckIn || OrderListType == CFP.Enum.OrderListType.Fulfillment || CFP.Enum.OrderListType.AppointmentBooking || CFP.Enum.OrderListType.CheckIn },
                    { data: "address", name: "Address", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.Fulfillment || CFP.Enum.OrderListType.AppointmentBooking || CFP.Enum.OrderListType.CheckIn },
                    { data: "cityStateZip", name: "CityStateZip", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.Fulfillment || CFP.Enum.OrderListType.AppointmentBooking || CFP.Enum.OrderListType.CheckIn },
                    {
                        data: "testStatus", name: "TestStatus", className: "col-1  text-center",
                        render: function (data, type, row) {
                            return CFP.Common.GetTestStatusHTML(data);
                        }
                    },
                    { data: "appointmentTime", name: "AppointmentDate", visible: OrderListType == CFP.Enum.OrderListType.CheckIn || OrderListType == CFP.Enum.OrderListType.SampleCollection },
                    {
                        data: "locationName", name: "LocationName", className: "text-left", orderable: false, visible: OrderListType == CFP.Enum.OrderListType.CheckIn,
                        render: function (data, type, row) {
                            if (data != null && data != "" && typeof data != "undefined") {
                                return `<i class="ri-map-pin-line ml-1" title="${row.locationAddress}"></i> <span>${data}</span>`;
                            } else {
                                return '';
                            }
                        }
                    },
                    //{
                    //    data: "appointmentStatus", orderable: false, className: "text-center col-1", orderable: false, visible: OrderListType == CFP.Enum.OrderListType.AppointmentBooking ,
                    //    render: function (data, type, row) {
                    //        return CFP.Common.GetAppointmentStatusHTML(data);
                    //    }
                    //},
                    { data: "createdOnString", name: "CreatedOn", autoWidth: true },
                    { data: "sampleCollectionDateString", name: "SampleCollectionDate", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.LabProcessing || OrderListType == CFP.Enum.OrderListType.Completed || OrderListType == CFP.Enum.OrderListType.Shipment },
                    { data: "sampleReceivedDateString", name: "SampleReceivedDate", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.LabProcessing || OrderListType == CFP.Enum.OrderListType.Completed },
                    { data: "resultUpdatedDateString", name: "ResultUpdatedDate", autoWidth: true, visible: OrderListType == CFP.Enum.OrderListType.Completed },

                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnScheduleApp = '', btnOrderHistory = '', ScreeningQuestion = '', btnsend = '', btnReScheduleApp = '', btnUpdateTest = '', btnUpdateTrackingNumber = ``, checkShipmentStatus = '', btnPrint = ``;
                            let btnView = ``, btnMarkCheckedIn = '', btnFulfillment = '', btnCollectSample = '', btnReceiveSample = '', btnVerifySample = '', btnDownloadResult = '', btnGoto = '';
                            if (OrderListType == CFP.Enum.OrderListType.All) {
                                btnGoto = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" onclick="CFP.Common.GoToCurrentTable(${row.orderType},${row.testStatus},${RoleId})" title="Go to Current Table"><i class="ri-arrow-right-fill text-white" ></i></button>`;

                                //btnPrint = `<button class="btn btn-dark btn-sm mr-1 ml-1" type="button" onclick="CFP.Order.Print('${data}')" title="Print Unique Id Label"><i class="ri-printer-line text-white" ></i></button>`;
                                btnOrderHistory = `<button class="btn btn-warning btn-sm mr-1 ml-1" type="button" onclick="CFP.Order.OrderHistory('${data}')" title="OrderHistory"><i class="ri-history-line text-white" ></i></button>`;


                                if (row.orderType == CFP.Enum.TestType.AtHome || row.orderType == CFP.Enum.TestType.DCS) {
                                    btnView = `<button class="btn btn-secondary btn-sm mr-1 ml-1" type="button" title="View Kit Registration Details" onclick="CFP.Order.ViewQuestions('${data}')"><i class="ri-eye-line text-white" ></i></button>`;
                                }
                                return btnOrderHistory + btnView + btnPrint + btnGoto;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.AppointmentBooking) {

                                if (row.appointmentStatus == CFP.Enum.AppointmentStatus.Pending) {
                                    btnScheduleApp = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Schedule Appointment" type="button" onclick="CFP.Appointment.Schedule('${data}')"><i class="ri-calendar-check-line text-white" ></i></button>`;
                                }
                                if (row.isShowReSchedule) {
                                    btnReScheduleApp = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Re-Schedule Appointment" type="button" onclick="CFP.Appointment.ReSchedule('${data}')"><i class="ri-refresh-line text-white" ></i></button>`;
                                }

                                return btnScheduleApp;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.CheckIn) {
                                let btnSendUniqueId = `<button class="btn btn-warning btn-sm mr-1 ml-1" title="Send Unique Kit Id" type="button" onclick="CFP.Appointment.SendUniqueKitId('${data}')"><i class="ri-message-3-line text-white" ></i></button>`;
                                btnMarkCheckedIn = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Mark Checked In" type="button" onclick="CFP.Appointment.MarkCheckedInModal('${data}')"><i class="ri-map-pin-time-line text-white" ></i></button>`;
                                let btnDownloadDocument = `<button class="btn btn-info btn-sm mr-1 ml-1" title="Download requisition form" type="button" onclick="CFP.Order.DownloadDocument('${data}')"><i class="ri-arrow-down-line text-white" ></i></button>`;
                                if (row.isShowReSchedule) {
                                    btnReScheduleApp = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Re-Schedule Appointment" type="button" onclick="CFP.Appointment.ReSchedule('${data}')"><i class="ri-refresh-line text-white" ></i></button>`;
                                } if (row.isScreeningQuestion) {
                                    btnsend = `<button class="btn btn-info btn-sm mr-1 ml-1"title="Send Screening Question" type="button" onclick="CFP.Common.SendScreeningQuestionMail('${data}')"><i class="ri-mail-send-line text-white" ></i></button>`;
                                    ScreeningQuestion = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Screening Question" type="button" onclick="CFP.Common.ScreeningQuestion('${data}')"><i class="ri-question-mark" ></i></button>`;
                                }

                                return btnsend + ScreeningQuestion + btnSendUniqueId + btnMarkCheckedIn + btnDownloadDocument + btnReScheduleApp;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.Fulfillment) {
                                //btnPrint = `<button class="btn btn-dark btn-sm mr-1 ml-1" type="button" onclick="CFP.Order.Print('${data}')" title="Print Unique Id Label"><i class="ri-printer-line text-white" ></i></button>`;
                                btnFulfillment = `<button class="btn btn-primary btn-sm mr-1 ml-1" title="Mark Fulfilment Completed" type="button" onclick="CFP.Order.FulfillmentModal('${data}')"><i class="ri-check-double-line text-white" ></i></button>`;
                                if (row.isScreeningQuestion) {
                                    ScreeningQuestion = `<button class="btn btn-success btn-sm mr-1 ml-1" title="Screening Question" type="button" onclick="CFP.Order.ScreeningQuestion('${data}')"><i class="ri-question-mark" ></i></button>`;
                                }
                                return btnView + btnPrint + btnFulfillment + ScreeningQuestion;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.Shipment) {
                                if (row.orderType == CFP.Enum.TestType.AtHome || row.orderType == CFP.Enum.TestType.DCS) {
                                    checkShipmentStatus = `<button class="btn btn-warning btn-sm mr-1 ml-1" type="button" title="Check Shipment Status" onclick="CFP.Order.CheckShipmentStatus('${row.kitUniqueId}')"><i class="ri-information-line text-white" ></i></button>`;
                                    if (row.testStatus == CFP.Enum.TestStatus.Kit_Registred || row.testStatus == CFP.Enum.TestStatus.Sample_Collected
                                        || row.testStatus == CFP.Enum.TestStatus.Sample_Shipped_To_Lab || row.testStatus == CFP.Enum.TestStatus.Sample_Received_At_Lab) {
                                        btnReceiveSample = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" title="Receive Sample" onclick="CFP.Order.ReceiveSampleAtLabModal('${data}')"><i class="ri-user-received-line text-white" ></i></button>`;
                                    } else {
                                        btnUpdateTrackingNumber = `<button class="btn btn-primary btn-sm mr-1 ml-1" type="button" title="Update Tracking Number" onclick="CFP.Order.UpdateTrackingNumber('${data}')"><i class="ri-truck-line text-white" ></i></button>`;
                                    }
                                }
                                return btnUpdateTrackingNumber + checkShipmentStatus + btnReceiveSample;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.SampleCollection) {
                                btnCollectSample = `<button class="btn btn-primary btn-sm mr-1 ml-1" type="button" title="Collect Sample"  onclick="CFP.Order.CollectSampleModal('${data}')"><i class="ri-temp-cold-line text-white" ></i></button>`;
                                return btnCollectSample;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.LabProcessing) {
                                /*  if (row.orderType == CFP.Enum.TestType.WalkIn || row.orderType == CFP.Enum.TestType.InPerson) {
                                      if (row.testStatus == CFP.Enum.TestStatus.Sample_Collected) {
                                          btnReceiveSample = `<button class="btn btn-primary btn-sm mr-1 ml-1" type="button" title="Receive Sample" onclick="CFP.Order.ReceiveSampleAtLabModal('${data}')"><i class="ri-user-received-line text-white" ></i></button>`;
                                      }
                                  }*/
                                if (row.testStatus != CFP.Enum.TestStatus.In_Process) {
                                    btnVerifySample = `<button class="btn btn-danger btn-sm mr-1 ml-1" type="button" title="Receive & Verify Sample" onclick="CFP.Order.VerifySampleModal('${data}')" ><i class="ri-test-tube-line text-white" ></i></button>`;
                                }
                                if (row.testStatus == CFP.Enum.TestStatus.In_Process) {
                                    btnUpdateTest = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" title="Update Test Result" onclick="CFP.Order.UpdateResultModal('${data}')"><i class="ri-checkbox-circle-line text-white" ></i></button>`;
                                }

                                return btnReceiveSample + btnUpdateTest + btnVerifySample;
                            }
                            else if (OrderListType == CFP.Enum.OrderListType.Completed) {
                                btnDownloadResult = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" title="Download Test Result" onclick="CFP.Common.DownloadTestResult('${row.resultFileName}')"><i class="ri-download-line text-white" ></i></button>`;
                                return btnDownloadResult;
                            } else {
                                return '';
                            }
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Order.Option.Table.ajax.reload();
    }

    this.InitCompleteOrders = function () {
        CFP.Order.Option.CompleteTable = $("#completeOrdersTable").DataTable(
            {
                searching: false,
                paging: true,
                serverSide: true,
                processing: true,
                bPaginate: true,
                bLengthChange: false,
                bInfo: true,
                ajax: {
                    type: "Post",
                    url: UrlContent("PatientKitRegistration/GetCompleteOrders"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                },
                "columns": [
                    { data: "orderNumber", name: "OrderNumber", autoWidth: true },
                    { data: "kitName", name: "KitName", autoWidth: true },
                    {
                        data: "orderType", name: "OrderType", autoWidth: true, className: "text-center col-1", render: function (data, type, row) {
                            if (data == CFP.Enum.TestType.AtHome) {
                                return '<span class="badge bg-success font-14">At Home</span>';
                            }
                            else if (data == CFP.Enum.TestType.InPerson) {
                                return '<span class="badge bg-primary font-14">In Person</span>';
                            }
                            else if (data == CFP.Enum.TestType.WalkIn) {
                                return '<span class="badge bg-warning font-14">Walk-In</span>';
                            }
                            else if (data == CFP.Enum.TestType.DCS) {
                                return '<span class="badge bg-secondary font-14">DCS</span>';
                            } else {
                                return '';
                            }
                        }
                    },
                    { data: "kitUniqueId", name: "KitUniqueId", autoWidth: true },
                    { data: "createdOnString", name: "CreatedOn", autoWidth: true },
                    {
                        data: "testStatus", name: "TestStatus", className: "col-1  text-center",
                        render: function (data, type, row) {
                            return CFP.Common.GetTestStatusHTML(data);
                        }
                    },
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnDownload = `<button class="btn btn-success btn-sm mr-1 " title="Download Test Result" type="button" onclick="CFP.Common.DownloadTestResult('${row.resultFileName}')"><i class="ri-file-upload-line text-white"></i></button>`;
                            return btnDownload;
                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.SearchCompleteOrders = function () {
        CFP.Order.Option.CompleteTable.ajax.reload();
    }

    this.ViewQuestions = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_Questions/" + id),
            success: function (data) {
                $("#common-xl-dialogContent").html(data);
                $("#common-xl-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }
    this.ScreeningQuestion = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_ScreeningQuestion/" + id),
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

    this.UpdateStatus = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_UpdateStatus/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#KitForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.UpdateTestStatus = function () {
        if ($("#KitForm").valid()) {
            var formData = $("#KitForm").serialize();
            $(".preloader").show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/UpdateTestStatus"),
                data: formData,
                success: function (response) {
                    $(".preloader").hide();
                    if (response.isSuccess) {
                        CFP.Common.ToastrSuccess(response.message);
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                    } else {
                        CFP.Common.ToastrError(response.message);
                    }
                }
            })
        }
    }


    this.ShippedSample = function (id) {
        Swal.fire({
            title: '<h4>Are you sure, you shipped the sample to the lab?</h4>',
            html: '',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#7460ee',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="ri-check-line"></i> Yes',
            cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("PatientKitRegistration/ShippedSample"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            window.location.reload();
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }

    this.Print = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to print this Unique Kit Id Label?</h4>',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#7460ee',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="ri-printer-line"></i> Yes',
            cancelButtonText: '<i class="ri-forbid-line"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $('.preloader').show();
                $.ajax({
                    type: "POST",
                    url: UrlContent("Order/Print"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            CFP.Order.Option.Table.ajax.reload();
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

    this.FulfillmentModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_MarkFulfillment/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#markFulfillmentForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.MarkFulfillComplete = function (id) {
        if ($("#markFulfillmentForm").valid()) {
            var data = $("#markFulfillmentForm").serialize();
            $('.preloader').show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/MarkFulfillComplete"),
                data: data,
                success: function (result) {
                    $('.preloader').hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                }
            })
        }

    }

    this.CollectSampleModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_CollectSample/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#sampleCollectionForm"));
                $("#common-md-dialog").modal('show');
                $(".dateTimePicker").flatpickr({
                    enableTime: true,
                    dateFormat: "m/d/Y H:i",
                })

                $(".preloader").hide();
            }
        })
    }

    this.CollectSample = function (id) {
        if ($("#sampleCollectionForm").valid()) {
            var data = $("#sampleCollectionForm").serialize();
            $('.preloader').show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/CollectSample"),
                data: data,
                success: function (result) {
                    $('.preloader').hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                }
            })
        }

    }

    this.VerifySampleModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_VerifySample/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $(".dateTimePicker").flatpickr({
                    enableTime: true,
                    dateFormat: "m/d/Y H:i",
                })
                $.validator.unobtrusive.parse($("#verifySampleForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.VerifySample = function (id) {
        if ($("#verifySampleForm").valid()) {
            var data = $("#verifySampleForm").serialize();
            $('.preloader').show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/VerifySample"),
                data: data,
                success: function (result) {
                    $('.preloader').hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                }
            })
        }

    }

    this.UpdateResultModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_UpdateTestResult/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#TestResultForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.UpdateTestResult = function () {
        if ($("#TestResultForm").valid()) {

            var fileUpload = $("#TestResultFile").get(0);
            var files = fileUpload.files;
            if (files.length == 0) {
                CFP.Common.ToastrError("Please select file");
                return;
            }

            $(".preloader").show();
            var formdata = new FormData();
            formdata.append("TestResultFile", files[0]);
            $(".formcontrol").each(function (index, elem) {
                formdata.append($(elem).attr("name"), $(elem).val())
            });

            $.ajax({
                type: "POST",
                url: UrlContent("Order/UpdateTestResult"),
                data: formdata,
                contentType: false,
                processData: false,
                success: function (response) {
                    $(".preloader").hide();
                    if (response.isSuccess) {
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(response.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(response.message);
                    }

                },
                error: function (textStatus, errorThrown) {
                }
            });

        }
    }

    this.UpdateTrackingNumber = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_UpdateTrackingNumber/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#trackingNumberForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.SaveTrackingNumber = function (id) {
        if ($("#trackingNumberForm").valid()) {
            var data = $("#trackingNumberForm").serialize();
            $('.preloader').show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/UpdateTrackingNumber"),
                data: data,
                success: function (result) {
                    $('.preloader').hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                }
            })
        }
    }

    this.ReceiveSampleAtLabModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_ReceiveSampleAtLab/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $("#common-md-dialog").modal('show');
                $(".dateTimePicker").flatpickr({
                    enableTime: true,
                    dateFormat: "m/d/Y H:i",
                })

                $.validator.unobtrusive.parse($("#receiveSampleForm"));
                $(".preloader").hide();
            }
        })
    }

    this.ReceiveSampleAtLab = function (id) {
        if ($("#receiveSampleForm").valid()) {
            var data = $("#receiveSampleForm").serialize();
            $('.preloader').show();
            $.ajax({
                type: "POST",
                url: UrlContent("Order/ReceiveSampleAtLab"),
                data: data,
                success: function (result) {
                    $('.preloader').hide();
                    if (result.isSuccess) {
                        $("#common-md-dialog").modal('hide');
                        CFP.Order.Option.Table.ajax.reload();
                        CFP.Common.ToastrSuccess(result.message);
                    }
                    else {
                        CFP.Common.ToastrError(result.message);
                    }
                }

            })
        }
    }

    this.OrderHistory = function (id) {
        $('.preloader').show();
        $.ajax({
            type: "POST",
            url: UrlContent("Order/_OrderHistory"),
            data: { id: id },
            success: function (data) {
                $('.preloader').hide();
                $("#common-md-dialogContent").html(data);
                $("#common-md-dialog").modal('show');
            }

        })

    }

    this.DownloadFulfilment = function () {
        $(".preloader").show();
        $.ajax({
            url: UrlContent("Order/DownloadFulfilment"),
            type: "POST",
            data: {
                SearchText: $("#txtSearch").val(),
                KitId: $("#ddKitList").val(),
                Status: $("#ddTestStatus").val(),
                TestType: $("#ddTestType").val(),
                OrderListType: CFP.Enum.OrderListType.Fulfillment,
            },
            success: function (response) {
                $(".preloader").hide();
                if (response.isSuccess) {
                    window.location.href = UrlContent("ExtraFiles/Downloads/" + response.message);
                } else {
                    CFP.Common.ToastrError(response.message);
                }
            }
        });
    }

    this.UploadFulfilment = function (id) {
        $('.preloader').show();
        $.ajax({
            type: "POST",
            url: UrlContent("Order/_UploadFulfilment"),
            data: { id: id },
            success: function (data) {
                $('.preloader').hide();
                $("#common-md-dialogContent").html(data);
                $("#common-md-dialog").modal('show');
            }

        })

    }
    this.ImportFulfilment = function () {
        $("#divMsg").addClass("hide");
        $("#btnDownloadError").addClass("hide");
        var fileUpload = $("#fileUpload").get(0);
        var files = fileUpload.files;
        $(".preloader").show();
        var formdata = new FormData();
        for (var i = 0; i < files.length; i++) {
            formdata.append("ImportFile", files[i]);
        }
        $.ajax({
            type: "POST",
            url: UrlContent("Order/UploadFulfilment"),
            data: formdata,
            contentType: false,
            processData: false,
            success: function (response) {
                $(".preloader").hide();
                $("#btnDownloadError").addClass("hide");
                $("#divMsg").addClass("hide");
                $("#fileUpload").val(null);
                if (response.isSuccess) {
                    $("#divMsg").removeClass("hide");
                    $("#lblMsg").html(response.message);
                    if (response.result != null && response.result != "" && typeof response.result != "undefined") {
                        $("#btnDownloadError").attr("href", response.result);
                        $("#btnDownloadError").removeClass("hide");
                    }

                } else {
                    $("#divMsg").removeClass("hide");
                    $("#lblMsg").html(response.message);
                }

            },
            error: function (textStatus, errorThrown) {
            }
        });
    }
    this.CheckShipmentStatus = function (id) {
        $(".preloader").show();
        $.ajax({
            type: "POST",
            url: UrlContent("Order/GetTrackingNo/" + id),
            success: function (data) {
                $(".preloader").hide();
                if (data.isSuccess) {
                    $(".preloader").show();
                    $.ajax({
                        type: "GET",
                        url: UrlContent("Order/_CheckShipmentStatus/" + data.result),
                        success: function (result) {
                            $(".preloader").hide();
                            $("#common-xl-dialogContent").html(result);
                            $("#common-xl-dialog").modal('show');

                        }
                    })
                } else {
                    CFP.Common.ToastrError(data.message);
                }
            }


        })
    }

    this.DownloadDocument = function (id) {
        $.ajax({
            type: "Post",
            url: UrlContent("Common/DownloadDocument"),
            data: { id: id },
            success: function (result) {
                $('.preloader').hide();
                if (result.isSuccess) {
                    // CFP.Common.ToastrError(result.message);
                    window.location.href = UrlContent("Common/DownloadDoc/?fileName=" + result.result);
                }
                else {
                    CFP.Common.ToastrError(result.message);
                }
            }
        })
    }
}