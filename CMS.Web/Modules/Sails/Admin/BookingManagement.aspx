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
            <div class="col-xs-1">
                Code   
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtCode" CssClass="form-control" placeholder="Code (HLXXXXX)" />
            </div>
            <div class="col-xs-1">
                Date
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" placeholder="Date (dd/MM/yyyy)" data-control="datetimepicker" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Agency
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtAgency" CssClass="form-control" placeholder="Agency" />
            </div>
            <div class="col-xs-1">
                Payment
            </div>
            <div class="col-xs-3">
                <asp:DropDownList runat="server" ID="ddlPayment" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Value="-1" Text="-- Payment --" />
                    <asp:ListItem Value="1" Text="Thanh toán ngay" />
                    <asp:ListItem Value="2" Text="Công nợ" />
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button runat="server" ID="btnDisplay" Text="Display" OnClick="btnDisplay_Click" CssClass="btn btn-primary" />
            </div>
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
                            <td><a href="AgencyView.aspx?NodeId=1&SectionId=15&AgencyId=<%# Eval("Agency.Id")%>"><%# Eval("Agency.TradingName")%></a></td>
                            <td><%# Eval("Date","{0:dd/MM/yyyy}")%></td>
                            <td><%# Eval("Time")%></td>
                            <td><%# Eval("NumberOfPaxAdult")%></td>
                            <td><%# Eval("NumberOfPaxChild")%></td>
                            <td><%# Eval("NumberOfPaxBaby")%></td>
                            <td><a href="MenuEditing.aspx?NodeId=1&SectionId=15&mi=<%# Eval("Menu.Id")%> "><%# Eval("Menu.Name")%></td>
                            <td><%# Eval("SpecialRequest")%></td>
                            <td style="text-align:right!important"><%# Eval("TotalPrice","{0:#,##0.##}") + "₫"%></td>
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
