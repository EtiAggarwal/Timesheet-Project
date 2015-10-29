<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHomePage.aspx.cs" Inherits="TimeSheet.AdminHomePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin Home Page</title>
    <link href="Content/datepicker.css" rel="stylesheet" />
        <script type="text/javascript" src="Scripts/bootstrap-datepicker.js"></script>
  <script>
      $(function () {
          var nowTemp = new Date();
          var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

          var checkin = $('#tbStartDate').datepicker().on('changeDate', function (ev) {
              if (ev.date.valueOf() > checkout.date.valueOf()) {
                  var newDate = new Date(ev.date)
                  newDate.setDate(newDate.getDate());
                  checkout.setValue(newDate);
                 
              }
              checkin.hide();
              checkout.update();
              $('#tbEndDate')[0].focus();
          }).data('datepicker');
          var checkout = $('#tbEndDate').datepicker({
              onRender: function (date) {
                  if ($('#tbStartDate').val().length > 0)
                      return date.valueOf() < new Date($('#tbStartDate').val()) ? 'disabled' : '';
                  else
                      return '';
              }
          }).on('changeDate', function (ev) {
              checkout.hide();
              
             
          }).data('datepicker');
      
      });
  </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title">Search Timesheets</h3>
  </div>
  <div class="panel-body">
   <table width="60%">
       <tr>
           <td> Start Date</td>
           <td><asp:TextBox ID="tbStartDate" runat="server" ClientIDMode="Static"></asp:TextBox></td>
           <td>End Date</td>
           <td>  <asp:TextBox ID="tbEndDate" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
       </tr>
       <tr>
           <td>
             Select an employee
           </td>
           <td>
           <asp:DropDownList ID="ddlEmployees" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
              
           </td>

       </tr>
       <tr>
           <td>  Select a project
            </td>
           <td>
               <asp:DropDownList ID="ddlProjects" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
              
           </td>
       </tr>
       <tr>
           <td>
               <asp:Button ID="btSubmit" runat="server" Text="Button" OnClick="btSubmit_Click" /></td>
       </tr>
   </table>
  </div>
</div>
       
        
</asp:Content>
