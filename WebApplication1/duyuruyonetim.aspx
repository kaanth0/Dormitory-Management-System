<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DuyuruYonetim.aspx.cs" Inherits="WebApplication1.DuyuruYonetim" %>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Duyuru Yönetimi</title>
    <link rel="stylesheet" href="yonetici.css">
    <link rel="stylesheet" href="duyuruyonetim.css">
</head>
<body>
    <div class="container">
        <header>
            <h1 style="color: white; font-size: 2.5em; text-align: center;">Duyuru Yönetimi</h1>
        </header>

        <main>
            <form runat="server">
                <asp:GridView ID="DuyuruGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="duyuru_id"
    OnRowDeleting="DuyuruGrid_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="duyuru_id" HeaderText="ID" />
                        <asp:BoundField DataField="Baslik" HeaderText="Başlık" />
                        <asp:BoundField DataField="Metin" HeaderText="Metin" />
                        <asp:BoundField DataField="Tarih" HeaderText="Tarih" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="Sil" />
                    </Columns>
                </asp:GridView>

                <hr>

                <label for="BaslikTxt">Duyuru Başlığı:</label>
                <asp:TextBox ID="BaslikTxt" runat="server" CssClass="input"></asp:TextBox>

                <label for="MetinTxt">Duyuru Metni:</label>
                <asp:TextBox ID="MetinTxt" runat="server" CssClass="input" TextMode="MultiLine"></asp:TextBox>

                <asp:Button ID="EkleBtn" runat="server" Text="Duyuruyu Ekle" CssClass="button" OnClick="EkleBtn_Click" />

                <asp:Button ID="btngeri" runat="server" Text="Geri" CssClass="button" OnClick="btngeri_Click" />
            </form>
        </main>

        <footer>
            <p>&copy; 2025 Yurt Otomasyon Sistemi</p>
        </footer>
    </div>
</body>
</html>