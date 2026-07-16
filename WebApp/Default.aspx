<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="maiyas10920WebApp._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ar" dir="rtl">
<head runat="server">
    <meta charset="utf-8" />
    <title>عرض الجدول</title>
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
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e8f0fe;
            color: #333;
            direction: rtl;

        }

        .page-container {
    display: flex;
    justify-content: center;
    align-items: flex-start; /* or center for vertical centering too */
    min-height: 100vh;
    padding-top: 40px;
        }

        .table-wrapper { /* light blue background */
         box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3); 
         margin-bottom: 30px; 
          }

        .table-and-button-wrapper {
            display: flex;
            flex-direction: column;     /* stack children vertically */
            align-items: center;        /* center horizontally */
            width: fit-content;         /* shrink-wrap around table+button */
            margin: 0 auto;             /* center in page-container */
           }

        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #e8f0fe;
            overflow: hidden;
            box-shadow: none;
            border-radius: 12px;
        }

        .table th, .table td {
            background-color: white;
            padding: 12px 15px;
            text-align: right;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        .table th {
            background-color: var(--dark-blue);
            color: var(--white);
            font-weight: bold;
            position: sticky;
            top: 0;
            z-index: 1;
            text-align: center;
            font-size: 25px;
        }

        .table tbody tr:nth-child(even) td {
    background-color: #e8f0fe;
}
         .table, .table-wrapper {
          margin: 0;
          padding: 0;
}

        .table tr:hover {
            background-color: #f1f1f1;
        }

        @media (max-width: 768px) {
            .table th, .table td {
                padding: 8px 10px;
                font-size: 14px;
            }
        }

        .button-container {
           margin-top: 40px; 
          margin-bottom: 80px;        /* space between button and page bottom */
           }

        .redirect-button {
          background-color: var(--primary-color);
    color: white;
    padding: 15px 35px;
    font-size: 18px;
    border: none;
    border-radius: 16px;
    cursor: pointer;
    box-shadow: 0 5px 12px rgba(26, 115, 232, 0.4);
    transition: background-color 0.3s ease;
       }

     .redirect-button:hover {
      background-color: var(--secondary-color);
      }

    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div class="page-container">
  <div class="table-and-button-wrapper">
    <div class="table-wrapper">
      <asp:GridView 
          ID="GridView1" 
          runat="server" 
          AutoGenerateColumns="True" 
          CssClass="table"
          OnRowDataBound="GridView1_RowDataBound">
      </asp:GridView>
    </div>

    <div class="button-container">
      <asp:Button 
          ID="btnRedirect" 
          runat="server" 
          Text="Go to Next Page" 
          OnClick="btnRedirect_Click" 
          CssClass="redirect-button" />
    </div>
  </div>
</div>

    </form>
</body>
</html>



