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
                            <td><%# Eval("Code")%></td>
                            <td><%# Eval("Agency.Name")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
