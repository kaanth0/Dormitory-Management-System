using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Yemekhane : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BugununMenusunuGetir();
                AylikMenuleriGetir();
            }
            
        }

        private void BugununMenusunuGetir()
        {
            using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
            {
                conn.Open();
                string sql = "SELECT Kahvalti, Ogle, Aksam FROM Yemekhane WHERE Tarih = CURDATE()";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            bugunKahvalti.Text = reader["Kahvalti"].ToString();
                            bugunOgle.Text = reader["Ogle"].ToString();
                            bugunAksam.Text = reader["Aksam"].ToString();
                        }
                        else
                        {
                            bugunKahvalti.Text = "Menü bulunamadı!";
                            bugunOgle.Text = "Menü bulunamadı!";
                            bugunAksam.Text = "Menü bulunamadı!";
                        }
                    }
                }
            }
        }

        private void AylikMenuleriGetir()
        {
            using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
            {
                conn.Open();
                string sql = "SELECT DATE_FORMAT(Tarih, '%d %M %Y') AS Tarih, Kahvalti, Ogle, Aksam FROM Yemekhane ORDER BY Tarih ASC";
                using (MySqlDataAdapter da = new MySqlDataAdapter(sql, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    AylikMenuGrid.DataSource = dt;
                    AylikMenuGrid.DataBind();
                }
            }
        }
    }
}