<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="maiyas10920WebApp.Pages.Registration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["lang"] ?? "en" %>" dir="<%= (Session["lang"] as string) == "ar" ? "rtl" : "ltr" %>">
<head>
  <meta charset="UTF-8"/>
  <title><asp:Literal ID="litPageTitle" runat="server" /></title>
  <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;700&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"/>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ar.js"></script>
  <style>
.input-with-prefix input {
  border-radius: 0 6px 6px 0;
  border-left: none;
  flex: 1;
}

    body {
      font-family: 'Tajawal', sans-serif;
      background-size: cover;
      background-position: left 18%;
      background-repeat: no-repeat;
      background-attachment: fixed;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 900px;
      margin: 250px auto 30px;
      background-color: rgba(255, 255, 255, 0.80);
      border-radius: 12px;
      padding: 40px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.1);
      backdrop-filter: blur(2px);
    }

    h2 {
      text-align: center;
      margin-bottom: 35px;
      font-size: 30px;
      font-weight: 700;
      color: #00b4d8;
    }

    .form-label {
      display: block;
      margin-top: 35px;
      margin-bottom: 10px;
      font-size: 20px;
      font-weight: 600;
    }

     .form-abel {
      display: block;
      margin-top: 35px;
      margin-bottom: 20px;
      font-size: 20px;
      font-weight: 600;
    }

    input, select {
      width: 100%;
      padding: 12px;
      margin-top: 6px;
      border: 1px solid #dcdcdc;
      border-radius: 6px;
      font-size: 15px;
      background-color: #fff;
      box-sizing: border-box;
      transition: border-color 0.3s ease;
    }

    input:focus, select:focus {
      outline: none;
      border-color: #0077b6;
    }

    .form-row {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }

    .form-row .half {
      flex: 1 1 48%;
    }

    @media (max-width: 600px) {
      .form-row {
        flex-direction: column;
      }

      .form-row .half {
        flex: 1 1 100%;
      }
    }

    .radio-group {
      display: flex;
      gap: 30px;
      margin-top: 6px;
    }

    .radio-group input[type="radio"] {
      display: none;
    }

    .radio-group label {
      position: relative;
      padding: 10px 20px;
      border: 2px solid #0077b6;
      border-radius: 20px;
      font-weight: 600;
      font-size: 20px;
      cursor: pointer;
      background-color: white;
      transition: background-color 0.3s ease, color 0.3s ease;
    }

    .radio-group input[type="radio"]:checked + label {
      background-color: #0077b6;
      color: white;
    }
    .custom-file {
  position: relative;
  margin-top: 6px;
  height: 48px; /* يضمن وجود مساحة للفاصل */
}

.custom-file input[type="file"] {
  opacity: 0;
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  cursor: pointer;
}

.file-label {
  background-color: #f0f3f6;
  padding: 12px;
  border-radius: 8px;
  border: 1px solid #ccd1d9;
  display: inline-block;
  width: 100%;
  text-align: center;
  margin-top: 10px;
  margin-bottom: 10px;
  box-sizing: border-box;
}
    .note {
      font-size: 13px;
      color: #888 !important;
      margin-top: 5px;
    }

    button, .button {
      margin: 30px auto 0;
      display: block;
      width: 50%;
      background: linear-gradient(to right, #0077b6, #00b4d8);
      color: #fff;
      padding: 14px 20px;
      border: none;
      border-radius: 50px;
      font-size: 20px;
      font-weight: bold;
      cursor: pointer;
      box-shadow: 0 4px 10px rgba(0, 119, 182, 0.3);
      transition: all 0.3s ease;
    }

    button:hover, .button:hover {
      background: linear-gradient(to right, #00b4d8, #0077b6);
      transform: scale(1.03);
      box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
    }
  .input-with-prefix {
  display: flex;
  align-items: center;
}

.input-with-prefix span {
  background-color: #f0f3f6;
  padding: 12px;
  border: 1px solid #dcdcdc;
  border-radius: 6px 0 0 6px;
  font-size: 15px;
  white-space: nowrap;
  color: #333;
}
.input-with-prefix input {
  border-radius: 0 6px 6px 0;
  border-left: none;
  flex: 1;
}
.input-with-prefix-left {
  position: relative;
}

.input-with-prefix-left input {
  padding-left: 55px;
}

.input-with-prefix-left .prefix {
  position: absolute;
  left: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #555;
  font-size: 15px;
  pointer-events: none;
}
.slideshow-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: -1;
  overflow: hidden;
}

.slide {
  position: absolute;
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center top;
  animation: fadeSlide 15s infinite;
  opacity: 0;
}

.slide:nth-child(1) { animation-delay: 0s; }
.slide:nth-child(2) { animation-delay: 5s; }
.slide:nth-child(3) { animation-delay: 10s; }

@keyframes fadeSlide {
  0%   { opacity: 0; }
  10%  { opacity: 1; }
  30%  { opacity: 1; }
  40%  { opacity: 0; }
  100% { opacity: 0; }
}

.rounded-navbar {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 20px 30px;
            border-radius: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            width: fit-content;
            margin: 100px auto;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }


        .rounded-navbar > ul {
              list-style: none;
              margin: 0;
              padding: 0;
              display: flex;  /* only direct child ul of .rounded-navbar is flex */
              gap: 35px;
            }

           /* Parent item styling */
            .rounded-navbar li {
              position: relative;
            }

            .rounded-navbar a {
              text-decoration: none !important;
              color: #ffffff;/* or your desired link color */
               font-weight: bold;        /*Makes text bold */
              font-size: 25px;
            }


            /* Dropdown menu */
            .dropdown-menu {
              position: absolute;
              top: 100%;
              left: 50%;
              transform: translateX(-50%);
              background-color: #ffffff;
              border-radius: 8px;
              box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
              min-width: 180px;
              padding: 4px 0;
              margin: 0;
              z-index: 100;
              opacity: 0;
              visibility: hidden;
              pointer-events: none;
              transition: opacity 0.2s ease, visibility 0.2s ease;
              display: block;
            }

            /* Show on hover */
            .dropdown:hover .dropdown-menu {
              opacity: 1;
              visibility: visible;
              pointer-events: auto;
            }

            /* Dropdown items */
            .dropdown-menu li {
              margin: 0;
              padding: 0;
              list-style: none;
            }

            /* Links inside dropdown */
            .dropdown-menu li a {
              display: block;
              padding: 6px 14px;
              font-size: 14px;
              color: #1e266d;
              text-decoration: none; /* FIX: Remove underline */
              transition: background-color 0.2s;
            }

            /* Hover effect */
            .dropdown-menu li a:hover {
              background-color: #f0f0f0;
              border-radius: 4px;
            }
  </style>
</head>
<body>
  <form id="form1" runat="server" enctype="multipart/form-data">
    <div class="slideshow-background">
      <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
      <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
      <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
    </div>

      <div class="rounded-navbar">
            <ul>
                <li class="dropdown">
                    <asp:HyperLink ID="aboutLink" runat="server" NavigateUrl="#">About ▾</asp:HyperLink>
                    <ul class="dropdown-menu">
                        <li><asp:HyperLink ID="whoWeAreLink" runat="server" NavigateUrl="#">Who We Are</asp:HyperLink></li>
                        <li><asp:HyperLink ID="visionLink" runat="server" NavigateUrl="#">Vision</asp:HyperLink></li>
                        <li><asp:HyperLink ID="missionLink" runat="server" NavigateUrl="#">Mission</asp:HyperLink></li>
                        <li><asp:HyperLink ID="contactLink" runat="server" NavigateUrl="#">Contact Information</asp:HyperLink></li>
                    </ul>
                </li>
                <li><asp:HyperLink ID="healthCentersLink" runat="server" NavigateUrl="HealthCenters.aspx">Health Centers</asp:HyperLink></li>
                <li><asp:HyperLink ID="traineeRegLink" runat="server" NavigateUrl="Registration.aspx">Trainee Registration</asp:HyperLink></li>
                <li><asp:HyperLink ID="clearanceFormLink" runat="server" NavigateUrl="ClearanceForm.aspx">Clearance Form</asp:HyperLink></li>
                <li><asp:LinkButton ID="lnkSwitchLang" runat="server" OnClick="btnSwitchLang_Click" CssClass="lang-switch">العربية</asp:LinkButton></li>
            </ul>
        </div>

    <div class="container">
       <h2><asp:Literal ID="litFormTitle" runat="server" /></h2>

      <div class="form-row">
        <div class="half">
         <asp:Label ID="lblNameArabic" runat="server" CssClass="form-label" AssociatedControlID="NameArabic" />
         <asp:TextBox runat="server" ID="NameArabic" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblNameEnglish" runat="server" CssClass="form-label" AssociatedControlID="NameEnglish" />
           <asp:TextBox runat="server" ID="NameEnglish" CssClass="form-control" />
        </div>
      </div>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblNationalID" runat="server" CssClass="form-label" AssociatedControlID="NationalID" />
         <asp:TextBox runat="server" ID="NationalID" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblAge" runat="server" CssClass="form-label" AssociatedControlID="Age" />
          <asp:TextBox runat="server" ID="Age" CssClass="form-control" TextMode="Number" />
        </div>
      </div>

      <div class="form-row">
        <div class="half">
         <asp:Label ID="lblMobile" runat="server" CssClass="form-label" AssociatedControlID="Mobile" />
          <div class="input-with-prefix-left">
            <span class="prefix">+966</span>
            <asp:TextBox runat="server" ID="Mobile" CssClass="form-control" placeholder="5xxxxxxxx" />
          </div>
           <div class="note"> <asp:Label ID="lblNoteMobileFormat" runat="server" CssClass="form-note" AssociatedControlID="Mobile" /></div>
        </div>
        <div class="half">
          <asp:Label ID="lblEmail" runat="server" CssClass="form-label" AssociatedControlID="Email" />
          <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
        </div>
      </div>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblCountry" runat="server" CssClass="form-label" AssociatedControlID="Country" />
          <asp:TextBox runat="server" ID="Country" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblGender" runat="server" CssClass="form-abel" AssociatedControlID="Gender" />
          <asp:RadioButtonList ID="Gender" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
            <asp:ListItem Text="ذكر" Value="ذكر" />
            <asp:ListItem Text="أنثى" Value="أنثى" />
          </asp:RadioButtonList>
        </div>
      </div>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblUniversityName" runat="server" CssClass="form-label" AssociatedControlID="UniversityName" />
          <asp:DropDownList runat="server" ID="UniversityName" CssClass="form-control" OnSelectedIndexChanged="UniversityName_SelectedIndexChanged" />
           
        </div>
        <div class="half">
          <asp:Label ID="lblStudentUniversityID" runat="server" CssClass="form-label" AssociatedControlID="StudentUniversityID" />
          <asp:TextBox runat="server" ID="StudentUniversityID" CssClass="form-control" />
        </div>
      </div>

      <asp:Panel runat="server" ID="OtherUniversityPanel" Visible="false" style="margin-top: 10px;">
         <asp:Label ID="lblOtherUniversity" runat="server" CssClass="form-label" AssociatedControlID="OtherUniversity" />
        <asp:TextBox runat="server" ID="OtherUniversity" CssClass="form-control" />
      </asp:Panel>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblDegreeMajor" runat="server" CssClass="form-label" AssociatedControlID="DegreeMajor" />
          <asp:DropDownList runat="server" ID="DegreeMajor" CssClass="form-control" OnSelectedIndexChanged="DegreeMajor_SelectedIndexChanged" />
        </div>
        <div class="half">
         <asp:Label ID="lblDegree" runat="server" CssClass="form-label" AssociatedControlID="Degree" />
          <asp:TextBox runat="server" ID="Degree" CssClass="form-control" />
        </div>
      </div>

      <asp:Panel runat="server" ID="OtherMajorPanel" Visible="false" style="margin-top: 10px;">
        <asp:Label ID="lblOtherMajor" runat="server" CssClass="form-label" AssociatedControlID="OtherMajor" />
        <asp:TextBox runat="server" ID="OtherMajor" CssClass="form-control" />
      </asp:Panel>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblTrainingStartDate" runat="server" CssClass="form-label" AssociatedControlID="TrainingStartDate" />
          <asp:TextBox runat="server" ID="TrainingStartDate" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblTrainingEndDate" runat="server" CssClass="form-label" AssociatedControlID="TrainingEndDate" />
          <asp:TextBox runat="server" ID="TrainingEndDate" CssClass="form-control" />
        </div>
      </div>

      <div class="form-row">
        <div class="half">
           <asp:Label ID="lblSupervisorName" runat="server" CssClass="form-label" AssociatedControlID="SupervisorName" />
          <asp:TextBox runat="server" ID="SupervisorName" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblSupervisorEmail" runat="server" CssClass="form-label" AssociatedControlID="SupervisorEmail" />
          <asp:TextBox runat="server" ID="SupervisorEmail" CssClass="form-control" TextMode="Email" />
        </div>
      </div>

      <div class="form-row">
        <div class="half">
          <asp:Label ID="lblTrainingLetterFile" runat="server" CssClass="form-label" AssociatedControlID="TrainingLetterFile" />
          <asp:FileUpload runat="server" ID="TrainingLetterFile" CssClass="form-control" />
        </div>
        <div class="half">
          <asp:Label ID="lblCVFile" runat="server" CssClass="form-label" AssociatedControlID="CVFile" />
          <asp:FileUpload runat="server" ID="CVFile" CssClass="form-control" />
        </div>
      </div>

      <asp:Button runat="server" ID="SubmitButton" CssClass="button" OnClick="SubmitButton_Click" />
    </div>
  </form>

<script>
    var lang = '<%= (Session["lang"] as string) ?? "ar" %>';
    var locale = lang === "ar" ? "ar" : "default";

    flatpickr("#<%= TrainingStartDate.ClientID %>", {
    locale: locale,
    dateFormat: "Y-m-d"
  });

  flatpickr("#<%= TrainingEndDate.ClientID %>", {
        locale: locale,
        dateFormat: "Y-m-d"
    });
</script>
</body>
</html>


