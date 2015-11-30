//for now d3.json does a get request to get the contents of the file and stores it in a local javascript file called json
//d3.json("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/Hours.json", function(error, json) {
(function (d3) {
  //if (error) throw error;
    //console.log(json);
    //json = json;
    //need to clean/ conver the data so it is recognized in js
    json = JSON.parse($('#hdnData').val());
    json.forEach(function(d){
        d.Hours = d["HOURS_PER_DAY"];
        //console.log(d["HOURS_PER_DAY"]); 
        d.Begin = new Date(d.ENTRY_ADD_DATE);
        //console.log(d.EMPLOYEE_ID);
        d.End = new Date(d.Begin);

    });
//this function converts the large table to something we are looking for, project vs time
json=d3.nest().key(function(d){return d.EMPLOYEE_ID;})
                         .rollup(function(v){return d3.sum(v, function(d){return d.Hours;});})
                        .entries(json);


  //this is used for later with the tooltip function
    json.forEach(function(d){
         d.enabled = true;
    });

  //these are static variables that define the frame size of the svg
    var width = 360;
    var height = 360;
    var radius = Math.min(width, height) / 2;
    var legendwidth = width + 400;

    var color = d3.scale.category20b();
  //these are for the legend aka the key
    var legendRectSize = 18;
    var legendSpacing = 4;

//this alerts to create the svg in the div called id='pichart'

    var svg = d3.select('#pichart')
      .append('svg')
      .attr('width', legendwidth)
      .attr('height', height)
      .append('g')
      .attr('transform', 'translate(' + (width / 2) +  ',' + (height / 2) + ')');

//can make this a donut chart, but pi chart looks better?
    var arc = d3.svg.arc()
      .outerRadius(radius);

  //expecting json object , looking for key and value
  //look for SINGLE RETURN TYPE
  //calls anon function with a reference to "d"
  //d refers to EACH element in array
  //d.values is then EACH ELEMENT "." the item we want


//there is a separate object that converts items into vectors of the pie
    var pie = d3.layout.pie()
      .value(function(d) { return d.values; })
      .sort(null);

//    console.log(pie(json)); //making sure it gets initialized

//the tooltip is just a pop up for when you are hovering over the item, note that you will need some css for it to show up
    var tooltip = d3.select('#pichart')
          .append('div')
          .attr('class', 'tooltip');

        tooltip.append('div')
          .attr('class', 'label');

        tooltip.append('div')
          .attr('class', 'count');

        tooltip.append('div')
          .attr('class', 'percent');

//this is the one that actually creates the pi chart
    var path = svg.selectAll('path')
      .data(pie(json))
      .enter()        // this goes one level deep for the data, it's a bit weird.
      .append('path')
      .attr('d', arc)
      .attr('fill', function(d, i) {
//      console.log(color(d.data.values));
        return color(d.data.key);
      })
     .each(function(d) { this._current = d; }); // NEW

//this one this one displays the tooltip based on the enabled items
    path.on('mouseover', function(d) {
      var total = d3.sum(json.map(function(d) {
        return (d.enabled) ? d.values : 0;        // Begin
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

//this creates the key at to the right of the chart
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
  //this part adds the functionality of the legend to change what goes on in the Pi chart
    legend.append('rect')
      .attr('width', legendRectSize)
      .attr('height', legendRectSize)
      .style('fill', color)
      .style('stroke', color)
    //based on which item is the clicked, make a change
      .on('click', function(label) {

              var rect = d3.select(this);
              var enabled = true;
              var totalEnabled = d3.sum(json.map(function(d) {

                return (d.enabled) ? 1 : 0;
              }));
              //console.log(totalEnabled); //just debugging to find out if the javascript can detect all the selected items
              //console.log(rect.attr('class')); //just debugging to see the state of the clicked item
              if (rect.attr('class') === 'disabled') {
                rect.attr('class', '');
              } else {
                  if (totalEnabled < 2){ return;}
                rect.attr('class', 'disabled');
                enabled = false;    //make sure to change item to unclicked afterwards
              }

              pie.value(function(d) {
                if (d.key === label) d.enabled = enabled;
                return (d.enabled) ? d.values : 0;
              });

              path = path.data(pie(json));
             //console.log(path); //just seeing the vector values, had an error
              path.transition()
                .duration(750)
                .attrTween('d', function(d) {
                  var interpolate = d3.interpolate(this._current, d);
                  this._current = interpolate(0);
                  return function(t) {
                    return arc(interpolate(t));
                  };
                });
            });

//adds the words of the thing
    legend.append('text')
      .attr('x', legendRectSize + legendSpacing)
      .attr('y', legendRectSize - legendSpacing)
      .text(function(d) { return d; });

})(window.d3);
