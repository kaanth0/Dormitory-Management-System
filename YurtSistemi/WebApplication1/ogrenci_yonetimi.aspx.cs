using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace WebApplication1
{
    public partial class ogrenci_yonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOgrenciler();
            }
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        private void LoadBolumler(DropDownList ddlBolum)
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT bolum_id, bolum_adi FROM bolumler";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlBolum.DataSource = reader;
                        ddlBolum.DataTextField = "bolum_adi";
                        ddlBolum.DataValueField = "bolum_id";
                        ddlBolum.DataBind();
                        ddlBolum.Items.Insert(0, new ListItem("-- Bölüm Seçin --", "0"));
                    }
                }
            }
        }

        private void LoadOgrenciler()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
        SELECT o.ogrenci_id, o.ad, o.soyad, o.bolum_id, COALESCE(b.bolum_adi, 'Bölüm Yok') AS bolum_adi, 
               o.eposta, o.oda_no, oda.kapasite,
               (SELECT COUNT(*) FROM ogrenciler WHERE ogrenciler.oda_no = oda.oda_no) AS doluluk
        FROM ogrenciler o
        LEFT JOIN bolumler b ON o.bolum_id = b.bolum_id
        LEFT JOIN oda ON o.oda_no = oda.oda_no";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        var dataTable = new System.Data.DataTable();
                        dataTable.Load(reader);
                        ogrenciGrid.DataSource = dataTable;
                        ogrenciGrid.DataBind();
                    }
                }
            }
        }

        protected void ogrenciGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            ogrenciGrid.EditIndex = e.NewEditIndex;
            LoadOgrenciler();

            GridViewRow row = ogrenciGrid.Rows[e.NewEditIndex];
            DropDownList ddlBolum = (DropDownList)row.FindControl("ddlBolum");

            if (ddlBolum != null)
            {
                LoadBolumler(ddlBolum);

                object bolumIdObj = ogrenciGrid.DataKeys[e.NewEditIndex].Values["bolum_id"];
                if (bolumIdObj != null)
                {
                    string mevcutBolumID = bolumIdObj.ToString();
                    if (ddlBolum.Items.FindByValue(mevcutBolumID) != null)
                    {
                        ddlBolum.SelectedValue = mevcutBolumID;
                    }
                }
            }
        }

        protected void ogrenciGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int ogrenciID = Convert.ToInt32(ogrenciGrid.DataKeys[e.RowIndex].Value);
            GridViewRow row = ogrenciGrid.Rows[e.RowIndex];

            TextBox txtAd = (TextBox)row.FindControl("txtAd");
            TextBox txtSoyad = (TextBox)row.FindControl("txtSoyad");
            DropDownList ddlBolum = (DropDownList)row.FindControl("ddlBolum");
            TextBox txtEposta = (TextBox)row.FindControl("txtEposta");

            string ad = txtAd?.Text.Trim() ?? "";
            string soyad = txtSoyad?.Text.Trim() ?? "";
            string bolumID = ddlBolum?.SelectedValue ?? "0";
            string eposta = txtEposta?.Text.Trim() ?? "";

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE ogrenciler SET ad = @ad, soyad = @soyad, bolum_id = @bolumID, eposta = @eposta WHERE ogrenci_id = @ogrenciID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ad", ad);
                    cmd.Parameters.AddWithValue("@soyad", soyad);
                    cmd.Parameters.AddWithValue("@bolumID", bolumID);
                    cmd.Parameters.AddWithValue("@eposta", eposta);
                    cmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);

                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alertSuccess", "alert('Öğrenci bilgileri başarıyla güncellendi!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Güncelleme başarısız!');", true);
                    }
                }
            }

            ogrenciGrid.EditIndex = -1;
            LoadOgrenciler();
            ogrenciGrid.DataBind();
        }

        protected void ogrenciGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ogrenciID = Convert.ToInt32(ogrenciGrid.DataKeys[e.RowIndex].Value);
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM ogrenciler WHERE ogrenci_id = @ogrenciID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ogrenciID", ogrenciID);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadOgrenciler();
        }
        protected void ogrenciGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ogrenciGrid.EditIndex = -1; // 🔥 Düzenleme modundan çıkartıyoruz!
            LoadOgrenciler(); // 🔥 Verileri yeniden yüklüyoruz!
        }

        protected void btnGeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx"); // 📌 Yönetici ana sayfasına yönlendir!
        }
    }
}