using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;


namespace maiyas10920WebApp
{
    public partial class Login : System.Web.UI.Page
    {
        private Dictionary<string, string> englishTexts = new Dictionary<string, string>
{
    { "WhoWeAre", "Who We Are" },
    { "WhoWeAreContent", @"Where Perception Becomes Reality and Dream Comes True

King Fahad Medical City (KFMC) started as a pioneering idea that came true. The idea was adopted by King Fahad bin Abdulaziz.
The Prince of Riyadh region then, King Salman bin Abdulaziz laid the foundation stone in 1403H (1983G).
KFMC began operations in the era of King Fahad and was inaugurated by Crown Prince Abdullah bin Abdulaziz in 2004.
It is one of the largest and fastest-growing medical complexes in the Middle East with over 1,200 beds, strategically located in Riyadh." },

    { "Vision", "Vision" },
    { "VisionContent", "To lead the transformation of specialized healthcare services through innovative, sustainable, and person-centric digital solutions." },

    { "Mission", "Mission" },
    { "MissionContent", "To implement digital transformation strategies that enhance satisfaction, empower employees, ensure compliance, and drive innovation." },

    { "Contact", "Contact Information" },
    { "ContactContent", @"Toll Free no.: 8001277000
Fax: +966 11 461 4006

P.O.BOX:
59046 Riyadh 11525
Kingdom of Saudi Arabia" },

    { "Heading", "Login" },
    { "Username", "Username" },
    { "Password", "Password" },
    { "Login", "Login" },
    { "CreateAccount", "Create New Account" },
    { "User", "User" },
    { "Admin", "Admin" },
    { "About", "About" },



    { "HealthCenters", "Health Centers" },
    { "TraineeReg", "Trainee Registration" },
    { "ClearanceForm", "Clearance Form" }
};

        private Dictionary<string, string> arabicTexts = new Dictionary<string, string>
{
    { "WhoWeAre", "من نحن" },
    { "WhoWeAreContent", @"حيث تصبح الرؤية واقعًا، والحلم حقيقة.

بدأت مدينة الملك فهد الطبية كفكرة رائدة تحققت على أرض الواقع، وتبناها الملك فهد بن عبدالعزيز.
وقد وضع حجر الأساس الأمير سلمان بن عبدالعزيز (أمير منطقة الرياض آنذاك) عام 1403هـ (1983م).
ودشنت المدينة رسميًا عام 1425هـ (2004م) في عهد الملك فهد، بحضور ولي العهد الأمير عبدالله بن عبدالعزيز.
تُعد مدينة الملك فهد الطبية من أكبر وأسرع المجمعات الطبية نموًا في الشرق الأوسط بسعة سريرية تتجاوز 1200 سرير، وتتميز بموقع استراتيجي في قلب مدينة الرياض." },

    { "Vision", "الرؤية" },
    { "VisionContent", "قيادة تحول الخدمات الصحية التخصصية من خلال حلول رقمية مبتكرة ومستدامة تتمحور حول المستفيد والموظف." },

    { "Mission", "الرسالة" },
    { "MissionContent", "تنفيذ استراتيجيات التحول الرقمي التي تعزز رضا المستفيدين، وتمكّن الموظفين، وتضمن الامتثال، وتدفع عجلة الابتكار." },

    { "Contact", "معلومات التواصل" },
    { "ContactContent", @"الرقم المجاني: 8001277000
فاكس: +966 11 461 4006

ص.ب:
59046 الرياض 11525
المملكة العربية السعودية" },

    { "Heading", "تسجيل الدخول" },
    { "Username", "اسم المستخدم" },
    { "Password", "كلمة المرور" },
    { "Login", "تسجيل الدخول" },
    { "CreateAccount", "إنشاء حساب جديد" },
    { "User", "مستخدم" },
    { "Admin", "مدير" },
    { "About", "من نحن" },
    { "HealthCenters", "المراكز الصحية" },
    { "TraineeReg", "تسجيل المتدربين" },
    { "ClearanceForm", "نموذج الإخلاء" }
};
    protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string lang = Session["lang"] as string ?? "en";
                SetLanguage(lang);
            }
        }

        private void SetLanguage(string lang)
        {
            var dict = (lang == "ar") ? arabicTexts : englishTexts;

            lnkSwitchLang.Text = (lang == "ar") ? "English" : "العربية";

            // العناوين في النافبار
            aboutLink.Text = dict["About"];
            healthCentersLink.Text = dict["HealthCenters"];
            traineeRegLink.Text = dict["TraineeReg"];
            clearanceFormLink.Text = dict["ClearanceForm"];

            // أزرار المستخدم والمدير
            Button3.Text = dict["User"];
            Button4.Text = dict["Admin"];

            // العنوان
            litHeading.Text = dict["Heading"];

            // مربعات النص
            txtUsername.Attributes["placeholder"] = dict["Username"];
            txtPassword.Attributes["placeholder"] = dict["Password"];

            // زر تسجيل الدخول
            btnLogin.Text = dict["Login"];
            btnCreateAccount.Text = dict["CreateAccount"];

            // محتوى النافذة المنبثقة About

            // تحديث عناصر القائمة المنسدلة بلغة المستخدم
            // Inject JavaScript dictionary with modal content and dropdown translation
            string js = $@"
<script>
    function getLocalizedModalData() {{
        return {{
            who: {{
                title: '{dict["WhoWeAre"]}',
                content: `{dict["WhoWeAreContent"]}`
            }},
            vision: {{
                title: '{dict["Vision"]}',
                content: `{dict["VisionContent"]}`
            }},
            mission: {{
                title: '{dict["Mission"]}',
                content: `{dict["MissionContent"]}`
            }},
            contact: {{
                title: '{dict["Contact"]}',
                content: `{dict["ContactContent"]}`
            }}
        }};
    }}

    document.addEventListener('DOMContentLoaded', function () {{
        document.getElementById('linkWho').innerText = '{dict["WhoWeAre"]}';
        document.getElementById('linkVision').innerText = '{dict["Vision"]}';
        document.getElementById('linkMission').innerText = '{dict["Mission"]}';
        document.getElementById('linkContact').innerText = '{dict["Contact"]}';
    }});
</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "localizedData", js);


        }
        protected void btnSwitchLang_Click(object sender, EventArgs e)
        {
            string currentLang = Session["lang"] as string ?? "en";
            string newLang = currentLang == "en" ? "ar" : "en";
            Session["lang"] = newLang;
            SetLanguage(newLang);

            Response.Redirect(Request.RawUrl);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim().ToLower();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                lblError.Text = GetText("Please enter username and password.", "يرجى إدخال اسم المستخدم وكلمة المرور.");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = "SELECT Role FROM Admin WHERE Username = @user AND Passwordd = @pass";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@user", username);
                cmd.Parameters.AddWithValue("@pass", password);

                con.Open();
                object roleObj = cmd.ExecuteScalar();

                if (roleObj != null)
                {
                    string role = roleObj.ToString();
                    Session["IsAdminAuthenticated"] = true;
                    Session["Username"] = username;
                    Session["Role"] = role;

                    if (role == "admin")
                    {
                        // You can add additional checks here for 'naif' or authority level
                        if (username == "naif")
                            Response.Redirect("MainAdmin.aspx");
                        else if (username == "naifc")
                            Response.Redirect("Clearances.aspx");
                        else
                            Response.Redirect("AdminDashboard.aspx");
                    }
                    else if (role == "staff")
                    {
                        Response.Redirect("HomePage.aspx");
                    }
                }
                else
                {
                    lblError.Text = GetText("Invalid username or password.", "اسم المستخدم أو كلمة المرور غير صحيحة.");
                }
            }
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateAccount.aspx"); // غيّر الرابط إذا عندك صفحة ثانية
        }
        private string GetText(string en, string ar)
        {
            return (Session["lang"] as string == "ar") ? ar : en;
        }
    }
}