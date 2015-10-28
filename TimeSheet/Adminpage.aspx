<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Adminpage.aspx.cs" Inherits="TimeSheet.Adminpage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
  <title>jQuery UI Datepicker - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css"/>
  <script>
   
    $(function () {
        $("#employee").selectmenu().selectmenu("menuWidget").addClass("overflow");
        $("#project").selectmenu().selectmenu("menuWidget").addClass("overflow");;      
    });
    $(function () {
        $("#from").datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 1,
            onClose: function (selectedDate) {
                $("#to").datepicker("option", "minDate", selectedDate);
            }
        });
        $("#to").datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 1,
            onClose: function (selectedDate) {
                $("#from").datepicker("option", "maxDate", selectedDate);
            }
        });
    });

  </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
   
        <p> 

            <label for="from">Start Date</label>
            <input type="text" id="from" name="from"/>
            <label for="to">End Date</label>
            <input type="text" id="to" name="to"/>
            
            <label for="employee" class="col-lg-2 control-label"> Select an employee</label>
            <select name="employee" id="employee" class ="dropdown-menu">
                <option>Slower</option>
                <option>Slow</option>
                <option selected="selected">Medium</option>
                <option>Fast</option>
                <option>Faster</option>
            </select>
            <label for="project" class="col-lg-2 control-label">Select a project</label>
            <select name="project" id="project" class ="dropdown-menu">
                <option>Slower</option>
                <option>Slow</option>
                <option selected="selected">Medium</option>
                <option>Fast</option>
                <option>Faster</option>
            </select>
        </p>
        <button>Submit</button>
             
</asp:Content>
