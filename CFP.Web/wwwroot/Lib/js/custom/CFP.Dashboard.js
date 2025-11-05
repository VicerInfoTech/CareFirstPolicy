CFP.Dashboard = new function () {

    this.Option = {
        Table: null,
    }

    this.Init = function (RoleId) {
        CFP.Dashboard.Option.Table = $("#dashboardTableId").DataTable(
            {
                searching: false,
                paging: true,
                serverSide: "true",
                processing: false,
                bPaginate: false,
                bLengthChange: false,
                bInfo: false,
                pageLength: 7,
                ajax: {
                    type: "Post",
                    url: UrlContent("Dashboard/GetOrderList"),
                    data: function (dtParms) {
                        dtParms.search.value = $("#txtSearch").val();
                        return dtParms;
                    },
                    complete: function (response, result) {
                        $("#dashboardTableId_paginate").addClass("hide");
                    },
                },
                "columns": [
                    { data: "orderNumber", name: "OrderNumber", autoWidth: true, className: "text-center" },
                    { data: "patientName", name: "patientName", autoWidth: true },
                    { data: "kitName", name: "kitName", autoWidth: true },
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
                  
                    {
                        data: "testStatus", name: "TestStatus", className: "col-1  text-center",
                        render: function (data, type, row) {
                            return CFP.Common.GetTestStatusHTML(data);
                        }
                    },
                    {
                        data: "encId", orderable: false, className: "text-center col-1", orderable: false,
                        render: function (data, type, row) {
                            let btnScheduleApp = '', btnOrderHistory = '', btnReScheduleApp = '', btnUpdateTest = '', btnUpdateTrackingNumber = ``, checkShipmentStatus = '', btnPrint = ``;
                            let btnView = ``, btnMarkCheckedIn = '', btnFulfillment = '', btnCollectSample = '', btnReceiveSample = '', btnVerifySample = '', btnDownloadResult = '', btnGoto = '';

                            btnGoto = `<button class="btn btn-success btn-sm mr-1 ml-1" type="button" onclick="CFP.Common.GoToCurrentTable(${row.orderType},${row.testStatus},${RoleId})" title="Go to Current Table"><i class="ri-arrow-right-fill text-white" ></i></button>`;

                            //btnPrint = `<button class="btn btn-dark btn-sm mr-1 ml-1" type="button" onclick="CFP.Order.Print('${data}')" title="Print Unique Id Label"><i class="ri-printer-line text-white" ></i></button>`;
                            btnOrderHistory = `<button class="btn btn-warning btn-sm mr-1 ml-1" type="button" onclick="CFP.Order.OrderHistory('${data}')" title="OrderHistory"><i class="ri-history-line text-white" ></i></button>`;


                            /*if (row.orderType == CFP.Enum.TestType.AtHome || row.orderType == CFP.Enum.TestType.DCS) {
                                btnView = `<button class="btn btn-secondary btn-sm mr-1 ml-1" type="button" title="View Kit Registration Details" onclick="CFP.Order.ViewQuestions('${data}')"><i class="ri-eye-line text-white" ></i></button>`;
                            }*/
                            return btnOrderHistory + btnView + btnPrint + btnGoto;


                        }
                    },
                ],
                order: [[0, "DESC"]],
            });
    }

    this.Search = function () {
        CFP.Dashboard.Option.Table.ajax.reload();
    }

}