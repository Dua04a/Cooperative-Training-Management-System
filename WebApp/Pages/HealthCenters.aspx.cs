using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;

namespace maiyas10920WebApp
{
    public partial class HealthCenters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string lang = Session["lang"]?.ToString() ?? "en";
            if (!IsPostBack)
            {
                LoadTableData();
                btnRedirect.Text = (lang == "ar") ? "العودة إلى الصفحة الرئيسية" : "Back to Homepage";
            }
            languageBtn.Text = (lang == "ar") ? "English" : "العربية";
        }

        private void LoadTableData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;
            string query = @" SELECT 
            [اسم المركز] AS CenterName,
            [ايميل المركز الصحي] AS Email,
            [المحافظة] AS District,
            [موقع المركز] AS Location
             FROM health";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    rptHealthCenters.DataSource = dt;
                    rptHealthCenters.DataBind();
                }
            }
        }

        protected void rptHealthCenters_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal litDirectionText = (Literal)e.Item.FindControl("litDirectionText");
                string lang = Session["lang"]?.ToString() ?? "en";

                litDirectionText.Text = (lang == "ar") ? "احصل على الاتجاهات" : "Get Directions";
            }
        }


        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void languageBtn_Click(object sender, EventArgs e)
        {
            if (Session["lang"]?.ToString() == "en")
                Session["lang"] = "ar";
            else
                Session["lang"] = "en";

            Response.Redirect(Request.RawUrl);
        }
    }

}