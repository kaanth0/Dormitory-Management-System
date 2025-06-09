using System;
using System.Web;

namespace WebApplication1
{
    public partial class cikis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🔥 Oturum verilerini temizle
            Session.Clear();
            Session.Abandon();
            Response.Redirect("anasayfa.aspx");
        }
    }
}