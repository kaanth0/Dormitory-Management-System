using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class ogrenci : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KullaniciAdi"] == null)
            {
                Response.Redirect("giris.aspx"); // 🔥 Eğer giriş yapılmamışsa, login sayfasına yönlendir!
            }

            if (!IsPostBack)
            {
                LoadOgrenciBilgileri(); // 🔥 Öğrenci bilgilerini ekrana yükle!
            }
        }

        private void LoadOgrenciBilgileri()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            int ogrenciID = Convert.ToInt32(Session["OgrenciID"]); // 🔥 Öğrenci ID'sini Session'dan al!

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT ad, soyad, DATE_FORMAT(dogum_tarihi, '%d/%m/%Y') AS dogum_tarihi, bolum_adi, oda_no FROM ogrenciler INNER JOIN bolumler ON ogrenciler.bolum_id = bolumler.bolum_id WHERE ogrenci_id = @ogrenciID";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblAdSoyad.Text = $"{reader["ad"]} {reader["soyad"]}";
                            lblDogumTarihi.Text = reader["dogum_tarihi"].ToString();
                            lblBolum.Text = reader["bolum_adi"].ToString();
                            lblOdaNo.Text = reader["oda_no"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnIzinTalebi_Click(object sender, EventArgs e)
        {
            Response.Redirect("izintalebi.aspx"); // 📌 İzin talebi sayfasına yönlendirme
        }

        protected void btnOdaDegisikligi_Click(object sender, EventArgs e)
        {
            Response.Redirect("odatalebi.aspx"); // 📌 Oda değişikliği sayfasına yönlendirme
        }

        protected void btnCikis_Click(object sender, EventArgs e)
        {
            Session.Clear(); // 🔥 Kullanıcı oturumunu sıfırla!
            Response.Redirect("giris.aspx"); // 📌 Çıkış yapınca giriş sayfasına yönlendir!
        }

        protected void btnTalepSonuc_Click(object sender, EventArgs e)
        {

            Response.Redirect("talepsonuc.aspx", false);


        }
    }
}