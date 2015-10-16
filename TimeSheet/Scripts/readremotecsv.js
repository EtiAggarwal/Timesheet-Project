var format = d3.time.format("%_m/%e/%Y %H:%M");
//            var iso = d3.time.format.utc("%Y-%m-%dT%H:%M:%S.%LZ")
var margin = { top: 20, right: 20, bottom: 30, left: 50 },
width = 750 - margin.left - margin.right,
height = 300 - margin.top - margin.bottom;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.line()
    .x(function (d) { return x(d.Updated); })
    .y(function (d) { return y(d.Freq); });

var svg = d3.select("#remotecsv").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

globaldata = d3.csv("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/freq.csv", function (data) {
    data.forEach(function (d) {
        d.Updated = new Date(d.Updated);
        d["Freq"] = +d["Freq"];
    });
    console.log(data[0]);
    x.domain(d3.extent(data, function (d) { return d.Updated; }));
    y.domain(d3.extent(data, function (d) { return d.Freq; }));

    svg.append("g")
     .attr("class", "x axis")
     .attr("transform", "translate(0," + height + ")")
     .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Frequency");

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", line);

});