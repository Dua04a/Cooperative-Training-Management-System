<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="maiyas10920WebApp.Pages.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["Language"] ?? "en" %>" dir="<%= (Session["Language"]?.ToString() == "ar") ? "rtl" : "ltr" %>">
<head runat="server">
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <!-- Google Fonts: Tajawal & Cairo -->
    <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500;700&family=Cairo:wght@400;700&display=swap" rel="stylesheet" />
    <style>
        /* Slideshow Background */
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
            font-family: 'Tajawal', 'Cairo', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-body);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* Modern Navbar */
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
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: white;
            font-size: 1.25rem;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .navbar-brand i {
            background: var(--success-gradient);
            padding: 0.5rem;
            border-radius: 0.5rem;
            font-size: 1rem;
            box-shadow: var(--shadow-light);
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

        .language-switcher {
            display: flex;
            gap: 0.5rem;
        }

        .lang-btn, .logout-btn {
            background: rgba(255,255,255,0.2);
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

        #trainingRequestsHeader {
            font-size: 1.5rem;  /* or try 2.5rem or 32px */
            font-weight: bold;
            color: #fff; /* optional: enhance readability */
            text-shadow: 1px 1px 2px rgba(0,0,0,0.4); /* optional: pop against background */
        }


        /* Main Container */
        .admin-container {
        padding: 12rem 2rem 2rem 2rem; /* padding-top عشان يبعد تحت الشريط */
    }

        /* Header Section */
        .header-section {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 2rem;
        }

        .header-text {
            flex: 1;
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: initial;
            -webkit-text-fill-color: transparent;
            background-clip: initial;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .header-subtitle {
            color: white;
            font-size: 1.125rem;
            font-weight: 500;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .header-logo {
            width: 400px;
            height: auto;
            border-radius: 1rem;
            box-shadow: var(--shadow-light);
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
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

        /* Forms Section */
        .forms-section {
             max-width: 1500px; /* match .grid-container width */
            margin: 30px auto;
            display: grid;
            grid-template-columns: 1fr 1fr; /* force 2 equal columns */
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .form-card {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            padding: 2rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
            transition: all 0.3s ease;
        }

        .form-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }

        .form-card-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--glass-border);
        }

               .form-card-icon {
            background: linear-gradient(to right, #0077b6, #00b4d8); /* same as login button */
            color: white;
            padding: 0.75rem;
            border-radius: 50%; /* fully rounded */
            font-size: 1.25rem;
            box-shadow: 0 4px 10px rgba(0, 119, 182, 0.3); /* same shadow as login */
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 48px;
        }

        .form-card-icon:hover {
            background: linear-gradient(to right, #00b4d8, #0077b6); /* reverse gradient on hover */
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
            cursor: pointer;
        }

        .form-card-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: white;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: white;
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid var(--glass-border);
            border-radius: 0.75rem;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            background: lightgrey;
            color: var(--text-primary);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            transform: translateY(-1px);
            background: rgba(255, 255, 255, 0.95);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 0.75rem;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-medium);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            min-width: 160px;
            justify-content: center;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-heavy);
        }

        .btn:active {
            transform: translateY(-1px);
        }
            .btn-interview,
            .btn-accept,
            .btn-reject {
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

            .btn-interview:hover,
            .btn-accept:hover,
            .btn-reject:hover {
                background: linear-gradient(to right, #00b4d8, #0077b6);
                transform: scale(1.03);
                box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
            }



        /* Message Display */
        .message-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 1rem;
            padding: 1.5rem;
            margin-top: 1rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
        }

        .message {
            color: white;
            font-weight: 600;
            font-size: 0.975rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .message i {
            font-size: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .navbar-actions {
                flex-direction: column;
                width: 100%;
            }

            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .header-title {
                font-size: 2rem;
            }

            .header-logo {
                width: 300px;
            }

            .forms-section {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .admin-container > * {
            animation: fadeInUp 0.6s ease-out;
        }

        .admin-container > *:nth-child(2) {
            animation-delay: 0.1s;
        }

        .admin-container > *:nth-child(3) {
            animation-delay: 0.2s;
        }

        .admin-container > *:nth-child(4) {
            animation-delay: 0.3s;
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


        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }
        /* تكبير خانات التدريب والمقابلة */
        #txtInterviewDate,
        #dtStartDate,
        #dtEndDate {
            font-size: 1rem;
            padding: 0.5rem 0.25rem;
            border-radius: 1rem;
        }

    </style>
</head>
<body>
    <!-- Slideshow Background -->
    <div class="slideshow-background">
        <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
        <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
        <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
    </div>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

       <!-- Navbar -->
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


        <div class="admin-container">
              <!-- Message Display -->
            <div class="message-container">
                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Data Grid -->
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

            <!-- Forms Section -->
            <div class="forms-section">
                <!-- Interview Card -->
                <div class="form-card">
                    <div class="form-card-header">
                        <div class="form-card-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h3 class="form-card-title" runat="server" id="interviewCardTitle">Interview Scheduling</h3>
                    </div>
                    <div class="form-group">
                        <label class="form-label" runat="server" id="interviewDateLabel" for="txtInterviewDate">
                            <i class="fas fa-clock"></i> Interview Date & Time
                        </label>
                        <asp:TextBox ID="txtInterviewDate" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />
                    </div>
                </div>

                <!-- Training Period Card -->
                <div class="form-card">
                    <div class="form-card-header">
                        <div class="form-card-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h3 class="form-card-title" runat="server" id="trainingCardTitle">Training Period</h3>
                    </div>
                    <div class="form-group">
                        <label class="form-label" runat="server" id="startDateLabel" for="dtStartDate">
                            <i class="fas fa-play"></i> Start Date
                        </label>
                        <asp:TextBox ID="dtStartDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="form-group">
                        <label class="form-label" runat="server" id="endDateLabel" for="dtEndDate">
                            <i class="fas fa-stop"></i> End Date
                        </label>
                        <asp:TextBox ID="dtEndDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <asp:Button ID="btnNominateForInterview" runat="server" Text="Nominate for Interview" OnClick="btnNominateForInterview_Click" CssClass="btn btn-interview" />
                <asp:Button ID="btnAcceptTraining" runat="server" Text="Accept Trainee" OnClick="btnAcceptTraining_Click" CssClass="btn btn-accept" />
                <asp:Button ID="btnReject" runat="server" Text="Reject Request" OnClick="btnReject_Click" CssClass="btn btn-reject" />
            </div>
        </div>

        <script type="text/javascript">
    window.addEventListener('load', function () {
        const msg = document.getElementById('<%= lblMessage.ClientID %>');
        const container = document.getElementById('<%= lblMessage.ClientID %>');
        if (msg && msg.innerText.trim() !== "") {
            container.style.display = 'block';
            setTimeout(function () {
                container.style.display = 'none';
            }, 4000); // hides after 4 seconds
        }
    });
</script>
    </form>
</body>
</html>
