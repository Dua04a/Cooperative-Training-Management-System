using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp
{
    public partial class _Default : System.Web.UI.Page
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
            // ✅ Your existing connection and query
            string connectionString = "Server=.\\SQLEXP2017;Database=maiyas10920;Trusted_Connection=True;";
            string query = "SELECT * FROM health";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        // ✅ This will make the 'الموقع' column clickable
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Make first 3 columns bold
                for (int i = 0; i < 3 && i < e.Row.Cells.Count; i++)
                {
                    e.Row.Cells[i].Font.Bold = true;
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.HeaderRow != null)
            {
                for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
                {
                    string headerText = GridView1.HeaderRow.Cells[i].Text.Trim();
                    if (headerText == "موقع المركز")
                    {
                        string url = e.Row.Cells[i].Text.Trim();

                        if (!string.IsNullOrWhiteSpace(url) && Uri.IsWellFormedUriString(url, UriKind.Absolute))
                        {
                            HyperLink link = new HyperLink
                            {
                                Text = "عرض الموقع",
                                NavigateUrl = url,
                                Target = "_blank",
                                ForeColor = System.Drawing.ColorTranslator.FromHtml("#007bff")
                            };

                            e.Row.Cells[i].Controls.Clear();
                            e.Row.Cells[i].Controls.Add(link);
                        }
                    }
                }
            }
        }
        protected void btnRedirect_Click(object sender, EventArgs e)
        {
            // Change "NextPage.aspx" to the actual page you want to redirect to
            Response.Redirect("NextPage.aspx");
        }
    }
  }
