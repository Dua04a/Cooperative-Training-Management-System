<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainAdmin.aspx.cs" Inherits="maiyas10920WebApp.Pages.MainAdmin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["Language"] ?? "en" %>" dir="<%= (Session["Language"]?.ToString() == "ar") ? "rtl" : "ltr" %>">
    <head runat="server">
    <title>Main Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@400;700&display=swap" rel="stylesheet" />
   <style>

        :root {
            --primary-color: #1a73e8;
            --secondary-color: #4285f4;
            --light-blue: #e8f0fe;
            --dark-blue: #0d47a1;
            --white: #ffffff;
            --gray: #f5f5f5;
            --primary-gradient: linear-gradient(135deg, #1a73e8 0%, #4285f4 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #00c851 0%, #007e33 100%);
            --danger-gradient: linear-gradient(135deg, #ff4444 0%, #cc0000 100%);
            --info-gradient: linear-gradient(135deg, #33b5e5 0%, #0099cc 100%);
            --warning-gradient: linear-gradient(135deg, #ffbb33 0%, #ff8800 100%);
            --dark-gradient: linear-gradient(135deg, #0d47a1 0%, #1a73e8 100%);
            --light-gradient: linear-gradient(135deg, #e8f0fe 0%, #f5f5f5 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.3);
            --shadow-light: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 12px 40px rgba(0, 0, 0, 0.15);
            --shadow-heavy: 0 20px 60px rgba(0, 0, 0, 0.2);
            --text-primary: #2d3748;
            --text-secondary: #4a5568;
            --text-muted: #718096;
            --border-color: rgba(226, 232, 240, 0.3);
            --bg-body: transparent;
        }
         body {
        font-family: 'Tajawal', sans-serif;
        margin: 0;
        background: transparent;
        color: #fff;
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
           .navbar {
            position: fixed;
            top: 80px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 0.3rem 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 12px;
            width: 60%;
            max-width: 900px;
            height: 48px; /* ارتفاع الشريط */
            z-index: 1000;
            font-size: 0.875rem;
            color: #e0e0e0;
            font-weight: 500;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }

               .navbar-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

    
         .navbar-left {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            flex: 1;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 1rem;
            flex: 1;
        }

            .datetime-display {
            background: transparent;
            border: none;
            color: #f0f0f0;
            font-size: 1.25rem;           /* larger font */
            font-weight: 500;             /* semi-bold */
            display: flex;
            justify-content: center;      /* center horizontally */
            align-items: center;          /* center vertically */
            gap: 0.3rem;                  /* spacing between icon and text */
            text-shadow: 1px 1px 3px rgba(0,0,0,0.6);
            width: 100%;
            position: relative;           /* needed for ::before shimmer effect */
        }

          .datetime-display::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shimmer 2s infinite;
        }

           #trainingRequestsHeader {
            font-size: 1.5rem;  /* or try 2.5rem or 32px */
            font-weight: bold;
            color: #fff; /* optional: enhance readability */
            text-shadow: 1px 1px 2px rgba(0,0,0,0.4); /* optional: pop against background */
        }

           .language-switcher {
            display: flex;
            gap: 0.5rem;
        }

            .lang-btn, .logout-btn {
            background: rgba(255,255,255,0.2);
            font-size: 18px;
            border: none;
            padding: 0.5rem 1rem;
            color: white;
            font-size: 18px;
            border-radius: 8px;
            margin-left: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }
              .lang-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); /* نفس قيمة shadow-light */
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15); /* نفس قيمة shadow-medium */
        }

    .admin-container {
        padding: 12rem 2rem 2rem 2rem; /* padding-top عشان يبعد تحت الشريط */
    }

    .forms-section {
        background: rgba(255,255,255,0.1);
        backdrop-filter: blur(10px);
        border-radius: 1rem;
        padding: 1.5rem;
        margin-bottom: 2rem;
    }

            .message-container {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
            display: none; /* ✅ make sure it starts hidden */
        }

        .message {
            color: white; /* or whatever color you want */
            font-size: 1rem;
        }

        .message.failure {
            background-color: #f44336; /* red for failure */
        }


     /* Data Grid */
        .grid-container {
             background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
            overflow: hidden;
            margin-bottom: 2rem;
            max-width: 1500px; /* or any width you want */
            margin: 0 auto; /* centers the container */
}
        

      .grid-header {
          background-color: rgba(0, 0, 0, 0.5); /* Black transparent */
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            font-size: 20px;
            align-items: center;
            gap: 0.75rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            backdrop-filter: blur(10px); /* Glassy blur */
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }


        .grid-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .grid-header i {
            font-size: 1.25rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

         .table-wrapper {
            overflow-x: auto;
        }

                  .table {
                width: 100%;
                border-collapse: collapse;
                background-color: rgba(0, 0, 0, 0.3); /* خلفية الجدول */
                color: white;
                border: 1px solid rgba(255, 255, 255, 0.2); /* حدود خارجية للجدول */
                border-radius: 8px;
                overflow: hidden; /* يخلي الزوايا ناعمة */
            }

            .table th {
                background-color: rgba(255, 255, 255, 0.1); /* خلفية رأس الجدول */
                font-size: 22px;
                color: white;
                padding: 0.75rem;
                border: 1px solid rgba(255, 255, 255, 0.2); /* حدود رأس الجدول */
            }

            .table td {
                background-color: transparent;
                 font-size: 20px; 
                padding: 0.75rem;
                 text-align: center;
                border: 1px solid rgba(255, 255, 255, 0.1); /* حدود خلايا الجدول */
            }

            .table tr:nth-child(even) {
                background-color: rgba(255, 255, 255, 0.05); /* تمييز الصفوف */
            }

            .table th:nth-child(1), /* Select column header */
            .table td:nth-child(1) {
                width: 60px;
                max-width: 60px;
                text-align: center; /* Center the checkbox */
                white-space: nowrap; /* Prevent wrapping */
            }

            .table th:nth-child(2), /* RequestID column */
            .table td:nth-child(2) {
                width: 150px;
                max-width: 150px;
            }


            .table th:nth-child(3), 
            .table td:nth-child(3) {
                width: 200px;
                max-width: 200px;
            }
            .table tr:hover {
                background-color: rgba(255, 255, 255, 0.15); /* تفاعل عند تمرير الفأرة */
            }
                .form-card {
            margin: 2rem auto 0 auto; /* top margin 2rem, horizontally auto */
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
            max-width: 1450px;
        }

                .form-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }
        .form-label {
            display: block;
            font-weight: 600;
            color: white;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            /* text-align: center; */ /* optional, inherited from form-group */
        }

        .form-control {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 1.5rem;
            font-size: 1rem;
            background: rgba(0, 0, 0, 0.3);
            color: lightgray;
            backdrop-filter: blur(20px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.3);
            background: rgba(255, 255, 255, 0.1);
            outline: none;
        }


        .action-buttons 
        {
            display: flex;         /* Use flexbox to align items */
            justify-content: center;  /* Center the button horizontally */
            margin-top: 2rem;
        }


  .btn {
                background: linear-gradient(to right, #0077b6, #00b4d8);
                color: #fff;
                padding: 14px 20px;
                border: none;
                border-radius: 50px;
                font-size: 17px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 4px 10px rgba(0, 119, 182, 0.3);
                transition: all 0.3s ease;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
              }

         .btn:hover{
               background: linear-gradient(to right, #00b4d8, #0077b6);
                transform: scale(1.03);
                box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
         }


    /* ✅ Responsive للشاشات الصغيرة */
    @media (max-width: 768px) {
        .navbar, .rounded-navbar {
            width: 90%;
            flex-direction: column;
            gap: 0.5rem;
            padding: 1rem;
        }

        .admin-container {
            padding: 9rem 1rem 2rem 1rem;
        }
    }

    /* Styling for DropDownList */
        #ddlDepartment {
            color: #000; /* Set text color to black */
            background-color: rgba(255, 255, 255, 0.8); /* Set background color to a light transparent white */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Set border to a light transparent white */
            padding: 1rem 1.5rem;
            border-radius: 1.5rem;
            font-size: 1rem;
            backdrop-filter: blur(20px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        #ddlDepartment:focus {
            border-color: var(--primary-color); /* Highlight border on focus */
            box-shadow: 0 0 0 3px rgba(26, 115, 232, 0.3);
            background: rgba(255, 255, 255, 0.1);
        }

</style>
</head>
<body>
    <!-- Background slideshow -->
    <div class="slideshow-background">
        <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
        <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
        <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
    </div>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
      <nav class="navbar">
    <div class="navbar-content">
    <!-- Left side: Language buttons -->
    <div class="navbar-left">
        <div class="language-switcher">
           <asp:Button ID="btnToggleLanguage" runat="server" OnClick="btnToggleLanguage_Click" Text="" CssClass="lang-btn" />
        </div>
    </div>

    <!-- Center: Clock/DateTime -->
    <div class="navbar-center">
        <div class="datetime-display">
            <i class="fas fa-clock"></i>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="lblDateTime" runat="server"></asp:Label>
                    <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <!-- Right side: Logout -->
    <div class="navbar-right">
        <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
    </div>
</div>

</nav>
        <div id="message-container" class="message-container" style="display:none;">
                <asp:Label ID="lblMessage" runat="server" CssClass="message"/>
            </div>

        <div class="admin-container">
            <div class="grid-container">
              <div class="grid-header">
                    <i class="fas fa-table"></i>
                    <h3 id="trainingRequestsHeader" runat="server">Training Requests</h3>
                </div>
                <div class="table-wrapper">
                    <asp:GridView ID="gvRequests" runat="server" AutoGenerateColumns="False" DataKeyNames="RequestID" CssClass="table">
                        <Columns>
                            <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="RequestID"  />
                            <asp:BoundField DataField="TraineeName" />
                            <asp:BoundField DataField="Email"  />
                            <asp:BoundField DataField="Status"  />
                            <asp:BoundField DataField="InterviewDate" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

             <div class="form-card">
                    <label class="form-label" runat="server" id="departmentLabel" for="ddlDepartment">🏢 Department</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" />
                </div>

            <div class="action-buttons">
                <asp:Button ID="btnAssignToDepartment" runat="server" Text="Assign to Department" OnClick="btnAssignToDepartment_Click" CssClass="btn" />
            </div>
        </div>
    </form>
    <script>
function showAndHideMessage() {
    var container = document.getElementById("message-container");
    container.style.display = "block"; // show the box

    // hide after 3 seconds
    setTimeout(function () {
        container.style.display = "none";
    }, 3000);
}
    </script>
</body>
</html>