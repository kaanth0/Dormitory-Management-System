using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class talep_log : System.Web.UI.Page
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
                LoadTalepLog();
            }
        }

        protected void GridViewTalepLog_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewTalepLog.PageIndex = e.NewPageIndex;
            LoadTalepLog(); // 🔄 Sayfa değiştiğinde tekrar verileri çekiyoruz!
        }
        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx"); // 🔥 Yönetici ana sayfasına yönlendiriyoruz!
        }

        protected void GridViewTalepLog_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int talepID = Convert.ToInt32(GridViewTalepLog.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM oda_talepleri WHERE talep_id = @talepID"; // 🔥 Log'u silmek için sorgu!
                    using (MySqlCommand deleteCmd = new MySqlCommand(deleteQuery, conn))
                    {
                        deleteCmd.Parameters.AddWithValue("@talepID", talepID);
                        int rowsAffected = deleteCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteSuccess", "alert('Log başarıyla silindi!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteFail", "alert('Hata: Log silinemedi!');", true);
                        }
                    }
                }

                LoadTalepLog(); // 🔄 Listeyi güncelle
            }
        }
        private void LoadTalepLog()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT talep_id, ogrenci_id, ogrenci_adi, talep_tipi, mevcut_oda_no, 
                                hedef_oda_no, talep_tarihi, onay_tarihi, durum, red_sebebi 
                                FROM oda_talepleri 
                                WHERE durum IN ('Onaylandı', 'Reddedildi') 
                                ORDER BY onay_tarihi DESC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewTalepLog.DataSource = dt;
                    GridViewTalepLog.DataBind();
                }
            }
        }
    }
}