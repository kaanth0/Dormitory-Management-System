<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="anasayfa.aspx.cs" Inherits="WebApplication1.anasayfa" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yurt Otomasyon Sistemi - Ana Sayfa</title>
    <link rel="stylesheet" href="anasayfa.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Yurt Otomasyon Sistemi</h1>
            <nav>
    <ul>
        <li><a href="anasayfa.aspx" class="button">Anasayfa</a></li>
        <li><a href="YurtHakkinda.aspx" class="button">Yurt Hakkında</a></li>
        <li><a href="Duyurular.aspx" class="button">Duyurular</a></li>
        <li><a href="Fotograflar.aspx" class="button">Fotoğraflar</a></li>
        <li><a href="Yemekhane.aspx" class="button">Yemekhane</a></li>
        <li><a href="Iletisim.aspx" class="button">İletişim</a></li>
        <li><a href="Yonetici_giris.aspx" class="button">Yönetici Girişi</a></li>

        <% if (Session["KullaniciAdi"] != null) { %>
            <li><a href="ogrenci.aspx" class="button">Öğrenci Paneli</a></li>
            <li><a href="cikis.aspx" class="button">Çıkış Yap</a></li>
        <% } else { %>
            <li><a href="giris.aspx" class="button">Giriş Yap</a></li>
            <li><a href="kayit.aspx" class="button">Kayıt Ol</a></li>
        <% } %>
    </ul>
</nav>
        </header>
        <main>
            <h2>Hoş Geldiniz!</h2>
            <p>Yurt otomasyon sistemimize giriş yaparak çeşitli bilgilere ulaşabilir ve hizmetlerden faydalanabilirsiniz.</p>
        </main>
        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>
