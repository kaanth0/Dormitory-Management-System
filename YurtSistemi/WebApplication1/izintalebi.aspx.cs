using System;
using MySql.Data.MySqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class izintalebi : System.Web.UI.Page
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
                // 🔥 Oturum açan öğrencinin bilgilerini ekrana otomatik olarak yüklüyoruz!
                txtOgrenciAdi.Text = Session["Ad"]?.ToString() + " " + Session["Soyad"]?.ToString();
                txtOgrenciAdi.Enabled = false;

                txtOdaNo.Text = Session["OdaNo"]?.ToString();
                txtOdaNo.Enabled = false;
            }
        }

        protected void btnTalepGonder_Click(object sender, EventArgs e)
        {
            // 🔥 Öğrenci bilgilerini çekiyoruz!
            string ogrenciID = Session["OgrenciID"]?.ToString();
            string ogrenciAdi = txtOgrenciAdi.Text.Trim();
            string odaNo = txtOdaNo.Text.Trim();
            string izinBaslangic = txtIzinBaslangic.Text.Trim();
            string izinBitis = txtIzinBitis.Text.Trim();
            string izinSebebi = txtIzinSebebi.Text.Trim();

            // 🔥 Eksik veri kontrolü
            if (string.IsNullOrEmpty(izinBaslangic) || string.IsNullOrEmpty(izinBitis) || string.IsNullOrEmpty(izinSebebi))
            {
                lblMesaj.Text = "Lütfen tüm alanları eksiksiz doldurun!";
                lblMesaj.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // 📌 Tarih kontrolü ekliyoruz
            DateTime baslangicTarihi;
            DateTime bitisTarihi;

            if (!DateTime.TryParse(izinBaslangic, out baslangicTarihi) || !DateTime.TryParse(izinBitis, out bitisTarihi))
            {
                lblMesaj.Text = "Geçersiz tarih formatı!";
                lblMesaj.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (baslangicTarihi < DateTime.Now.Date)
            {
                lblMesaj.Text = "Geçmiş tarihler için izin talebi oluşturamazsınız!";
                lblMesaj.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (bitisTarihi <= baslangicTarihi)
            {
                lblMesaj.Text = "İzin bitiş tarihi, başlangıç tarihinden önce olamaz!";
                lblMesaj.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // 🔥 Eğer tarihler doğruysa, izin talebini gönderiyoruz!
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO izinler (ogrenci_id, ogrenci_adi, oda_no, izin_baslangic, izin_bitis, izin_sebebi, durum) VALUES (@ogrenciID, @ogrenciAdi, @odaNo, @izinBaslangic, @izinBitis, @izinSebebi, 'Beklemede')";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    cmd.Parameters.AddWithValue("@ogrenciAdi", ogrenciAdi);
                    cmd.Parameters.AddWithValue("@odaNo", odaNo);
                    cmd.Parameters.AddWithValue("@izinBaslangic", baslangicTarihi);
                    cmd.Parameters.AddWithValue("@izinBitis", bitisTarihi);
                    cmd.Parameters.AddWithValue("@izinSebebi", izinSebebi);
                    cmd.ExecuteNonQuery();
                }
            }

            lblMesaj.Text = "İzin talebiniz başarıyla gönderildi!";
            lblMesaj.ForeColor = System.Drawing.Color.Green;

            // 🔥 Formu temizliyoruz!
            txtIzinBaslangic.Text = "";
            txtIzinBitis.Text = "";
            txtIzinSebebi.Text = "";
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("ogrenci.aspx"); // 📌 Öğrenciyi ana sayfaya yönlendir!
        }
    }
}