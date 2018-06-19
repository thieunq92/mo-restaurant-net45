<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuManagement.aspx.cs" Inherits="Portal.Modules.OrientalSails.Web.Admin.MenuManagement"
    MasterPageFile="MO.Master" %>

<asp:Content ID="Head" ContentPlaceHolderID="Head" runat="server">
    <title>Menu Management</title>
</asp:Content>
<asp:Content ID="AdminContent" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="page-header">
        <h3>Menu management</h3>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <table class="table table-bordered table-hover table-common">
                <tr class="active">
                    <th>Name
                    </th>
                    <th>Cost
                    </th>
                    <th>Details
                    </th>
                    <th></th>
                </tr>
                <asp:Repeater runat="server" ID="rptMenuTable">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("Name") %>
                            </td>
                            <td>
                                <%# Eval("Cost") %>
                            </td>
                            <td>
                                <%# Eval("Details")%>
                            </td>
                            <td><a href="MenuEditing.aspx?NodeId=1&SectionId=15&bi=<%# Eval("Id") %>">
                                <i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Edit"></i>
                            </a></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        <tr style="display: <%= rptMenuTable.Items.Count == 0 ? "" : "none"%>">
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
