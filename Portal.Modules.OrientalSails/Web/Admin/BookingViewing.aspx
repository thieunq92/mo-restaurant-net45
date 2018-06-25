<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingViewing.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.BookingViewing"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking Viewing</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Code : <%= RestaurantBooking.Code %></h3>
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
            <div class="col-xs-3" ng-controller="menuController" ng-init="menuId = '<%= RestaurantBooking.Menu != null? RestaurantBooking.Menu.Id : -1%>'">
                <asp:DropDownList ID="ddlMenu" runat="server" CssClass="form-control" AppendDataBoundItems="true" ng-model="menuId" ng-change="menuGetById()">
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
    <div class="form-group" ng-controller="bookerController" ng-init="agencyId=<%= RestaurantBooking.Agency.Id %>;bookerGetByAgencyId()">
        <div class="row">
            <div class="col-xs-1">
                Agency    
            </div>
            <div class="col-xs-3">
                <input type="text" name="txtAgency" id="ctl00_AdminContent_agencySelectornameid" class="form-control"
                    readonly placeholder="Click to select agency" value="<%= RestaurantBooking.Agency.Name %>" />
                <input id="agencySelector" type="text" runat="server" ng-model="agencyId" ng-change="bookerGetByAgencyId()" data-id="hidAgencyId" style="display:none"/>
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
    <div class="form-group" ng-controller="numberOfPaxController" ng-init="$root.numberOfPax.Adult = <%= RestaurantBooking.NumberOfPaxAdult %>;$root.numberOfPax.Child = <%=RestaurantBooking.NumberOfPaxChild %>;$root.numberOfPax.Baby = <%=RestaurantBooking.NumberOfPaxBaby %>">
        <div class="row">
            <div class="col-xs-1">
                Number of pax    
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxAdult" runat="server" CssClass="form-control" placeholder="Number of pax adult " Text="0" ng-model="$root.numberOfPax.Adult" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxChild" runat="server" CssClass="form-control" placeholder="Number of pax child " Text="0" ng-model="$root.numberOfPax.Child" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfPaxBaby" runat="server" CssClass="form-control" placeholder="Number of pax baby " Text="0" ng-model="$root.numberOfPax.Baby" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group" ng-controller="priceController" ng-init="$root.costPerPerson.Adult='<%= RestaurantBooking.CostPerPersonAdult %>';$root.costPerPerson.Child='<%= RestaurantBooking.CostPerPersonChild %>';$root.costPerPerson.Baby='<%= RestaurantBooking.CostPerPersonBaby %>'">
        <div class="row">
            <div class="col-xs-1 nopadding-right" style="width: 8.3%">
                Cost per person
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonAdult" runat="server" CssClass="form-control" placeholder="Cost per person adult " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" ng-model="$root.costPerPerson.Adult" data-id="txtCostPerPersonAdult" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonChild" runat="server" CssClass="form-control" placeholder="Cost per person child " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" ng-model="$root.costPerPerson.Child" data-id="txtCostPerPersonChild" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtCostPerPersonBaby" runat="server" CssClass="form-control" placeholder="Cost per person baby " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" ng-model="$root.costPerPerson.Baby" data-id="txtCostPerPersonBaby" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group" ng-controller="numberOfDiscountedPaxController" ng-init="$root.numberOfDiscountedPax.Adult=<%=RestaurantBooking.NumberOfDiscountedPaxAdult %>;$root.numberOfDiscountedPax.Child=<%=RestaurantBooking.NumberOfDiscountedPaxChild %>;$root.numberOfDiscountedPax.Baby=<%=RestaurantBooking.NumberOfDiscountedPaxBaby %>">
        <div class="row">
            <div class="col-xs-1">
                Number of discounted pax
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxAdult" runat="server" CssClass="form-control" placeholder="Number of discounted pax adult " Text="0" ng-model="$root.numberOfDiscountedPax.Adult" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Adult</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxChild" runat="server" CssClass="form-control" placeholder="Number of discounted pax child " Text="0" ng-model="$root.numberOfDiscountedPax.Child" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Child</span>
                </div>
            </div>
            <div class="col-xs-3" style="width: 19.420%">
                <div class="input-group">
                    <asp:TextBox ID="txtNumberOfDiscountedPaxBaby" runat="server" CssClass="form-control" placeholder="Number of discounted pax baby " Text="0" ng-model="$root.numberOfDiscountedPax.Baby" ng-change="$root.calculateTotalPrice()" />
                    <span class="input-group-addon">Baby</span>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group" ng-controller="totalPriceController" ng-init="$root.calculateTotalPrice()">
        <div class="row">
            <div class="col-xs-1">
                Total Price
            </div>
            <div class="col-xs-3">
                {{totalPrice + "₫"}}
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Special Request    
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtSpecialRequest" CssClass="form-control" TextMode="MultiLine" placeholder="Special Request" Rows="10"/>
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
    <script type="text/javascript" src="/modules/sails/admin/bookingviewingcontroller.js"></script>
    <script>
        $("#ctl00_AdminContent_agencySelectornameid").click(function () {
            var width = 800;
            var height = 600;
            var popup = window.open('/Modules/Sails/Admin/AgencySelectorPage.aspx?NodeId=1&SectionId=15&clientid=ctl00_AdminContent_agencySelector', 'Agencyselect', 'width=' + width + ',height=' + height + ',top=' + ((screen.height / 2) - (height / 2)) + ',left=' + ((screen.width / 2) - (width / 2)));
            var popupTick = setInterval(function () {
                if (popup.closed) {
                    clearInterval(popupTick);
                    var input = $('[data-id="hidAgencyId"]');
                    input.trigger('input');
                    input.trigger('change')
                }
            }, 500);

            return false;
        });
    </script>
</asp:Content>
