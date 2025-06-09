<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="kayit.aspx.cs" Inherits="WebApplication1.kayit" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Öğrenci Kayıt</title>
    <link rel="stylesheet" href="kayit.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Öğrenci Kayıt Sayfası</h1>
        </header>

        <main>
            <section class="register-form">
                <h2>Kayıt Ol</h2>

                <form runat="server">
                    <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <label for="ad">Ad:</label>
                    <asp:TextBox ID="ad" runat="server"></asp:TextBox>

                    <label for="soyad">Soyad:</label>
                    <asp:TextBox ID="soyad" runat="server"></asp:TextBox>

                    <label for="kullaniciAdi">Kullanıcı Adı:</label>
                    <asp:TextBox ID="kullaniciAdi" runat="server"></asp:TextBox>

                    <label for="sifre">Şifre:</label>
                    <asp:TextBox ID="sifre" runat="server" TextMode="Password"></asp:TextBox>

                    <label for="eposta">E-Posta:</label>
                    <asp:TextBox ID="eposta" runat="server"></asp:TextBox>

                    <label for="dogumTarihi">Doğum Tarihi:</label>
                    <asp:TextBox ID="dogumTarihi" runat="server" TextMode="Date"></asp:TextBox>

                    <label for="bolum">Bölüm:</label>
                    <asp:DropDownList ID="bolum" runat="server"></asp:DropDownList>

                    <asp:Button ID="btnKayit" runat="server" Text="Kayıt Ol" CssClass="button" OnClick="btnKayit_Click"/>
                    <asp:Button ID="btnAnasayfa" runat="server" Text="Ana Sayfaya Dön" CssClass="button-back" OnClick="btnAnasayfa_Click"/>

                </form>

                <p class="login-link">Zaten hesabın var mı? <a href="giris.aspx">Giriş Yap</a></p>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>