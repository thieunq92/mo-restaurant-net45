<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingAdding.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.BookingAdding"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Booking adding
    </title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Booking adding</h3>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Agency
            </div>
            <div class="col-xs-7">
                <input type="text" name="txtAgency" id="ctl00_AdminContent_agencySelectornameid" class="form-control"
                    readonly placeholder="Click to select agency" />
                <input id="agencySelector" type="hidden" runat="server" />
            </div>
            <div class="col-xs-1">
                Date
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" data-control="datetimepicker" placeholder="Date (dd/mm/yyyy)" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button runat="server" ID="btnAdd" CssClass="btn btn-primary" Text="Add" OnClick="btnAdd_Click" />
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
