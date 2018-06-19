<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuAdding.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.MenuAdding"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Menu Adding</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Menu adding
        </h3>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Name
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" ID="txtName" CssClass="form-control" placeholder="Name" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Cost
            </div>
            <div class="col-xs-3">
                <asp:TextBox runat="server" CssClass="form-control" ID="txtCost" placeholder="Cost" data-inputmask="'alias': 'numeric', 'groupSeparator': ',', 'autoGroup': true, 'digits': 2, 'digitsOptional': true, 'placeholder': '0', 'rightAlign':false" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-1">
                Details
            </div>
            <div class="col-xs-11">
                <asp:TextBox runat="server" CssClass="form-control" ID="txtDetais" placeholder="Details" TextMode="MultiLine" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" CssClass="btn btn-primary" Text="Add" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
