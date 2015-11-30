/*fetch json text from server*/

(function (d3) {
  
//d3.json("https://raw.githubusercontent.com/EtiAggarwal/Timesheet-Project/master/suggestedGraphTypes/Hours.json", function (error, json) {
//d3.json( $('#hdnData').val() , function (error, json) {
    /*convert json text to javascript objects*/
    
    json = JSON.parse($('#hdnData').val());
   
    if (json.length == 0) {
        $("#NoDataLb").html("No Timesheet Records to display");
        
        return;
    }
    
    //json = $('#hdnData').val();
    console.log(json);
    json.forEach(function (d) {
        d.Hours = d["HOURS_PER_DAY"];
        //console.log(d["HOURS_PER_DAY"]); 
        d.Begin = new Date(d.ENTRY_ADD_DATE);
        //console.log(d.EMPLOYEE_ID);
        d.End = new Date(d.Begin);

    });
    //console.log(json);
    //console.log(d3.nest().key(function (d) { return d.EMPLOYEE_ID; }).entries(json));
    json=d3.nest()
        .key(function (d) { return d.PROJECT_NAME; })
        .rollup(function (v) { return d3.sum(v, function (d) { return d.Hours; }); })
        .entries(json);
    console.log(json);
    /*add enable tag to json objects*/
    json.forEach(function (d) {
        d.enabled = true;
    });
    /*svg region*/
    var margin = { top: 20, right: 100, bottom: 100, left: 40 },
    width = 760 - margin.left - margin.right,
    height = 300 - margin.top - margin.bottom;
    /*y axis range*/
    var y = d3.scale.linear()
    .range([height, 0]);
    /*x axis range*/
    var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);
    /*x axis*/
    var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");
    /*y axis*/
    var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

    /*declare bar chart variable*/
    var chart = d3.select("#chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    /*all the colors we can use in this bar chart*/
    var color = d3.scale.category20b();
    /*properties of legend*/
    var legendwidth = width + 400;
    var legendRectSize = 18;
    var legendSpacing = 4;
    /*tooltip variable for displaying information, totally opaque intially*/
    var tooltip = d3.select("body")
    .append('div')
    .attr('class', 'tooltip')
    .style("opacity", 0.0);
    
    /*x domain contains all the names of collected empolyees*/
    x.domain(json.map(function (d) { return d.key; }));
    /*y domain contains all the correspoind working-hours*/
    y.domain([0, d3.max(json, function (d) { return d.values; })]);
    /*append x axis*/
    chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-.8em")
    .attr("dy", ".15em")
    .attr("transform", "rotate(-45)");
    /*append y axis*/
    chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", "-3em")
   .style("text-anchor", "end")
    .text("total hours");
    /*display all the bars*/
    chart.selectAll("bar")
    .data(json)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("id", function (d, i) { return "rect" + i.toString(); })
    .attr("x", function (d) { return x(d.key); })
    .attr("y", function (d) { return 0; })
//	.attr("y", function(d) { return y(d.values); })
    //.attr("height", function(d) { return height - y(d.values); })
    .attr("height", function (d) { return 0; })
    .attr('fill', function (d, i) {
        return color(d.key);
    })
    .attr("width", x.rangeBand())
    .each(function (d) { this._current = d; })
        /*when mouse is over one bar, hightlight the bar(red color)and display information*/
    .on('mouseover', function (d) {

        d3.select(this)
        .transition()
        .duration(500)
        .attr("fill", "red");
        var total = d3.sum(json.map(function (d) {
            return (d.enabled) ? d.values : 0;
        }));
        var percent = Math.round(1000 * d.values / total) / 10;
        tooltip.html(d.key + "<br />" + d.values + "<br />" + percent + "%")
        .style("left", (d3.event.pageX) + "px")
        .style("top", (d3.event.pageY) + "px")
        .style("opacity", 1.0);

    })
    /*when mouse is out of a bar, no hightlight, no display*/
    .on('mouseout', function (d) {
        d3.select(this)
        .transition()
        .duration(500)
        .attr("fill", color(d.key));
        tooltip.style("opacity", 0.0);
    })
    .transition()
    .delay(function (d, i) { return i * 100 })
    .duration(1000)
    .ease("bounce")
    .attr("y", function (d) { return y(d.values); })
    .attr("height", function (d) { return height - y(d.values); });
    /*legends part*/
    var legend = chart.selectAll('.legend')
    .data(json)
    .enter()
    .append('g')
    .attr('class', 'legend')
    /*top-left position for each legend*/
    .attr('transform', function (d, i) {
        var height = legendRectSize + legendSpacing;
        var offset = height * color.domain().length / 2;
        var horz = width;
        var vert = 200 + (i * height - offset);
        return 'translate(' + horz + ',' + vert + ')';
    });
    /*show one legend*/
    legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', function (d, i) {
        return color(d.key);
    })
    .style('stroke', function (d, i) {
        return color(d.key);
    })
    /*when mouse is over one legend, highlight the correspoding bar and display information*/
    .on("mouseover", function (d, i) {
        if (d.enabled == true) {
            var rectid = "#rect" + i.toString();
            d3.select(rectid)
    .transition()
    .duration(500)
    .attr("fill", "red");
            var total = d3.sum(json.map(function (d) {
                return (d.enabled) ? d.values : 0; // UPDATED
            }));
            var percent = Math.round(1000 * d.values / total) / 10;
            tooltip.html(d.key + "<br />" + d.values + "<br />" + percent + "%")
            .style("left", (d3.event.pageX) + "px")
            .style("top", (d3.event.pageY) + "px")
            .style("opacity", 1.0);
        }
    })
    /*when mouse is outside one legend, no highlight, no information*/
    .on("mouseout", function (d, i) {
        if (d.enabled == true) {
            var rectid = "#rect" + i.toString();
            d3.select(rectid)
            .transition()
            .duration(500)
            .attr("fill", color(d.key));
            // tooltip.style('display', 'none');
            tooltip.style("opacity", 0.0);
        }
    })
    //NING PUT ANIMATION IN .ONCLICK FUNCTION
    // on legend, the corresponding one disappear and the bars should be shifted
    .on('click', function (label) {
        var totalEnabled0 = d3.sum(json.map(function (d) {
            return (d.enabled) ? 1 : 0;
        }));
        /*change the enabled property, true->false, false->true*/
        label.enabled = !label.enabled;
        /*when we need to show the bar for this employee, show it*/
        if (label.enabled == true) {
            var total = d3.sum(json.map(function (d) {
                return (d.enabled) ? d.values : 0;
            }));
            var percent = Math.round(1000 * label.values / (total)) / 10;
            tooltip.html(label.key + "<br />" + label.values + "<br />" + percent + "%")
            .style("left", (d3.event.pageX) + "px")
            .style("top", (d3.event.pageY) + "px")
            .style("opacity", 1.0);
        }
            /*otherwise, don't show it*/
        else {
            tooltip.style("opacity", 0.0);
        }
        for (var i = 0; i < json.length; i++) {
            if (json[i].key == label.key) {
                json[i].enabled = label.enabled;
            }
        }
        delRow(1);
        var rect = d3.select(this);
        var enabled = true;
        var totalEnabled1 = d3.sum(json.map(function (d) {
            return (d.enabled) ? 1 : 0;
        }));

        if (rect.attr('class') === 'disabled') {
            rect.attr('class', '');
        } else {
            if (totalEnabled1 < 2) { return; }
            rect.attr('class', 'disabled');
            enabled = false;
        }
        /*create a new object array that contains all the employees to be shown*/
        var newjson = [];
        j = 0;
        for (var i = 0; i < json.length; i++) {
            if (json[i].enabled == true) {
                newjson[j] = json[i];
                j = j + 1;
            }
        }
        /*update table NingZhang 11.23.2015*/
        var tbl = document.getElementById("table");
        if (tbl) { tbl.parentNode.removeChild(tbl); }
        createTable(newjson);
        /*new domains for x axis and y axis*/
        x.domain(newjson.map(function (d) { return d.key; }));
        y.domain([0, d3.max(newjson, function (d) { return d.values; })]);

        /* Hide or show the elements based on the ID*/
        /*update x axis and y axis*/
        chart.select('.x.axis').transition().duration(300).call(xAxis)
        .selectAll("text")
        .style("text-anchor", "end")
        .attr("dx", "-.8em")
        .attr("dy", ".15em")
        .attr("transform", "rotate(-65)");
        chart.select(".y.axis").transition().duration(300).call(yAxis);
        /*update bars*/
        /*erase the bars firstly(just make their heights be 0)*/
        chart.selectAll(".bar").transition()
        .duration(300)
        .attr("y", height)
        .attr("height", 0);
        /*draw new bars if employee is enabled*/
        chart.selectAll(".bar").transition()
        .duration(300)
        .attr("x", function (d) { if (d.enabled == true) { return x(d.key); } })
        .attr("y", function (d) { if (d.enabled == true) { return y(d.values); } })
        .attr("height", function (d) { if (d.enabled == true) { return height - y(d.values); } })
        .attr('fill', function (d, i) {
            if (label.key == d.key) { return "red"; }
            else {
                return color(d.key);
            }
        })
        .attr("width", x.rangeBand())
        .each(function (d) { this._current = d; });
    }); /*end of legend onclick*/
    /*show employee names*/
    legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .text(function (d) { return d.key; });
    /*NingZhang 11.23.2015*/
    /*find row and column numbers*/
    var row = 2;
    var cols = json.length;
    /*create table*/
    createTable(json);
    /*functions for table operations*/
    var tableNode;
    function createTable(newjson) {
        /*get table element*/
        tableNode = document.createElement("table");
        tableNode.setAttribute("id", "table");
        var row = 2;
        var cols = newjson.length;;

        if (row <= 0 || isNaN(row)) {
            alert("wrong row number!");
            return;
        }
        if (isNaN(cols) || cols <= 0) {
            alert("wrong column number!");
            return;
        }
        /*based on right column and row numbers, start creating table*/
        for (var x = 0; x < row; x++) {
            var trNode = tableNode.insertRow();
            for (var y = 0; y < cols; y++) {
                var tdNode = trNode.insertCell();
                if (x == 0) { tdNode.innerHTML = newjson[y].key; }
                if (x == 1) { tdNode.innerHTML = newjson[y].values; }
            }
        }
        /*add table*/
        document.getElementById("div1").appendChild(tableNode);
    }
    function delRow(rows) {
        /*delete a row by row number and table id*/
        /*get table element*/
        var tab = document.getElementById("table");
        if (tab == null) {
            alert("Table doesn't exist!")
            return;
        }
        if (isNaN(rows)) {
            alert("wrong row to delete!");
            return;
        }
        if (rows >= 1 && rows <= tab.rows.length) {
            tab.deleteRow(rows - 1);
        } else {
            alert("row doesn't exist!");
            return;
        }
    }
    //not easy to delete a column, need to delete it by rows 
    // the length of cells in a row is the number of columns 
    //tab.rows[x].deleteCell(cols-1) 
    function delCols() {
        //get table element 
        var tab = document.getElementById("table");
        if (tab == null) {
            alert("Table doesn't exist!");
            return;
        }
        //check column number 
        if (isNaN(cols)) {
            alert("wrong column number!");
            return;
        }
        if (!(cols >= 1 && cols < tab.rows[0].cells.length)) {
            alert("column doesn't exist!");
            return;
        }
        for (var x = 0; x < tab.rows.length; x++) {//all the rows 
            tab.rows[x].deleteCell(cols - 1);
        }
    }
})(window.d3);
