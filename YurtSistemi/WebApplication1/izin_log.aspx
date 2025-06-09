<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="izin_log.aspx.cs" Inherits="WebApplication1.izin_log" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>İzin Logları</title>
    <link rel="stylesheet" href="izin_log.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center">İzin Talepleri Geçmişi</h2>
            <hr />

            <asp:GridView ID="GridViewIzinLog" runat="server" AutoGenerateColumns="False"
                DataKeyNames="izin_id" CssClass="table table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewIzinLog_PageIndexChanging"
                OnRowCommand="GridViewIzinLog_RowCommand">
                
                <Columns>
                    <asp:BoundField DataField="izin_id" HeaderText="İzin ID" />
                    <asp:BoundField DataField="ogrenci_id" HeaderText="Öğrenci ID" />
                    <asp:BoundField DataField="ogrenci_adi" HeaderText="Öğrenci Adı" />
                    <asp:BoundField DataField="oda_no" HeaderText="Oda No" />
                    <asp:BoundField DataField="izin_baslangic" HeaderText="Başlangıç Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_bitis" HeaderText="Bitiş Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_sebebi" HeaderText="İzin Sebebi" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />
                    <asp:BoundField DataField="onay_tarihi" HeaderText="Onay/Reddetme Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />

               
                    <asp:TemplateField HeaderText="Sil">
                        <ItemTemplate>
                            <asp:Button ID="btnSilLog" runat="server" Text="Sil" CssClass="btn btn-danger"
                                CommandName="Sil" CommandArgument='<%# Container.DataItemIndex %>'
                                OnClientClick="return confirm('Bu log kaydını silmek istediğinize emin misiniz?');" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

            <div class="text-center mt-4">
                <asp:Button ID="btnGeri" runat="server" CssClass="btn btn-primary" Text="Geri Dön" OnClick="btnGeri_Click" />
            </div>
        </div>
    </form>
</body>
</html>