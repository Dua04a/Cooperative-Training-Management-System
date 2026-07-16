using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.Pages
{
    public partial class HomePage : System.Web.UI.Page
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
     { "About", "من نحن" },
    { "HealthCenters", "المراكز الصحية" },
    { "TraineeReg", "تسجيل المتدربين" },
    { "ClearanceForm", "نموذج الإخلاء" }
};
        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent admin users from accessing this page
            if (Session["Role"]?.ToString() == "admin")
            {
                Response.Redirect("AdminDashboard.aspx"); // or MainAdmin.aspx based on user
                return;
            }

            // Default to English if not set
            if (!IsPostBack)
            {
                string lang = Session["lang"] as string ?? "en";
                SetLanguage(lang);
            }
        }

        protected void btnSwitchLang_Click(object sender, EventArgs e)
        {
            string currentLang = Session["lang"] as string ?? "en";
            string newLang = currentLang == "en" ? "ar" : "en";
            Session["lang"] = newLang;

            SetLanguage(newLang);
            Response.Redirect(Request.RawUrl); // Refresh page to apply changes
        }

        private void SetLanguage(string lang)
        {

            var dict = (lang == "ar") ? arabicTexts : englishTexts;
            // Example of dynamic translation
            lnkSwitchLang.Text = (lang == "ar") ? "English" : "العربية";

            // العناوين في النافبار
            aboutLink.Text = dict["About"];
            healthCentersLink.Text = dict["HealthCenters"];
            traineeRegLink.Text = dict["TraineeReg"];
            clearanceFormLink.Text = dict["ClearanceForm"];

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
    }
}