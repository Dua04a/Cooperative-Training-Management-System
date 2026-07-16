using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.Pages
{
    public partial class MainAdmin : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdminAuthenticated"] == null || !(bool)Session["IsAdminAuthenticated"])
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["Language"] == null)
                Session["Language"] = "en"; // اللغة الافتراضية انجليزية

            if (!IsPostBack)
            {
                LoadRequests();
                FillDepartments();
                lblDateTime.Text = DateTime.Now.ToString("f");
            }

            SetLanguage();
            btnToggleLanguage.Text = (Session["Language"]?.ToString() == "ar") ? "English" : "العربية";
        }

        private void SetLanguage()
        {
            string lang = Session["Language"]?.ToString() ?? "ar";

            if (lang == "ar")
            {
                trainingRequestsHeader.InnerText = "طلبات التدريب";
                departmentLabel.InnerText = "🏢 القسم";
                btnAssignToDepartment.Text = "توجيه للقسم";
                btnLogout.Text = "تسجيل خروج";
            }
            else
            {
                trainingRequestsHeader.InnerText = "Training Requests";
                departmentLabel.InnerText = "🏢 Department";
                btnAssignToDepartment.Text = "Assign to Department";
                btnLogout.Text = "Logout";
            }
        }

        protected void btnToggleLanguage_Click(object sender, EventArgs e)
        {
            string currentLang = Session["Language"]?.ToString() ?? "en";
            Session["Language"] = (currentLang == "ar") ? "en" : "ar";

            Response.Redirect(Request.RawUrl); // Refresh the page to apply new language
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblDateTime.Text = DateTime.Now.ToString("dddd, MMMM dd, yyyy hh:mm:ss tt");
        }

        private void FillDepartments()
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add(new ListItem("-- Select --", ""));

            string lang = Session["Language"]?.ToString() ?? "ar";

            if (lang == "ar")
            {
                ddlDepartment.Items.Add(new ListItem("المالية", "Finance"));
                ddlDepartment.Items.Add(new ListItem("الموارد البشرية", "HR"));
                ddlDepartment.Items.Add(new ListItem("تقنية المعلومات", "IT"));
                ddlDepartment.Items.Add(new ListItem("العلاقات العامة", "PR"));
            }
            else
            {
                ddlDepartment.Items.Add(new ListItem("Finance", "Finance"));
                ddlDepartment.Items.Add(new ListItem("Human Resources", "HR"));
                ddlDepartment.Items.Add(new ListItem("Information Technology", "IT"));
                ddlDepartment.Items.Add(new ListItem("Public Relations", "PR"));
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnArabic_Click(object sender, EventArgs e)
        {
            Session["Language"] = "ar";
            Response.Redirect(Request.RawUrl);
        }

        protected void btnEnglish_Click(object sender, EventArgs e)
        {
            Session["Language"] = "en";
            Response.Redirect(Request.RawUrl);
        }

        protected void btnAssignToDepartment_Click(object sender, EventArgs e)
        {
            try
            {
                int id = GetSelectedRequestID();
                string department = ddlDepartment.SelectedValue;

                if (string.IsNullOrEmpty(department))
                {
                    lblMessage.Text = Session["Language"]?.ToString() == "en" ?
                        "Please select a department to assign the trainee." :
                        "يرجى اختيار القسم لتوجيه المتدرب.";

                    // ✅ Show the message temporarily
                    ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", "showAndHideMessage();", true);
                    return;
                }

                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "UPDATE TrainingRequests SET Department = @Department WHERE RequestID = @RequestID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@RequestID", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = (Session["Language"]?.ToString() == "en"
                    ? "Trainee assigned to "
                    : "تم توجيه المتدرب إلى قسم ") + GetDepartmentName(department);

                LoadRequests();

                // ✅ Show the success message temporarily
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", "showAndHideMessage();", true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = (Session["Language"]?.ToString() == "en"
                    ? "Error assigning department: "
                    : "خطأ في التوجيه: ") + ex.Message;

                // ✅ Show the error message temporarily
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", "showAndHideMessage();", true);
            }
        }

        private int GetSelectedRequestID()
        {
            foreach (GridViewRow row in gvRequests.Rows)
            {
                CheckBox chk = row.FindControl("chkSelect") as CheckBox;
                if (chk != null && chk.Checked)
                {
                    return Convert.ToInt32(gvRequests.DataKeys[row.RowIndex].Value);
                }
            }
            throw new Exception(Session["Language"]?.ToString() == "en" ? "Please select a request from the table." : "الرجاء اختيار طلب من الجدول.");
        }

        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"
                    SELECT R.RequestID, T.TraineeName, T.Email, R.Status, R.InterviewDate
                    FROM TrainingRequests R
                    INNER JOIN Trainees T ON R.TraineeID = T.TraineeID
                    ORDER BY R.RequestID DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvRequests.DataSource = dt;
                        gvRequests.DataBind();
                    }
                }
            }
        }

        private string GetDepartmentName(string deptValue)
        {
            string lang = Session["Language"]?.ToString() ?? "ar";

            if (lang == "ar")
            {
                switch (deptValue)
                {
                    case "Finance":
                        return "المالية";
                    case "HR":
                        return "الموارد البشرية";
                    case "IT":
                        return "تقنية المعلومات";
                    case "PR":
                        return "العلاقات العامة";
                    default:
                        return deptValue;
                }
            }
            else
            {
                switch (deptValue)
                {
                    case "Finance":
                        return "Finance";
                    case "HR":
                        return "Human Resources";
                    case "IT":
                        return "Information Technology";
                    case "PR":
                        return "Public Relations";
                    default:
                        return deptValue;
                }
            }
        }
    }
}
