<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="yonetici_giris.aspx.cs" Inherits="WebApplication1.yonetici_giris" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetici Girişi</title>
    <link rel="stylesheet" href="globl.css">
    <link rel="stylesheet" href="vip.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Yönetici Girişi</h1>
        </header>

        <main>
            <section class="login-form">
                <h2>Lütfen Giriş Yapın</h2>
                <form runat="server">
                    <label for="kullaniciAdi">Kullanıcı Adı:</label>
                    <asp:TextBox ID="kullaniciAdi" runat="server"></asp:TextBox>

                    <label for="sifre">Şifre:</label>
                    <asp:TextBox ID="sifre" runat="server" TextMode="Password"></asp:TextBox>

                    <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" CssClass="button" OnClick="btnGiris_Click"/>
                    <asp:Button ID="btnAnasayfa" runat="server" Text="Ana Sayfaya Dön" CssClass="button-back" OnClick="btnAnasayfa_Click"/>

                </form>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>