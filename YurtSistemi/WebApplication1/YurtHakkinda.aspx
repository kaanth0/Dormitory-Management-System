<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YurtHakkinda.aspx.cs" Inherits="WebApplication1.YurtHakkinda" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yurt Hakkında</title>
    <link rel="stylesheet" href="gloal.css" />
    <link rel="stylesheet" href="yurthakkinda.css" />

</head>
<body>
    <div class="container">
        <header>
            
            <h1>Yurt Hakkında
            </h1>
            <nav>
                <ul>
                    <li><a href="anasayfa.aspx" class="button">Anasayfa</a></li>
                    <li><a href="YurtHakkinda.aspx" class="button">Yurt Hakkında</a></li>
                    <li><a href="Duyurular.aspx" class="button">Duyurular</a></li>
                    <li><a href="Fotograflar.aspx" class="button">Fotoğraflar</a></li>
                    <li><a href="Yemekhane.aspx" class="button">Yemekhane</a></li>
                    <li><a href="giris.aspx" class="button">Giris</a></li>
                    <li><a href="kayit.aspx" class="button">Ön Kayıt</a></li>
                    <li><a href="Iletisim.aspx" class="button">İletişim</a></li>
                    <li><a href="Yonetici_giris.aspx" class="button">Yönetici</a></li>  
                </ul>
            </nav>
        </header>

        <main>
            <section class="yurt-info">
                <h2>Yurdumuz Hakkında</h2>
                <p>Yurdumuz, konforlu odaları, geniş sosyal alanları ve güvenlik hizmetleri ile öğrencilerin rahat bir yaşam sürmesi için tasarlanmıştır.</p>
                
                <h3>Yurdun Özellikleri</h3>
                <div class="features">
                    <div>📍 Konum: Kastamonu, Türkiye</div>
                    <div>🏠 200+ Kişilik Konaklama Kapasitesi</div>
                    <div>🍽️ Yemekhane & Kafeterya</div>
                    <div>📚 Etüt ve Çalışma Alanları</div>
                    <div>🔒 24/7 Güvenlik & Kamera Sistemi</div>
                </div>

                <h3>Yurdumuzdan Görüntüler</h3>
                <div class="gallery">
                    <img src="img/yurt1.jpg" alt="Yurt Odası">
                    <img src="img/yurt2.jpg" alt="Çalışma Alanı">
                    <img src="img/yurt3.jpg" alt="Sosyal Alan">
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>