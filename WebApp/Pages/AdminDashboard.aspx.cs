using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace maiyas10920WebApp.Pages
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["maiyas10920ConStr"].ConnectionString;

        private const string senderEmail = "kfmc55541@gmail.com";
        private const string senderAppPassword = "atelqbqihjscigbr";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdminAuthenticated"] == null || !(bool)Session["IsAdminAuthenticated"])
            {
                Response.Redirect("Login.aspx");
                return;
            }

                if (Session["Language"] == null)
                    Session["Language"] = "en"; // اللغة الافتراضية انجليزية

            if (!IsPostBack) // ✅ Only bind GridView and time ON FIRST LOAD
            {
                LoadRequests();
                lblDateTime.Text = DateTime.Now.ToString("f");
            }


            SetLanguage();
            btnToggleLanguage.Text = (Session["Language"]?.ToString() == "ar") ? "English" : "العربية";
        }

        private void SetLanguage()
        {
            string lang = Session["Language"]?.ToString() ?? "en";

            if (lang == "ar")
            {
                btnNominateForInterview.Text = "ترشيح للمقابلة";
                btnAcceptTraining.Text = "قبول المتدرب";
                btnReject.Text = "رفض الطلب";
                btnLogout.Text = "تسجيل خروج";

                interviewCardTitle.InnerText = "تحديد موعد المقابلة";
                trainingCardTitle.InnerText = "فترة التدريب";

                interviewDateLabel.InnerText = "📅 تاريخ ووقت المقابلة";
                startDateLabel.InnerText = "▶ تاريخ البدء";
                endDateLabel.InnerText = "⏹ تاريخ الانتهاء";
                trainingRequestsHeader.InnerText = "طلبات التدريب";
            }
            else
            {
                btnNominateForInterview.Text = "Nominate for Interview";
                btnAcceptTraining.Text = "Accept Trainee";
                btnReject.Text = "Reject Request";
                btnLogout.Text = "Logout";

                interviewCardTitle.InnerText = "Interview Scheduling";
                trainingCardTitle.InnerText = "Training Period";

                interviewDateLabel.InnerText = "🕐 Interview Date & Time";
                startDateLabel.InnerText = "▶ Start Date";
                endDateLabel.InnerText = "⏹ End Date";
                trainingRequestsHeader.InnerText = "Training Requests";
            }
            if (gvRequests.Columns.Count > 0)
            {
                if (lang == "ar")
                {
                    gvRequests.Columns[0].HeaderText = "اختيار";
                    gvRequests.Columns[1].HeaderText = "معرّف الطلب";
                    gvRequests.Columns[2].HeaderText = "اسم المتدرب";
                    gvRequests.Columns[3].HeaderText = "البريد الإلكتروني";
                    gvRequests.Columns[4].HeaderText = "الحالة";
                    gvRequests.Columns[5].HeaderText = "تاريخ المقابلة";
                }
                else
                {
                    gvRequests.Columns[0].HeaderText = "Select";
                    gvRequests.Columns[1].HeaderText = "Request ID";
                    gvRequests.Columns[2].HeaderText = "Trainee Name";
                    gvRequests.Columns[3].HeaderText = "Email";
                    gvRequests.Columns[4].HeaderText = "Status";
                    gvRequests.Columns[5].HeaderText = "Interview Date";
                }
            }

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnToggleLanguage_Click(object sender, EventArgs e)
        {
            string currentLang = Session["Language"]?.ToString() ?? "en";
            Session["Language"] = (currentLang == "ar") ? "en" : "ar";

            Response.Redirect(Request.RawUrl); // Refresh the page to apply new language
        }


        protected void btnNominateForInterview_Click(object sender, EventArgs e)
        {
            try
            {
                int id = GetSelectedRequestID();
                DateTime interviewDate = DateTime.Parse(txtInterviewDate.Text);
                ApproveRequest(id, interviewDate);
                SendInterviewEmail(id);
                LoadRequests();
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "تم إرسال دعوة المقابلة بنجاح." : "Interview invitation sent successfully.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "خطأ: " + ex.Message : "Error: " + ex.Message;
            }
        }

        protected void btnAcceptTraining_Click(object sender, EventArgs e)
        {
            try
            {
                int id = GetSelectedRequestID();
                DateTime startDate = DateTime.Parse(dtStartDate.Text);
                DateTime endDate = DateTime.Parse(dtEndDate.Text);

                AcceptTraineeForTraining(id, startDate, endDate);
                SendAcceptanceEmail(id, startDate, endDate);
                LoadRequests();
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "تم إرسال إشعار القبول بنجاح." : "Acceptance notification sent successfully.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "خطأ: " + ex.Message : "Error: " + ex.Message;
            }
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            try
            {
                int id = GetSelectedRequestID();
                RejectRequest(id);
                SendRejectEmail(id);
                LoadRequests();
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "تم إرسال إشعار الرفض بنجاح." : "Rejection notification sent successfully.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = (Session["Language"]?.ToString() == "ar") ? "خطأ: " + ex.Message : "Error: " + ex.Message;
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
            throw new Exception((Session["Language"]?.ToString() == "ar") ? "الرجاء اختيار طلب من الجدول." : "Please select a request from the table.");
        }

        private void LoadRequests()
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                string sql = @"
                    SELECT R.RequestID, T.TraineeName, T.Email, R.Status, R.InterviewDate
                    FROM TrainingRequests R
                    JOIN Trainees T ON R.TraineeID = T.TraineeID";

                var da = new SqlDataAdapter(sql, con);
                var dt = new DataTable();
                da.Fill(dt);

                gvRequests.DataSource = dt;
                gvRequests.DataBind();
            }
        }

        private DataRow GetRequestByID(int requestID)
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                var da = new SqlDataAdapter(@"
                    SELECT R.RequestID, T.TraineeName, T.Email, T.Major, T.AcademicID, T.SupervisorEmail,
                           R.Status, R.InterviewDate
                    FROM TrainingRequests R
                    JOIN Trainees T ON R.TraineeID = T.TraineeID
                    WHERE R.RequestID = @id", con);

                da.SelectCommand.Parameters.AddWithValue("@id", requestID);
                var dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                    throw new Exception((Session["Language"]?.ToString() == "ar") ? "لم يتم العثور على الطلب." : "Request not found.");

                return dt.Rows[0];
            }
        }

        private void ApproveRequest(int id, DateTime interviewDate)
        {
            using (SqlConnection con = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("ApproveRequest", con) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@RequestID", id);
                cmd.Parameters.AddWithValue("@InterviewDate", interviewDate);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void AcceptTraineeForTraining(int id, DateTime startDate, DateTime endDate)
        {
            using (SqlConnection con = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("AcceptTraineeForTraining", con) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@RequestID", id);
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void RejectRequest(int id)
        {
            using (SqlConnection con = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("RejectRequest", con) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@RequestID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void SendEmail(string to, string subject, string body)
        {
            var msg = new MailMessage(senderEmail, to, subject, body)
            {
                BodyEncoding = Encoding.UTF8,
                IsBodyHtml = false
            };

            using (var client = new SmtpClient("smtp.gmail.com", 587))
            {
                client.Credentials = new NetworkCredential(senderEmail, senderAppPassword);
                client.EnableSsl = true;
                client.Send(msg);
            }
        }

        private void SendInterviewEmail(int requestID)
        {
            var req = GetRequestByID(requestID);
            DateTime interviewDate = (DateTime)req["InterviewDate"];

            string body = (Session["Language"]?.ToString() == "ar") ?
$@"بعد التحية ,,,
ننوه بموعد مقابلة شخصية
اليوم {interviewDate:dddd} الموافق {interviewDate:yyyy/MM/dd}
الساعة: {interviewDate:hh:mm tt}

الرجاء احضار السيرة الذاتية , نسخة من خطاب الجامعة

,,
مدينة الملك فهد الطبية كلية الطب الدور الثاني
https://maps.app.goo.gl/QyaZ5aXtG5TRNWfc8"
:
$@"Dear,

This is a reminder for your interview appointment on:
{interviewDate:dddd}, {interviewDate:yyyy/MM/dd}
At: {interviewDate:hh:mm tt}

Please bring your CV and a copy of the university letter.

King Fahad Medical City, Medical College, 2nd Floor
https://maps.app.goo.gl/QyaZ5aXtG5TRNWfc8";

            SendEmail(req["Email"].ToString(), (Session["Language"]?.ToString() == "ar") ? "موعد مقابلة تدريب" : "Training Interview Appointment", body);
        }

        private void SendAcceptanceEmail(int requestID, DateTime startDate, DateTime endDate)
        {
            var req = GetRequestByID(requestID);

            string body = (Session["Language"]?.ToString() == "ar") ?
$@"مع التحية

نفيدكم بأنه لا مانع لدينا من قبول تدريب المتدربـ/ـة : {req["TraineeName"]}
تخصص: {req["Major"]}
الرقم الأكاديمي : {req["AcademicID"]}
في: مدينة الملك فهد الطبية
ابتداء من {startDate:yyyy/MM/dd}
والنهاية {endDate:yyyy/MM/dd}

وشكراً"
:
$@"Greetings,

We hereby inform you that the trainee: {req["TraineeName"]}
Major: {req["Major"]}
Academic ID: {req["AcademicID"]}
has been accepted for training at King Fahad Medical City
Starting from {startDate:yyyy/MM/dd}
Until {endDate:yyyy/MM/dd}

Thank you.";

            SendEmail(req["Email"].ToString(), (Session["Language"]?.ToString() == "ar") ? "قبول التدريب" : "Training Acceptance", body);
            SendEmail(req["SupervisorEmail"].ToString(), (Session["Language"]?.ToString() == "ar") ? "قبول تدريب الطالب" : "Student Training Acceptance", body);
        }

        private void SendRejectEmail(int requestID)
        {
            var req = GetRequestByID(requestID);

            string body = (Session["Language"]?.ToString() == "ar") ?
$@"السلام عليكم،

نأسف لإبلاغكم بأن طلب التدريب الخاص بالمتدرب/ة {req["TraineeName"]} قد تم رفضه.

نتمنى لكم التوفيق في المستقبل.

شكراً."
:
$@"Dear Sir/Madam,

We regret to inform you that the training request for trainee {req["TraineeName"]} has been rejected.

We wish you the best of luck in the future.

Thank you.";

            SendEmail(req["Email"].ToString(), (Session["Language"]?.ToString() == "ar") ? "رفض طلب التدريب" : "Training Request Rejection", body);
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblDateTime.Text = DateTime.Now.ToString("dddd, MMMM dd, yyyy hh:mm:ss tt");
        }
    }
}