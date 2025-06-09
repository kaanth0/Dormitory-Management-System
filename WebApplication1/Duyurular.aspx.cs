using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Duyurular : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DuyurulariListele();
            }
        }

        private void DuyurulariListele()
        {
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT duyuru_id, Baslik, Metin, DATE_FORMAT(Tarih, '%d %M %Y') AS Tarih FROM duyurular ORDER BY Tarih DESC";
                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                foreach (DataRow row in dt.Rows)
                {
                    Literal duyuru = new Literal();
                    duyuru.Text = $"<div class='duyuru'>" +
                                  $"<span class='duyuru-tarih'>{row["Tarih"]}</span>" +
                                  $"<h3 class='duyuru-baslik'>{row["Baslik"]}</h3>" +
                                  $"<p>{row["Metin"]}</p>" +
                                  $"</div>";
                    DuyuruListe.Controls.Add(duyuru); // 🔥 Duyuru yalnızca burada gösterilecek!
                }
            }
        }
    }
}