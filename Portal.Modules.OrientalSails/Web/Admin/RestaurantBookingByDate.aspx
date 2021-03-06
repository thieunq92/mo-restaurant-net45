﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RestaurantBookingByDate.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.RestaurantBookingByDate"
    MasterPageFile="MO.Master" %>

<%@ Import Namespace="Portal.Modules.OrientalSails.Domain" %>
<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking By Date</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Booking by date
        </h3>
    </div>
    <div class="row">
        <div class="col-xs-9">
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-1 nopadding-right">
                        Date to view 
                    </div>
                    <div class="col-xs-2 nopadding-left nopadding-right">
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" data-control="datetimepicker" autocomplete="off" placeholder="Date (dd/mm/yyyy)"></asp:TextBox>
                    </div>
                    <div class="col-xs-2" style="display: none">
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
        </div>
        <div class="col-xs-3">
            <strong>Chú thích</strong>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-12">
                        <div style="width: 20px; height: 10px; display: inline-block; border: solid 1px" class="custom-success"></div>
                        : Booking đã thu tiền
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-12">
                        <div style="width: 20px; height: 10px; display: inline-block; border: solid 1px" class="custom-warning"></div>
                        : Booking thanh toán ngay chưa thu tiền 
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-12">
                        <div style="width: 20px; height: 10px; display: inline-block; border: solid 1px"></div>
                        : Booking công nợ chưa thu tiền 
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-xs-12">
            <table class="table table-bordered table-common">
                <tr class="active">
                    <th rowspan="2">No
                    </th>
                    <th rowspan="2">Code
                    </th>
                    <th rowspan="2">Agency
                    </th>
                    <th rowspan="2">Hướng dẫn viên
                    </th>
                    <th rowspan="2" colspan="2">Time
                    </th>
                    <th colspan="3">Number of pax
                    </th>
                    <th colspan="3">Đơn giá</th>
                    <th rowspan="2">Service
                    </th>
                    <th rowspan="2">Special request
                    </th>
                    <th rowspan="2">VAT</th>
                    <th rowspan="2">Tổng giá
                    </th>
                    <th rowspan="2">Thực thu</th>
                    <th rowspan="2"></th>
                </tr>
                <tr class="active">
                    <th>Adult
                    </th>
                    <th>Child
                    </th>
                    <th>Baby
                    </th>
                    <th>Adult
                    </th>
                    <th>Child
                    </th>
                    <th>Baby
                    </th>
                </tr>
                <asp:Repeater ID="rptBooking" runat="server" OnItemDataBound="rptBooking_ItemDataBound">
                    <ItemTemplate>
                        <tbody>
                            <tr class="<%# ((bool)Eval("IsPaid")) ? "custom-success" : ((int)Eval("Payment")) == 1 ? "custom-warning":"" %>">
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# Container.ItemIndex + 1%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>">
                                    <a href="BookingViewing.aspx?NodeId=1&SectionId=15&bi=<%# Eval("Id")%>"><%# Eval("Code")%>
                                </td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%> ">
                                    <a href="AgencyView.aspx?NodeId=1&SectionId=15&AgencyId=<%# Eval("Agency") != null ? Eval("Agency.Id") : ""%>"><%# Eval("Agency") != null ? Eval("Agency.TradingName"):""%>
                                </td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>" style="text-align: left!important"><%# Eval("NameAndPhoneOfGuides")%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# ((int)Eval("PartOfDay")) == 1 ? "Sáng" : ((int)Eval("PartOfDay")) == 2 ? "Trưa" : ((int)Eval("PartOfDay")) == 3 ? "Tối" : "" %></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# Eval("Time")%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# Eval("NumberOfPaxAdult")%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# Eval("NumberOfPaxChild")%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# Eval("NumberOfPaxBaby")%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# ((Double)Eval("CostPerPersonAdult")).ToString("#,##0.##") + "₫"%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# ((Double)Eval("CostPerPersonChild")).ToString("#,##0.##") + "₫"%></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# ((Double)Eval("CostPerPersonBaby")).ToString("#,##0.##") + "₫"%></td>
                                <td>
                                    <a href="MenuEditing.aspx?NodeId=1&SectionId=15&mi=<%# Eval("Menu") != null ? Eval("Menu.Id"):""%>"><%# Eval("Menu") != null ? Eval("Menu.Name"):""%>
                                </td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>" style="text-align: left!important">
                                    <%# !String.IsNullOrEmpty((string)Eval("SpecialRequest")) ? ((string)Eval("SpecialRequest")).Replace("\n","<br/>") + "<br/>": ""%>
                                    <%# !String.IsNullOrEmpty((string)Eval("MenuDetail")) ? ((string)Eval("MenuDetail")).Replace("\n","<br/>") : ""%>
                                </td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>">
                                    <%# ((bool)Eval("VAT")) == true ? "Yes" : ""%>
                                </td>
                                <td style="text-align: right!important" rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>">
                                    <%# ((Double)Eval("TotalPrice")).ToString("#,##0.##") + "₫"%>
                                </td>
                                <td style="text-align: right!important" rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>"><%# ((Double)Eval("ActuallyCollected")).ToString("#,##0.##") + "₫" %></td>
                                <td rowspan="<%# ((IList<ServiceOutside>)Eval("ListServiceOutside")).Count + 1%>">
                                    <a href="javascript:void(0)" data-toggle="modal" data-target=".modal-bookingpayment" data-url="RestaurantBookingPayment.aspx?NodeId=1&SectionId=15&bi=<%# Eval("Id")%>">
                                        <i class="fa fa-money-bill fa-lg" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Payment"></i>
                                    </a>
                                </td>
                            </tr>
                            <asp:Repeater runat="server" ID="rptServiceOutside">
                                <ItemTemplate>
                                    <tr class="<%# ((RestaurantBooking)((RepeaterItem)Container.Parent.Parent).DataItem).IsPaid ? "success" : ((RestaurantBooking)((RepeaterItem)Container.Parent.Parent).DataItem).Payment == 1 ? "custom-warning":"" %>">
                                        <td><a href="javascript:void(0)" data-toggle="tooltip" title="<%# GetServiceOutsideDetail((ServiceOutside)Container.DataItem) %>"><%# Eval("Service")%> ; SL: <%# Eval("Quantity")%></a></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </ItemTemplate>
                    <FooterTemplate>
                        <tr style="display: <%= rptBooking.Items.Count == 0 ? "" : "none"%>">
                            <td colspan="100%">No records found
                            </td>
                        </tr>
                        <tr style="display: <%= rptBooking.Items.Count > 0 ? "" : "none"%>; font-weight: bold">
                            <td colspan="6"><strong>Total</strong></td>
                            <td>
                                <asp:Label runat="server" ID="lblTotalAdult"></asp:Label></td>
                            <td>
                                <asp:Label runat="server" ID="lblTotalChild"></asp:Label></td>
                            <td>
                                <asp:Label runat="server" ID="lblTotalBaby"></asp:Label></td>
                            <td colspan="6"></td>
                            <td style="text-align: right!important">
                                <asp:Label runat="server" ID="lblTotalOfTotalPrice"></asp:Label></td>
                            <td style="text-align: right!important">
                                <asp:Label runat="server" ID="lblTotalActuallyCollected"></asp:Label></td>
                            <td></td>
                        </tr>
                    </FooterTemplate>
                </asp:Repeater>
            </table>
            <div class="row">
                <div class="col-xs-12">
                    <asp:Button runat="server" ID="btnSalesReportExport" OnClick="btnSalesReportExport_Click" Text="Trích xuất BCDT" CssClass="btn btn-primary" />
                </div>
            </div>
            <div class="modal fade modal-bookingpayment" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" data-backdrop="static" data-keyboard="false">
                <div class="modal-dialog" role="document" style="width: 1230px; height: 580px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="modal-title">Booking payment</h3>
                        </div>
                        <div class="modal-body">
                            <iframe frameborder="0" width="1200" height="570"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        $('a[data-target = ".modal-bookingpayment"]').click(function () {
            $(".modal iframe").attr('src', $(this).attr('data-url'))
        })
    </script>
</asp:Content>
