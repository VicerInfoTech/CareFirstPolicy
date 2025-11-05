CFP.Appointment = new function () {

    this.Schedule = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_ScheduleAppointment/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#AppointmentForm"));
                flatpicker();
                CFP.Appointment.InitDatePickerWithDisabledDate();


                var today = new Date();
                CFP.Appointment.Slot(today.toLocaleDateString("en-US"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.ReSchedule = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_ReScheduleAppointment/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#AppointmentForm"));
                flatpicker();
                CFP.Appointment.InitDatePickerWithDisabledDate();

                var today = new Date();
                CFP.Appointment.Slot(today.toLocaleDateString("en-US"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.Update = function () {
        if ($("#AppointmentForm").valid()) {
            Swal.fire({
                title: '<h4>Are you sure want to schedule appointment on this time?</h4>',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#7460ee',
                cancelButtonColor: '#a1aab2',
                confirmButtonText: '<i class="mdi mdi-check"></i> Yes',
                cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
            }).then((result) => {
                if (result.value) {

                    $(".preloader").show();
                    var formdata = $("#AppointmentForm").serialize();
                    $.ajax({
                        type: "Post",
                        url: UrlContent("Order/ScheduleAppointment"),
                        data: formdata,
                        success: function (result) {
                            $(".preloader").hide();
                            if (result.isSuccess) {
                                if (CFP.Order.Option != null && CFP.Order.Option.Table != null) {
                                    CFP.Order.Option.Table.ajax.reload();
                                }
                                CFP.Common.ToastrSuccess(result.message);
                                $("#common-md-dialog").modal('hide');
                            } else {
                                CFP.Common.ToastrError(result.message);
                            }
                        }, error: function () {
                            $(".preloader").hide();
                        }
                    })
                }
            });
        }
    }

    this.UpdateReSchedule = function () {
        if ($("#AppointmentForm").valid()) {
            Swal.fire({
                title: '<h4>Are you sure want to re-schedule appointment on this time?</h4>',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#7460ee',
                cancelButtonColor: '#a1aab2',
                confirmButtonText: '<i class="mdi mdi-check"></i> Yes',
                cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
            }).then((result) => {
                if (result.value) {
                    $(".preloader").show();
                    var formdata = $("#AppointmentForm").serialize();
                    $.ajax({
                        type: "Post",
                        url: UrlContent("Order/ReScheduleAppointment"),
                        data: formdata,
                        success: function (result) {
                            $(".preloader").hide();
                            if (result.isSuccess) {
                                if (CFP.Order.Option != null && CFP.Order.Option.Table != null) {
                                    CFP.Order.Option.Table.ajax.reload();
                                }
                                CFP.Common.ToastrSuccess(result.message);
                                $("#common-md-dialog").modal('hide');
                            } else {
                                CFP.Common.ToastrError(result.message);
                            }
                        },
                    })
                }
            });
        }
    }


    this.MarkCheckedInModal = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_MarkCheckedIn/" + id),
            success: function (data) {
                $("#common-md-dialogContent").html(data);
                $.validator.unobtrusive.parse($("#TestResultForm"));
                $("#common-md-dialog").modal('show');
                $(".preloader").hide();
            }
        })
    }

    this.MarkCheckedIn = function () {
        if ($("#TestResultForm").valid()) {
            $(".preloader").show();
            var formdata = $("#TestResultForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Order/MarkCheckedIn"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        if (CFP.Order.Option != null && CFP.Order.Option.Table != null) {
                            CFP.Order.Option.Table.ajax.reload();
                        }
                        $("#common-md-dialog").modal('hide');
                        CFP.Common.ToastrSuccess(result.message);
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }

    this.SendUniqueKitId = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to send Unique Kit Id?</h4>',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#11D1B7',
            cancelButtonColor: '#a1aab2',
            confirmButtonText: '<i class="mdi mdi-check"></i> Yes',
            cancelButtonText: '<i class="mdi mdi-cancel"></i> Cancel'
        }).then((result) => {
            if (result.value) {
                $(".preloader").show();
                $.ajax({
                    type: "GET",
                    url: UrlContent("Order/SendUniqueKitId/" + id),
                    success: function (result) {
                        $(".preloader").hide();
                        if (result.isSuccess) {
                            CFP.Common.ToastrSuccess(result.message);
                        } else {
                            CFP.Common.ToastrError(result.message);
                        }
                    },
                })
            }
        });
    }

    this.Slot = function (date) {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Order/_TimeSlot/?date=" + date),
            success: function (data) {
                $(".preloader").hide();
                $("#slotDiv").html(data);
                //$(".flatpickr-day").click(function () {
                //    if (!$(this).hasClass("flatpickr-disabled")) {
                //        CFP.Appointment.Slot($(this).attr("aria-label"))
                //    }
                //});

                var avslot = $('#divSlot ul li.avSlot').first();
                console.log(avslot);
                if (avslot != null && avslot != undefined && avslot.length > 0) {
                    $('#divSlot').scrollTop(avslot.position().top - 50);
                }
            }
        })
    }

    this.InitDatePickerWithDisabledDate = function () {
        $.ajax({
            type: "GET",
            url: UrlContent("Order/GetNonWorkingDays"),
            success: function (data) {
                $("#hidSun").val(data.isSun);
                $("#hidMon").val(data.isMon);
                $("#hidTue").val(data.isTue);
                $("#hidWed").val(data.isWed);
                $("#hidThu").val(data.isThu);
                $("#hidFri").val(data.isFri);
                $("#hidSat").val(data.isSat);

                var weekend = new Array()
                for (var i = 0; i <= 356; i++) {
                    var newDate = addDays(new Date(), i);
                    if (rmydays(newDate)) {
                        weekend.push(newDate.toISOString().split('T')[0]);
                    }
                }
                data.dates += (data.dates != "undefined" && data.dates != "" ? "," : "") + weekend.toString();

                $(".apptInput").show();
                $('.datepicker').flatpickr({
                    dateFormat: "Y-m-d",
                    inline: true,
                    minDate: new Date(),
                    defaultDate: new Date(),
                    disable: data.dates.split(','),
                    onChange: function (selectedDates, dateStr, instance) {
                        $('.flatpickr-day').on('click', function (event) {
                            if (!$(event.target).hasClass('flatpickr-disabled')) {
                                CFP.Appointment.Slot($(this).attr("aria-label"))
                            }
                        });
                    }
                })
                $('.flatpickr-day.today').click();
                $(".apptInput").hide();
            }
        })
    }

    function addDays(date, days) {
        var result = new Date(date);
        result.setDate(result.getDate() + days);
        return result;
    }

    function rmydays(date) {
        var result = false;
        if (date.getDay() === 0 && $("#hidSun").val() === 'false')
            result = true;
        else if (date.getDay() === 1 && $("#hidMon").val() === 'false')
            result = true;
        else if (date.getDay() === 2 && $("#hidTue").val() === 'false')
            result = true;
        else if (date.getDay() === 3 && $("#hidWed").val() === 'false')
            result = true;
        else if (date.getDay() === 4 && $("#hidThu").val() === 'false')
            result = true;
        else if (date.getDay() === 5 && $("#hidFri").val() === 'false')
            result = true;
        else if (date.getDay() === 6 && $("#hidSat").val() === 'false')
            result = true;
        else
            result = false;
        return result;
    }

    this.SelectSlot = function (hour) {
        $("#AppointmentSlot").val(hour);
        $(".list-group-item").removeClass("list-group-fill-success");
        $("#hrs_" + hour).addClass("list-group-fill-success");
    }



}