<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="TimeSheet.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    
    </div>
    <div>
        <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
        <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
    </div>
        <div id="remotecsv" style="min-width: 800px; height: 300px; margin: 0 auto"></div>
                            <script type="text/javascript" src="Scripts/readremotecsv.js"></script>
    </form>
</body>
</html>
