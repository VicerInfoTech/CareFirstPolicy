CFP.Job = new function () {


    this.SaveJobForm = function () {
        debugger;
        if ($("#jobForm").valid()) {
            $(".preloader").show();
            var formdata = $("#jobForm").serialize();
            $.ajax({
                type: "Post",
                url: UrlContent("Job/SaveJobForm"),

                data: formdata,
                success: function (result) {
                    debugger;
                    $(".preloader").hide();
                    if (result.isSuccess) {
                        Swal.fire({
                            title: "Success!",
                            text: "Your job application has been submitted successfully.",
                            icon: "success",
                            confirmButtonText: "OK"
                        }).then(function () {
                            // Redirect to Job Application Dashboard
                            window.location.href = UrlContent("Job/Medicare/");
                        });
                    } else {
                        CFP.Common.ToastrError(result.message);
                    }
                },
            })
        }
    }

    this.SaveDocument = function (docId, stateId) {
        var input;
        if (docId!=2)
             input = $("#JobDoc_" + docId)[0];
        else
             input = $("#JobDoc_" + stateId)[0];
        var file = input.files[0];

        if (!file) {
            CFP.Common.ToastrError("Please select a document");
            return;
        }

        $(".preloader").show();

        var formData = new FormData();
        formData.append("file", file);
        formData.append("docId", docId);
        formData.append("stateId", stateId || 0); // stateId = 0 if not a state doc
        $.ajax({
            type: "POST",
            url: UrlContent("Job/SaveDoc"),
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {

                $(".preloader").hide();

                if (data.isSuccess) {
                    CFP.Common.ToastrSuccess("Document uploaded successfully");
                } else {
                    CFP.Common.ToastrError(data.message);
                }
            }
        });
    }

}