<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingViewing.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.BookingViewing"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking Viewing</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Booking viewing</h3>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Code
            </div>
            <div class="col-xs-3">
                <%= RestaurantBooking.Code %>
            </div>
            <div class="col-xs-1">
                Menu
            </div>
            <div class="col-xs-3">
                <asp:DropDownList ID="ddlMenu" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Value="-1">-- Menu --</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-xs-1">
                Status
            </div>
            <div class="col-xs-3">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Value="-1">-- Status --</asp:ListItem>
                    <asp:ListItem Value="1">Approved</asp:ListItem>
                    <asp:ListItem Value="2">Cancel</asp:ListItem>
                    <asp:ListItem Value="3">Pending</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Date
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" placeholder="Date (dd/mm/yyyy)" data-control="datetimepicker" />
            </div>
            <div class="col-xs-1">
                Time    
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtTime" CssClass="form-control" placeholder="Time (hh:mm)" data-control="timepicker" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Agency    
            </div>
            <div class="col-xs-3">
                <input type="text" name="txtAgency" id="ctl00_AdminContent_agencySelectornameid" class="form-control"
                    readonly placeholder="Click to select agency" value="<%= RestaurantBooking.Agency.Name %>" />
                <input id="agencySelector" type="hidden" runat="server" />
            </div>
            <div class="col-xs-1">
                Booker          
            </div>
            <div class="col-xs-3">
                <asp:DropDownList runat="server" ID="ddlBooker" CssClass="form-control" AppendDataBoundItems="true">
                    <asp:ListItem Value="-1">-- Booker --</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Number of pax    
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxAdult" runat="server" CssClass="form-control" placeholder="Number of pax adult " Text="0" />
                    <span class="input-group-addon">Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxChild" runat="server" CssClass="form-control" placeholder="Number of pax child " Text="0" />
                    <span class="input-group-addon">Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxBaby" runat="server" CssClass="form-control" placeholder="Number of pax baby " Text="0" />
                    <span class="input-group-addon">Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1 nopadding-right" style="width: 8.3%">
                Cost per person
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonAdult" runat="server" CssClass="form-control" placeholder="Cost per person adult " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" />
                    <span class="input-group-addon">VND/1 Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonChild" runat="server" CssClass="form-control" placeholder="Cost per person child " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" />
                    <span class="input-group-addon">VND/1 Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonBaby" runat="server" CssClass="form-control" placeholder="Cost per person baby " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" />
                    <span class="input-group-addon">VND/1 Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Number of discounted pax
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxAdult" runat="server" CssClass="form-control" placeholder="Number of discounted adult " Text="0" />
                    <span class="input-group-addon">Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxChild" runat="server" CssClass="form-control" placeholder="Number of discounted child " Text="0" />
                    <span class="input-group-addon">Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxBaby" runat="server" CssClass="form-control" placeholder="Number of discounted baby " Text="0" />
                    <span class="input-group-addon">Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Total Price
            </div>
            <div class="col-xs-3">
                <%= RestaurantBooking.TotalPrice.ToString("#,###.##") +" "+ "VND"%>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Special Request    
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtSpecialRequest" CssClass="form-control" TextMode="MultiLine" placeholder="Special Request" />
            </div>
            <div class="col-xs-4">
                <div class="radio-inline">
                    <asp:RadioButton runat="server" ID="rbPayNow" GroupName="payment" Text="Thanh toán ngay" Checked="true"></asp:RadioButton>
                </div>
                <div class="radio-inline">
                    <asp:RadioButton runat="server" ID="rbDebt" GroupName="payment" Text="Công nợ"></asp:RadioButton>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button CssClass="btn btn-primary" ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        $("#ctl00_AdminContent_agencySelectornameid").click(function () {
            var width = 800;
            var height = 600;
            window.open('/Modules/Sails/Admin/AgencySelectorPage.aspx?NodeId=1&SectionId=15&clientid=ctl00_AdminContent_agencySelector', 'Agencyselect', 'width=' + width + ',height=' + height + ',top=' + ((screen.height / 2) - (height / 2)) + ',left=' + ((screen.width / 2) - (width / 2)));
        });
    </script>
</asp:Content>
