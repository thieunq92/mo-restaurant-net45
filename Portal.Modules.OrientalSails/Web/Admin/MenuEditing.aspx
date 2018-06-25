<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuEditing.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.MenuEditing"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Menu Editing</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Menu editing</h3>
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
            <div class="col-xs-3">
                <asp:TextBox runat="server" CssClass="form-control" ID="txtDetails" placeholder="Details" TextMode="MultiLine" Rows="15" />
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="row">
            <div class="col-xs-12">
                <asp:Button runat="server" ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-primary" Text="Edit" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
