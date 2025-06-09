using System;
using MySql.Data.MySqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class odatalebi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔥 Eğer giriş yapılmamışsa, doğrudan giriş sayfasına yönlendir!
            if (Session["KullaniciAdi"] == null)
            {
                Response.Redirect("giris.aspx");
            }

            if (!IsPostBack)
            {
                // 🔥 Oturumu açan öğrencinin bilgilerini ekrana otomatik olarak yüklüyoruz!
                txtOgrenciAdi.Text = Session["Ad"]?.ToString() + " " + Session["Soyad"]?.ToString();
                txtOgrenciAdi.Enabled = false;

                txtMevcutOdaNo.Text = Session["OdaNo"]?.ToString();
                txtMevcutOdaNo.Enabled = false;
            }
        }

        protected void btnTalepGonder_Click(object sender, EventArgs e)
        {
            // 🔥 Öğrenci bilgilerini oturumdan çekiyoruz!
            string ogrenciID = Session["OgrenciID"]?.ToString();
            string ogrenciAdi = txtOgrenciAdi.Text.Trim();
            string mevcutOdaNo = txtMevcutOdaNo.Text.Trim();
            string hedefOdaNo = txtHedefOdaNo.Text.Trim();

            // 🔥 Eksik veri kontrolü
            if (string.IsNullOrEmpty(hedefOdaNo))
            {
                lblMesaj.Text = "Lütfen geçmek istediğiniz oda numarasını girin!";
                lblMesaj.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO oda_talepleri (ogrenci_id, ogrenci_adi, talep_tipi, mevcut_oda_no, hedef_oda_no, durum) VALUES (@ogrenciID, @ogrenciAdi, 'Oda Değişikliği', @mevcutOdaNo, @hedefOdaNo, 'Beklemede')";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    cmd.Parameters.AddWithValue("@ogrenciAdi", ogrenciAdi);
                    cmd.Parameters.AddWithValue("@mevcutOdaNo", mevcutOdaNo);
                    cmd.Parameters.AddWithValue("@hedefOdaNo", hedefOdaNo);
                    cmd.ExecuteNonQuery();
                }
            }

            // 🔥 Başarı mesajı gösteriyoruz!
            lblMesaj.Text = "Oda değişikliği talebiniz başarıyla gönderildi!";
            lblMesaj.ForeColor = System.Drawing.Color.Green;

            // 🔥 Formu temizliyoruz!
            txtHedefOdaNo.Text = "";
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("ogrenci.aspx"); // 📌 Öğrenciyi ana sayfaya yönlendir!
        }
    }
}