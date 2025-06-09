<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ogrenci.aspx.cs" Inherits="WebApplication1.ogrenci" %>

<!DOCTYPE html>
<html>
<head>
    <title>Öğrenci Paneli</title>
    <link rel="stylesheet" href="ogrenci.css">
</head>
<body>
    <form runat="server">
        <div class="container">
            <h2>Öğrenci Bilgi Paneli</h2>

            <!-- Öğrenci Bilgileri -->
            <div class="bilgiler">
                <label>Ad Soyad:</label>
                <asp:Label ID="lblAdSoyad" runat="server" CssClass="form-label"></asp:Label>

                <label>Doğum Tarihi:</label>
                <asp:Label ID="lblDogumTarihi" runat="server" CssClass="form-label"></asp:Label>

                <label>Bölüm:</label>
                <asp:Label ID="lblBolum" runat="server" CssClass="form-label"></asp:Label>

                <label>Oda Numarası:</label>
                <asp:Label ID="lblOdaNo" runat="server" CssClass="form-label"></asp:Label>
            </div>

            <!-- Talep Butonları -->
            <div class="talep-butonlari">
                <asp:Button ID="btnOdaDegisikligi" runat="server" Text="Oda Değişikliği Talebi Gönder"
                    CssClass="btn btn-primary" OnClientClick="window.location.href='odatalebi.aspx'; return false;" />

                <asp:Button ID="btnIzinTalebi" runat="server" Text="İzin Talebi Gönder"
                    CssClass="btn btn-success" OnClientClick="window.location.href='izintalebi.aspx'; return false;" />
            </div>

            <!-- Çıkış Butonu -->
            <div class="cikis">
                <asp:Button ID="btnCikis" runat="server" Text="Çıkış Yap" OnClick="btnCikis_Click"
                    CssClass="btn btn-danger" />
                <asp:Button ID="btnAnaSayfa" runat="server" Text="Ana Sayfa" CssClass="btn btn-dark"
    OnClientClick="window.location.href='anasayfa.aspx'; return false;" />

<asp:Button ID="btnTalepSonuc" runat="server" Text="Talep Sonuçları" CssClass="btn btn-primary"
    OnClick="btnTalepSonuc_Click" />
            </div>
        </div>

    </form>
</body>
</html>