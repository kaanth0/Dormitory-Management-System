using System;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class ogrencitalepleri : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTalepler();
            }
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        private void LoadTalepler()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
        SELECT talep_id, ogrenci_id, ogrenci_adi, talep_tipi, mevcut_oda_no, hedef_oda_no, 
        talep_tarihi, durum, red_sebebi, onay_tarihi 
        FROM oda_talepleri
        ORDER BY talep_id DESC"; // 🔥 Artık sadece oda taleplerini çekiyoruz!

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewTalepler.DataSource = dt;
                    GridViewTalepler.DataBind();
                }
            }
        }

        protected void GridViewTalepler_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Onayla")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int talepID = Convert.ToInt32(GridViewTalepler.DataKeys[index].Value);

                // 🔥 Öğrenci ID’yi kesin olarak alıyoruz!
                int ogrenciID;
                bool idParsed = int.TryParse(GridViewTalepler.Rows[index].Cells[0].Text.Trim(), out ogrenciID); // 📌 Kesin ID alıyoruz!
                string mevcutOdaNo = GridViewTalepler.Rows[index].Cells[3].Text.Trim(); // 🔥 Mevcut oda
                string hedefOdaNo = GridViewTalepler.Rows[index].Cells[4].Text.Trim(); // 🔥 Yeni oda

                if (!idParsed || string.IsNullOrEmpty(hedefOdaNo) || string.IsNullOrEmpty(mevcutOdaNo))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "updateError", "alert('Hata: Öğrenci ID yanlış veya Oda No eksik!');", true);
                    return;
                }

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    // 🔥 Oda numarasını güncelliyoruz!
                    string updateOdaQuery = "UPDATE ogrenciler SET oda_no = @hedefOdaNo WHERE ogrenci_id = @ogrenciID";
                    using (MySqlCommand updateCmd = new MySqlCommand(updateOdaQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                        updateCmd.Parameters.AddWithValue("@hedefOdaNo", hedefOdaNo);
                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "updateFail", "alert('Hata: Oda numarası güncellenemedi!');", true);
                            return;
                        }
                    }


                    // 🔥 Onaylanan veya reddedilen talepleri log tablosuna ekleyelim!
                    string insertLogQuery = @"INSERT INTO log_talepler (talep_id, ogrenci_id, ogrenci_adi, talep_tipi, mevcut_oda_no, hedef_oda_no, 
talep_tarihi, durum, onay_tarihi) 
VALUES (@talepID, @ogrenciID, @ogrenciAdi, 'Oda Değişimi', @mevcutOdaNo, @hedefOdaNo, NOW(), @durum, NOW())";

                    using (MySqlCommand insertLogCmd = new MySqlCommand(insertLogQuery, conn))
                    {
                        insertLogCmd.Parameters.AddWithValue("@talepID", talepID);
                        insertLogCmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                        insertLogCmd.Parameters.AddWithValue("@ogrenciAdi", GridViewTalepler.Rows[index].Cells[2].Text.Trim());
                        insertLogCmd.Parameters.AddWithValue("@mevcutOdaNo", mevcutOdaNo);
                        insertLogCmd.Parameters.AddWithValue("@hedefOdaNo", hedefOdaNo);
                        insertLogCmd.Parameters.AddWithValue("@durum", e.CommandName == "Onayla" ? "Onaylandı" : "Reddedildi");
                        insertLogCmd.ExecuteNonQuery();
                    }

                    // 🔥 Talepleri tamamen sistemden kaldırıyoruz!
                    string deleteApprovedQuery = "DELETE FROM oda_talepleri WHERE talep_id = @talepID";
                    using (MySqlCommand deleteApprovedCmd = new MySqlCommand(deleteApprovedQuery, conn))
                    {
                        deleteApprovedCmd.Parameters.AddWithValue("@talepID", talepID);
                        deleteApprovedCmd.ExecuteNonQuery();
                    }








                    // 🔥 Mevcut odanın doluluğunu 1 azalt
                    string updateEskiOdaQuery = "UPDATE oda SET doluluk = doluluk - 1 WHERE oda_no = @mevcutOdaNo";
                    using (MySqlCommand updateEskiOdaCmd = new MySqlCommand(updateEskiOdaQuery, conn))
                    {
                        updateEskiOdaCmd.Parameters.AddWithValue("@mevcutOdaNo", mevcutOdaNo);
                        updateEskiOdaCmd.ExecuteNonQuery();
                    }

                    // 🔥 Yeni odanın doluluğunu 1 artır
                    string updateYeniOdaQuery = "UPDATE oda SET doluluk = doluluk + 1 WHERE oda_no = @hedefOdaNo";
                    using (MySqlCommand updateYeniOdaCmd = new MySqlCommand(updateYeniOdaQuery, conn))
                    {
                        updateYeniOdaCmd.Parameters.AddWithValue("@hedefOdaNo", hedefOdaNo);
                        updateYeniOdaCmd.ExecuteNonQuery();
                    }

                    // 🔥 Talep geçmişini güncelliyoruz!
                    string updateTalepQuery = "UPDATE oda_talepleri SET durum = 'Onaylandı', onay_tarihi = NOW() WHERE talep_id = @talepID";
                    using (MySqlCommand updateTalepCmd = new MySqlCommand(updateTalepQuery, conn))
                    {
                        updateTalepCmd.Parameters.AddWithValue("@talepID", talepID);
                        updateTalepCmd.ExecuteNonQuery();
                    }

                    ClientScript.RegisterStartupScript(this.GetType(), "updateSuccess", "alert('Oda değişimi başarıyla tamamlandı ve talep geçmişe kaydedildi!');", true);
                }

                LoadTalepler(); // 🔄 Listeyi güncelle
            }

            // 🔥 Silme işlemi
            if (e.CommandName == "Sil")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int talepID = Convert.ToInt32(GridViewTalepler.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM oda_talepleri WHERE talep_id = @talepID";
                    using (MySqlCommand deleteCmd = new MySqlCommand(deleteQuery, conn))
                    {
                        deleteCmd.Parameters.AddWithValue("@talepID", talepID);
                        int rowsAffected = deleteCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteSuccess", "alert('Talep başarıyla silindi!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "deleteFail", "alert('Hata: Talep silinemedi!');", true);
                        }
                    }
                }

                LoadTalepler(); // 🔄 Listeyi yeniliyoruz!
            }

            // 🔥 Reddetme işlemi
            if (e.CommandName == "Reddet")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int talepID = Convert.ToInt32(GridViewTalepler.DataKeys[index].Value);

                string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    string updateQuery = "UPDATE oda_talepleri SET durum = 'Reddedildi', onay_tarihi = NOW() WHERE talep_id = @talepID";
                    using (MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.AddWithValue("@talepID", talepID);
                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "rejectSuccess", "alert('Talep reddedildi ve geçmişe kaydedildi!');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "rejectFail", "alert('Hata: Talep reddedilemedi!');", true);
                        }
                    }
                }

                LoadTalepler(); // 🔄 Listeyi güncelle
            }
        }
    }
}