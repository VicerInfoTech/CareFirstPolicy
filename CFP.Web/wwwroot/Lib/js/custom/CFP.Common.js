
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
              
                $("#leaderboarddivId").html(data);
               
               
                $(".preloader").hide();
            }
        })
    }
}