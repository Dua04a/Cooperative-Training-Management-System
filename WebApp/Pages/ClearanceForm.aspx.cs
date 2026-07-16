using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace maiyas10920WebApp.Pages
{
    public partial class ClearanceForm : System.Web.UI.Page
    {

        private Dictionary<string, string> en = new Dictionary<string, string>
        {
            { "alertMessage", "For KFMC staff, kindly submit clearance request in RMS" },
            { "personalInfoTitle", "Personal Information" },
            { "labelNationality", "Nationality:" },
            { "labelIdNumber", "ID Number/Iqama:" },
            { "labelEnglishName", "English Name:" },
            { "labelArabicName", "Arabic Name:" },
            { "labelKfmcEmail", "KFMC Email:" },
            { "labelMobile", "Mobile No.:" },
            { "labelJobTitle", "Job title:" },
            { "labelExecutiveAdmin", "Executive Administration:" },
            { "labelDepartment", "Department:" },
            { "documentsTitle", "ID Documents" },
            { "labelIdBadge", "ID Badge:" },
            { "labelIdExpiry", "ID Badge Expiry Date:" },
            { "labelNationalId", "National ID:" },
            { "adminInfoTitle", "Administration Information" },
            { "labelDate", "Date:" },
            { "labelAdminName", "Administration Name:" },
            { "labelUserName", "User name account:" },
            { "labelEmployeeNo", "Employee No.:" },
            { "submitBtn", "Submit" },
            { "cancelBtn", "Cancel" },
            { "langBtn", "العربية" },
            { "headerLine1", "King Fahad Medical City" },
            { "headerLine2", "Access Management Department Clearance" },
            { "headerLine3", "(For Non KFMC staff)" }
        };

        private Dictionary<string, string> ar = new Dictionary<string, string>
        {
            { "alertMessage", "بالنسبة لموظفي المدينة الطبية، يرجى تقديم طلب التصريح عبر نظام RMS" },
            { "personalInfoTitle", "المعلومات الشخصية" },
            { "labelNationality", "الجنسية:" },
            { "labelIdNumber", "رقم الهوية/الإقامة:" },
            { "labelEnglishName", "الاسم بالإنجليزية:" },
            { "labelArabicName", "الاسم بالعربية:" },
            { "labelKfmcEmail", "البريد الإلكتروني للمدينة الطبية:" },
            { "labelMobile", "رقم الجوال:" },
            { "labelJobTitle", "المسمى الوظيفي:" },
            { "labelExecutiveAdmin", "الإدارة التنفيذية:" },
            { "labelDepartment", "القسم:" },
            { "documentsTitle", "وثائق الهوية" },
            { "labelIdBadge", "بطاقة الهوية:" },
            { "labelIdExpiry", "تاريخ انتهاء بطاقة الهوية:" },
            { "labelNationalId", "الهوية الوطنية:" },
            { "adminInfoTitle", "معلومات الإدارة" },
            { "labelDate", "التاريخ:" },
            { "labelAdminName", "اسم الإدارة:" },
            { "labelUserName", "اسم المستخدم:" },
            { "labelEmployeeNo", "رقم الموظف:" },
            { "submitBtn", "إرسال" },
            { "cancelBtn", "إلغاء" },
            { "langBtn", "English" },
             { "headerLine1", "مدينة الملك فهد الطبية" },
                { "headerLine2", " تصريح قسم إدارة الدخول" },
                { "headerLine3", " (لغير موظفي المدينة الطبية)" }
        };
        protected void Page_Load(object sender, EventArgs e)
        {
                if (Session["lang"] == null)
                {
                    Session["lang"] = "en"; // Default only if not set before
                }

                if (Session["lang"].ToString() == "ar")
                {
                    ApplyTranslations(ar);
                    form2.Attributes["dir"] = "rtl";
                }
                else
                {
                    ApplyTranslations(en);
                    form2.Attributes["dir"] = "ltr";
                }
        }


        private void ApplyTranslations(Dictionary<string, string> lang)
        {
            alertMessage.InnerText = lang["alertMessage"];
            personalInfoTitle.InnerText = lang["personalInfoTitle"];
            labelNationality.InnerText = lang["labelNationality"];
            labelIdNumber.InnerText = lang["labelIdNumber"];
            labelEnglishName.InnerText = lang["labelEnglishName"];
            labelArabicName.InnerText = lang["labelArabicName"];
            labelKfmcEmail.InnerText = lang["labelKfmcEmail"];
            labelMobile.InnerText = lang["labelMobile"];
            labelJobTitle.InnerText = lang["labelJobTitle"];
            labelExecutiveAdmin.InnerText = lang["labelExecutiveAdmin"];
            labelDepartment.InnerText = lang["labelDepartment"];
            documentsTitle.InnerText = lang["documentsTitle"];
            labelIdBadge.InnerText = lang["labelIdBadge"];
            labelIdExpiry.InnerText = lang["labelIdExpiry"];
            labelNationalId.InnerText = lang["labelNationalId"];
            adminInfoTitle.InnerText = lang["adminInfoTitle"];
            labelDate.InnerText = lang["labelDate"];
            labelAdminName.InnerText = lang["labelAdminName"];
            labelUserName.InnerText = lang["labelUserName"];
            labelEmployeeNo.InnerText = lang["labelEmployeeNo"];
            submitBtn.Text = lang["submitBtn"];
            cancelBtn.Text = lang["cancelBtn"];
            languageBtn.Text = lang["langBtn"];
            headerLine1.InnerText = lang["headerLine1"];
            headerLine2.InnerText = lang["headerLine2"];
            headerLine3.InnerText = lang["headerLine3"];

            // ✅ Update dropdowns based on selected language
            nationality.Items.Clear();
            if (Session["lang"].ToString() == "ar")
            {
                nationality.Items.Add(new ListItem("سعودي", "Saudi"));
                nationality.Items.Add(new ListItem("غير سعودي", "Non-Saudi"));
                adminName.Items.Clear();
                adminName.Items.Add(new ListItem("إدارة التدريب الإداري", "Management Training Administration"));
                adminName.Items.Add(new ListItem("إدارة التدريب الطبي", "Medical Training Administration"));
                adminName.Items.Add(new ListItem("إدارة التدريب الصحي", "Health Training Administration"));
                adminName.Items.Add(new ListItem("إدارة التعليم التمريضي", "Nursing Education Administration"));
                adminName.Items.Add(new ListItem("إدارة التطوع", "Volunteer Administration"));
                adminName.Items.Add(new ListItem("التعاقد/الاستعانة بمصادر خارجية", "Contracting/Outsourcing"));
                adminName.Items.Add(new ListItem("أكاديمية طب الأسرة", "Family Medicine Academy"));
                adminName.Items.Add(new ListItem("أمن الرعاية الصحية", "Health Care Security"));
                adminName.Items.Add(new ListItem("إدارة الأشعة AAML", "Radiology AAML Administration"));
            }
            else
            {
                nationality.Items.Add(new ListItem("Saudi", "Saudi"));
                nationality.Items.Add(new ListItem("Non-Saudi", "Non-Saudi"));
                adminName.Items.Clear();
                adminName.Items.Add(new ListItem("Management Training Administration"));
                adminName.Items.Add(new ListItem("Medical Training Administration"));
                adminName.Items.Add(new ListItem("Health Training Administration"));
                adminName.Items.Add(new ListItem("Nursing Education Administration"));
                adminName.Items.Add(new ListItem("Volunteer Administration"));
                adminName.Items.Add(new ListItem("Contracting/Outsourcing"));
                adminName.Items.Add(new ListItem("Family Medicine Academy"));
                adminName.Items.Add(new ListItem("Health Care Security"));
                adminName.Items.Add(new ListItem("Radiology AAML Administration"));
            }

            if (Session["lang"].ToString() == "ar")
            {
                formHeader.Attributes["class"] = "form-header form-header-rtl";
            }
            else
            {
                formHeader.Attributes["class"] = "form-header";
            }
        }

        protected void languageBtn_Click(object sender, EventArgs e)
        {
            if (Session["lang"]?.ToString() == "en")
                Session["lang"] = "ar";
            else
                Session["lang"] = "en";

            Response.Redirect(Request.RawUrl);
        }

        protected void cancelBtn_Click(object sender, EventArgs e)
        {
            // Redirect to the homepage (adjust the URL as needed)
            Response.Redirect("HomePage.aspx");
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            // 1) Get normal form values
            string nationality = Request.Form["nationality"];
            string idNumber = Request.Form["idNumber"];
            string englishName = Request.Form["englishName"];
            string arabicName = Request.Form["arabicName"];
            string kfmcEmail = Request.Form["kfmcEmail"];
            string mobile = Request.Form["mobile"];
            string jobTitle = Request.Form["jobTitle"];
            string executiveAdmin = Request.Form["executiveAdmin"];
            string department = Request.Form["department"];
            string idExpiry = Request.Form["idExpiry"];
            string submissionDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); // Auto submission date
            string adminName = Request.Form["adminName"];
            string userName = Request.Form["userName"];
            string employeeNo = Request.Form["employeeNo"];

            // 2) Handle File Uploads
            string uploadFolder = Server.MapPath("~/Uploads/");
            if (!Directory.Exists(uploadFolder))
            {
                Directory.CreateDirectory(uploadFolder);
            }

            string idBadgeFilePath = "";
            if (Request.Files["idBadgeFile"] != null && Request.Files["idBadgeFile"].ContentLength > 0)
            {
                string idBadgeFileName = Path.GetFileName(Request.Files["idBadgeFile"].FileName);
                idBadgeFilePath = Path.Combine(uploadFolder, idBadgeFileName);
                Request.Files["idBadgeFile"].SaveAs(idBadgeFilePath);
            }

            string nationalIdFilePath = "";
            if (Request.Files["nationalIdFile"] != null && Request.Files["nationalIdFile"].ContentLength > 0)
            {
                string nationalIdFileName = Path.GetFileName(Request.Files["nationalIdFile"].FileName);
                nationalIdFilePath = Path.Combine(uploadFolder, nationalIdFileName);
                Request.Files["nationalIdFile"].SaveAs(nationalIdFilePath);
            }

                // 3) Save to Database
                SaveClearanceRequest(
                  nationality, idNumber, englishName, arabicName, kfmcEmail,
        mobile, jobTitle, executiveAdmin, department, idBadgeFilePath,
        nationalIdFilePath, idExpiry, submissionDate, adminName,
        userName, employeeNo
            );
        }

        private void SaveClearanceRequest(string nationality, string idNumber, string englishName,
    string arabicName, string kfmcEmail, string mobile, string jobTitle,
    string executiveAdmin, string department, string idBadgeFilePath,
    string nationalIdFilePath, string idExpiryDate, string submissionDate,
    string administrationName, string userNameAccount, string employeeNumber)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"INSERT INTO Clearances
                (Nationality, IdNumber, EnglishName, ArabicName, KfmcEmail, Mobile,
                 JobTitle, ExecutiveAdmin, Department, IdBadgeFilePath,
                 NationalIdFilePath, IdExpiryDate, SubmissionDate, AdministrationName, UserNameAccount, EmployeeNumber)
                VALUES
                (@Nationality, @IdNumber, @EnglishName, @ArabicName, @KfmcEmail, @Mobile,
                 @JobTitle, @ExecutiveAdmin, @Department, @IdBadgeFilePath,
                 @NationalIdFilePath, @IdExpiryDate, @SubmissionDate, @AdministrationName,
                 @UserNameAccount, @EmployeeNumber)";

                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@Nationality", nationality);
                cmd.Parameters.AddWithValue("@IdNumber", idNumber);
                cmd.Parameters.AddWithValue("@EnglishName", englishName);
                cmd.Parameters.AddWithValue("@ArabicName", arabicName);
                cmd.Parameters.AddWithValue("@KfmcEmail", kfmcEmail);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@JobTitle", jobTitle);
                cmd.Parameters.AddWithValue("@ExecutiveAdmin", executiveAdmin);
                cmd.Parameters.AddWithValue("@Department", department);
                cmd.Parameters.AddWithValue("@IdBadgeFilePath", idBadgeFilePath);
                cmd.Parameters.AddWithValue("@NationalIdFilePath", nationalIdFilePath);
                cmd.Parameters.AddWithValue("@IdExpiryDate", idExpiryDate);
                cmd.Parameters.AddWithValue("@SubmissionDate", submissionDate);
                cmd.Parameters.AddWithValue("@AdministrationName", administrationName);
                cmd.Parameters.AddWithValue("@UserNameAccount", userNameAccount);
                cmd.Parameters.AddWithValue("@EmployeeNumber", employeeNumber);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
