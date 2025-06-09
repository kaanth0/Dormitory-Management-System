using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class izin_log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔥 Yönetici oturumu açık mı kontrol edelim
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }

            if (!IsPostBack)
            {
                LoadIzinLog();
            }
        }

        private void LoadIzinLog()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT izin_id, ogrenci_id, ogrenci_adi, oda_no, izin_baslangic, 
                                izin_bitis, izin_sebebi, durum, onay_tarihi 
                                FROM izinler 
                                WHERE durum IN ('Onaylandı', 'Reddedildi') 
                                ORDER BY onay_tarihi DESC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewIzinLog.DataSource = dt;
                    GridViewIzinLog.DataBind();
                }
            }
        }

        protected void GridViewIzinLog_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int izinID = Convert.ToInt32(GridViewIzinLog.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM izinler WHERE izin_id = @izinID"; // 🔥 Log'u silmek için sorgu!
                    using (MySqlCommand deleteCmd = new MySqlCommand(deleteQuery, conn))
                    {
                        deleteCmd.Parameters.AddWithValue("@izinID", izinID);
                        int rowsAffected = deleteCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteSuccess", "alert('İzin geçmiş kaydı başarıyla silindi!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteFail", "alert('Hata: İzin geçmiş kaydı silinemedi!');", true);
                        }
                    }
                }

                LoadIzinLog();
            }
        }

        protected void GridViewIzinLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewIzinLog.PageIndex = e.NewPageIndex;
            LoadIzinLog(); // 🔄 Sayfa değiştiğinde verileri tekrar çekiyoruz!
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx"); // 🔥 Yönetici ana sayfasına yönlendiriyoruz!
        }
    }
}