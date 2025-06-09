<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="giris.aspx.cs" Inherits="WebApplication1.giris" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Öğrenci Girişi</title>
    <link rel="stylesheet" href="vip.css">
</head>
<body>
    <div class="container">
        <header>
          
            <h1>Öğrenci Giriş Sayfası</h1>            

        </header>

        <main>
            <section class="login-form">


                
                <form runat="server">
                    <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <label for="kullaniciAdi">Kullanıcı Adı:</label>
                    <asp:TextBox ID="kullaniciAdi" runat="server"></asp:TextBox>

                    <label for="sifre">Şifre:</label>
                    <asp:TextBox ID="sifre" runat="server" TextMode="Password"></asp:TextBox>

                    <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" CssClass="button" OnClick="btnGiris_Click"/>

<asp:Button ID="btnAnasayfa" runat="server" Text="Ana Sayfaya Dön" CssClass="button-back" OnClick="btnAnasayfa_Click"/>

                </form>

                <p class="register-link">Hesabın yok mu? <a href="kayit.aspx">Kayıt Ol</a></p>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>