<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clearances.aspx.cs" Inherits="maiyas10920WebApp.Pages.Clearances" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["Language"] ?? "en" %>" dir="<%= (Session["Language"]?.ToString() == "ar") ? "rtl" : "ltr" %>">
<head runat="server">
    <title>Clearance Requests</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
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

        .slide::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.3);
            z-index: 1;
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
            margin: 0;
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

        .language-switcher {
            display: flex;
            gap: 0.5rem;
        }

        .lang-btn, .logout-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            padding: 0.5rem 1rem;
            font-size: 18px;
            color: white;
            border-radius: 8px;
            margin-left: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        .lang-btn:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
        }

        .admin-container {
            padding: 12rem 2rem 2rem 2rem;
            max-width: 1200px;
            margin: auto;
            position: relative;
            z-index: 2;
        }

         .grid-container {
             background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--glass-border);
            overflow: hidden;
            margin-bottom: 2rem;
            max-width: 1000px; /* or any width you want */
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


        .grid-title {
            font-size: 1.3rem;
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
                font-size: 21px;
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

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
            margin-top: 2rem;
        }

        .btn {
            background: #0066cc;
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 0.75rem;
            cursor: pointer;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-medium);
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            min-width: 160px;
            justify-content: center;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            font-size: 0.875rem;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-heavy);
        }

       
            .btn-accept,
            .btn-reject {
                background: linear-gradient(to right, #0077b6, #00b4d8);
                color: #fff;
                padding: 14px 20px;
                border: none;
                border-radius: 50px;
                font-size: 19px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0 4px 10px rgba(0, 119, 182, 0.3);
                transition: all 0.3s ease;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            }

            
            .btn-accept:hover,
            .btn-reject:hover {
                background: linear-gradient(to right, #00b4d8, #0077b6);
                transform: scale(1.03);
                box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
            }

        .btn:active {
            transform: translateY(-1px);
        }

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
            justify-content: center;
            gap: 0.5rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }

        .message i {
            font-size: 1rem;
        }

        @media (max-width: 768px) {
            .navbar {
                width: 90%;
                flex-direction: column;
                height: auto;
                padding: 1rem;
            }

            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .admin-container {
                padding: 8rem 1rem 2rem 1rem;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }

            .table th, .table td {
                padding: 0.5rem;
                font-size: 0.875rem;
            }
        }

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

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }
    </style>
</head>
<body>
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

        <div class="admin-container">
            <div class="grid-container">
                <div class="grid-header">
                    <i class="fas fa-table"></i>
                    <asp:Label ID="lblGridTitle" runat="server" CssClass="grid-title" Text="قائمة طلبات اخلاء الطرف"></asp:Label>
                </div>

                <div class="table-wrapper">
                    <asp:GridView ID="gvClearance" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,KfmcEmail" CssClass="table">
                        <Columns>
                            <asp:TemplateField HeaderText="اختيار">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Id" HeaderText="رقم الطلب" ReadOnly="True" />
                            <asp:BoundField DataField="EnglishName" HeaderText="اسم المتدرب" ReadOnly="True" />
                            <asp:BoundField DataField="KfmcEmail" HeaderText="البريد الإلكتروني" ReadOnly="True" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="action-buttons">
                <asp:Button ID="btnApprove" runat="server" Text="قبول" CssClass="btn-accept" OnClick="btnApprove_Click" />
                <asp:Button ID="btnReject" runat="server" Text="رفض" CssClass="btn-reject" OnClick="btnReject_Click" />
            </div>

            <div class="message-container" id="messageContainer" runat="server" Visible="false">
                <div class="message">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
