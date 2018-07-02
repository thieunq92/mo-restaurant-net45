<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingViewing.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.BookingViewing"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking Viewing</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Code : <%= RestaurantBooking.Code %></h3>
    </div>
    <div class="row" ng-controller="saveController" ng-init="$root.restaurantBookingId = <%= RestaurantBooking.Id %>">
        <div class="col-xs-12">
            <asp:Button CssClass="btn btn-primary" ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ng-click="save()" Style="display: none" />
            <button id="btnSave" type="button" ng-click="save()" class="btn btn-primary" data-uniqueid="<%= btnSave.UniqueID %>">Save</button>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-xs-7">
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-2">Menu</div>
                    <div class="col-xs-4" ng-controller="menuController" ng-init="menuId = '<%= RestaurantBooking.Menu != null? RestaurantBooking.Menu.Id : -1%>'">
                        <asp:DropDownList ID="ddlMenu" runat="server" CssClass="form-control" AppendDataBoundItems="true" ng-model="menuId" ng-change="menuGetById()">
                            <asp:ListItem Value="-1">-- Menu --</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-xs-2">
                        Status
                    </div>
                    <div class="col-xs-4">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem Value="1">Approved</asp:ListItem>
                            <asp:ListItem Value="2">Cancel</asp:ListItem>
                            <asp:ListItem Value="3">Pending</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-2">
                        Date
                    </div>
                    <div class="col-xs-4">
                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" placeholder="Date (dd/mm/yyyy)" data-control="datetimepicker" />
                    </div>
                    <div class="col-xs-2">
                        Time
                    </div>
                    <div class="col-xs-2 nopadding-right">
                        <asp:DropDownList ID="ddlPartOfDay" runat="server" CssClass="form-control" AppendDataBoundItems="true">
                            <asp:ListItem Value="1">Sáng</asp:ListItem>
                            <asp:ListItem Value="2">Trưa</asp:ListItem>
                            <asp:ListItem Value="3">Tối</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-xs-2 nopadding-left">
                        <asp:TextBox runat="server" ID="txtTime" CssClass="form-control" placeholder="Time (hh:mm)" data-control="timepicker" />
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="bookerController" ng-init="agencyId=<%= RestaurantBooking.Agency.Id %>;bookerGetAllByAgencyId()">
                <div class="row">
                    <div class="col-xs-2">
                        Agency
                    </div>
                    <div class="col-xs-4">
                        <input type="text" name="txtAgency" id="ctl00_AdminContent_agencySelectornameid" class="form-control"
                            readonly placeholder="Click to select agency" value="<%= RestaurantBooking.Agency.Name %>" />
                        <input id="agencySelector" type="text" runat="server" ng-model="agencyId" ng-change="bookerGetAllByAgencyId()" data-id="hidAgencyId" style="display: none" />
                    </div>
                    <div class="col-xs-2">
                        Booker
                    </div>
                    <div class="col-xs-4">
                        <select ng-model="$root.bookerId" class="form-control" convert-to-number ng-init="$root.bookerId = <%= RestaurantBooking.Booker != null ? RestaurantBooking.Booker.Id : -1 %>">
                            <option value="-1">-- Booker --</option>
                            <option ng-repeat="item in listBooker" value="{{item.id}}">{{item.name}}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="numberOfPaxController" ng-init="$root.numberOfPax.Adult = <%= RestaurantBooking.NumberOfPaxAdult %>;$root.numberOfPax.Child = <%=RestaurantBooking.NumberOfPaxChild %>;$root.numberOfPax.Baby = <%=RestaurantBooking.NumberOfPaxBaby %>">
                <div class="row">
                    <div class="col-xs-2">
                        Number of pax
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfPaxAdult" runat="server" CssClass="form-control" placeholder="Number of pax adult " Text="0" ng-model="$root.numberOfPax.Adult" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Adult</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfPaxChild" runat="server" CssClass="form-control" placeholder="Number of pax child " Text="0" ng-model="$root.numberOfPax.Child" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Child</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 27%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfPaxBaby" runat="server" CssClass="form-control" placeholder="Number of pax baby " Text="0" ng-model="$root.numberOfPax.Baby" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Baby</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="priceController" ng-init="$root.costPerPerson.Adult='<%= RestaurantBooking.CostPerPersonAdult %>';$root.costPerPerson.Child='<%= RestaurantBooking.CostPerPersonChild %>';$root.costPerPerson.Baby='<%= RestaurantBooking.CostPerPersonBaby %>'">
                <div class="row">
                    <div class="col-xs-2">
                        Đơn giá
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtCostPerPersonAdult" runat="server" CssClass="form-control" placeholder="Cost per person adult " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" ng-model="$root.costPerPerson.Adult" data-id="txtCostPerPersonAdult" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Adult</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtCostPerPersonChild" runat="server" CssClass="form-control" placeholder="Cost per person child " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" ng-model="$root.costPerPerson.Child" data-id="txtCostPerPersonChild" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Child</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 27%">
                        <div class="input-group">
                            <asp:TextBox ID="txtCostPerPersonBaby" runat="server" CssClass="form-control" placeholder="Cost per person baby " Text="0" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" ng-model="$root.costPerPerson.Baby" data-id="txtCostPerPersonBaby" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Baby</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="numberOfDiscountedPaxController" ng-init="$root.numberOfDiscountedPax.Adult=<%=RestaurantBooking.NumberOfDiscountedPaxAdult %>;$root.numberOfDiscountedPax.Child=<%=RestaurantBooking.NumberOfDiscountedPaxChild %>;$root.numberOfDiscountedPax.Baby=<%=RestaurantBooking.NumberOfDiscountedPaxBaby %>">
                <div class="row">
                    <div class="col-xs-2">
                        FOC
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfDiscountedPaxAdult" runat="server" CssClass="form-control" placeholder="Number of discounted pax adult " Text="0" ng-model="$root.numberOfDiscountedPax.Adult" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Adult</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 28%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfDiscountedPaxChild" runat="server" CssClass="form-control" placeholder="Number of discounted pax child " Text="0" ng-model="$root.numberOfDiscountedPax.Child" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Child</span>
                        </div>
                    </div>
                    <div class="col-xs-3" style="width: 27%">
                        <div class="input-group">
                            <asp:TextBox ID="txtNumberOfDiscountedPaxBaby" runat="server" CssClass="form-control" placeholder="Number of discounted pax baby " Text="0" ng-model="$root.numberOfDiscountedPax.Baby" ng-change="$root.calculateTotalPrice()" />
                            <span class="input-group-addon">Baby</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="totalPriceController" ng-init="$root.calculateTotalPrice()">
                <div class="row">
                    <div class="col-xs-2">
                        Tổng giá
                    </div>
                    <div class="col-xs-3">
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="txtTotalPrice" CssClass="form-control" ng-model="totalPrice" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" />
                            <span class="input-group-addon">₫</span>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="radio-inline">
                            <asp:RadioButton runat="server" ID="rbPayNow" GroupName="payment" Text="Thanh toán ngay" Checked="true"></asp:RadioButton>
                        </div>
                        <div class="radio-inline">
                            <asp:RadioButton runat="server" ID="rbDebt" GroupName="payment" Text="Công nợ"></asp:RadioButton>

                        </div>
                    </div>
                    <div class="col-xs-3 nopadding-left" ng-controller="vatController" ng-init="bookingVAT = false">
                        <div class="checkbox" style="margin-top: 0px; margin-bottom: 0px">
                            <label>
                                <asp:CheckBox ID="chkVAT" runat="server" Text="VAT" />
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-controller="actuallyCollectedController" ng-init="$root.calculateActuallyCollected()">
                <div class="row">
                    <div class="col-xs-2">
                        Thực thu
                    </div>
                    <div class="col-xs-2">
                        {{ $root.actuallyCollected + "₫"}}
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-5">
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-3">
                        Special Request    
                    </div>
                    <div class="col-xs-9">
                        <asp:TextBox runat="server" ID="txtSpecialRequest" CssClass="form-control" TextMode="MultiLine" placeholder="Special Request" Rows="5" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-3">
                    </div>
                    <div class="col-xs-9">
                        <asp:TextBox runat="server" ID="txtMenuDetail" data-id="txtMenuDetail" CssClass="form-control" TextMode="MultiLine" placeholder="Menu" Rows="15"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" ng-controller="commissionController" ng-init="loadCommission()">
        <div class="col-xs-12">
            <h3>Trích ngoài
                <button type="button" class="btn btn-primary" ng-click="addCommission()">Add</button></h3>
            <br />
            <div class="form-group" ng-show="$root.listCommission.length > 0">
                <div class="row">
                    <div class="col-xs-2">
                        Trả cho
                    </div>
                    <div class="col-xs-2">
                        Số tiền
                    </div>
                </div>
            </div>
            <div class="form-group" ng-repeat="item in $root.listCommission">
                <div class="row">
                    <input type="hidden" ng-model="item.id">
                    <div class="col-xs-2">
                        <input type="text" class="form-control" placeholder="Trả cho" ng-model="item.payFor" />
                    </div>
                    <div class="col-xs-2">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Số tiền" ng-model="item.amount" data-control="inputmask" ng-change="calculateTotalCommission() " />
                            <span class="input-group-addon">₫</span>
                        </div>
                    </div>
                    <div class="col-xs-1">
                        <button type="button" class="btn btn-primary" ng-click="removeCommission($index)">
                            Remove
                        </button>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col-xs-offset-2 col-xs-2" ng-show="$root.listCommission.length > 0">
                        Tổng : {{ calculateTotalCommission() }}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" ng-controller="serviceOutsideController" ng-init="loadServiceOutside()">
        <div class="col-xs-12">
            <h3>Dịch vụ ngoài 
                <button type="button" class="btn btn-primary" ng-click="addServiceOutside()">Add</button></h3>
            <br />
            <div class="form-group" ng-show="$root.listServiceOutside.length > 0">
                <div class="row">
                    <div class="col-xs-2">
                        Dịch vụ
                    </div>
                    <div class="col-xs-2">
                        Đơn giá
                    </div>
                    <div class="col-xs-2">
                        Số lượng
                    </div>
                    <div class="col-xs-2">
                        Thành tiền
                    </div>
                </div>
            </div>
            <div class="form-group" ng-repeat="item in $root.listServiceOutside">
                <div class="row">
                    <input type="hidden" ng-model="item.id">
                    <div class="col-xs-2">
                        <input type="text" class="form-control" placeholder="Dịch vụ" ng-model="item.service" />
                    </div>
                    <div class="col-xs-2">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Đơn giá" ng-model="item.unitPrice" data-control="inputmask" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false"
                                ng-change="calculateServiceOutside($index, item.unitPrice, item.quantity)" />
                            <span class="input-group-addon">₫</span>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <input type="text" class="form-control" placeholder="Số lượng" ng-model="item.quantity" ng-change="calculateServiceOutside($index, item.unitPrice, item.quantity)" />
                    </div>
                    <div class="col-xs-2">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Thành tiền" ng-model="item.totalPrice" data-control="inputmask" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" ng-change="calculateTotalServiceOutside()" />
                            <span class="input-group-addon">₫</span>
                        </div>
                    </div>
                    <div class="col-xs-1">
                        <div class="checkbox" style="margin-top: 0px; margin-bottom: 0px">
                            <label>
                                <input type="checkbox" ng-model="item.vat">VAT
                            </label>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".modal-serviceOutsideDetail{{item.id}}">Chi tiết</button>
                        <button type="button" class="btn btn-primary" ng-click="removeServiceOutside($index)">
                            Remove
                        </button>
                    </div>
                </div>
            </div>
            <div class="form-group" ng-show="$root.listServiceOutside.length > 0">
                <div class="row">
                    <div class="col-xs-offset-6 col-xs-2">
                        Tổng : {{ calculateTotalServiceOutside() }}
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="row" ng-controller="guideController" ng-init="loadGuide()">
        <div class="col-xs-12">
            <h3>Hướng dẫn viên
                <button type="button" class="btn btn-primary" ng-click="addGuide()">Add</button></h3>
            <br />
            <div class="form-group" ng-show="$root.listGuide.length > 0">
                <div class="row">
                    <div class="col-xs-2">
                        Tên
                    </div>
                    <div class="col-xs-2">
                        Số điện thoại
                    </div>
                </div>
            </div>
            <div class="form-group" ng-repeat="item in $root.listGuide">
                <div class="row">
                    <input type="hidden" ng-model="item.id">
                    <div class="col-xs-2">
                        <input type="text" class="form-control" placeholder="Tên" ng-model="item.name" />
                    </div>
                    <div class="col-xs-2">
                        <input type="text" class="form-control" placeholder="Số điện thoại" ng-model="item.phone" />
                    </div>
                    <div class="col-xs-1">
                        <button type="button" class="btn btn-primary" ng-click="removeGuide($index)">
                            Remove
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div ng-controller="serviceOutsideDetailController">
        <div class="modal fade modal-serviceOutsideDetail{{serviceOutside.id}}" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel" data-backdrop="static" data-keyboard="false" ng-init="loadServiceOutsideDetail(serviceOutside.id)" ng-repeat="serviceOutside in $root.listServiceOutside">
            <div class="modal-dialog" role="document" style="width: 1100px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title">Chi tiết của dịch vụ {{serviceOutside.service}}
                            <button type="button" class="btn btn-primary" ng-click="addServiceOutsideDetail(serviceOutside.id)">Add</button></h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group" ng-show="serviceOutside.listServiceOutsideDetailDTO.length > 0">
                            <div class="row">
                                <div class="col-xs-2" style="width: 20%">
                                    Tên
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    Đơn giá
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    Số lượng
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    Thành tiền
                                </div>
                            </div>
                        </div>
                        <div class="form-group" ng-repeat="serviceOutsideDetail in serviceOutside.listServiceOutsideDetailDTO">
                            <div class="row">
                                <input type="hidden" ng-model="item.id">
                                <div class="col-xs-2" style="width: 20%">
                                    <input type="text" class="form-control" placeholder="Tên" ng-model="serviceOutsideDetail.name" />
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Đơn giá" ng-model="serviceOutsideDetail.unitPrice" data-control="inputmask" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false"
                                            ng-change="calculateServiceOutside($index, item.unitPrice, item.quantity)" />
                                        <span class="input-group-addon">₫</span>
                                    </div>
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    <input type="text" class="form-control" placeholder="Số lượng" ng-model="serviceOutsideDetail.quantity" ng-change="calculateServiceOutside($index, item.unitPrice, item.quantity)" />
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Thành tiền" ng-model="serviceOutsideDetail.totalPrice" data-control="inputmask" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'rightAlign':false" ng-change="calculateTotalServiceOutside()" />
                                        <span class="input-group-addon">₫</span>
                                    </div>
                                </div>
                                <div class="col-xs-2" style="width: 20%">
                                    <button type="button" class="btn btn-primary" ng-click="removeServiceOutsideDetail($index,serviceOutside.id)">
                                        Remove
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                    </div>
                </div>
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
        $("#<%= chkVAT.ClientID%>").attr({ "ng-model": "$root.bookingVAT", "ng-change": "serviceOutsideChangeValueVAT()" })
    </script>
</asp:Content>
