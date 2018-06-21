<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingManagement.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.BookingManagement"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking Management</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Booking management</h3>
    </div>
    <div class="form-group">
        <div class="row">
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <table class="table table-bordered table-hover table-common">
                <tr class="active">
                    <th rowspan="2">Code
                    </th>
                    <th rowspan="2">Agency
                    </th>
                    <th rowspan="2">Date
                    </th>
                    <th rowspan="2">Time
                    </th>
                    <th colspan="3">Number of pax
                    </th>
                    <th rowspan="2">Menu
                    </th>
                    <th rowspan="2">Special request
                    </th>
                    <th rowspan="2">Total Price
                    </th>
                    <th rowspan="2">Payment
                    </th>
                </tr>
                <tr class="active">
                    <th>Adult
                    </th>
                    <th>Child
                    </th>
                    <th>Baby
                    </th>
                </tr>
                <asp:Repeater runat="server" ID="rptBooking">
                    <ItemTemplate>
                        <tr>
                            <td><a href="BookingViewing.aspx?NodeId=1&SectionId=15&bi=<%# Eval("Id")%>"><%# Eval("Code")%></td>
                            <td><a href="AgencyView.aspx?NodeId=1&SectionId=15&ai=<%# Eval("Agency.Id")%>"><%# Eval("Agency.Name")%></a></td>
                            <td><%# Eval("Date","{0:dd/MM/yyyy}")%></td>
                            <td><%# Eval("Time")%></td>
                            <td><%# Eval("NumberOfPaxAdult")%></td>
                            <td><%# Eval("NumberOfPaxChild")%></td>
                            <td><%# Eval("NumberOfPaxBaby")%></td>
                            <td><a href="MenuEditing.aspx?NodeId=1&SectionId=15&mi=<%# Eval("Menu.Id")%> "><%# Eval("Menu.Name")%></td>
                            <td><%# Eval("SpecialRequest")%></td>
                            <td><%# Eval("TotalPrice","{0:#,###.##}")%></td>
                            <td><%# ((int)Eval("Payment")) == 0 ? "" : ((int)Eval("Payment")) == 1 ? "Thanh toán ngay" : "Công nợ" %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
