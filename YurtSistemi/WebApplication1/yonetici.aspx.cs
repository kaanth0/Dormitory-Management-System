using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class yonetici : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["yonetici_id"] == null)
            {
                Response.Redirect("yonetici_giris.aspx");
            }
        }

        protected void btnCikis_Click(object sender, EventArgs e)
        {
            Session.Abandon(); // 🔥 Oturumu tamamen bitir!
            Response.Redirect("anasayfa.aspx");
        }
    }
}