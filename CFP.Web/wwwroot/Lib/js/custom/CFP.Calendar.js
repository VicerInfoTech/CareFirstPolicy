CFP.Calendar = new function () {

    this.Options = {
        Calendar: null,
        WorkingDays: [0, 1],
    }

    this.Init = function () {

        CFP.Calendar.GetWorkingDays();
        if (CFP.Calendar.Options.Calendar != null)
            CFP.Calendar.Options.Calendar.destroy()

        var calendarEl = document.getElementById("calendar");
        CFP.Calendar.Options.Calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'local',
            editable: true,
            droppable: true,
            selectable: true,
            navLinks: true,
            showNonCurrentDates: false,
            initialView: 'dayGridMonth',
            themeSystem: 'bootstrap',
            businessHours: {
                daysOfWeek: CFP.Calendar.Options.WorkingDays,
                startTime: '12:00',  
                endTime: '23:59', 
            }, 
            //selectConstraint: {
            //    daysOfWeek: CFP.Calendar.Options.WorkingDays,
            //},
            selectAllow: function (selectInfo) {
                console.log(selectInfo)
            },
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
            },

            events: function (fetchInfo, successCallback, failureCallback) {
                $.ajax({
                    type: "Post",
                    url: UrlContent("Calendar/GetList"),
                    data: {
                        start: fetchInfo.startStr,
                        end: fetchInfo.endStr
                    },
                    success: function (data) {
                        successCallback(data);
                    }
                })
            }
            ,
            eventClick: function (info) { 
                CFP.Calendar.View(info.event.id, '');
            },
            dateClick: function (info) {
                console.log(info.dateStr)
                if (isBusinessDay(new Date(info.dateStr))) { 
                    CFP.Calendar.Add('', info.dateStr);
                } 
            },
        });
        CFP.Calendar.Options.Calendar.render();
    }

    function isBusinessDay(date) { 
        var dayOfWeek = date.getDay();
        return CFP.Calendar.Options.WorkingDays.includes(dayOfWeek);
    }

    function getInitialView() {
        if (window.innerWidth >= 768 && window.innerWidth < 1200) {
            return 'timeGridWeek';
        } else if (window.innerWidth <= 768) {
            return 'listMonth';
        } else {
            return 'dayGridMonth';
        }
    }


    this.Add = function (id = '', date = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Calendar/_Details"),
            data: {
                id: id,
                date: date
            },
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $('.datepicker').daterangepicker({
                    singleDatePicker: true,
                    showDropdowns: true,
                    minYear: 1901,
                    autoApply: true,
                }, function (start, end, label) {

                });

                $.validator.unobtrusive.parse($("#nonWorkingDayForm"));
                $("#common-md-dialog").modal('show');
            }
        })
    }


    this.View = function (id = '') {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Calendar/_View"),
            data: {
                id: id,
            },
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);
                $("#common-md-dialog").modal('show');
            }
        })
    }


    this.Save = function () {
        if ($("#nonWorkingDayForm").valid()) {
            $(".preloader").show();
            var formdata = $("#nonWorkingDayForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Calendar/Save"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        if (CFP.Calendar.Options.Calendar != null)
                            CFP.Calendar.Options.Calendar.refetchEvents()
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }


    this.Delete = function (id) {
        Swal.fire({
            title: '<h4>Are you sure want to delete record?</h4>',
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
                    type: "GET",
                    url: UrlContent("Calendar/Delete"),
                    data: {
                        id: id,
                    },
                    success: function (result) {
                        $('.preloader').hide();
                        if (result.isSuccess) {
                            if (CFP.Calendar.Options.Calendar != null)
                                CFP.Calendar.Options.Calendar.refetchEvents()
                            CFP.Common.ToastrSuccess(result.message);
                            $("#common-md-dialog").modal('hide');
                        }
                        else {
                            CFP.Common.ToastrError(result.message);
                        }
                    }
                })
            }
        });
    }


    this.WorkingHour = function () {
        $(".preloader").show();
        $.ajax({
            type: "get",
            url: UrlContent("Calendar/_WorkingHours"),
            success: function (data) {
                $(".preloader").hide();
                $("#common-md-dialogContent").html(data);

                $(".timePicker").flatpickr({
                    enableTime: true,
                    noCalendar: true,
                    dateFormat: "H:i",
                })
                $(".form-check-input").trigger("change");
                $.validator.unobtrusive.parse($("#workingHourForm"));
                $("#common-md-dialog").modal('show');
            }
        })
    }


    this.SaveWorkingHours = function () {
        if ($("#workingHourForm").valid()) {
            $(".preloader").show();
            var formdata = $("#workingHourForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Calendar/SaveWorkingHours"),
                data: formdata,
                success: function (result) {
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        CFP.Calendar.Init();
                        CFP.Common.ToastrSuccess(result.message);
                        $("#common-md-dialog").modal('hide');
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }


    this.HideShowTime = function ($_this) {
        var isChecked = $($_this).prop("checked");
        let id = $($_this)[0].id;
        if (isChecked) {
            $(".div" + id).removeClass("hide");
        } else {
            $(".div" + id).addClass("hide");
        }
    }

    this.GetWorkingDays = function () {
        $.ajax({
            type: "get",
            async: false,
            url: UrlContent("Calendar/GetWorkingDays"),
            success: function (data) {
                CFP.Calendar.Options.WorkingDays = data;
            }
        })
    } 

}