<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HealthCenters.aspx.cs" Inherits="maiyas10920WebApp.HealthCenters" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ar" dir="rtl">
<head runat="server">
  <meta charset="utf-8" />
  <title>عرض المراكز الصحية</title>
  <style>
    :root {
      --primary-color: #1a73e8;
      --secondary-color: #4285f4;
      --light-blue: #e8f0fe;
      --dark-blue: #0d47a1;
      --white: #ffffff;
      --gray: #f5f5f5;
    }

    body {
        font-family: 'Cairo', sans-serif;
          direction: rtl;
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

            /* Show each slide at different times */
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


    .page-container {
      padding-top: 200px;
      display: flex;
      justify-content: center;
      flex-direction: column;
      align-items: center;
      min-height: 100vh;
    }

    .health-center-card {
      background: rgba(255, 255, 255, 0.85);
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      border-radius: 20px;
      padding: 20px 25px;
      margin-bottom: 20px;
      display: flex;
      width: 60%;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      border: 1px solid rgba(255, 255, 255, 0.3);
}


    .center-name {
        text-align: right;
      flex: 1;
      font-weight: 700;
      color: #0d47a1;
      font-size: 28px;
    }

    .center-email,
        .center-district {
            text-align: right;  /* ✅ explicitly align these too */
            display: block;     /* already block but ensures consistency */
        }

    .center-email {
      font-size: 18px;
      font-weight: bold;
      color: #444;
      display: block;
      margin-top: 8px;
    }

    .center-district {
      font-size: 18px;
      font-weight: bold;
      color: #0674b9;
      display: block;
      margin-top: 4px;
    }

    .direction-link {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-decoration: none;
      color: #0674b9;
      font-weight: 700;
      min-width: 100px;
    }

    .direction-link:hover {
      color: #0d47a1;
    }

    .map-icon {
      width: 110px;
      height: 110px;
    }

    .direction-text {
      font-size: 18px;
      text-align: center;
    }

    .button-container {
      margin-top: 40px;
      margin-bottom: 80px;
    }

     .btn-primary {
            width: 100%;
            background: linear-gradient(to right, #0077b6, #00b4d8);
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

    .cards-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px 5px; /* vertical 10px, horizontal 5px */
      justify-content: center;
      width: 100%;
      padding: 30px 10px; /* balanced padding */
      box-sizing: border-box;
      margin-right: 200px;  /* uncomment if you want to shift grid left */

    }

  </style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="slideshow-background">
  <div class="slide" style="background-image: url('../Images/bg1.jpg');"></div>
  <div class="slide" style="background-image: url('../Images/bg2.jpg');"></div>
  <div class="slide" style="background-image: url('../Images/bg3.jpg');"></div>
</div>

      <div class="lang-switch">
           <asp:Button ID="languageBtn" runat="server" Text="العربية" CssClass="lang-btn" 
    OnClick="languageBtn_Click" CausesValidation="false" UseSubmitBehavior="false" />
          </div>
    <div class="page-container">
        <div class="cards-grid">
      <!-- Health Center Cards -->
      <asp:Repeater ID="rptHealthCenters" runat="server" OnItemDataBound="rptHealthCenters_ItemDataBound">
        <ItemTemplate>
          <div class="health-center-card">
            <div class="center-name">
              <%# Eval("CenterName") %><br />
              <span class="center-email"><%# Eval("Email") %></span>
              <span class="center-district"><%# Eval("District") %></span>
            </div>
            <a href='<%# Eval("Location") %>' target="_blank" class="direction-link">
              <img src="../Images/loc_icon.png" alt="Map Icon" class="map-icon" />
              <asp:Literal ID="litDirectionText" runat="server" />
            </a>
          </div>
        </ItemTemplate>
      </asp:Repeater>
            </div>
      <!-- Back Button -->
      <div class="button-container">
        <asp:Button 
          ID="btnRedirect" 
          runat="server" 
          Text="Back to Homepage" 
          OnClick="btnRedirect_Click" 
          CssClass="btn-primary" />
      </div>

    </div>
  </form>
</body>
</html>

