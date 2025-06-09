<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="talep_log.aspx.cs" Inherits="WebApplication1.talep_log" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Talep Geçmişi</title>
    <link rel="stylesheet" href="talep_log.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center">Talep Geçmişi</h2>
            <hr />

            <asp:GridView ID="GridViewTalepLog" runat="server" AutoGenerateColumns="False"
                DataKeyNames="talep_id" CssClass="table table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewTalepLog_PageIndexChanging"
                OnRowCommand="GridViewTalepLog_RowCommand">
                
                <Columns>
                    <asp:BoundField DataField="talep_id" HeaderText="Talep ID" />
                    <asp:BoundField DataField="ogrenci_id" HeaderText="Öğrenci ID" />
                    <asp:BoundField DataField="ogrenci_adi" HeaderText="Öğrenci Adı" />
                    <asp:BoundField DataField="talep_tipi" HeaderText="Talep Tipi" />
                    <asp:BoundField DataField="mevcut_oda_no" HeaderText="Mevcut Oda No" />
                    <asp:BoundField DataField="hedef_oda_no" HeaderText="Hedef Oda No" />
                    <asp:BoundField DataField="talep_tarihi" HeaderText="Talep Tarihi" DataFormatString="{0:dd.MM.yyyy}" />
                    <asp:BoundField DataField="onay_tarihi" HeaderText="İşlem Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />

                    
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