<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="myCombo.aspx.cs" Inherits="maiyas10920WebApp.demo.myCombo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br /> <br /> <br  />
    <asp:DropDownList ID="ddlCountry" runat="server"></asp:DropDownList><br  />
    <asp:Label ID="lblOutput" runat="server" Text="Output"></asp:Label><br  />
    <asp:Button ID="btnGetData" runat="server" Text="Get Data" /><br  />
</asp:Content>
