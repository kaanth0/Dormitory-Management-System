<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Yemekhane_Yonetimi.aspx.cs" Inherits="WebApplication1.Yemekhane_Yonetimi" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yemekhane Yönetimi</title>
    
    <link rel="stylesheet" href="yemekhane_yonetimi.css">
</head>
<body>
    <div class="container">
        <header>
            <h1 style="color: white; font-size: 2.5em; text-align: center;">Yemekhane Yönetimi</h1>
        </header>

        <main>
            
            <form runat="server">

               
                <asp:GridView ID="YemekhaneGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="yemek_id"
                    OnRowDeleting="YemekhaneGrid_RowDeleting" CssClass="grid-table">
                    <Columns>
                        <asp:BoundField DataField="Tarih" HeaderText="Tarih" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Kahvalti" HeaderText="Kahvaltı" />
                        <asp:BoundField DataField="Ogle" HeaderText="Öğle Yemeği" />
                        <asp:BoundField DataField="Aksam" HeaderText="Akşam Yemeği" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="Sil" />

                    </Columns>
                </asp:GridView>

                <hr>

                <!-- 🔥 Yeni Yemek Menüsü Ekleme Formu -->
                <label for="TarihTxt">Tarih:</label>
                <asp:TextBox ID="TarihTxt" runat="server" CssClass="input" TextMode="Date"></asp:TextBox>

                <label for="KahvaltiTxt">Kahvaltı:</label>
                <asp:TextBox ID="KahvaltiTxt" runat="server" CssClass="input"></asp:TextBox>

                <label for="OgleTxt">Öğle Yemeği:</label>
                <asp:TextBox ID="OgleTxt" runat="server" CssClass="input"></asp:TextBox>

                <label for="AksamTxt">Akşam Yemeği:</label>
                <asp:TextBox ID="AksamTxt" runat="server" CssClass="input"></asp:TextBox>

                <asp:Button ID="EkleBtn" runat="server" Text="Menüyü Ekle" CssClass="button" OnClick="EkleBtn_Click" />
                <asp:Button ID="SilBtn" runat="server" Text="Tümünü Sil" OnClick="SilBtn_Click" CssClass="btn btn-danger" />
                <asp:Button ID="btngeri" runat="server" Text="Geri" CssClass="button" OnClick="btngeri_Click" />

                <hr>

                <!-- 🔥 Excel Dosyası Yükleme Alanı -->
                <label for="ExcelDosya">Cvs Dosyası Yükle:</label>
                <asp:FileUpload ID="ExcelDosya" runat="server" CssClass="input" />
                <asp:Button ID="YukleBtn" runat="server" Text="Yemek Listesini Yükle" CssClass="button" OnClick="YukleBtn_Click" />

            </form> <!-- 🔥 Form etiketi burada kapanıyor, tüm bileşenleri kapsıyor -->
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>