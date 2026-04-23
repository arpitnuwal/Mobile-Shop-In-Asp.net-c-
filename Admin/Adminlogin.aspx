<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adminlogin.aspx.cs" Inherits="Admin_Adminlogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: linear-gradient(135deg, #000000, #1f1f1f);
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 40px 35px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(255, 193, 7, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-card h2 {
            color: #ffc107;
            font-weight: 700;
            margin-bottom: 25px;
            letter-spacing: 1px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            border-radius: 8px;
            padding: 10px 15px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #ffc107;
            background: rgba(255, 255, 255, 0.15);
        }

        .btn-login {
            background: #ffc107;
            color: #000;
            font-weight: 600;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: #ffcd39;
            transform: translateY(-2px);
        }

        .footer-text {
            margin-top: 20px;
            font-size: 13px;
            color: #aaa;
        }

        @media (max-width: 480px) {
            .login-card {
                padding: 30px 25px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <h2>Admin Login</h2>

            <div class="mb-3">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Enter Username"></asp:TextBox>
            </div>

            <div class="mb-3">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-login" Text="Login" OnClick="btnLogin_Click" />

            <div class="footer-text">
                © <%= DateTime.Now.Year %> Admin Panel. All rights reserved.
            </div>
        </div>
    </form>
</body>
</html>
