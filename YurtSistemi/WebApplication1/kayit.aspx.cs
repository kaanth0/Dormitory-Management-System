using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

namespace WebApplication1
{
    public partial class kayit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBolumler();
            }
        }

        private void LoadBolumler()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT bolum_id, bolum_adi FROM bolumler";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    MySqlDataReader reader = cmd.ExecuteReader();
                    bolum.DataSource = reader;
                    bolum.DataTextField = "bolum_adi";
                    bolum.DataValueField = "bolum_id";
                    bolum.DataBind();
                }
            }
        }

        protected void btnKayit_Click(object sender, EventArgs e)
        {
            string adValue = ad.Text.Trim();
            string soyadValue = soyad.Text.Trim();
            string kullaniciAdiValue = kullaniciAdi.Text.Trim();
            string sifreValue = HashPassword(sifre.Text.Trim());
            string epostaValue = eposta.Text.Trim();
            string dogumTarihiValue = dogumTarihi.Text.Trim();
            int bolumID = Convert.ToInt32(bolum.SelectedValue);

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                // 🔥 Uygun oda bulma işlemi
                int uygunOdaNo = 0;
                string odaQuery = "SELECT oda_no FROM oda WHERE bolum_id = @bolumID AND doluluk < kapasite ORDER BY oda_no ASC LIMIT 1";
                using (MySqlCommand odaCmd = new MySqlCommand(odaQuery, conn))
                {
                    odaCmd.Parameters.AddWithValue("@bolumID", bolumID);
                    object odaResult = odaCmd.ExecuteScalar();
                    if (odaResult != null) uygunOdaNo = Convert.ToInt32(odaResult);
                }

                if (uygunOdaNo == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Uygun oda bulunamadı! Lütfen yöneticinizle iletişime geçin.');", true);
                    return;
                }

                // 🔥 Öğrenci kaydı
                string ogrenciQuery = "INSERT INTO ogrenciler (ad, soyad, kullanici_adi, sifre, eposta, dogum_tarihi, bolum_id, oda_no) VALUES (@ad, @soyad, @kullaniciAdi, @sifre, @eposta, @dogumTarihi, @bolumID, @odaNo)";
                using (MySqlCommand ogrenciCmd = new MySqlCommand(ogrenciQuery, conn))
                {
                    ogrenciCmd.Parameters.AddWithValue("@ad", adValue);
                    ogrenciCmd.Parameters.AddWithValue("@soyad", soyadValue);
                    ogrenciCmd.Parameters.AddWithValue("@kullaniciAdi", kullaniciAdiValue);
                    ogrenciCmd.Parameters.AddWithValue("@sifre", sifreValue);
                    ogrenciCmd.Parameters.AddWithValue("@eposta", epostaValue);
                    ogrenciCmd.Parameters.AddWithValue("@dogumTarihi", dogumTarihiValue);
                    ogrenciCmd.Parameters.AddWithValue("@bolumID", bolumID);
                    ogrenciCmd.Parameters.AddWithValue("@odaNo", uygunOdaNo);

                    // 🔥 Boş alan kontrolü
                    if (string.IsNullOrWhiteSpace(adValue) || string.IsNullOrWhiteSpace(soyadValue) ||
                        string.IsNullOrWhiteSpace(kullaniciAdiValue) || string.IsNullOrWhiteSpace(sifreValue) ||
                        string.IsNullOrWhiteSpace(epostaValue) || string.IsNullOrWhiteSpace(dogumTarihiValue))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Lütfen tüm alanları doldurun!');", true);
                        return;
                    }

                    // 🔥 Kullanıcı adı kontrolü (KAYITTAN ÖNCE)
                    string checkQuery = "SELECT COUNT(*) FROM ogrenciler WHERE kullanici_adi = @kullaniciAdi";
                    using (MySqlCommand checkCmd = new MySqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@kullaniciAdi", kullaniciAdiValue);
                        int existingUserCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (existingUserCount > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Bu kullanıcı adı zaten kullanılıyor!');", true);
                            return;
                        }
                    }

                    // 🔥 Kullanıcı adı **benzersiz** olduğu için, artık kayıt işlemi yapılabilir!
                    int result = ogrenciCmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        // 🔥 Başarılı kayıt sonrası oda doluluğunu artırıyoruz
                        string dolulukQuery = "UPDATE oda SET doluluk = doluluk + 1 WHERE oda_no = @odaNo";
                        using (MySqlCommand cmdDoluluk = new MySqlCommand(dolulukQuery, conn))
                        {
                            cmdDoluluk.Parameters.AddWithValue("@odaNo", uygunOdaNo);
                            cmdDoluluk.ExecuteNonQuery();
                        }

                        // 🔥 Kayıt başarılı olduğunda alert göster ve giriş sayfasına yönlendir!
                        string script = $"alert('Kayıt başarılı! {uygunOdaNo} numaralı odaya yerleştirildiniz.'); window.location='giris.aspx';";
                        ClientScript.RegisterStartupScript(this.GetType(), "alertSuccess", script, true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Kayıt başarısız! Lütfen tekrar deneyin.');", true);
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