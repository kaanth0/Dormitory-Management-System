using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class talepsonuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔥 Eğer öğrenci giriş yapmamışsa, doğrudan giriş sayfasına yönlendiriyoruz!
            if (Session["OgrenciID"] == null)
            {
                Response.Redirect("giris.aspx");
            }

            if (!IsPostBack)
            {
                LoadOdaTalepleri();
                LoadIzinTalepleri();
            }
        }

        private void LoadOdaTalepleri()
        {
            string ogrenciID = Session["OgrenciID"]?.ToString();
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT talep_id, mevcut_oda_no, hedef_oda_no, talep_tarihi, durum, red_sebebi 
                                FROM oda_talepleri 
                                WHERE ogrenci_id = @ogrenciID 
                                ORDER BY talep_tarihi DESC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    adapter.SelectCommand.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewOdaTalepleri.DataSource = dt;
                    GridViewOdaTalepleri.DataBind();
                }
            }
        }

        private void LoadIzinTalepleri()
        {
            string ogrenciID = Session["OgrenciID"]?.ToString();
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT izin_id, izin_baslangic, izin_bitis, izin_sebebi, durum, onay_tarihi 
                                FROM izinler 
                                WHERE ogrenci_id = @ogrenciID 
                                ORDER BY izin_baslangic DESC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    adapter.SelectCommand.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewIzinTalepleri.DataSource = dt;
                    GridViewIzinTalepleri.DataBind();
                }
            }
        }

        protected void GridViewOdaTalepleri_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewOdaTalepleri.PageIndex = e.NewPageIndex;
            LoadOdaTalepleri();
        }

        protected void GridViewIzinTalepleri_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewIzinTalepleri.PageIndex = e.NewPageIndex;
            LoadIzinTalepleri();
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("ogrenci.aspx"); // 🔥 Öğrenciyi ana sayfasına yönlendiriyoruz!
        }
    }
}