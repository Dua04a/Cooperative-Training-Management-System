<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="maiyas10920WebApp.Pages.CreateAccount" %>

<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head runat="server">
    <meta charset="UTF-8" />
    <title>إنشاء حساب</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(to bottom, #dbeeff, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
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
            0% { opacity: 0; }
            10% { opacity: 1; }
            30% { opacity: 1; }
            40% { opacity: 0; }
            100% { opacity: 0; }
        }

        .card {
            background: rgba(255,255,255,0.95);
            padding: 50px;
            border-radius: 40px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            width: 600px;
            text-align: center;
            position: relative;
            z-index: 1;
        }

        h2 {
            color: #0674b9;
            margin-bottom: 40px;
        }

        .input-icon-wrapper {
            position: relative;
            margin-bottom: 30px;
            width: 80%;            /* ✅ Match input width */
            margin-left: auto;     /* ✅ Center wrapper */
            margin-right: auto; 
        }

        .input-icon-wrapper i {
               position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-48%); /* slight adjustment for optical centering */
            font-size: 20px; /* closer to input text size */
            color: #0077b6;
        }

       input[type="text"], input[type="password"] {
            width: 80%; 
            display: block;
            margin: 0 auto;

           padding: 12px 12px 12px 12px;
            font-size: 20px;
            border: none;
            border-bottom: 2px solid #0077b6;
            background: transparent;
            outline: none;
        }

        .btn {
            width: 250px; /* fixed width */
          max-width: 100%; /* prevent overflow */
          margin: 0 auto; /* center horizontally */
          display: block;
            background: linear-gradient(to right, #0077b6, #00b4d8);
            color: #fff;
            padding: 14px;
            border: none;
            border-radius: 40px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn:hover {
          background: linear-gradient(to right, #00b4d8, #0077b6);
          transform: scale(1.03);
          box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
        }

        .message {
            color: green;
            margin-top: 15px;
        }

        .login-link {
                margin-top: 25px; /* ✅ spacing between button and link */
                text-align: center;
            }

        .login-link a {
            text-decoration: none;
            color: #0077b6;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .login-link a:hover {
            text-decoration: underline;
            color: #00b4d8; /* optional hover color change */
        }

                .switch-lang-btn {
            width: 150px; /* smaller than main button */
            max-width: 100%;
            margin: 0 auto 20px auto; /* center & add spacing below */
            display: block;
            background: linear-gradient(to right, #0077b6, #00b4d8);
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 40px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .switch-lang-btn:hover {
            background: linear-gradient(to right, #00b4d8, #0077b6);
            transform: scale(1.05);
            box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
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
        <div class="card">
            <h2 id="h2Title" runat="server"></h2>

            <div class="input-icon-wrapper">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="اسم المستخدم"></asp:TextBox>
                <i class='bx bx-user'></i>
            </div>

            <div class="input-icon-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="كلمة المرور"></asp:TextBox>
                <i class='bx bx-lock'></i>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="إنشاء الحساب" CssClass="btn" OnClick="btnRegister_Click" />


                <div class="login-link">
                <asp:LinkButton ID="loginLink" runat="server" PostBackUrl="Login.aspx">تسجيل الدخول</asp:LinkButton>
                <span class="divider">|</span>
                <asp:LinkButton ID="langSwitchLink" runat="server" OnClick="btnSwitchLang_Click">English</asp:LinkButton>
            </div>



            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>

</body>
</html>
