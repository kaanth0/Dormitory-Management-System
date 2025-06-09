using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class izintalepleri : System.Web.UI.Page
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
                LoadIzinTalepleri();
            }
        }

        private void LoadIzinTalepleri()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT izin_id, ogrenci_id, ogrenci_adi, oda_no, izin_baslangic, 
                                izin_bitis, izin_sebebi, durum 
                                FROM izinler 
                                WHERE durum = 'Beklemede' 
                                ORDER BY izin_baslangic ASC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewIzinTalepleri.DataSource = dt;
                    GridViewIzinTalepleri.DataBind();
                }
            }
        }

        protected void GridViewIzinTalepleri_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Onayla")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int izinID = Convert.ToInt32(GridViewIzinTalepleri.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string updateQuery = "UPDATE izinler SET durum = 'Onaylandı', onay_tarihi = NOW() WHERE izin_id = @izinID";
                    using (MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@izinID", izinID);
                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "approveSuccess", "alert('İzin talebi onaylandı!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "approveFail", "alert('Hata: İzin talebi onaylanamadı!');", true);
                        }
                    }
                }

                LoadIzinTalepleri();
            }

            if (e.CommandName == "Reddet")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int izinID = Convert.ToInt32(GridViewIzinTalepleri.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string updateQuery = "UPDATE izinler SET durum = 'Reddedildi', onay_tarihi = NOW() WHERE izin_id = @izinID";
                    using (MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@izinID", izinID);
                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "rejectSuccess", "alert('İzin talebi reddedildi!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "rejectFail", "alert('Hata: İzin talebi reddedilemedi!');", true);
                        }
                    }
                }

                LoadIzinTalepleri();
            }
        }

        protected void btnLoglar_Click(object sender, EventArgs e)
        {
            Response.Redirect("izin_log.aspx"); // 🔥 Yöneticiyi izin logları sayfasına yönlendiriyoruz!
        }

       
        protected void GridViewIzinTalepleri_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewIzinTalepleri.PageIndex = e.NewPageIndex;
            LoadIzinTalepleri(); // 🔄 Sayfa değiştiğinde verileri tekrar çekiyoruz!
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx"); // 🔥 Yönetici ana sayfasına yönlendiriyoruz!
        }
    }
}