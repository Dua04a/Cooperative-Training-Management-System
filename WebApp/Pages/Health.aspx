<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Health.aspx.cs" Inherits="maiyas10920WebApp.Pages.Health" %>

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
        margin: 0;
        padding: 0;
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

    .page-container {
      padding-top: 500px;
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
      flex: 1;
      font-weight: 700;
      color: #0d47a1;
      font-size: 28px;
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

    .redirect-button {
      background: linear-gradient(to right, #0674b9, #0b98db);
      color: white;
      padding: 18px 45px;
      font-size: 20px;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      box-shadow: 0 6px 14px rgba(0, 115, 185, 0.4);
      transition: background 0.3s ease, transform 0.2s ease;
    }

    .redirect-button:hover {
      background: linear-gradient(to right, #0b98db, #0674b9);
      transform: translateY(-2px);
    }

    .cards-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 10px 5px;
      justify-content: center;
      width: 100%;
      padding: 30px 10px;
      box-sizing: border-box;
    }

    /* ✅ المربع الأخير في الوسط */
    .cards-grid .health-center-card:last-child {
      grid-column: 1 / -1;
      justify-self: center;
      width: 60%;
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
    <div class="page-container">
      <div class="cards-grid">
        <asp:Repeater ID="rptHealthCenters" runat="server">
          <ItemTemplate>
            <div class="health-center-card">
              <div class="center-name">
                <%# Eval("CenterName") %><br />
                <span class="center-email"><%# Eval("Email") %></span>
                <span class="center-district"><%# Eval("District") %></span>
              </div>
              <a href='<%# Eval("Location") %>' target="_blank" class="direction-link">
                <img src="../Images/loc_icon.png" alt="Map Icon" class="map-icon" />
                <span class="direction-text">احصل على الاتجاهات</span>
              </a>
            </div>
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <div class="button-container">
        <asp:Button 
          ID="btnRedirect" 
          runat="server" 
          Text="العودة إلى الصفحة الرئيسية" 
          OnClick="btnRedirect_Click" 
          CssClass="redirect-button" />
      </div>
    </div>
  </form>
</body>
</html>