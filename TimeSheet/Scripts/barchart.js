d3.json("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/freq.json", function(error, json) {
json.forEach(function(d){

					d.Freq=parseInt(d.Freq);
					d.Updated=new Date(d.Updated);

				});
				json=d3.nest().key(function(d){return d.Assignee;})
				.rollup(function(v){return d3.sum(v, function(d){return d.Freq;});})
				.entries(json);
				/* console.log(json);
				*/
				json.forEach(function(d){
					d.enabled = true;
				});
				var margin = {top: 20, right: 100, bottom: 100, left: 40},
				width = 760 - margin.left - margin.right,
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
				var tooltip = d3.select("body")
				.append('div')
				.attr('class', 'tooltip')
				.style("opacity",0.0);


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
				.attr("transform", "rotate(-65)" );


				chart.append("g")
				.attr("class", "y axis")
				.call(yAxis)
				.append("text")
				.attr("transform", "rotate(-45)")
				.attr("y", 6)
				.attr("dy", ".71em")
				.style("text-anchor", "end")
				.text("Frequency");

			/*	console.log(json);
			*/	chart.selectAll("bar")
				.data(json)
				.enter().append("rect")
				.attr("class", "bar")
				.attr("id",function(d,i){return "rect"+i.toString();})
				.attr("x", function(d) { return x(d.key); })
				.attr("y", function(d) { return y(d.values); })
				.attr("height", function(d) { return height - y(d.values); })
				.attr('fill', function(d, i) {
					return color(d.key);
				})
				.attr("width", x.rangeBand())
				.each(function(d) { this._current = d; }) // NEW
				.on('mouseover', function(d) {
					d3.select(this)
					.transition()
					.duration(500)
					.attr("fill","red");
					var total = d3.sum(json.map(function(d) {
						return (d.enabled) ? d.values : 0; // UPDATED
					}));
					var percent = Math.round(1000 * d.values / total) / 10;
					tooltip.html(d.key +"<br />"+d.values+"<br />"+percent+"%")
					.style("left",(d3.event.pageX)+"px")
					.style("top",(d3.event.pageY)+"px")
					.style("opacity",1.0);

				})
				.on("mousemove",function(){
					tooltip.style("left",(d3.event.pageX)+"px")
					.style("top",(d3.event.pageY)+"px");
				})
				.on('mouseout', function(d) {
					d3.select(this)
					.transition()
					.duration(500)
					.attr("fill",color(d.key));
					// tooltip.style('display', 'none');
					tooltip.style("opacity",0.0);
				});





				var legend = chart.selectAll('.legend')
				.data(json)
				.enter()
				.append('g')
				.attr('class', 'legend')
				.attr('transform', function(d, i) {
					var height = legendRectSize + legendSpacing;
					var offset = height * color.domain().length / 2;
					var horz = width;
					var vert = 200+(i * height - offset);
					return 'translate(' + horz + ',' + vert + ')';
				});
				legend.append('rect')
				.attr('width', legendRectSize)
				.attr('height', legendRectSize)
				.style('fill', function(d, i) {
					return color(d.key);
				})
				.style('stroke', function(d, i) {
					return color(d.key);
				})
				.on("mouseover",function(d,i){
					if(d.enabled == true){
						 var rectid = "#rect" + i.toString();
				                d3.select(rectid)
						.transition()
						.duration(500)
						.attr("fill","red");
						var total = d3.sum(json.map(function(d) {
							return (d.enabled) ? d.values : 0; // UPDATED
						}));
						var percent = Math.round(1000 * d.values / total) / 10;
						tooltip.html(d.key +"<br />"+d.values+"<br />"+percent+"%")
						.style("left",(d3.event.pageX)+"px")
						.style("top",(d3.event.pageY)+"px")
						.style("opacity",1.0);
				}})
				.on("mousemove",function(d,i){
					if(d.enabled == true){
						tooltip.style("left",(d3.event.pageX)+"px")
						.style("top",(d3.event.pageY)+"px");
					}
				})
				.on("mouseout",function(d,i){
					if(d.enabled==true){
						var rectid="#rect"+i.toString();
						d3.select(rectid)
						.transition()
						.duration(500)
						.attr("fill",color(d.key));
						// tooltip.style('display', 'none');
						tooltip.style("opacity",0.0);}})
				//NING PUT ANIMATION IN .ONCLICK FUNCTION
				// on legend, the corresponding one disappear and the bars should be shifted
				//

				.on('click', function(label) {
					// save the original number of bars in tatolEnabled0
					var totalEnabled0 = d3.sum(json.map(function(d) {
						return (d.enabled) ? 1 : 0;
					}));
			/*		console.log(totalEnabled0);*/
					/* change the enabled status false->true, true->false*/
					label.enabled = !label.enabled;
					if(label.enabled == true){

						var total = d3.sum(json.map(function(d) {
							return (d.enabled) ? d.values : 0; // UPDATED
						}));
						var percent = Math.round(1000 * label.values /( total)) / 10;
						tooltip.html(label.key +"<br />"+label.values+"<br />"+percent+"%")
						.style("left",(d3.event.pageX)+"px")
						.style("top",(d3.event.pageY)+"px")
						.style("opacity",1.0);
					}
					else{
						tooltip.style("opacity",0.0);
					}
			/*		console.log(label);1 */
					for(var i=0;i<json.length;i++){
						if(json[i].key == label.key){
							json[i].enabled = label.enabled;
						}
					}
					var rect = d3.select(this);
					var enabled = true;
					// save the new number of bars in totalEnabled1
					var totalEnabled1 = d3.sum(json.map(function(d) {
						return (d.enabled) ? 1 : 0;
					}));

					if (rect.attr('class') === 'disabled') {
						rect.attr('class', '');
						} else {
						if (totalEnabled1 < 2){ return;}
						rect.attr('class', 'disabled');
						enabled = false;
					}

					var newjson = [];
					j = 0;
					for(var i=0;i<json.length;i++){
						if(json[i].enabled == true){
							newjson[j]=json[i];
							j=j+1;
						}
					}

					x.domain(newjson.map(function(d) { return d.key; }));
					y.domain([0, d3.max(newjson, function(d) { return d.values; })]);

					// Hide or show the elements based on the ID
					// update x axis and y axis
					chart.select('.x.axis').transition().duration(300).call(xAxis)
					.selectAll("text")
					.style("text-anchor", "end")
					.attr("dx", "-.8em")
					.attr("dy", ".15em")
					.attr("transform", "rotate(-65)" );
					chart.select(".y.axis").transition().duration(300).call(yAxis);
					//update bars
					//erease the bars first(fake operation, just make y=0)
					chart.selectAll(".bar").transition()
					.duration(300)
					.attr("y",height)
					.attr("height",0);
					// draw new bars
					chart.selectAll(".bar").transition()
					.duration(300)
					.attr("x", function(d) {if(d.enabled==true){ return x(d.key);}})
					.attr("y", function(d) { if(d.enabled==true){return y(d.values);} })
					.attr("height", function(d) {if(d.enabled==true){ return height - y(d.values);} })
					.attr('fill', function(d, i) {
						if(label.key==d.key){return "red";}
						else{
							return color(d.key);}
					})
					.attr("width", x.rangeBand())
					.each(function(d) { this._current = d; });
				    	// NEW
/*					if(label.enabled==true){
						var rectid ;
						for(var i=0;i<json.length;i++){
							if(label.key == json[i].key){
								rectid="#rect"+i.toString();break;}
						}
						d3.select(rectid)
						.transition()
						.duration(500)
						.attr("fill",color(d.key));
*/

				}); //END OF ONCLICK


				legend.append('text')
				.attr('x', legendRectSize + legendSpacing)
				.attr('y', legendRectSize - legendSpacing)
				.text(function(d) { return d.key; });

			});

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

