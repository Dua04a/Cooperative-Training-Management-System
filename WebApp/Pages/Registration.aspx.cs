using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Globalization;

namespace maiyas10920WebApp.Pages
{
    public partial class Registration : System.Web.UI.Page
    {
        private readonly List<string> arabicMajors = new List<string> {
            "علوم حاسب", "نظم معلومات", "تقنية معلومات", "أمن سيبراني", "هندسة حاسب",
            "إدارة أعمال", "محاسبة", "قانون", "طب بشري", "طب أسنان", "تمريض",
            "علاج طبيعي", "لغة إنجليزية", "تصميم جرافيكي", "أخرى"
        };

                private readonly List<string> englishMajors = new List<string> {
            "Computer Science", "Information Systems", "Information Technology", "Cybersecurity", "Computer Engineering",
            "Business Administration", "Accounting", "Law", "Medicine", "Dentistry", "Nursing",
            "Physical Therapy", "English Language", "Graphic Design", "Other"
        };

        private readonly List<string> arabicUniversities = new List<string> {
            "جامعة الإمام محمد بن سعود الإسلامية", "جامعة الأميرة نورة بنت عبد الرحمن", "جامعة الملك سعود بن عبدالعزيز للعلوم الصحية",
            "جامعة الأمير سطام بن عبدالعزيز", "جامعة الملك عبدالعزيز", "جامعة الملك فهد للبترول والمعادن",
            "جامعة الملك خالد", "جامعة أم القرى", "جامعة الملك فيصل", "جامعة القصيم", "جامعة طيبة",
            "جامعة حائل", "جامعة نجران", "جامعة الحدود الشمالية", "جامعة الجوف", "جامعة جازان",
            "جامعة تبوك", "جامعة الباحة", "جامعة بيشة", "جامعة المجمعة", "جامعة شقراء",
            "جامعة الإمام عبدالرحمن بن فيصل", "الجامعة الإسلامية", "جامعة جدة", "جامعة الأعمال والتكنولوجيا",
            "جامعة دار الحكمة", "جامعة الأمير محمد بن فهد", "جامعة الفيصل", "جامعة الأمير مقرن بن عبدالعزيز", "الجامعة العربية المفتوحة", "أخرى"
        };

        private readonly List<string> englishUniversities = new List<string> {
            "Imam Muhammad bin Saud Islamic University", "Princess Nourah Bint Abdulrahman University", "King Saud bin Abdulaziz University for Health Sciences",
            "Prince Sattam bin Abdulaziz University", "King Abdulaziz University", "King Fahd University of Petroleum and Minerals",
            "King Khalid University", "Umm Al-Qura University", "King Faisal University", "Qassim University", "Taibah University",
            "Hail University", "Najran University", "Northern Borders University", "Al-Jouf University", "Jazan University",
            "Tabuk University", "Al-Baha University", "Bisha University", "Majmaah University", "Shaqra University",
            "Imam Abdulrahman Bin Faisal University", "Islamic University", "University of Jeddah", "University of Business and Technology",
            "Dar Al-Hekma University", "Prince Mohammad Bin Fahd University", "Alfaisal University", "Prince Muqrin Bin Abdulaziz University", "Arab Open University", "Other"
        };


                    private readonly List<ListItem> arabicGenders = new List<ListItem>
            {
                new ListItem("ذكر", "ذكر"),
                new ListItem("أنثى", "أنثى")
            };

                    private readonly List<ListItem> englishGenders = new List<ListItem>
            {
                new ListItem("Male", "Male"),
                new ListItem("Female", "Female")
            };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string lang = Session["lang"] as string ?? "ar";
                PopulateDegreeMajorDropDown(lang);
                PopulateUniversityDropDown(lang);
                PopulateGenderRadioButtonList(lang);
                SetStaticText(lang);

                // Handle panels visibility if a postback caused a selection change
                OtherUniversityPanel.Visible = (UniversityName.SelectedValue == "other");
                OtherMajorPanel.Visible = (DegreeMajor.SelectedValue == "other");
            }
        }

        private void PopulateDegreeMajorDropDown(string lang)
        {
            DegreeMajor.Items.Clear();

            List<string> majors = lang == "en" ? englishMajors : arabicMajors;

            foreach (var major in majors)
            {
                string value = (major == "Other" || major == "أخرى") ? "other" : major;
                DegreeMajor.Items.Add(new ListItem(major, value));
            }
        }

        private void PopulateUniversityDropDown(string lang)
        {
            UniversityName.Items.Clear();

            List<string> universities = lang == "en" ? englishUniversities : arabicUniversities;

            UniversityName.Items.Add(new ListItem(
                lang == "en" ? "-- Select University --" : "-- اختر الجامعة --", ""));

            foreach (var uni in universities)
            {
                string value = (uni == "Other" || uni == "أخرى") ? "other" : uni;
                UniversityName.Items.Add(new ListItem(uni, value));
            }
        }

        private void SetStaticText(string lang)
        {
            // Page title
            litPageTitle.Text = lang == "ar" ? "تسجيل متدرب" : "Trainee Registration";

            // Form title
            litFormTitle.Text = lang == "ar" ? "تسجيل متدرب" : "Trainee Registration";

            lblNameArabic.Text = lang == "ar" ? "الاسم بالعربية" : "Name (Arabic)";
            lblNameEnglish.Text = lang == "ar" ? "الاسم بالإنجليزية" : "Name (English)";

            lblNationalID.Text = lang == "ar" ? "رقم الهوية/الإقامة" : "National ID / Iqama";
            lblAge.Text = lang == "ar" ? "العمر" : "Age";

            lblMobile.Text = lang == "ar" ? "رقم الجوال" : "Mobile Number";
            lblNoteMobileFormat.Text = lang == "ar" ? "أدخل الرقم بدون الصفر، مثال: 512345678" : "Enter number without leading zero, e.g., 512345678";

            lblEmail.Text = lang == "ar" ? "البريد الإلكتروني" : "Email";

            lblCountry.Text = lang == "ar" ? "الدولة" : "Country";
            lblGender.Text = lang == "ar" ? "الجنس" : "Gender";

            lblUniversityName.Text = lang == "ar" ? "اسم الجامعة" : "University Name";
            lblStudentUniversityID.Text = lang == "ar" ? "الرقم الجامعي" : "Student University ID";

            lblOtherUniversity.Text = lang == "ar" ? "يرجى كتابة اسم الجامعة" : "Please enter university name";

            lblDegreeMajor.Text = lang == "ar" ? "التخصص" : "Degree Major";
            lblDegree.Text = lang == "ar" ? "الدرجة العلمية" : "Degree";

            lblOtherMajor.Text = lang == "ar" ? "يرجى كتابة التخصص" : "Please enter major";

            lblTrainingStartDate.Text = lang == "ar" ? "تاريخ بداية التدريب" : "Training Start Date";
            lblTrainingEndDate.Text = lang == "ar" ? "تاريخ نهاية التدريب" : "Training End Date";

            lblSupervisorName.Text = lang == "ar" ? "اسم المشرف الأكاديمي" : "Academic Supervisor Name";
            lblSupervisorEmail.Text = lang == "ar" ? "إيميل المشرف الأكاديمي" : "Academic Supervisor Email";

            lblTrainingLetterFile.Text = lang == "ar" ? "ارفع خطاب التدريب التعاوني" : "Upload Training Letter";
            lblCVFile.Text = lang == "ar" ? "ارفع السيرة الذاتية" : "Upload CV";

            SubmitButton.Text = lang == "ar" ? "إرسال" : "Submit";


            if (lang == "ar")
            {
                aboutLink.Text = "حول ▾";
                whoWeAreLink.Text = "من نحن";
                visionLink.Text = "الرؤية";
                missionLink.Text = "الرسالة";
                contactLink.Text = "معلومات الاتصال";
                healthCentersLink.Text = "المراكز الصحية";
                traineeRegLink.Text = "تسجيل المتدربين";
                clearanceFormLink.Text = "نموذج الإخلاء";
                lnkSwitchLang.Text = "English";
            }
            else
            {
                aboutLink.Text = "About ▾";
                whoWeAreLink.Text = "Who We Are";
                visionLink.Text = "Vision";
                missionLink.Text = "Mission";
                contactLink.Text = "Contact Information";
                healthCentersLink.Text = "Health Centers";
                traineeRegLink.Text = "Trainee Registration";
                clearanceFormLink.Text = "Clearance Form";
                lnkSwitchLang.Text = "العربية";
            }
        }

        protected void UniversityName_SelectedIndexChanged(object sender, EventArgs e)
        {
            OtherUniversityPanel.Visible = (UniversityName.SelectedValue == "other");
        }

        protected void DegreeMajor_SelectedIndexChanged(object sender, EventArgs e)
        {
            OtherMajorPanel.Visible = (DegreeMajor.SelectedValue == "other");
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        { 
            string connStr = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

            string nameArabic = NameArabic.Text.Trim();
            string nameEnglish = NameEnglish.Text.Trim();
            string nationalId = NationalID.Text.Trim();
            string age = Age.Text.Trim();
            string mobile = Mobile.Text.Trim();
            string email = Email.Text.Trim();
            string country = Country.Text.Trim();
            string gender = Gender.SelectedValue;
            string university = UniversityName.SelectedValue == "other" ? OtherUniversity.Text.Trim() : UniversityName.SelectedValue;
            string studentId = StudentUniversityID.Text.Trim();
            string degree = Degree.Text.Trim();
            string major = DegreeMajor.SelectedValue == "other" ? OtherMajor.Text.Trim() : DegreeMajor.SelectedValue;
            string startDate = TrainingStartDate.Text.Trim();
            string endDate = TrainingEndDate.Text.Trim();
            string supervisorName = SupervisorName.Text.Trim();
            string supervisorEmail = SupervisorEmail.Text.Trim();

            // Save files
            string trainingLetterFileName = Path.GetFileName(TrainingLetterFile.FileName);
            string cvFileName = Path.GetFileName(CVFile.FileName);

            string uploadFolder = Server.MapPath("~/Uploads");
            if (!Directory.Exists(uploadFolder)) Directory.CreateDirectory(uploadFolder);

            string trainingLetterPath = Path.Combine(uploadFolder, trainingLetterFileName);
            string cvPath = Path.Combine(uploadFolder, cvFileName);

            DateTime trainingStartDate = DateTime.ParseExact(startDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            DateTime trainingEndDate = DateTime.ParseExact(endDate, "yyyy-MM-dd", CultureInfo.InvariantCulture);

            if (TrainingLetterFile.HasFile)
                TrainingLetterFile.SaveAs(trainingLetterPath);

            if (CVFile.HasFile)
                CVFile.SaveAs(cvPath);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"
                INSERT INTO TRAINEE (
                    NameArabic, NameEnglish, NationalID, Age, Mobile, Email, Country, Gender,
                    UniversityName, StudentID, DegreeMajor, Degree,
                    TrainingStartDate, TrainingEndDate,
                    SupervisorName, SupervisorEmail,
                    TrainingLetter, CV
                ) VALUES (
                    @NameArabic, @NameEnglish, @NationalID, @Age, @Mobile, @Email, @Country, @Gender,
                    @UniversityName, @StudentUniversityID, @DegreeMajor, @Degree,
                    @TrainingStartDate, @TrainingEndDate,
                    @SupervisorName, @SupervisorEmail,
                    @TrainingLetter, @CV
                )";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@NameArabic", nameArabic);
                    cmd.Parameters.AddWithValue("@NameEnglish", nameEnglish);
                    cmd.Parameters.AddWithValue("@NationalID", nationalId);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Country", country);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.Parameters.AddWithValue("@UniversityName", university);
                    cmd.Parameters.AddWithValue("@StudentUniversityID", studentId);
                    cmd.Parameters.AddWithValue("@DegreeMajor", major);
                    cmd.Parameters.AddWithValue("@Degree", degree);
                    cmd.Parameters.AddWithValue("@TrainingStartDate", trainingStartDate);
                    cmd.Parameters.AddWithValue("@TrainingEndDate", trainingEndDate);
                    cmd.Parameters.AddWithValue("@SupervisorName", supervisorName);
                    cmd.Parameters.AddWithValue("@SupervisorEmail", supervisorEmail);
                    cmd.Parameters.AddWithValue("@TrainingLetter", "Uploads/" + trainingLetterFileName);
                    cmd.Parameters.AddWithValue("@CV", "Uploads/" + cvFileName);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            string lang = Session["lang"] as string ?? "ar";

            string message = lang == "ar"
                ? "تم إرسال البيانات بنجاح"
                : "Data submitted successfully";

            string script = $"<script>alert('{message}');</script>";
            Response.Write(script);
        }

        protected void btnSwitchLang_Click(object sender, EventArgs e)
        {
            string currentLang = Session["lang"] as string ?? "ar";
            Session["lang"] = currentLang == "ar" ? "en" : "ar";
            Response.Redirect(Request.RawUrl); // Refresh to apply language change
        }

        private void PopulateGenderRadioButtonList(string lang)
        {
            Gender.Items.Clear();
            if (lang == "ar")
            {
                Gender.Items.AddRange(arabicGenders.ToArray());
            }
            else
            {
                Gender.Items.AddRange(englishGenders.ToArray());
            }
        }


    }
}