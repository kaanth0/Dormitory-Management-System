<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="izintalebi.aspx.cs" Inherits="WebApplication1.izintalebi" %>

<!DOCTYPE html>
<html>
<head>
    <title>İzin Talebi</title>
    <link rel="stylesheet" href="ortaktalep.css">
</head>
<body>
    <form runat="server">
        <div class="container">
            <h2>İzin Talebi Gönder</h2>

            <!-- Öğrenci Bilgileri Otomatik Gelecek -->
            <label for="txtOgrenciAdi">Öğrenci Adı:</label>
            <asp:TextBox ID="txtOgrenciAdi" runat="server" CssClass="form-control" ReadOnly="true" />

            <label for="txtOdaNo">Oda No:</label>
            <asp:TextBox ID="txtOdaNo" runat="server" CssClass="form-control" ReadOnly="true" />

            <!-- İzin Bilgileri -->
            <label for="txtIzinBaslangic">İzin Başlangıç Tarihi:</label>
            <asp:TextBox ID="txtIzinBaslangic" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />

            <label for="txtIzinBitis">İzin Bitiş Tarihi:</label>
            <asp:TextBox ID="txtIzinBitis" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />

            <label for="txtIzinSebebi">İzin Sebebi:</label>
            <asp:TextBox ID="txtIzinSebebi" runat="server" CssClass="form-control" TextMode="MultiLine" />

            <asp:Button ID="btnTalepGonder" runat="server" Text="Talep Gönder" OnClick="btnTalepGonder_Click" CssClass="btn btn-primary" />

            <asp:Button ID="btnGeri" runat="server" Text="Geri Dön" OnClick="btnGeri_Click" CssClass="btn btn-secondary" />

            <asp:Label ID="lblMesaj" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>


