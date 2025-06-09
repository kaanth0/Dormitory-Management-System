y<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Yemekhane.aspx.cs" Inherits="WebApplication1.Yemekhane" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yemekhane - Aylık Menü</title>
    <link rel="stylesheet" href="gloal.css">
    <link rel="stylesheet" href="yemekhane.css">
    <script>
        function toggleMenu() {
            var fullMenu = document.getElementById("fullMenu");
            fullMenu.style.display = (fullMenu.style.display === "none") ? "block" : "none";
        }
    </script>
</head>
<body>
    <div class="container">
        <header>
            <h1>Yemekhane - Aylık Menü</h1>
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
            <section class="menu">
                <h2>Bugünün Menüsü</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Kahvaltı</th>
                            <th>Öğle Yemeği</th>
                            <th>Akşam Yemeği</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="today">
                            <td><asp:Literal ID="bugunKahvalti" runat="server"></asp:Literal></td>
                            <td><asp:Literal ID="bugunOgle" runat="server"></asp:Literal></td>
                            <td><asp:Literal ID="bugunAksam" runat="server"></asp:Literal></td>
                        </tr>
                    </tbody>
                </table>

                <button onclick="toggleMenu()" class="toggle-button">Tüm Ayı Göster</button>

                <div id="fullMenu" style="display: none;">
                    <h2>Aylık Yemek Listesi</h2>
                    <form runat="server">
                        <asp:GridView ID="AylikMenuGrid" runat="server" AutoGenerateColumns="False" CssClass="grid-table">
                            <Columns>
                                <asp:BoundField DataField="Tarih" HeaderText="Tarih" />
                                <asp:BoundField DataField="Kahvalti" HeaderText="Kahvaltı" />
                                <asp:BoundField DataField="Ogle" HeaderText="Öğle Yemeği" />
                                <asp:BoundField DataField="Aksam" HeaderText="Akşam Yemeği" />
                            </Columns>
                        </asp:GridView>
                    </form>
                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>