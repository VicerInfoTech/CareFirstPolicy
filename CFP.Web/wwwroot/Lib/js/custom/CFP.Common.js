
CFP.Common = new function () {
    this.Option = {
        Table: null,
    }
    this.ToastrSuccess = function (msg) {
        toastr.success(msg);
    }

    this.ToastrError = function (msg) {
        toastr.error(msg);
    }

    this.ToastrRemove = function () {
        toastr.remove();
    }

    this.TimeZoneOptions = {
        timeZone: "America/New_York",
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
        hour12: true
    };

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


    this.InitDatePicker = function () {
        debugger;
        $('.date-picker-time').flatpickr({
            enableTime: true,
            enableSeconds: true,
            time_24hr: false,
            dateFormat: "m/d/Y h:i:S K",
            allowInput: true
        });

        $('.date-picker').flatpickr({
            dateFormat: "m/d/Y",    // MM/DD/YYYY format
            allowInput: true,       // user can type manually
            defaultDate: null,      // no default date
        });


        CFP.Common.InitDateKeyEvent();
    }

    this.InitDateKeyEvent = function () {
        $('.date-picker, .date-picker-time').on('keypress', function (e) {
            var Id = "#" + $(this).attr("Id");
            var key = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
            if ($(Id).val().length < 10 && key != 47 && key != 45) {
                FormatDate(e, this);
            }
            else {
                e.preventDefault();
                return false;
            }
        });
    }

    this.ChangePassword = function (id) {
        debugger;
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("Common/_ChangePassword/" + id),
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


    this.LeaderBoard = function () {
        $(".preloader").show();
        $.ajax({
            type: "GET",
            url: UrlContent("LeaderBoard/_LeaderBoard/"),
            success: function (data) {
                $("#leaderboarddivId").empty();
                $("#leaderboarddivId").html(data);
                $(".preloader").hide();
            }
        })
    }

    this.ChatHistory = function (options) {
        CFP.Common.Option.Table = $("#chatHistoryTableId").DataTable({
            searching: false,
            paging: true,
            serverSide: true,
            processing: true,
            bPaginate: true,
            bLengthChange: false,
            bInfo: true,
            ajax: {
                type: "POST",
                url: UrlContent("Common/GetChatHistoryList"),
                data: function (dtParms) {
                    dtParms.search.value = $("#txtSearch").val();
                    dtParms.chatTypeValue = $("#chatTypeId").val();
                    dtParms.fromValue = $("#fromUserId").val();
                    dtParms.startData = $("#startDate").val();
                    dtParms.endDate = $("#endDate").val();
                    if ($("#chatTypeId").val() == "1") {
                        dtParms.toUserValue = $("#toUserid").val();
                    }
                    else {
                        dtParms.roomIdValue = $("#roomid").val();
                        dtParms.msgTypeValue = $("#msgTypeId").val();
                    }
                    return dtParms;
                },
            },
            columns: [
                { data: "sendAtString", name: "SendAtString", autoWidth: true, className: "col-2" },
                { data: "senderName", name: "SenderName", autoWidth: true, className: "col-2" },
                {
                    data: "receiverName",
                    name: "ReceiverName",
                    autoWidth: true,
                    className: "col-2",
                    render: function (data, type, row) {

                        if (row.chatRoomId == 0) {
                            return data;   // private chat ? show name
                        }
                        else {
                            return `<span class="badge bg-success">${data}</span>`;
                            // channel chat ? show badge
                        }
                    }
                },

                {
                    data: null,  // we will use render so we need the full row
                    name: "Message",
                    autoWidth: true,
                    className: "col-4",
                    render: function (data, type, row, meta) {
                        // row is full data object
                        if (row.isAttachment) {
                            const downloadUrl = `/Chat/DownloadAttachment?roomId=${encodeURIComponent(row.chatRoomId)}&file=${encodeURIComponent(row.message)}`;
                            // Show filename if you have `row.fileName`, else use `row.message`
                            const fileName = row.fileName || row.message;
                            return `<a href="${downloadUrl}" target="_blank">${fileName}</a>`;
                        } else {
                            return row.message;
                        }
                    }
                },
                {
                    data: "isAttachment",
                    name: "MessageType",
                    autoWidth: true,
                    className: "col-1",
                    render: function (data, type, row, meta) {
                        return data ? "Media" : "Text";
                    }
                }
            ],
            order: [[0, "DESC"]],
        });
    }


    this.ChatSearch = function () {
        CFP.Common.Option.Table.ajax.reload();
    }


    this.DownloadChatHistData = function () {
        $(".preloader").show();

        let searchValue = $("#txtSearch").val();
        let chatTypeValue = $("#chatTypeId").val();
        let fromValue = $("#fromUserId").val();
        let startDate = $("#startDate").val();
        let endDate = $("#endDate").val();

        let toUserValue = 0;
        let roomIdValue = 0;
        let msgTypeValue = 0;

        if (chatTypeValue == "1") {
            toUserValue = $("#toUserid").val();
        } else {
            roomIdValue = $("#roomid").val();
            msgTypeValue = $("#msgTypeId").val();
        }

        $.ajax({
            type: "POST",
            url: UrlContent("Common/DownloadChatHistData"),
            data: {
                searchValue: searchValue,
                chatTypeValue: chatTypeValue,
                fromValue: fromValue,
                startDate: startDate,
                endDate: endDate,
                toUserValue: toUserValue,
                roomIdValue: roomIdValue,
                msgTypeValue: msgTypeValue,
            },
            success: function (result) {
                $(".preloader").hide();

                if (result.isSuccess) {
                    window.location = result.message; // download
                } else {
                    CFP.Agent.ToastrError(result.message);
                }
            }
        });
    }

}