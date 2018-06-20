<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receivables.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.Receivables"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Receivables</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Receivables</h3>
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
                    <th rowspan="2">Price
                    </th>
                    <th rowspan="2">Total Price
                    </th>
                    <th rowspan="2">Paid
                    </th>
                    <th rowspan="2">Receivable
                    </th>
                    <th></th>
                </tr>
                <tr class="active">
                    <th>Adult
                    </th>
                    <th>Child
                    </th>
                    <th>Baby
                    </th>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content>
