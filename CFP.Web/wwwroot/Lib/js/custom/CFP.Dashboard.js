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

    //this.BindDealChart = function () {

    //    var agentId = $("#AgentId").val();

    //    $.ajax({
    //        type: "POST",
    //        url: UrlContent("Dashboard/FetchDealData"),
    //        data: { agentId: agentId },

    //        success: function (result) {

    //            // NO DATA
    //            if (!result || result.length === 0) {

    //                $("#dealLineChart").addClass("chart-hidden");
    //                $("#dealNoData").show();

    //                if (window.dealChart) window.dealChart.destroy();

    //                return;
    //            }

    //            // HAS DATA
    //            $("#dealLineChart").removeClass("chart-hidden");
    //            $("#dealNoData").hide();


    //            // Backend already returns grouped data
    //            const labels = result.map(x => x.date);
    //            const data = result.map(x => x.totalDeal);

    //            const ctx = document.getElementById('dealLineChart').getContext('2d');

    //            // Destroy old chart
    //            if (window.dealChart) {
    //                window.dealChart.destroy();
    //            }


    //            // Gradient effect for chart
    //            const gradient = ctx.createLinearGradient(0, 0, 0, 300);
    //            gradient.addColorStop(0, 'rgba(23, 71, 159, 0.7)');
    //            gradient.addColorStop(1, 'rgba(0, 204, 255, 0.3)');

    //            window.dealChart = new Chart(ctx, {
    //                type: 'line',
    //                data: {
    //                    labels: labels,
    //                    datasets: [{
    //                        label: 'Deal Data',
    //                        data: data,
    //                        fill: true,
    //                        borderColor: '#17479f',
    //                        backgroundColor: gradient,
    //                        tension: 0.4,
    //                        borderWidth: 2,
    //                        pointRadius: 3,
    //                        pointBackgroundColor: '#17479f'
    //                    }]
    //                },
    //                options: {
    //                    responsive: true,
    //                    maintainAspectRatio: false,

    //                    plugins: {
    //                        legend: { display: false },

    //                        tooltip: {
    //                            callbacks: {
    //                                title: function (context) {
    //                                    return context[0].label; // shows "11/20/2025"
    //                                }
    //                            }
    //                        }

    //                    },

    //                    scales: {
    //                        x: {
    //                            grid: { display: false },
    //                            ticks: {
    //                                callback: function (value, index) {
    //                                    const raw = this.chart.data.labels[index];  // "11/20/2025"

    //                                    const [month, day, year] = raw.split("/");

    //                                    // Format bottom label
    //                                    const date = new Date(year, month - 1, day);

    //                                    return `${day}-${date.toLocaleString("en-US", { month: "short" })}`;
    //                                }
    //                            }


    //                        },
    //                        y: {
    //                            beginAtZero: true,
    //                            ticks: { stepSize: 1 },
    //                            grid: { color: 'rgba(230,230,230,0.5)' }
    //                        }
    //                    }
    //                }
    //            });
    //            const canvas = $(".deal-chart-canvas").val();
    //            canvas.style.height = "350px";
    //            canvas.style.minHeight = "350px";
    //        },

    //        error: function (xhr) {
    //            console.error("Error loading deal data", xhr);
    //        }
    //    });
    //}
    //this.BindDealChart = function () {

    //    var agentId = $("#AgentId").val();

    //    $.ajax({
    //        type: "POST",
    //        url: UrlContent("Dashboard/FetchDealData"),
    //        data: { agentId: agentId },

    //        success: function (result) {

    //            // NO DATA
    //            if (!result || result.length === 0) {
    //                $("#dealLineChart").addClass("chart-hidden");
    //                $("#dealNoData").show();

    //                if (window.dealChart) window.dealChart.destroy();

    //                return;
    //            }

    //            // HAS DATA
    //            $("#dealLineChart").removeClass("chart-hidden");
    //            $("#dealNoData").hide();

    //            // Using backend payload
    //            const labels = result.map(x => x.date);
    //            const applicantSeries = result.map(x => x.applicantCount);
    //            const dealSeries = result.map(x => x.dealCount);

    //            // SUM TOTALS
    //            const totalApplicants = applicantSeries.reduce((a, b) => a + b, 0);
    //            const totalDeals = dealSeries.reduce((a, b) => a + b, 0);

    //            // UPDATE HEADER DISPLAY
    //            $("#totalApplicantsDisplay").html(
    //                `${totalApplicants} <span class="text-muted d-inline-block fs-14 align-middle ms-2">Applicants</span>`
    //            );

    //            $("#totalDealsDisplay").html(
    //                `${totalDeals} <span class="text-muted d-inline-block fs-14 align-middle ms-2">Deals</span>`
    //            );

    //            // Destroy old chart
    //            if (window.dealChart) {
    //                window.dealChart.destroy();
    //            }

    //            // Clear old SVG
    //            document.querySelector("#dealLineChart").innerHTML = "";

    //            // ApexChart options
    //            var options = {
    //                chart: {
    //                    type: 'line',
    //                    height: 350,
    //                },

    //                series: [
    //                    { name: 'Deals', data: dealSeries },
    //                    { name: 'Forms', data: applicantSeries }
    //                ],

    //                xaxis: {
    //                    categories: labels,
    //                    labels: {
    //                        formatter: function (val) {
    //                            // Apex sends undefined sometimes → avoid crash
    //                            if (!val) return "";

    //                            const parts = val.split("/");
    //                            if (parts.length !== 3) return val;

    //                            const [month, day, year] = parts;
    //                            const date = new Date(year, month - 1, day);

    //                            return `${day}-${date.toLocaleString("en-US", { month: "short" })}`;
    //                        }
    //                    }
    //                },

    //                stroke: { curve: 'smooth', width: 3 },
    //                colors: ['#17479f', '#00bcd4'],
    //                dataLabels: { enabled: false },

    //                grid: { borderColor: '#e0e0e0' }
    //            };

    //            window.dealChart = new ApexCharts(
    //                document.querySelector("#dealLineChart"),
    //                options
    //            );

    //            window.dealChart.render();
    //        },

    //        error: function (xhr) {
    //            console.error("Error loading deal data", xhr);
    //        }
    //    });
    //}
    this.BindDealChart = function () {

        let agentId = $("#AgentId").val();

        $.ajax({
            url: "/Dashboard/FetchDealData",
            type: "GET",
            data: { agentId: agentId },
            success: function (res) {

                if (!res || res.length === 0) {
                    $("#dealLineChart").hide();
                    $("#dealNoData").show();
                    return;
                }

                // Convert values to Numbers
                let chartData = {
                    dates: res.map(x => x.label),
                    deals: res.map(x => Number(x.dealCount)),
                    applicants: res.map(x => Number(x.applicantCount)),
                    agents: res.map(x => Number(x.agentCount))
                };

                // -------- METRICS ----------
                let totalDeals = chartData.deals.reduce((a, b) => a + b, 0);
                let totalApplicants = chartData.applicants.reduce((a, b) => a + b, 0);
                let totalAgents = Math.max(...chartData.agents);   // max agents in 10 days
                let avgDeals = (totalDeals / chartData.deals.length).toFixed(1);

                $("#metricDeals").text(totalDeals);
                $("#metricApplicants").text(totalApplicants);
                $("#metricAgents").text(totalAgents);
                $("#metricAvgDeals").text(avgDeals);

                $("#dealLineChart").show();
                $("#dealNoData").hide();

                // -------- Theme Colors ----------
                var chartColors = getChartColorsArray(
                    document.querySelector("#dealLineChart")
                );

                // -------- APEX CHART CODE ----------
                let options = {
                    chart: {
                        height: 350,
                        type: "line",
                        toolbar: { show: false }
                    },

                    series: [
                        {
                            name: "Deals",
                            type: "column",
                            data: chartData.deals
                        },
                        {
                            name: "Applicants",
                            type: "column",
                            data: chartData.applicants
                        },
                        {
                            // 🔥 Fake series → ONLY for soft yellow background area
                            name: "Agents Area",
                            type: "area",
                            data: chartData.agents
                        },
                        {
                            name: "Agents",
                            type: "line",
                            data: chartData.agents
                        }
                    ],

                    colors: chartColors,

                    stroke: {
                        width: [0, 0, 0, 3],
                        curve: "smooth",
                        dashArray: [0, 0, 0, 5]   // dotted yellow line
                    },

                    plotOptions: {
                        bar: {
                            columnWidth: "40%",
                            borderRadius: 4
                        }
                    },

                    fill: {
                        type: ["solid", "solid", "gradient", "solid"],
                        opacity: [1, 1, 0.25, 1], // ⭐ FAKE AREA SOFT SHADE
                        gradient: {
                            shadeIntensity: 1,
                            opacityFrom: 0.30,
                            opacityTo: 0.05,
                            stops: [0, 90, 100]
                        }
                    },

                    markers: {
                        size: 5,
                        strokeWidth: 3
                    },

                    xaxis: {
                        categories: chartData.dates,
                        labels: { style: { fontSize: "12px" } }
                    },

                    yaxis: {
                        labels: { style: { fontSize: "12px" } }
                    },

                    grid: {
                        borderColor: "#f1f1f1"
                    },

                    // -------- HIDE FAKE SERIES FROM TOOLTIP ----------
                    tooltip: {
                        shared: true,
                        intersect: false,
                        y: {
                            formatter: function (val, opts) {
                                let index = opts.seriesIndex;

                                // ❗ Hide Agents Area series from tooltip
                                if (opts.w.config.series[index].name === "Agents Area") {
                                    return "";
                                }
                                return val;
                            }
                        }
                    },


                    // -------- HIDE FAKE SERIES FROM LEGEND ----------
                    legend: {
                        position: "bottom",
                        fontSize: "12px",
                        formatter: function (seriesName, opts) {
                            if (seriesName === "Agents Area") return ""; // hide it
                            return seriesName;
                        }
                    }
                };

                // Destroy old chart
                if (window.dealChartInstance) {
                    window.dealChartInstance.destroy();
                }

                window.dealChartInstance = new ApexCharts(
                    document.querySelector("#dealLineChart"),
                    options
                );

                window.dealChartInstance.render();
            }
        });
    };


    // ============ THEME COLOR FUNCTION ============
    function getChartColorsArray(el) {
        if (!el) return [];
        var colors = el.getAttribute("data-colors");

        try {
            colors = JSON.parse(colors);
        } catch {
            return [];
        }

        return colors.map(function (value) {
            var newValue = value.replace(" ", "");
            if (newValue.indexOf("--") !== -1) {
                var cssVar = getComputedStyle(document.documentElement)
                    .getPropertyValue(newValue);
                return cssVar.trim();
            }
            return newValue;
        });
    }


    this.LoadPortfolioChart = function () {
        const days = parseInt($('#portfolioRange').val() || '7', 10);

        // show spinner / placeholder if you want
        $.ajax({
            type: 'POST',
            url: UrlContent('Dashboard/FetchDealDataAllAgents'),
            data: { days: days },
            success: function (result) {
                // result is array of AgentDealChartViewModel {AgentId, AgentName, DealCount}

                // If no data
                if (!result || !result.chartAgents || result.chartAgents.length === 0) {
                    CFP.Dashboard.RenderEmptyPortfolio();
                    return;
                }

                // Prepare data: labels and series for donut
                const labels = result.chartAgents.map(r => r.agentName);
                const series = result.chartAgents.map(r => r.dealCount);


                // Optionally limit slices shown and aggregate rest into "Other"
                const maxSlices = 8; // show up to 8 slices
                let finalLabels = labels;
                let finalSeries = series;
                if (labels.length > maxSlices) {
                    const top = labels.slice(0, maxSlices);
                    const topSeries = series.slice(0, maxSlices);
                    const restTotal = series.slice(maxSlices).reduce((a, b) => a + b, 0);
                    top.push('Others');
                    topSeries.push(restTotal);
                    finalLabels = top;
                    finalSeries = topSeries;
                }

                // Colors from CSS variables (optional)
                const colorCss = $('#portfolio_donut_charts').data('colors');
                let colors = [];
                try {
                    colors = JSON.parse(colorCss.replace(/&quot;/g, '"'));
                } catch (e) {
                    colors = generateUniqueColors(result.length);
                }

                CFP.Dashboard.RenderDonut(finalLabels, finalSeries, colors);
                CFP.Dashboard.RenderTop5List(result.topAgents);

            },
            error: function (err) {
                console.error('Error fetching portfolio data', err);
                CFP.Dashboard.RenderEmptyPortfolio();
            }
        });

    };
    function generateUniqueColors(count) {
        const colors = [];
        for (let i = 0; i < count; i++) {
            colors.push("#" + Math.floor(Math.random() * 16777215).toString(16));
        }
        return colors;
    }

    this.RenderDonut = function (labels, series, colors) {
        // destroy previous chart if present
        if (window.portfolioDonutChart) {
            window.portfolioDonutChart.destroy();
            $('#portfolioDonut').empty();
        }
        const totalDeals = series.reduce((a, b) => a + b, 0);
        const options = {
            series: series,
            chart: { type: 'donut', height: 227 },
            labels: labels,
            legend: {
                show: false   // 🔥 HIDE LEGEND
            },
            colors: colors,
            // 🔥 Add donut center label
            plotOptions: {
                pie: {
                    donut: {
                        size: '75%',
                        labels: {
                            show: true,
                            total: {
                                show: true,
                                label: 'Total Deals',
                                formatter: function () {
                                    return "#"+ totalDeals;  // center value
                                }
                            },
                            value: {
                                show: true,
                                fontSize: '18px',
                                formatter: function (val) {
                                    return "#" + val;    // <<< ADD # FOR EACH SEGMENT
                                }
                            }
                        }
                    }
                }
            },
            dataLabels: { enabled: false },
            tooltip: {
                y: {
                    formatter: function (value) {
                        return "#" + value;
                    }
                }
            },
            responsive: [{
                breakpoint: 480,
                options: { chart: { width: 200 }, legend: { show: false } }
            }]
        };

        window.portfolioDonutChart = new ApexCharts(document.querySelector("#portfolioDonut"), options);
        window.portfolioDonutChart.render();
    };

    this.RenderTop5List = function (top5Array) {
        // top5Array: array of AgentDealChartViewModel ordered desc
        const $list = $('#portfolioTop5');
        $list.empty();

        if (!top5Array || top5Array.length === 0) {
            $list.append('<li class="list-group-item px-0 text-center text-muted">No agents found</li>');
            return;
        }

        top5Array.forEach(item => {
            const html = `
      <li class="list-group-item px-0">
        <div class="d-flex">
          <div class="flex-grow-1 ms-2">
            <h6 class="mb-1">${escapeHtml(item.agentName)}</h6>
          </div>
          <div class="flex-shrink-0 text-end">
            <h6 class="fs-13 mb-0 text-muted"># ${item.dealCount}</h6>
          </div>
        </div>
      </li>`;
            $list.append(html);
        });
    };

    this.RenderEmptyPortfolio = function () {
        if (window.portfolioDonutChart) {
            window.portfolioDonutChart.destroy();
            $('#portfolioDonut').empty();
        }
        $('#portfolioDonut').html('<div class="text-center text-muted" style="padding:70px 0;">No data available</div>');
        $('#portfolioTop5').html('<li class="list-group-item px-0 text-center text-muted">No agents found</li>');
    };

    // small helper to avoid XSS if agent names are user-provided
    function escapeHtml(text) {
        return String(text)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    }


}