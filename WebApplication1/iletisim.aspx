<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="WebApplication1.iletisim" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>İletişim</title>
    
    <link rel="stylesheet" href="global.css">
    <link rel="stylesheet" href="iletisim.css"><!-- ✅ İletişim sayfası için ayrı stil dosyası -->
</head>
<body>
    <div class="container">
        <header>
            <h1 style="color: white; font-size: 2.5em; text-align: center;">Yurt İletişim Bilgileri</h1>
        </header>

        <!-- ✅ Ana Sayfa ile uyumlu üst menü -->
        <nav>
            <ul>
                <li><a href="anasayfa.aspx" class="button">Ana Sayfa</a></li>

            </ul>
        </nav>

        <main>
            <section class="contact-info">
                <h2>İletişim Bilgileri</h2>
                <p><strong>Adres:</strong> Örnek Mah. 123. Sokak No: 45, Kastamonu, Türkiye</p>
                <p><strong>Telefon:</strong> +90 555 123 45 67</p>
                <p><strong>E-Posta:</strong> info@ornekyurt.com</p>
                <p><strong>Çalışma Saatleri:</strong> Pazartesi - Cuma: 08:00 - 18:00</p>
                
                <h3>Konum</h3>
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3123.789123947095!2d33.789123947095!3d41.389123947095!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0000000000000000%3A0x1234567890abcdef!2sKastamonu%20Üniversitesi!5e0!3m2!1str!2str!4v1234567890123" width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>