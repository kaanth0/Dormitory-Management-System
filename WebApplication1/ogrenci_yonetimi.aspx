<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ogrenci_yonetimi.aspx.cs" Inherits="WebApplication1.ogrenci_yonetimi" %>

<!DOCTYPE html>
<html>
<head>
    <title>Öğrenci Yönetimi</title>
    <link rel="stylesheet" type="text/css" href="ogrenciyonetim.css">
</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="ogrenciGrid" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="ogrenci_id, bolum_id, oda_no"
                    OnRowEditing="ogrenciGrid_RowEditing"
                    OnRowUpdating="ogrenciGrid_RowUpdating"
                    OnRowCancelingEdit="ogrenciGrid_RowCancelingEdit"
                    OnRowDeleting="ogrenciGrid_RowDeleting" CssClass="gridview">
                    
                    <Columns>
                        <asp:TemplateField HeaderText="Ad">
                            <ItemTemplate> <%# Eval("ad") %> </ItemTemplate>
                            <EditItemTemplate> <asp:TextBox ID="txtAd" runat="server" Text='<%# Bind("ad") %>' CssClass="textbox" /> </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Soyad">
                            <ItemTemplate> <%# Eval("soyad") %> </ItemTemplate>
                            <EditItemTemplate> <asp:TextBox ID="txtSoyad" runat="server" Text='<%# Bind("soyad") %>' CssClass="textbox" /> </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="E-posta">
                            <ItemTemplate> <%# Eval("eposta") %> </ItemTemplate>
                            <EditItemTemplate> <asp:TextBox ID="txtEposta" runat="server" Text='<%# Bind("eposta") %>' CssClass="textbox" /> </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bölüm">
                            <ItemTemplate> <%# Eval("bolum_adi") %> </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlBolum" runat="server" AutoPostBack="False" CssClass="dropdown"></asp:DropDownList> 
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Oda No">
                            <ItemTemplate> <%# Eval("oda_no") %> </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Doluluk">
                            <ItemTemplate> <%# Eval("doluluk") %> / <%# Eval("kapasite") %> </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sil">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSil" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ogrenci_id") %>' Text="🗑 Sil" CssClass="button delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" />
                    </Columns>
                </asp:GridView>

                <asp:Button ID="btnGeri" runat="server" Text="Geri Dön" OnClick="btnGeri_Click" CssClass="btn btn-secondary" />

            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>