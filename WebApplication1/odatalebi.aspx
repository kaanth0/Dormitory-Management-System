<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="odatalebi.aspx.cs" Inherits="WebApplication1.odatalebi" %>

<!DOCTYPE html>
<html>
<head>
    <title>Oda Değişikliği Talebi</title>
    <link rel="stylesheet" href="ortaktalep.css">
</head>
<body>
    <form runat="server">
        <div class="container">
            <h2>Oda Değişikliği Talebi</h2>

            <!-- Öğrenci bilgileri oturumdan otomatik çekilecek -->
            <label for="txtOgrenciAdi">Öğrenci Adı:</label>
            <asp:TextBox ID="txtOgrenciAdi" runat="server" CssClass="form-control" ReadOnly="true" />

            <label for="txtMevcutOdaNo">Mevcut Oda No:</label>
            <asp:TextBox ID="txtMevcutOdaNo" runat="server" CssClass="form-control" ReadOnly="true" />

            <label for="txtHedefOdaNo">Geçmek İstediğiniz Oda No:</label>
            <asp:TextBox ID="txtHedefOdaNo" runat="server" CssClass="form-control" />

            <asp:Button ID="btnTalepGonder" runat="server" Text="Talep Gönder" OnClick="btnTalepGonder_Click" CssClass="btn btn-primary" />

            <asp:Button ID="btnGeri" runat="server" Text="Geri Dön" OnClick="btnGeri_Click" CssClass="btn btn-secondary" />

            <asp:Label ID="lblMesaj" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>