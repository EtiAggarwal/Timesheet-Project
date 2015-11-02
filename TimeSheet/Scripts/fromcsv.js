
var margin = {top: 20, right: 80, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var parseDate = d3.time.format("%m/%d/%y").parse;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.category10();

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.line()
    .interpolate("basis")
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.commits); });

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.csv("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/horribleTable.csv", function(error, data) {
  if (error) throw error;
   // console.log(parseDate(data[0].Date));

  color.domain(d3.keys(data[0]).filter(function(key) { return key !== "Date"; }));

  data.forEach(function(d) {
    d.date = parseDate(d.Date);
  });
data.sort(function(a, b){
 var dateA=a.date, dateB=b.date
 return dateA-dateB //sort by date ascending
})

//data=data.sort()
console.log(data[0])
  var cities = color.domain().map(function(name) {
    return {
      name: name,
      values: data.map(function(d) {
        return {date: d.date, commits: +d[name]};
      })
    };
  });

  x.domain(d3.extent(data, function(d) {
//      console.log(d.date);
      return d.date; }));

  y.domain([
    d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.commits; }); }),
    d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.commits; }); })
  ]);
//console.log(data.reduce(add,0));
/*Object.keys(cities).reduce(function (previous, key) {
    return previous + cities[key].commits;
}, {commits: 0});*/
   // console.log( d3.sum(cities, function(c) { return d3.sum(c.values, function(v){c.commits })}));
     console.log(d3.entries(cities));

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
      .text("commits");

  var city = svg.selectAll(".city")
      .data(cities)
      .enter().append("g")
      .attr("class", "city");

  city.append("path")
      .attr("class", "line")
      .attr("d", function(d) { return line(d.values); })
      .style("stroke", function(d) { return color(d.name); });
//console.log(city[0][0].d);
  city.append("text")
      .datum(function(d) { return {name: d.name, value: d.value}; })
      .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.commits) + ")"; })
      .attr("x", 3)
      .attr("dy", ".35em")
      .text(function(d) { return d.name; });
});
