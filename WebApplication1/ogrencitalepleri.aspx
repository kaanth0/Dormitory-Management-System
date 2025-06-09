<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ogrencitalepleri.aspx.cs" Inherits="WebApplication1.ogrencitalepleri" %>

<!DOCTYPE html>
<html>
<head>
    <title>Öğrenci Talepleri Yönetimi</title>
    <link rel="stylesheet" href="ogrencitalepleri.css">
</head>
<body>
    <form runat="server">
        <div class="container">
            <h2>Öğrenci Talepleri Yönetimi</h2>

    <div class="log-buton">
    <asp:Button ID="btnLoglar" runat="server" Text="Logları Görüntüle" CssClass="btn btn-log"
        OnClientClick="window.location.href='talep_log.aspx'; return false;" />
</div>

                       <asp:GridView ID="GridViewTalepler" runat="server" AutoGenerateColumns="False" DataKeyNames="talep_id"
    OnRowCommand="GridViewTalepler_RowCommand" >
    <Columns>
        <asp:BoundField DataField="ogrenci_id" HeaderText="Öğrenci ID" /> 
        <asp:BoundField DataField="ogrenci_adi" HeaderText="Öğrenci Adı" />
        <asp:BoundField DataField="talep_tipi" HeaderText="Talep Tipi" />
        <asp:BoundField DataField="mevcut_oda_no" HeaderText="Mevcut Oda No" />
        <asp:BoundField DataField="hedef_oda_no" HeaderText="Yeni Oda No" />

                   
                    <asp:TemplateField HeaderText="Onayla">
                        <ItemTemplate>
                            <asp:Button ID="btnOnayla" runat="server" Text="Onayla" CssClass="btn btn-success"
                                CommandName="Onayla" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                  
                    <asp:TemplateField HeaderText="Reddet">
                        <ItemTemplate>
                            <asp:Button ID="btnReddet" runat="server" Text="Reddet" CssClass="btn btn-warning"
                                CommandName="Reddet" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                 
                    <asp:TemplateField HeaderText="Sil">
                        <ItemTemplate>
                            <asp:Button ID="btnSil" runat="server" Text="Sil" CssClass="btn btn-danger"
                                CommandName="Sil" CommandArgument='<%# Container.DataItemIndex %>'
                                OnClientClick="return confirm('Bu talebi silmek istediğinize emin misiniz?');" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
        <div class="log-buton">
</div>
    </form>
</body>
</html>