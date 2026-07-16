using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.Pages
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["lang"] == null)
                {
                    Session["lang"] = "ar"; // default Arabic
                }

                ApplyLanguage(Session["lang"].ToString());
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connectionString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // ✅ Check if username already exists
                string checkQuery = "SELECT COUNT(*) FROM Admin WHERE Username = @Username";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Username", username);
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        if (Session["lang"] != null && Session["lang"].ToString() == "en")
                        {
                            lblMessage.Text = "⚠️ Username already exists.";
                        }
                        else
                        {
                            lblMessage.Text = "⚠️ اسم المستخدم موجود مسبقًا";
                        }
                        lblMessage.ForeColor = System.Drawing.Color.Red;

                        // store message type (optional for ApplyLanguage method)
                        Session["lastMessageType"] = "error";
                        return;
                    }
                }

                // ✅ Insert new user
                string insertQuery = @"
            INSERT INTO Admin (Username, Passwordd, Department, Role) 
            VALUES (@Username, @Password, NULL, 'staff')";

                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Password", password);
                    insertCmd.ExecuteNonQuery();

                    if (Session["lang"] != null && Session["lang"].ToString() == "en")
                    {
                        lblMessage.Text = "✅ Account created successfully!";
                    }
                    else
                    {
                        lblMessage.Text = "✅ تم إنشاء الحساب بنجاح!";
                    }
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    Session["lastMessageType"] = "success"; // optional
                }
            }
        }


        protected void btnSwitchLang_Click(object sender, EventArgs e)
        {
            // Toggle language
            if (Session["lang"].ToString() == "ar")
                Session["lang"] = "en";
            else
                Session["lang"] = "ar";

            ApplyLanguage(Session["lang"].ToString());
        }

        private void ApplyLanguage(string lang)
        {
            if (lang == "ar")
            {
                h2Title.InnerText = "إنشاء حساب";
                txtUsername.Attributes["placeholder"] = "اسم المستخدم";
                txtPassword.Attributes["placeholder"] = "كلمة المرور";
                btnRegister.Text = "إنشاء الحساب";
                loginLink.Text = "تسجيل الدخول";
                langSwitchLink.Text = "English";
            }
            else
            {
                h2Title.InnerText = "Create Account";
                txtUsername.Attributes["placeholder"] = "Username";
                txtPassword.Attributes["placeholder"] = "Password";
                btnRegister.Text = "Create Account";
                loginLink.Text = "Login";
                langSwitchLink.Text = "عربي";
            }
        }

    }
}