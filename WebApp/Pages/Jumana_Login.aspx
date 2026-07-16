<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jumana_Login.aspx.cs" Inherits="maiyas10920WebApp.Pages.Jumana_Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Login</title>
    <style>
        html{
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Cairo,sans-serif;
        }

        body {
          margin: 0;
          padding : 0;
        
        }

        .page-container {
            display: flex;
            flex-direction: column; /* Stack vertically */
          align-items: center;
          min-height: 100vh;        /* full viewport height */
          padding: 0 0 40px 0;      /* add bottom padding for spacing */
          box-sizing: border-box;
        }

        .login-card {
            background: rgba(255,255,255,0.85);
            padding: 60px 70px 70px 70px;
            margin-top: 100px;
            margin-bottom: 10px;
            border-radius: 50px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
            width: 450px;
            max-width: 90vw;
            text-align: center;
        }

        h2 {
           margin-bottom: 70px;
            color: #0674b9;
            font-weight: 700;
            font-size: 40px;
            font-family: 'Cairo', sans-serif;
            letter-spacing: 0.5px;
        }

        label {
            font-weight: 600;
            display: block;
            text-align: left;
            margin-bottom: 8px;
            color: #092f73;
            font-size: 19px;
        }

        input[type="text"], input[type="password"], .aspNetDisabled {
             width: 100%;
              padding: 10px 0;                  /* remove side padding */
              font-size: 16px;
              border: none;                     /* remove default border */
              border-bottom: 2px solid #0077b6; /* only bottom border */
              background: transparent;
              outline: none;
              box-sizing: border-box;
              margin-bottom: 70px;
              transition: border-color 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #1a73e8;

            outline: none;
        }

        .btn-primary {
           width: 50%;
          background: linear-gradient(to right, #0077b6, #00b4d8);
          display: block;
          color: #fff;
          padding: 14px 20px;
          margin: 15px auto 10px;
          border: none;
          border-radius: 50px;
          font-size: 17px;
          font-weight: bold;
          cursor: pointer;
          box-shadow: 0 4px 10px rgba(0, 119, 182, 0.3);
          transition: all 0.3s ease;
        }

        .btn-primary:hover {
             background: linear-gradient(to right, #00b4d8, #0077b6);
              transform: scale(1.03);
              box-shadow: 0 6px 16px rgba(0, 119, 182, 0.4);
        }

        .btn-hover-border {
    background: transparent;
    color: #0077b6;
    border: 2px solid transparent;
    border-radius: 50px;
    padding: 14px 20px;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: none;
}

.btn-hover-border:hover {
    border-color: #0077b6;
    background-color: rgba(0, 119, 182, 0.05); /* optional subtle hover effect */
}


        .error-label {
            margin-top: 18px;
            font-weight: 700;
            color: red;
            font-size: 16px;
            display: block;
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

                .rounded-navbar {
                    background: rgba(0, 0, 0, 0.3);           /* semi-transparent black */
                  backdrop-filter: blur(10px);
                  -webkit-backdrop-filter: blur(10px);
                  border: 1px solid rgba(255, 255, 255, 0.15);
                  padding: 20px 30px;
                  border-radius: 50px;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  width: fit-content;
                  margin: 90px auto 0;
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

            ::placeholder {
                  color: black;            /* placeholder text color */
                  font-size: 20px;        /* increase font size */
                  opacity: 1;             /* ensure it's not too transparent */
                }

                /* For cross-browser compatibility */
                input::-webkit-input-placeholder {
                  color: black;
                  font-size: 20px;
                }
                input:-moz-placeholder {
                  color: black;
                  font-size: 20px;
                }
                input::-moz-placeholder {
                  color: #888;
                  font-size: 17px;
                }
                input:-ms-input-placeholder {
                  color: black;
                  font-size: 20px;
                }

                .modal {
                  display: none;
                  position: fixed;
                  z-index: 9999;
                  left: 0;
                  top: 0;
                  width: 100%;
                  height: 100%;
                  overflow: auto;
                  background-color: rgba(0,0,0,0.6);
                }

                .modal-content {
                  background-color: #fff;
                  margin: 10% auto;
                  padding: 30px;
                  border-radius: 20px;
                  width: 80%;
                  max-width: 800px;
                  color: #1e266d;
                  font-size: 16px;
                  line-height: 1.8;
                  position: relative;
                 }

                .info-inline-bar {
    background: rgba(255,255,255,0.95);
    padding: 20px 25px;
    border: 2px solid #0077b6;
    border-radius: 15px;
    margin-top: 10px;
    width: 100%;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.info-inline-bar h4 {
    margin: 0 0 10px;
    color: #0077b6;
    font-size: 20px;
    font-weight: bold;
}

.info-inline-bar p {
    margin: 0;
    font-size: 16px;
    line-height: 1.6;
    color: #222;
    white-space: pre-line;
}


.close-btn {
  color: #aaa;
  position: absolute;
  top: 10px;
  right: 25px;
  font-size: 30px;
  font-weight: bold;
  cursor: pointer;
}



    </style>
</head>
<body>
   

    <div class="slideshow-background">
  <div class="slide" style="background-image: url('logo2.png');"></div>
  <div class="slide" style="background-image: url('logo3.png');"></div>
  <div class="slide" style="background-image: url('logo4.png');"></div>
</div>


    <form id="form1" runat="server">
        <div class="rounded-navbar">
            <ul>
                <li class="dropdown">

                    <asp:HyperLink ID="aboutLink" runat="server" NavigateUrl="javascript:void(0);">About ▾</asp:HyperLink>

                   <ul class="dropdown-menu">
    <li><a id="linkWho" href="javascript:void(0);" onclick="openModalWithContent('who')">Who We Are</a></li>
    <li><a id="linkVision" href="javascript:void(0);" onclick="openModalWithContent('vision')">Vision</a></li>
    <li><a id="linkMission" href="javascript:void(0);" onclick="openModalWithContent('mission')">Mission</a></li>
    <li><a id="linkContact" href="javascript:void(0);" onclick="openModalWithContent('contact')">Contact Information</a></li>
</ul>





    <div id="infoInlineBar" class="info-inline-bar" style="display:none;">
    <h4 id="infoInlineTitle"></h4>
    <p id="infoInlineText"></p>
</div>
                </li>
                <li><asp:HyperLink ID="healthCentersLink" runat="server" NavigateUrl="HealthCenter.aspx">Health Centers</asp:HyperLink></li>
                <li><asp:HyperLink ID="traineeRegLink" runat="server" NavigateUrl="Registration.aspx">Trainee Registration</asp:HyperLink></li>
                <li><asp:HyperLink ID="clearanceFormLink" runat="server" NavigateUrl="ClearanceForm.aspx">Clearance Form</asp:HyperLink></li>
                <li><asp:LinkButton ID="lnkSwitchLang" runat="server" OnClick="btnSwitchLang_Click" CssClass="lang-switch">العربية</asp:LinkButton></li>
            
            </ul>
        </div>

        <div class="page-container">

         
            


            <div class="login-card">
               <div style="display: flex; justify-content: center; gap: 20px; margin-bottom: 40px;">
    <asp:Button ID="Button3" runat="server" Text="User" CssClass="btn-hover-border" OnClick="btnUserRegister_Click" /> 
    <asp:Button ID="Button4" runat="server" Text="Admin" CssClass="btn-hover-border" OnClick="btnAdminRegister_Click" /> 
</div>

               <h2><asp:Literal ID="litHeading" runat="server" /></h2>

          

                 <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>

                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password"></asp:TextBox>

                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn-primary" />

                <asp:Button ID="btnCreateAccount" runat="server" Text="Create New Account" CssClass="btn-hover-border" OnClick="btnCreateAccount_Click" />


                <asp:Label ID="lblError" runat="server" CssClass="error-label" />
            </div>
        </div>

        <!-- Modal Popup for "Who We Are" -->
<div id="whoWeAreModal" class="modal">

  <div class="modal-content">
    <span class="close-btn" onclick="closeModal()">&times;</span>
    <h3 id="modal-title" style="margin-top:0;"></h3>
    <p id="modal-content" style="white-space: pre-line;"></p>
  </div>
</div>

        

        <div id="bottom-info-bar" style="
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  background-color: rgba(255, 255, 255, 0.95);
  color: #1e266d;
  padding: 20px 40px;
  font-size: 15px;
  line-height: 1.6;
  border-top: 2px solid #0077b6;
  box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  display: none;
  overflow-y: auto;
  max-height: 40vh;
">
  <div style="display: flex; justify-content: space-between; align-items: center;">
    <strong id="info-title" style="font-size: 18px;">Information</strong>
    <button onclick="closeInfoBar()" style="background: none; border: none; font-size: 24px; font-weight: bold; cursor: pointer; color: #666">&times;</button>
  </div>
  <div id="info-content" style="margin-top: 10px; white-space: pre-line;"></div>
</div>

<script>
    function showInfoBar(title, content) {
        document.getElementById("info-title").innerText = title;
        document.getElementById("info-content").innerText = content;
        document.getElementById("bottom-info-bar").style.display = "block";
    }

    function closeInfoBar() {
        document.getElementById("bottom-info-bar").style.display = "none";
    }

</script>

    </form >
</body >



        <script>
            function openModalWithContent(title, content) {
        const modal = document.getElementById("whoWeAreModal");
            modal.style.display = "block";
            document.getElementById("modal-title").innerText = title;
            document.getElementById("modal-content").innerText = content;
    }




            function closeModal() {
                document.getElementById("whoWeAreModal").style.display = "none";
    }

            // Optional: close modal when clicking outside content
            window.onclick = function (event) {
                const modal = document.getElementById("whoWeAreModal");
                if (event.target == modal) {
                    modal.style.display = "none";
                }

            }

    

            function showInfoInline(title, text) {
        const bar = document.getElementById("infoInlineBar");
            document.getElementById("infoInlineTitle").innerText = title;
            document.getElementById("infoInlineText").innerText = text;
            bar.style.display = "block";
            }

            function hideInfoInline() {
                document.getElementById("infoInlineBar").style.display = "none";
            }

            function openModalWithContent(key) {
                const data = getLocalizedModalData()[key];
                if (data) {
                    document.getElementById("modal-title").innerText = data.title;
                    document.getElementById("modal-content").innerText = data.content;
                    document.getElementById("whoWeAreModal").style.display = "block";
                }
            }




        </script>



</html>
