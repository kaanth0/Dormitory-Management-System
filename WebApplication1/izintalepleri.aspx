<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="izintalepleri.aspx.cs" Inherits="WebApplication1.izintalepleri" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>İzin Talepleri Yönetimi</title>
    <link rel="stylesheet" href="izintalepleri.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h2 class="text-center">İzin Talepleri Yönetimi</h2>
            <hr />

            <asp:GridView ID="GridViewIzinTalepleri" runat="server" AutoGenerateColumns="False"
                DataKeyNames="izin_id" CssClass="table table-striped"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="GridViewIzinTalepleri_PageIndexChanging"
                OnRowCommand="GridViewIzinTalepleri_RowCommand">
                
                <Columns>
                    <asp:BoundField DataField="izin_id" HeaderText="İzin ID" />
                    <asp:BoundField DataField="ogrenci_id" HeaderText="Öğrenci ID" />
                    <asp:BoundField DataField="ogrenci_adi" HeaderText="Öğrenci Adı" />
                    <asp:BoundField DataField="oda_no" HeaderText="Oda No" />
                    <asp:BoundField DataField="izin_baslangic" HeaderText="Başlangıç Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_bitis" HeaderText="Bitiş Tarihi" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                    <asp:BoundField DataField="izin_sebebi" HeaderText="İzin Sebebi" />
                    <asp:BoundField DataField="durum" HeaderText="Durum" />

                   
                    <asp:TemplateField HeaderText="Onayla">
                        <ItemTemplate>
                            <asp:Button ID="btnOnayla" runat="server" Text="Onayla" CssClass="btn btn-success"
                                CommandName="Onayla" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Reddet">
                        <ItemTemplate>
                            <asp:Button ID="btnReddet" runat="server" Text="Reddet" CssClass="btn btn-danger"
                                CommandName="Reddet" CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="text-center mt-4">
                <asp:Button ID="btnGeri" runat="server" CssClass="btn btn-primary" Text="Geri Dön" OnClick="btnGeri_Click" />
            </div>
            <div class="text-center mt-4">
    <asp:Button ID="btnLoglar" runat="server" CssClass="btn btn-info" Text="İzin Logları" OnClick="btnLoglar_Click" />
   
</div>
        </div>
    </form>
</body>
</html>