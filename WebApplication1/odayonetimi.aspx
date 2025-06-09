<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="odayonetimi.aspx.cs" Inherits="WebApplication1.odayonetimi" %>

<!DOCTYPE html>
<html>
<head>
    <title>Oda Yönetimi</title>
    <link rel="stylesheet" href="odayonetimi.css">
</head>
<body>
    <form runat="server"> 
        <div class="container">
            <h2>Oda Yönetimi</h2>

            <asp:GridView ID="GridViewOdalar" runat="server" AutoGenerateColumns="False"
                DataKeyNames="oda_no" CssClass="table"
                OnRowEditing="GridViewOdalar_RowEditing"
                OnRowUpdating="GridViewOdalar_RowUpdating"
                OnRowCancelingEdit="GridViewOdalar_RowCancelingEdit"
                OnRowDeleting="GridViewOdalar_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="oda_no" HeaderText="Oda No" ReadOnly="True" />
                    <asp:BoundField DataField="kapasite" HeaderText="Kapasite" />
                    <asp:BoundField DataField="doluluk" HeaderText="Doluluk Durumu" />
                    
                    
                    <asp:TemplateField HeaderText="Bölüm">
                        <ItemTemplate>
                            <%# Eval("bolum_adi") %> 
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlBolumEdit" runat="server">
                            </asp:DropDownList> 
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" EditText="Düzenle" />
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Sil" />
                </Columns>
            </asp:GridView>

            <h3>Yeni Oda Ekle</h3>
            <asp:TextBox ID="odaNo" runat="server" placeholder="Oda No"></asp:TextBox>
            <asp:TextBox ID="kapasite" runat="server" placeholder="Kapasite"></asp:TextBox>

            
            <asp:DropDownList ID="ddlBolum" runat="server">
                <asp:ListItem Text="Bölüm Seçiniz" Value="" />
            </asp:DropDownList>

            <asp:Button ID="btnOdaEkle" runat="server" Text="Ekle" OnClick="btnOdaEkle_Click" />

            <asp:Button ID="btngeri" runat="server" Text="Geri" OnClick="btngeri_Click" />
        </div>
    </form>
</body>
</html>