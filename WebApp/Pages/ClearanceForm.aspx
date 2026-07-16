<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClearanceForm.aspx.cs" Inherits="maiyas10920WebApp.Pages.ClearanceForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["lang"] ?? "en" %>" dir="<%= (Session["Language"]?.ToString() == "ar") ? "rtl" : "ltr" %>">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>KFMC Clearance Form</title>
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500;700&family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary-color: rgb(30, 45, 120);
            --secondary-color: #28a745;
            --danger-color: #dc3545;
            --light-gray: #f8f9fa;
            --dark-gray: #6c757d;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Tajawal',sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            transition: all 0.3s ease;
            line-height: 1.6;
        }

        /* Language Switch */
        .lang-switch {
            text-align: center; /* ✅ Centers inline elements like buttons */
           margin-top: 100px;
           margin-bottom: 2px;

        }

        .lang-btn {
             width: 200px;         /* Avoid fixed width */
             height: auto; 
              background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 20px 30px;
            border-radius: 50px;
            display: inline-flex;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            cursor: pointer; /* nice to indicate clickable */
            color: white; /* assuming button text */
            font-weight: 700;
            font-size: 25px;
        }

        .lang-btn:hover {
            background-color: #f0f0f0;
        }

        /* Alert Message */
        .alert-message {
            color: red;
            font-size: 17px;
            font-weight: bold;
            text-align: center;
            margin: 0 0 20px 0;
            padding: 0 20px;
        }

        .form-header {
                 display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 15px;
            }

            .form-header-rtl {
                flex-direction: row-reverse; /* Pushes logo to right */
                justify-content: flex-start; /* Keeps spacing consistent */
            }

            .form-title {
                 flex: 1;              /* Take available space */
                text-align: center;
                margin-left: -30px;
            }

            .header-line1 {
            font-size: 35px; /* Larger for main title */
            font-weight: bold;
        }

        .header-line2 {
            font-size: 18px;
            font-weight: 600;
        }

        .header-line3 {
            font-size: 16px;
            font-weight: normal;
            font-style: italic;
        }

            .form-logo {
                width: 200px;  /* Adjust as needed */
                height: auto;
            }


        /* Form Sections */
        .form-container {
            max-width: 1200px;
            margin: 250px auto 20px;
            padding: 0 20px;
        }

        section {
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            padding: 25px;
        }

        section h2 {
            color: #0674b9;
            font-size: 27px;
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #0674b9;
        }

        /* Form Grid Layout */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        .admin-grid {
            grid-template-columns: 1fr 1fr; /* 2 equal columns */
            gap: 30px 50px; /* row gap 30px, column gap 50px (adjust as needed) */
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            font-size: 18px;
            color: #092f73;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
        }

        input:focus, select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.2);
        }

        /* File Upload Styles */.file-upload {
            background-color: var(--light-gray);
            padding: 15px;
            border-radius: 4px;
            border: 1px dashed #ccc;
            text-align: center;
        }

        .file-upload-label {
            display: block;
            cursor: pointer;
            color: var(--primary-color);
            font-weight: bold;
            margin-bottom: 5px;
        }

        .file-name {
            font-size: 13px;
            color: var(--dark-gray);
            margin-top: 5px;
        }

        /* Button Styles */
        .buttons-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 16px 40px;    /* bigger padding for bigger buttons */
              font-size: 18px;       /* larger font size */
              width: auto;      /* wider buttons */
              border-radius: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

             .btn-primary {
              background: linear-gradient(135deg, #34d058, #196c2e); /* lighter to darker green */
              color: white;
            }

            .btn-primary:hover {
              background: linear-gradient(135deg, #196c2e, #0f3d16); /* even darker on hover */
            }

            .btn-danger {
              background: linear-gradient(135deg, #e5534b, #8b1c13); /* lighter to darker red */
              color: white;
            }

            .btn-danger:hover {
              background: linear-gradient(135deg, #8b1c13, #5a0e0a); /* darker on hover */
            }

        .btn, .btn-primary, .btn-danger {
            border: none !important;
            outline: none; /* optional: removes the blue outline on focus */
            box-shadow: none;
        }

        /* RTL Styles */
        body.rtl {
            direction: rtl;
            text-align: right;
        }

        body.rtl .lang-switch {
            right: 15px;
            left: auto;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 15px;
            }

            .logo-container {
                width: 80px;
                height: 80px;
            }

            header h1 {
                font-size: 26px;
            }

            section {
                padding: 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .buttons-container {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
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

            .slide:nth-child(1) {
              animation-delay: 0s;
            }
            .slide:nth-child(2) {
              animation-delay: 5s;
            }
            .slide:nth-child(3) {
              animation-delay: 10s;
            }

            @keyframes fadeSlide {
              0%   { opacity: 0; }
              10%  { opacity: 1; }
              30%  { opacity: 1; }
              40%  { opacity: 0; }
              100% { opacity: 0; }
            }

    </style>
</head>
<body>
    <form id="form2" runat="server" enctype="multipart/form-data">
        <div class="slideshow-background">
            <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
            <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
            <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
        </div>

        <!-- Language Switch Button -->
        <div class="lang-switch">
           <asp:Button ID="languageBtn" runat="server" Text="العربية" CssClass="lang-btn" 
    OnClick="languageBtn_Click" CausesValidation="false" UseSubmitBehavior="false" />

        </div>

        <!-- Personal Information Section -->
        <div class="form-container">
            <section>
                <div id="formHeader" runat="server" class="form-header">
                <div class="form-title">
                <div id="headerLine1" runat="server" class="header-line1"></div>
                <div id="headerLine2" runat="server" class="header-line2"></div>
                <div id="headerLine3" runat="server" class="header-line3"></div>
            </div>
            </div>

                <p class="alert-message" id="alertMessage" runat="server">For KFMC staff, kindly submit clearance request in RMS</p>
                <h2 id="personalInfoTitle" runat="server">Personal Information</h2>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="nationality" id="labelNationality" runat="server">Nationality:</label>
                       <asp:DropDownList ID="nationality" runat="server"></asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="idNumber" id="labelIdNumber" runat="server">ID Number/Iqama:</label>
                        <input type="text" id="idNumber" name="idNumber" required />
                    </div>

                    <div class="form-group">
                        <label for="englishName" id="labelEnglishName" runat="server">English Name:</label>
                        <input type="text" id="englishName" name="englishName" required />
                    </div>

                    <div class="form-group">
                        <label for="arabicName" id="labelArabicName" runat="server">Arabic Name:</label>
                        <input type="text" id="arabicName" name="arabicName" required />
                    </div>

                    <div class="form-group">
                        <label for="kfmcEmail" id="labelKfmcEmail" runat="server">KFMC Email:</label>
                        <input type="email" id="kfmcEmail" name="kfmcEmail" />
                    </div>

                    <div class="form-group">
                        <label for="mobile" id="labelMobile" runat="server">Mobile No.:</label>
                        <input type="tel" id="mobile" name="mobile" required />
                    </div>

                    <div class="form-group">
                        <label for="jobTitle" id="labelJobTitle" runat="server">Job title:</label>
                        <input type="text" id="jobTitle" name="jobTitle" required />
                    </div>

                    <div class="form-group">
                        <label for="executiveAdmin" id="labelExecutiveAdmin" runat="server">Executive Administration:</label>
                        <input type="text" id="executiveAdmin" name="executiveAdmin" required />
                    </div>

                    <div class="form-group">
                        <label for="department" id="labelDepartment" runat="server">Department:</label>
                        <input type="text" id="department" name="department" required />
                    </div>
                </div>
            </section>

            <!-- ID Documents Section -->
            <section>
                <h2 id="documentsTitle" runat="server">ID Documents</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <label id="labelIdBadge" runat="server">ID Badge:</label>
                        <div class="file-upload">
                            <label for="idBadgeFile" class="file-upload-label" id="idBadgeLabel" runat="server">Choose File</label>
                            <input type="file" id="idBadgeFile" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" />
                            <div class="file-name" id="idBadgeFileName" runat="server">No file chosen</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="idExpiry" id="labelIdExpiry" runat="server">ID Badge Expiry Date:</label>
                        <input type="date" id="idExpiry" name="idExpiry" required />
                    </div>

                    <div class="form-group">
                        <label id="labelNationalId" runat="server">National ID:</label>
                        <div class="file-upload">
                            <label for="nationalIdFile" class="file-upload-label" id="nationalIdLabel" runat="server">Choose File</label>
                            <input type="file" id="nationalIdFile" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" />
                            <div class="file-name" id="nationalIdFileName" runat="server">No file chosen</div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Administration Information Section -->
            <section>
                <h2 id="adminInfoTitle" runat="server">Administration Information</h2>
                <div class="form-grid admin-grid">
                    <div class="form-group">
                        <label for="date" id="labelDate" runat="server">Date:</label>
                        <input type="date" id="date" name="date" required />
                    </div>

                    <div class="form-group">
                        <label for="adminName" id="labelAdminName" runat="server">Administration Name:</label>
                       <asp:DropDownList ID="adminName" runat="server"></asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="userName" id="labelUserName" runat="server">User name account:</label>
                        <input type="text" id="userName" name="userName" required />
                    </div>

                    <div class="form-group">
                        <label for="employeeNo" id="labelEmployeeNo" runat="server">Employee No.:</label>
                        <input type="text" id="employeeNo" name="employeeNo" required />
                    </div>
                </div>
            </section>

            <!-- Submit Buttons -->
            <div class="buttons-container">
                <asp:Button ID="submitBtn" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="submitBtn_Click" />
                <asp:Button ID="cancelBtn" runat="server" Text="Cancel" CssClass="btn btn-danger" OnClick="cancelBtn_Click" CausesValidation="false" UseSubmitBehavior="false" />
            </div>
        </div>
    </form>
</body>
</html>
