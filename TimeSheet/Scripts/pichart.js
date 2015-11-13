d3.json("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/freq.json", function(error, json) {
    if (error) throw error;
    //console.log(json);
    //json = json;
    json.forEach(function(d){
       d.Freq=parseInt(d.Freq);
       d.Updated=new Date(d.Updated);

    });
json=d3.nest().key(function(d){return d.Assignee;})
                         .rollup(function(v){return d3.sum(v, function(d){return d.Freq;});})
                        .entries(json);

    json.forEach(function(d){
         d.enabled = true;
              });


    var width = 360;
    var height = 360;
    var radius = Math.min(width, height) / 2;
    var legendwidth = width + 400;

    var color = d3.scale.category20b();
    var legendRectSize = 18;
    var legendSpacing = 4;


    var svg = d3.select('#pichart')
      .append('svg')
      .attr('width', legendwidth)
      .attr('height', height)
      .append('g')
      .attr('transform', 'translate(' + (width / 2) +  ',' + (height / 2) + ')');

    var arc = d3.svg.arc()
      .outerRadius(radius);
    //expecting json object , looking for key and value
    //look for SINGLE RETURN TYPE
    //calls anon function with a reference to "d"
    //d refers to EACH element in array
    //d.values is then EACH ELEMENT "." the item we want
    //json[0].values
//    console.log(json);


    var pie = d3.layout.pie()
      .value(function(d) { return d.values; })
      .sort(null);

//    console.log(pie(json));
    

    var tooltip = d3.select('#pichart')
          .append('div')
          .attr('class', 'tooltip');

        tooltip.append('div')
          .attr('class', 'label');

        tooltip.append('div')
          .attr('class', 'count');

        tooltip.append('div')
          .attr('class', 'percent');


    var path = svg.selectAll('path')
      .data(pie(json))
      .enter()
      .append('path')
      .attr('d', arc)
      .attr('fill', function(d, i) {
//      console.log(color(d.data.values));
        return color(d.data.key);
      })
     .each(function(d) { this._current = d; }); // NEW
    /*
         path.append("text")
          .attr("transform", function(d) {  return "translate(" + arc.centroid(d.data.values) + ")"; })
          .attr("dy", ".35em")
          .style("text-anchor", "middle")
          .text(function(d) { return d.data.key; });
    */

    path.on('mouseover', function(d) {
      var total = d3.sum(json.map(function(d) {
        return (d.enabled) ? d.values : 0;        // UPDATED
      }));
//            console.log(total);
            var percent = Math.round(1000 * d.data.values / total) / 10;
            tooltip.select('.label').html(d.data.key);
            tooltip.select('.count').html(d.data.values);
            tooltip.select('.percent').html(percent + '%');
            tooltip.style('display', 'block');
    });
             path.on('mouseout', function() {
            tooltip.style('display', 'none');
          });


    var legend = svg.selectAll('.legend')
      .data(color.domain())
      .enter()
      .append('g')
      .attr('class', 'legend')
      .attr('transform', function(d, i) {
        var height = legendRectSize + legendSpacing;
        var offset =  height * color.domain().length / 2;
        var horz = width;
        var vert = i * height - offset;
        return 'translate(' + horz + ',' + vert + ')';
      });
    legend.append('rect')
      .attr('width', legendRectSize)
      .attr('height', legendRectSize)
      .style('fill', color)
      .style('stroke', color)
      .on('click', function(label) {                            // NEW

              var rect = d3.select(this);                             // NEW
              var enabled = true;                                     // NEW
              var totalEnabled = d3.sum(json.map(function(d) {     // NEW

                return (d.enabled) ? 1 : 0;                           // NEW
              }));                                                    // NEW
              //console.log(totalEnabled);
//                console.log(rect.attr('class'));
              if (rect.attr('class') === 'disabled') {                // NEW
                rect.attr('class', '');                               // NEW
              } else {                                                // NEW
                  if (totalEnabled < 2){ return;}                         // NEW
                rect.attr('class', 'disabled');                       // NEW
                enabled = false;                                      // NEW
              }                                                       // NEW

              pie.value(function(d) {                                  // NEW
                if (d.key === label) d.enabled = enabled;               // NEW
                return (d.enabled) ? d.values : 0;                     // NEW
              });                                                     // NEW

              path = path.data(pie(json));                            // NEW
           //     console.log(path);
              path.transition()                                       // NEW
                .duration(750)                                        // NEW
                .attrTween('d', function(d) {                         // NEW
                  var interpolate = d3.interpolate(this._current, d); // NEW
                  this._current = interpolate(0);                     // NEW
                  return function(t) {                                // NEW
                    return arc(interpolate(t));                       // NEW
                  };                                                  // NEW
                });                                                   // NEW
            });                                                       // NEW


    legend.append('text')
      .attr('x', legendRectSize + legendSpacing)
      .attr('y', legendRectSize - legendSpacing)
      .text(function(d) { return d; });

});
