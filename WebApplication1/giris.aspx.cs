using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication1
{
    public partial class giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı oturumu varsa doğrudan yönlendir
            if (Session["KullaniciAdi"] != null)
            {
                Response.Redirect("ogrenci.aspx");
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            string kullaniciAdiValue = kullaniciAdi.Text.Trim();
            string girisSifreValue = HashPassword(sifre.Text.Trim());

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT ogrenci_id, ad, soyad, bolum_id, oda_no FROM ogrenciler WHERE kullanici_adi = @kullaniciAdi AND sifre = @sifre";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@kullaniciAdi", kullaniciAdiValue);
                    cmd.Parameters.AddWithValue("@sifre", girisSifreValue);

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // 🔥 Kullanıcı bilgilerini session içine kaydet
                            Session["KullaniciAdi"] = kullaniciAdiValue;
                            Session["OgrenciID"] = reader["ogrenci_id"].ToString();
                            Session["Ad"] = reader["ad"].ToString();
                            Session["Soyad"] = reader["soyad"].ToString();
                            Session["BolumID"] = reader["bolum_id"].ToString();
                            Session["OdaNo"] = reader["oda_no"].ToString();
                            Session.Timeout = 120;

                            // 🔥 Hata olup olmadığını görmek için ekrana alert mesajı yazdır
                            string debugMessage = $"Session Kaydedildi: ID={Session["OgrenciID"]}, Ad={Session["Ad"]}, Oda={Session["OdaNo"]}";
                            ClientScript.RegisterStartupScript(this.GetType(), "sessionDebug", $"alert('{debugMessage}');", true);

                            // 🚀 Eğer hata yoksa sayfayı yönlendir
                            Response.Redirect("ogrenci.aspx");
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Hatalı kullanıcı adı veya şifre!');", true);
                        }
                    }
                }
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            }
        }

        protected void btnAnasayfa_Click(object sender, EventArgs e)
        {
            Response.Redirect("anasayfa.aspx");
        }
    }
}