<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="maiyas10920WebApp.Pages.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Session["lang"] ?? "en" %>" dir="<%= (Session["lang"] as string) == "ar" ? "rtl" : "ltr" %>">
<head runat="server">
    <title>Home</title>
    <style>
            html{
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Cairo,sans-serif;
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

               .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5); /* خلفية شفافة غامقة */
        }

        .modal-content {
            background-color: #ffffff;
            margin: 10% auto;
            padding: 30px 40px;
            border: 1px solid #888;
            width: 70%;
            max-width: 700px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            font-family: 'Cairo', sans-serif;
            color: #1e1e1e;
            line-height: 1.8;
            font-size: 16px;
        }
       
    </style>
</head>
<body>
        <form id="form1" runat="server">

        <!-- Background Slideshow -->
        <div class="slideshow-background">
            <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
            <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
            <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
        </div>

        <!-- Glass Navigation -->
        <div class="rounded-navbar">
            <ul>
                <li class="dropdown">
                    <asp:HyperLink ID="aboutLink" runat="server" NavigateUrl="#">About ▾</asp:HyperLink>
                    <ul class="dropdown-menu">
                          <li><a id="linkWho" href="javascript:void(0);" onclick="openModalWithContent('who')">Who We Are</a></li>
                        <li><a id="linkVision" href="javascript:void(0);" onclick="openModalWithContent('vision')">Vision</a></li>
                        <li><a id="linkMission" href="javascript:void(0);" onclick="openModalWithContent('mission')">Mission</a></li>
                        <li><a id="linkContact" href="javascript:void(0);" onclick="openModalWithContent('contact')">Contact Information</a></li>
                    </ul>
                </li>
                <li><asp:HyperLink ID="healthCentersLink" runat="server" NavigateUrl="HealthCenters.aspx">Health Centers</asp:HyperLink></li>
                <li><asp:HyperLink ID="traineeRegLink" runat="server" NavigateUrl="Registration.aspx">Trainee Registration</asp:HyperLink></li>
                <li><asp:HyperLink ID="clearanceFormLink" runat="server" NavigateUrl="ClearanceForm.aspx">Clearance Form</asp:HyperLink></li>
                <li><asp:LinkButton ID="lnkSwitchLang" runat="server" OnClick="btnSwitchLang_Click" CssClass="lang-switch">العربية</asp:LinkButton></li>
            </ul>
        </div>

    </form>

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
  max-height: 40vh;">
  <div style="display: flex; justify-content: space-between; align-items: center;">
    <strong id="info-title" style="font-size: 18px;">Information</strong>
    <button onclick="closeInfoBar()" style="background: none; border: none; font-size: 24px; font-weight: bold; cursor: pointer; color: #666">&times;</button>
  </div>
  <div id="info-content" style="margin-top: 10px; white-space: pre-line;"></div>
</div>


    <script>
    function openModalWithContent(key) {
        const data = getLocalizedModalData()[key];
        if (data) {
            document.getElementById("modal-title").innerText = data.title;
            document.getElementById("modal-content").innerText = data.content;
            document.getElementById("whoWeAreModal").style.display = "block";
        }
    }

    function closeModal() {
        document.getElementById("whoWeAreModal").style.display = "none";
    }

    window.onclick = function (event) {
        const modal = document.getElementById("whoWeAreModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    function showInfoBar(title, content) {
        document.getElementById("info-title").innerText = title;
        document.getElementById("info-content").innerText = content;
        document.getElementById("bottom-info-bar").style.display = "block";
    }

    function closeInfoBar() {
        document.getElementById("bottom-info-bar").style.display = "none";
        }
        console.log(getLocalizedModalData());
    </script>
</body>
</html>

