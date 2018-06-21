<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receivables.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.Receivables"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Receivables</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Receivables</h3>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                From
            </div>
            <div class="col-xs-3">
                <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" placeholder="From (dd/MM/yyyy)" data-control="datetimepicker" />
            </div>
            <div class="col-xs-1">
                To
            </div>
            <div class="col-xs-3">
                <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" placeholder="To (dd/MM/yyyy)" data-control="datetimepicker" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button ID="btnDisplay" runat="server" CssClass="btn btn-primary" Text="Display" OnClick="btnDisplay_Click" />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <table class="table table-bordered table-hover table-common">
                <tr class="active">
                    <th rowspan="2">Code
                    </th>
                    <th rowspan="2">Sales
                    </th>
                    <th rowspan="2">Partner
                    </th>
                    <th rowspan="2">Menu
                    </th>
                    <th colspan="3">Number Of Pax
                    </th>
                    <th rowspan="2">Total Price
                    </th>
                    <th rowspan="2">Total Paid
                    </th>
                    <th rowspan="2">Receivable
                    </th>
                    <th rowspan="2"></th>
                </tr>
                <tr class="active">
                    <th>Adult
                    </th>
                    <th>Child
                    </th>
                    <th>Baby
                    </th>
                </tr>
                <asp:Repeater runat="server" ID="rptReceivablesTable">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Code") %></td>
                            <td><%# Eval("Agency.Sale.Name") %></td>
                            <td><a href="AgencyView.aspx?NodeId=1&SectionId=15&ai=<%# Eval("Agency.Id")%>"><%# Eval("Agency.Name")%></a></td>
                            <td><a href="MenuEditing.aspx?NodeId=1&SectionId=15&mi=<%# Eval("Menu.Id")%> "><%# Eval("Menu.Name")%></td>
                            <td><%# Eval("NumberOfPaxAdult")%></td>
                            <td><%# Eval("NumberOfPaxChild")%></td>
                            <td><%# Eval("NumberOfPaxBaby")%></td>
                            <td><%# Eval("TotalPrice")%></td>
                            <td><%# Eval("TotalPaid")%></td>
                            <td><%# Eval("Receivable")%></td>
                            <td><a href="MenuEditing.aspx?NodeId=1&SectionId=15&mi=<%# Eval("Id") %>">
                                <i class="fa fa-money-bill fa-lg" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Payment"></i>
                            </a></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        <tr style="display: <%= rptReceivablesTable.Items.Count == 0 ? "" : "none"%>">
                            <td colspan="100%">No records found
                            </td>
                        </tr>
                    </FooterTemplate>
                </asp:Repeater>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
