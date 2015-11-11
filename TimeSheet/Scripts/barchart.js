

d3.json("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/freq.json", function(error, json) {

json.forEach(function(d){
       d.Freq=parseInt(d.Freq);
       d.Updated=new Date(d.Updated);

    });
  //  console.log(json);
    json=d3.nest().key(function(d){return d.Assignee;})
                         .rollup(function(v){return d3.sum(v, function(d){return d.Freq;});})
                        .entries(json);
//    console.log(json);

    json.forEach(function(d){
         d.enabled = true;
              });
var margin = {top: 50, right: 80, bottom: 130, left: 40},
    width = 800 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

var y = d3.scale.linear()
    .range([height, 0]);

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");


var chart = d3.select("#chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var color = d3.scale.category20b();
    var legendwidth = width + 400;

    var legendRectSize = 18;
    var legendSpacing = 4;
    var tooltip = d3.select('#ctooltip')
          .append('div')
          .attr('class', 'tooltip');

        tooltip.append('div')
          .attr('class', 'label');

        tooltip.append('div')
          .attr('class', 'count');

        tooltip.append('div')
          .attr('class', 'percent');




    x.domain(json.map(function(d) { return d.key; }));
    y.domain([0, d3.max(json, function(d) { return d.values; })]);

chart.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)
        .selectAll("text")
            .style("text-anchor", "end")
            .attr("dx", "-.8em")
            .attr("dy", ".15em")
            .attr("transform", "rotate(-65)");

  chart.append("g")
      .attr("class", "y axis")
      .call(yAxis)
  .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Frequency");


  chart.selectAll("bar")
      .data(json)
      .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.key); })
      .attr("y", function(d) { return y(d.values); })
      .attr("height", function(d) { return height - y(d.values); })
      .attr('fill', function(d, i) {
//      console.log(color(d.data.values));
        return color(d.key);
      })
      .attr("width", x.rangeBand())
      .each(function(d) { this._current = d; }) // NEW
      .on('mouseover', function(d) {
      var total = d3.sum(json.map(function(d) {
        return (d.enabled) ? d.values : 0;        // UPDATED
      }));

            //console.log(d.key);
            var percent = Math.round(1000 * d.values / total) / 10;
            tooltip.select('.label').html(d.key);
            tooltip.select('.count').html(d.values);
            tooltip.select('.percent').html(percent + '%');
            tooltip.style('display', 'block');
//           d3.select(this).attr('fill', 'grey');

    })
      .on('mouseout', function() {
            tooltip.style('display', 'none');
          });



   var legend = chart.selectAll('.legend')
      .data(json)
      .enter()
      .append('g')
      .attr('class', 'legend')
      .attr('transform', function(d, i) {
        var height = legendRectSize + legendSpacing;
        var offset =  height * color.domain().length / 2;
        var horz = width;
        var vert = 200+(i * height - offset);
        return 'translate(' + horz + ',' + vert + ')';
      });
    legend.append('rect')
      .attr('width', legendRectSize)
      .attr('height', legendRectSize)
      .style('fill', function(d, i) {
//      console.log(color(d.data.values));
        return color(d.key);
      })
      .style('stroke', function(d, i) {
//      console.log(color(d.data.values));
        return color(d.key);
      })
      .on('click', function(label) {                            // NEW

              var rect = d3.select(this);                             // NEW
              var enabled = true;                                     // NEW
              var totalEnabled = d3.sum(json.map(function(d) {     // NEW
//                console.log(d);
                return (d.enabled) ? 1 : 0;                           // NEW
              }));                                                    // NEW
              //console.log(totalEnabled);
                  //      console.log(rect.attr('class'));
              if (rect.attr('class') === 'disabled') {                // NEW
                rect.attr('class', '');                               // NEW
              } else {                                                // NEW
                  if (totalEnabled < 2){ return;}                     // NEW
                rect.attr('class', 'disabled');                       // NEW
                enabled = false;                                      // NEW
              }                                                       // NEW
    json.forEach(function(d){
        //console.log(d.key);
//        console.log(label.key);
        if (d.key === label.key){ d.enabled = enabled; }               // NEW
                return (d.enabled) ? d.values : 0;
    });
                //newOpacity = enabled ? 0 : 1;
                  //chart = chart.data(json);
                  chart.data(json).transition()
                    .duration(750)
                    .attrTween('d', function(d) {
                        x.domain(json.map(function(d) { if(d.enabled== true ){return d.key;} }));
                      console.log(x.domain());
                    });
                // Hide or show the elements based on the ID
            });


    legend.append('text')
      .attr('x', legendRectSize + legendSpacing)
      .attr('y', legendRectSize - legendSpacing)
      .text(function(d) { return d.key; });

});