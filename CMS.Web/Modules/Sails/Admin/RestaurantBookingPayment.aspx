<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestaurantBookingPayment.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.RestaurantBookingPayment"
    MasterPageFile="NewPopup.Master" %>

<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Code
            </div>
            <div class="col-xs-10">
                <%= RestaurantBooking.Code %>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Agency
            </div>
            <div class="col-xs-10">
                <%= RestaurantBooking.Agency.Name %>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Date
            </div>
            <div class="col-xs-10">
                <%= ((DateTime)RestaurantBooking.Date).ToString("dd/MM/yyyy") %>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Menu
            </div>
            <div class="col-xs-10">
                <%= RestaurantBooking.Menu != null ? RestaurantBooking.Menu.Name : ""%>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Total Price
            </div>
            <div class="col-xs-10">
                <%= RestaurantBooking.TotalPrice.ToString("#,##0.##") + "₫"%>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Đã thanh toán
            </div>
            <div class="col-xs-2">
                <%= RestaurantBooking.TotalPaid.ToString("#,##0.##") + "₫"%>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Số tiền thanh toán
            </div>
            <div class="col-xs-2">
                <asp:TextBox ID="txtPaid" runat="server" CssClass="form-control" placeholder="Số tiền thanh toán" Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
                Còn lại
            </div>
            <div class="col-xs-10">
                <%= RestaurantBooking.Receivable.ToString("#,##0.##") + "₫" %>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-2">
            </div>
            <div class="col-xs-10">
                <div class="checkbox">
                    <label>
                        <asp:CheckBox runat="server" ID="chkPaid" Text="Đánh dấu đã thanh toán" />
                    </label>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button runat="server" ID="btnPayment" CssClass="btn btn-primary" Text="Thanh toán" OnClick="btnPayment_Click"></asp:Button>
            </div>
        </div>
    </div>
    <h3>Payment History</h3>
    <table class="table table-bordered table-hover table-common">
        <tr class="active">
            <th>Time
            </th>
            <th>Pay by</th>
            <th>Số tiền thanh toán</th>
            <th>Created by</th>
            <asp:Repeater runat="server" ID="rptPaymentHistory">
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Time","{0:dd/MM/yyyy HH:mm}")%></td>
                        <td><%# Eval("Payby.Name")%></td>
                        <td><%# Eval("Amount")%></td>
                        <td><%# Eval("Createdby.FullName")%></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>

