<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Duyurular.aspx.cs" Inherits="WebApplication1.Duyurular" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Duyurular</title>
    <link rel="stylesheet" href="duyurular.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Yurt Duyuruları</h1>
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
            <section class="duyurular">
                <h2>Son Duyurular</h2>
                
                <!-- 🔥 Dinamik duyurular buraya ekleniyor, dışarı çıkmayacak! -->
                <asp:PlaceHolder ID="DuyuruListe" runat="server"></asp:PlaceHolder>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>