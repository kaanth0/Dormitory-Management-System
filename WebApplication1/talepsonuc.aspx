<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="talepsonuc.aspx.cs" Inherits="WebApplication1.talepsonuc" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Talep Sonuçlarım</title>
    <link rel="stylesheet" href="talepsonuc.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center">Talep Sonuçlarım</h2>
            <hr />

            <!-- 🔥 Oda Değiştirme Talepleri -->
            <h3 class="text-center text-primary">Oda Değiştirme Talepleri</h3>
            <asp:GridView ID="GridViewOdaTalepleri" runat="server" AutoGenerateColumns="False"
                DataKeyNames="talep_id" CssClass="table table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewOdaTalepleri_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField DataField="talep_id" HeaderText="Talep ID" />
                    <asp:BoundField DataField="mevcut_oda_no" HeaderText="Mevcut Oda No" />
                    <asp:BoundField DataField="hedef_oda_no" HeaderText="Hedef Oda No" />
                    <asp:BoundField DataField="talep_tarihi" HeaderText="Talep Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />
                    <asp:BoundField DataField="red_sebebi" HeaderText="Red Sebebi" />
                </Columns>
            </asp:GridView>

            <hr />

            <!-- 🔥 İzin Talepleri -->
            <h3 class="text-center text-success">İzin Talepleri</h3>
            <asp:GridView ID="GridViewIzinTalepleri" runat="server" AutoGenerateColumns="False"
                DataKeyNames="izin_id" CssClass="table table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewIzinTalepleri_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField DataField="izin_id" HeaderText="İzin ID" />
                    <asp:BoundField DataField="izin_baslangic" HeaderText="Başlangıç Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_bitis" HeaderText="Bitiş Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_sebebi" HeaderText="İzin Sebebi" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />
                    <asp:BoundField DataField="onay_tarihi" HeaderText="Onay/Reddetme Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                </Columns>
            </asp:GridView>

            <div class="text-center mt-4">
                <asp:Button ID="btnGeri" runat="server" CssClass="btn btn-primary" Text="Geri Dön" OnClick="btnGeri_Click" />
            </div>
        </div>
    </form>
</body>
</html>