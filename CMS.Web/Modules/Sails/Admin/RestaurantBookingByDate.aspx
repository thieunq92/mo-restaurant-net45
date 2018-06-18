<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestaurantBookingByDate.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.RestaurantBookingByDate"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking By Date</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Booking by date
        </h3>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1 nopadding-right">
                Date to view 
            </div>
            <div class="col-xs-2 nopadding-left nopadding-right">
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" data-control="datetimepicker" autocomplete="off" placeholder="Date (dd/mm/yyyy)"></asp:TextBox>
            </div>
            <div class="col-xs-2">
                <asp:TextBox runat="server" ID="txtBookingCode" placeholder="Booking code" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button ID="btnDisplay" runat="server" Text="Display" OnClick="btnDisplay_Click"
                    CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-xs-12">
            <table class="table table-bordered table-hover table-common">
                <tr class="active">
                    <th rowspan="2">No
                    </th>
                    <th rowspan="2">Agency
                    </th>
                    <th rowspan="2">Time
                    </th>
                    <th colspan="3">Number of pax
                    </th>
                    <th rowspan="2">Menu
                    </th>
                    <th rowspan="2">Special request
                    </th>
                    <th rowspan="2">Code
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
                <asp:Repeater ID="rptBooking" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex %></td>
                            <td><%# Eval("Agency.Name")%></td>
                            <td><%# Eval("Time")%></td>
                            <td><%# Eval("NumberOfPaxAdult")%></td>
                            <td><%# Eval("NumberOfPaxChild")%></td>
                            <td><%# Eval("NumberOfPaxBaby")%></td>
                            <td><%# Eval("Menu.Name")%></td>
                            <td><%# Eval("SpecialRequest")%></td>
                            <td><%# Eval("Id")%></td>
                            <td><%# ((Double)Eval("TotalPrice")).ToString("#,###.##")%></td>
                            <td><%# ((int)Eval("Payment")) == 1 ? "Thanh toán ngay" : "Công nợ"%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </div>
</asp:Content>
