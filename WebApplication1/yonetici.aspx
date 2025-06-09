<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="yonetici.aspx.cs" Inherits="WebApplication1.yonetici" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetici Paneli</title>
    <link rel="stylesheet" href="yonetici.css">
</head>
<body>
    <form runat="server"> <!-- ✅ Form etiketi eklendi! -->
        <div class="container">
            <header>
                <h1>Yönetici Paneli</h1>
            </header>

            <main>
                <div class="panel">
                    <h2>Hoşgeldiniz, Yönetici!</h2>
                    <p>İşlem yapmak istediğiniz bölümü seçin:</p>

                    <div class="buttons">
                        <a href="ogrenci_yonetimi.aspx" class="btn">Öğrenci Yönetimi</a>
                        <a href="odayonetimi.aspx" class="btn">Oda Yönetimi</a>
                        <a href="ogrencitalepleri.aspx" class="btn">Öğrenci Talepleri</a>
                        <a href="izintalepleri.aspx" class="btn">İzin Talepleri</a>
                        <a href="duyuruyonetim.aspx" class="btn">Duyuru Yönetimi</a>
                        <a href="yemekhane_yonetimi.aspx" class="btn">Yemekhane Yönetimi</a>
                    </div>

                    <!-- ✅ Buton artık form etiketi içinde! -->
                    <asp:Button ID="btnCikis" runat="server" Text="Çıkış Yap" CssClass="btn btn-danger" OnClick="btnCikis_Click" />

                </div>
            </main>

            <footer>
                <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
            </footer>
        </div>
    </form> <!-- ✅ Form etiketi kapatıldı! -->
</body>
</html>