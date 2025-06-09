using System;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class yonetici_giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdiValue = kullaniciAdi.Text.Trim(); // Kullanıcı adını al
            string sifreValue = HashPassword(sifre.Text.Trim()); // Şifreyi hashle

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT yonetici_id FROM yoneticiler WHERE kullanici_adi = @kullaniciAdi AND sifre = @sifre";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@kullaniciAdi", kullaniciAdiValue);
                    cmd.Parameters.AddWithValue("@sifre", sifreValue);

                    object yoneticiID = cmd.ExecuteScalar();
                    if (yoneticiID != null)
                    {
                        Session["yonetici_id"] = Convert.ToInt32(yoneticiID);
                        ClientScript.RegisterStartupScript(this.GetType(), "alertSuccess", "alert('Giriş başarılı!'); window.location='yonetici.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Kullanıcı adı veya şifre hatalı!');", true);
                    }
                }
            }
        }

        protected void btnAnasayfa_Click(object sender, EventArgs e)
        {
            Response.Redirect("anasayfa.aspx");
        }

        // SHA-256 ile şifre hashleme fonksiyonu
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }
    }
}