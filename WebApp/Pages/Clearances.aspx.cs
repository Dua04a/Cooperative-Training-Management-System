using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.Pages
{
    public partial class Clearances : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"]?.ToString() != "naifc")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Use Session["Language"] for language settings
            if (!IsPostBack)
            {
                if (Session["Language"] == null)
                    Session["Language"] = "ar";  // Default language is Arabic

                lblDateTime.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy - hh:mm tt", new CultureInfo("en-US"));

                LoadClearanceRequests();
                ApplyLanguage(Session["Language"].ToString());
            }
            else
            {
                ApplyLanguage(Session["Language"]?.ToString() ?? "ar");
                lblDateTime.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy - hh:mm tt", new CultureInfo("en-US"));
            }

            // Update the language toggle button text based on the current language
            btnToggleLanguage.Text = (Session["Language"]?.ToString() == "ar") ? "English" : "العربية";
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

        private void LoadClearanceRequests()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT Id, EnglishName, KfmcEmail FROM Clearances", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvClearance.DataSource = dt;
                gvClearance.DataBind();
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            string message = (Session["Lang"]?.ToString() == "en")
                ? "Your clearance form has been approved. Thank you for your cooperation and best wishes."
                : "تمت الموافقة على طلب إخلاء الطرف الخاص بك.\n\nنشكرك على تعاونك ونتمنى لك التوفيق.";

            ProcessClearance(message);
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            string message = (Session["Lang"]?.ToString() == "en")
                ? "Your clearance form was rejected due to missing requirements. Please resubmit."
                : "لم يتم قبول طلب إخلاء الطرف لعدم استكمال المتطلبات.\n\nيرجى مراجعة المتطلبات وإعادة تقديم الطلب.";

            ProcessClearance(message);
        }

        private void ProcessClearance(string messageBody)
        {
            bool anyChecked = false;
            foreach (GridViewRow row in gvClearance.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    anyChecked = true;
                    string email = gvClearance.DataKeys[row.RowIndex]["KfmcEmail"].ToString();

                    if (!string.IsNullOrEmpty(email))
                    {
                        SendEmail(email, "Clearance Request Status", messageBody);
                    }
                }
            }

            lblMessage.Text = anyChecked
                ? (Session["Lang"]?.ToString() == "en" ? "Emails sent successfully." : "تم إرسال الرسائل بنجاح.")
                : (Session["Lang"]?.ToString() == "en" ? "Please select at least one request." : "يرجى اختيار طلب واحد على الأقل.");

            messageContainer.Visible = true;
        }

        private void SendEmail(string to, string subject, string body)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(to))
                    return;

                MailMessage mail = new MailMessage();
                mail.To.Add(to);
                mail.From = new MailAddress("kfmc55541@gmail.com");
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new System.Net.NetworkCredential("kfmc55541@gmail.com", "atelqbqihjscigbr");
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "حدث خطأ أثناء إرسال البريد: " + ex.Message;
                messageContainer.Visible = true;
            }
        }

        private void ApplyLanguage(string lang)
        {
            if (lang == "en")
            {
                gvClearance.Columns[0].HeaderText = "Select";
                gvClearance.Columns[1].HeaderText = "Request ID";
                gvClearance.Columns[2].HeaderText = "Trainee Name";
                gvClearance.Columns[3].HeaderText = "Email";
                btnApprove.Text = "Approve";
                btnReject.Text = "Reject";
                lblGridTitle.Text = "Clearance Requests List";
                btnLogout.Text = "Logout";
            }
            else
            {
                gvClearance.Columns[0].HeaderText = "اختيار";
                gvClearance.Columns[1].HeaderText = "رقم الطلب";
                gvClearance.Columns[2].HeaderText = "اسم المتدرب";
                gvClearance.Columns[3].HeaderText = "البريد الإلكتروني";
                btnApprove.Text = "قبول";
                btnReject.Text = "رفض";
                lblGridTitle.Text = "قائمة طلبات إخلاء الطرف";
                btnLogout.Text = "خروج";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}