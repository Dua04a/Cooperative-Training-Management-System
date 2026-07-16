using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;

namespace maiyas10920WebApp.Pages
{
    public partial class Health : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTableData();
            }
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

        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}
