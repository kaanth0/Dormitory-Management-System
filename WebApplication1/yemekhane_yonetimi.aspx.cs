using System;
using System.Data;
using System.IO;
using MySql.Data.MySqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Yemekhane_Yonetimi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        private void YemekleriListele()

        {
            using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
            {
                conn.Open();
                string sql = "SELECT yemek_id, DATE_FORMAT(Tarih, '%d %M %Y') AS Tarih, Kahvalti, Ogle, Aksam FROM Yemekhane ORDER BY Tarih DESC";
                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                YemekhaneGrid.DataSource = dt;
                YemekhaneGrid.DataBind();
            }
        }

        protected void EkleBtn_Click(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
                {
                    conn.Open();
                    string sql = "INSERT INTO Yemekhane (Tarih, Kahvalti, Ogle, Aksam) VALUES (@Tarih, @Kahvalti, @Ogle, @Aksam)";
                    using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Tarih", TarihTxt.Text);
                        cmd.Parameters.AddWithValue("@Kahvalti", KahvaltiTxt.Text);
                        cmd.Parameters.AddWithValue("@Ogle", OgleTxt.Text);
                        cmd.Parameters.AddWithValue("@Aksam", AksamTxt.Text);
                        cmd.ExecuteNonQuery();
                    }
                }

                // 🔥 Güncellenmiş verileri tekrar listeleyelim
                YemekleriListele();
                Response.Write("<script>alert('Yeni yemek menüsü başarıyla eklendi!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Hata oluştu: " + ex.Message + "');</script>");
            }
        }

        protected void YemekhaneGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int yemekID = Convert.ToInt32(YemekhaneGrid.DataKeys[e.RowIndex].Value);

            using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
            {
                conn.Open();
                string sql = "DELETE FROM Yemekhane WHERE yemek_id=@yemek_id";
                using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@yemek_id", yemekID);
                    cmd.ExecuteNonQuery();
                }
            }
            YemekleriListele();
        }

        protected void YukleBtn_Click(object sender, EventArgs e)
        {
            if (ExcelDosya.HasFile)
            {
                try
                {
                    string filePath = Server.MapPath("~/uploads/" + ExcelDosya.FileName);
                    ExcelDosya.SaveAs(filePath);

                    DataTable dt = new DataTable();
                    dt.Columns.AddRange(new DataColumn[4] {
                        new DataColumn("Tarih", typeof(string)),
                        new DataColumn("Kahvalti", typeof(string)),
                        new DataColumn("Ogle", typeof(string)),
                        new DataColumn("Aksam", typeof(string))
                    });

                    using (StreamReader sr = new StreamReader(filePath))
                    {
                        string line;
                        sr.ReadLine(); // 🔥 İlk satır başlık, onu atlıyoruz!
                        while ((line = sr.ReadLine()) != null)
                        {
                            string[] rows = line.Split(',');
                            dt.Rows.Add(rows[0], rows[1], rows[2], rows[3]);
                        }
                    }

                    using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
                    {
                        conn.Open();
                        foreach (DataRow row in dt.Rows)
                        {
                            string sql = "INSERT INTO Yemekhane (Tarih, Kahvalti, Ogle, Aksam) VALUES (@Tarih, @Kahvalti, @Ogle, @Aksam)";
                            using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                            {
                                cmd.Parameters.AddWithValue("@Tarih", row["Tarih"]);
                                cmd.Parameters.AddWithValue("@Kahvalti", row["Kahvalti"]);
                                cmd.Parameters.AddWithValue("@Ogle", row["Ogle"]);
                                cmd.Parameters.AddWithValue("@Aksam", row["Aksam"]);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    YemekleriListele();
                    Response.Write("<script>alert('Yemek listesi başarıyla eklendi!');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Hata oluştu: " + ex.Message + "');</script>");
                }
            }
        }

        protected void SilBtn_Click(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection("Server=localhost;Database=yurtotomasyon;Uid=root;Pwd=;"))
                {
                    conn.Open();
                    string sql = "DELETE FROM Yemekhane"; // 🔥 Tüm yemek listesini sil!

                    using (MySqlCommand cmd = new MySqlCommand(sql, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }

                // 🔥 Güncellenmiş verileri tekrar listeleyelim
                YemekleriListele();
                Response.Write("<script>alert('Tüm yemek listesi başarıyla silindi!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Hata oluştu: " + ex.Message + "');</script>");
            }
        }

        protected void btngeri_Click(object sender, EventArgs e)
        {
            Response.Redirect("yonetici.aspx");
        }
    }
}