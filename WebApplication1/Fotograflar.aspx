<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fotograflar.aspx.cs" Inherits="WebApplication1.Fotograflar" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fotoğraflar</title>
    <link rel="stylesheet" href="fotograflar.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Yurt Fotoğrafları</h1>   
            <nav>
                <ul>
                    <li><a href="anasayfa.aspx" class="button">Anasayfa</a></li>
                    <li><a href="YurtHakkinda.aspx" class="button">Yurt Hakkında</a></li>
                    <li><a href="Duyurular.aspx" class="button">Duyurular</a></li>
                    <li><a href="Fotograflar.aspx" class="button">Fotoğraflar</a></li>
                    <li><a href="Yemekhane.aspx" class="button">Yemekhane</a></li>
                    <li><a href="giris.aspx" class="button">Giriş</a></li>
                    <li><a href="kayit.aspx" class="button">Ön Kayıt</a></li>
                    <li><a href="Iletisim.aspx" class="button">İletişim</a></li>
                    <li><a href="Yonetici_giris.aspx" class="button">Yönetici</a></li>  
                </ul>
            </nav>
        </header>

        <main>
            <section class="gallery">
                <h2>Yurt Fotoğrafları</h2>
                <div class="gallery-grid">
    <img src="img/yurtodas.png" alt="Yurt Odası1">
    <img src="img/calisma.jpg" alt="Çalışma Alanı">
    <img src="img/sosyal alan.jpg" alt="Sosyal Alan">
    <img src="img/yemekhane.jpg" alt="Yemekhane">
    <img src="img/dinlenme.jpg" alt="Dinlenme Alanı">
    <img src="img/yurtgiris.jpg" alt="Giriş Kapısı">
</div>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>