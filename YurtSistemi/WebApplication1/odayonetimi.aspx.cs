using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

namespace WebApplication1
{
    public partial class odayonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOdalar();
                LoadBolumler();
            }
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        private void LoadOdalar()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT oda.oda_no, oda.kapasite, oda.doluluk, bolumler.bolum_adi " +
                               "FROM oda INNER JOIN bolumler ON oda.bolum_id = bolumler.bolum_id ORDER BY oda.oda_no ASC";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridViewOdalar.DataSource = dt;
                    GridViewOdalar.DataBind();
                }
            }
        }

        private void LoadBolumler()
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT bolum_id, bolum_adi FROM bolumler ORDER BY bolum_adi ASC";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlBolum.Items.Clear(); // 📌 Önce eski verileri temizle
                        ddlBolum.Items.Add(new ListItem("Bölüm Seçiniz", "")); // 📌 Varsayılan seçenek ekle

                        while (reader.Read())
                        {
                            ddlBolum.Items.Add(new ListItem(reader["bolum_adi"].ToString(), reader["bolum_id"].ToString()));
                        }
                    }
                }
            }
        }

        protected void btnOdaEkle_Click(object sender, EventArgs e)
        {
            int odaNoValue, kapasiteValue, bolumID;

            if (!int.TryParse(odaNo.Text.Trim(), out odaNoValue) || !int.TryParse(kapasite.Text.Trim(), out kapasiteValue) || !int.TryParse(ddlBolum.SelectedValue, out bolumID))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alertFail", "alert('Lütfen geçerli bilgiler girin!');", true);
                return;
            }

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO oda (oda_no, kapasite, doluluk, bolum_id) VALUES (@odaNo, @kapasite, 0, @bolumID)";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@odaNo", odaNoValue);
                    cmd.Parameters.AddWithValue("@kapasite", kapasiteValue);
                    cmd.Parameters.AddWithValue("@bolumID", bolumID);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadOdalar();
        }
        private void LoadBolumlerEdit(DropDownList ddlBolumEdit)
        {
            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT bolum_id, bolum_adi FROM bolumler ORDER BY bolum_adi ASC";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlBolumEdit.Items.Clear(); // 📌 Önce eski verileri temizle
                        ddlBolumEdit.Items.Add(new ListItem("Bölüm Seçiniz", "")); // 📌 Varsayılan seçenek ekle

                        while (reader.Read())
                        {
                            ddlBolumEdit.Items.Add(new ListItem(reader["bolum_adi"].ToString(), reader["bolum_id"].ToString()));
                        }
                    }
                }
            }
        }
        protected void GridViewOdalar_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewOdalar.EditIndex = e.NewEditIndex;
            LoadOdalar();

            TextBox txtKapasite = (TextBox)GridViewOdalar.Rows[e.NewEditIndex].Cells[1].Controls[0];
            TextBox txtDoluluk = (TextBox)GridViewOdalar.Rows[e.NewEditIndex].Cells[2].Controls[0];
            DropDownList ddlBolumEdit = (DropDownList)GridViewOdalar.Rows[e.NewEditIndex].FindControl("ddlBolumEdit");

            if (txtDoluluk != null)
            {
                txtDoluluk.ReadOnly = true; // 🔥 Doluluk değiştirilemez!
                txtDoluluk.Enabled = false; // ✅ Ekstra güvenlik için kilitle!
                txtDoluluk.Style["background"] = "transparent"; // ✅ Arka planı tamamen kaldır!
                txtDoluluk.Style["border"] = "none"; // ✅ Çerçeveyi yok et!
                txtDoluluk.Style["outline"] = "none"; // ✅ Dış çizgiyi kaldır!
            }

            if (ddlBolumEdit != null)
            {
                ddlBolumEdit.Enabled = false; // 🔥 Bölüm değiştirilemez!
                ddlBolumEdit.Visible = false; // ✅ Dropdown'u tamamen gizle!
            }
        }
        protected void GridViewOdalar_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int odaNoValue = Convert.ToInt32(GridViewOdalar.DataKeys[e.RowIndex].Value);
            TextBox txtKapasite = (TextBox)GridViewOdalar.Rows[e.RowIndex].Cells[1].Controls[0]; // ✅ Sadece kapasite değiştirilecek!

            string kapasiteValue = txtKapasite.Text.Trim();

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE oda SET kapasite = @kapasite WHERE oda_no = @odaNo"; // ✅ Bölüm ve doluluk değiştirme yok!

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@kapasite", kapasiteValue);
                    cmd.Parameters.AddWithValue("@odaNo", odaNoValue);
                    cmd.ExecuteNonQuery();
                }
            }

            GridViewOdalar.EditIndex = -1; // Düzenleme modundan çık!
            LoadOdalar(); // 🔄 Listeyi güncelle
        }

        protected void GridViewOdalar_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewOdalar.EditIndex = -1;
            LoadOdalar();
        }
        protected void GridViewOdalar_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int odaNoValue = Convert.ToInt32(GridViewOdalar.DataKeys[e.RowIndex].Value);

            string connectionString = "Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM oda WHERE oda_no = @odaNo";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@odaNo", odaNoValue);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadOdalar();
        }

        protected void btngeri_Click(object sender, EventArgs e)
        {

            Response.Redirect("yonetici.aspx"); // 📌 Yönetici ana sayfasına yönlendir!
        
    }
    }
}