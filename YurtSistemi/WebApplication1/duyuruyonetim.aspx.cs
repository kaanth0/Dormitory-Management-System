using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class DuyuruYonetim : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DuyurulariListele();
            }
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        private void DuyurulariListele()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT duyuru_id, Baslik, Metin, Tarih FROM duyurular ORDER BY Tarih DESC"; // 🔥 duyuru_id eklendi!
                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                DuyuruGrid.DataSource = dt;
                DuyuruGrid.DataBind();
            }
        }

        protected void EkleBtn_Click(object sender, EventArgs e)
        {
            string baslik = BaslikTxt.Text;
            string metin = MetinTxt.Text;

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "INSERT INTO duyurular (Baslik, Metin, Tarih) VALUES (@Baslik, @Metin, NOW())";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Baslik", baslik);
                    cmd.Parameters.AddWithValue("@Metin", metin);
                    cmd.ExecuteNonQuery();
                }
            }
            DuyurulariListele();
        }

        protected void DuyuruGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int duyuruID = Convert.ToInt32(DuyuruGrid.DataKeys[e.RowIndex].Value); // 🔥 Hata burada olabilir!

            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "DELETE FROM duyurular WHERE duyuru_id=@duyuru_id";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@duyuru_id", duyuruID);
                    cmd.ExecuteNonQuery();
                }
            }
            DuyurulariListele(); // 🔥 Silme işlemi sonrasında listeyi yeniliyoruz!
        }

        protected void btngeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx");
        }
    }
}