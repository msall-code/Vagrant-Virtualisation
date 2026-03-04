<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.InetAddress" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Portfolio DevOps | Mamadou Sall</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #0f2027;
            background: linear-gradient(135deg, #2c5364, #203a43, #0f2027);
            color: white;
        }

        header {
            text-align: center;
            padding: 60px 20px;
        }

        h1 {
            font-size: 45px;
            margin-bottom: 10px;
        }

        .subtitle {
            font-size: 20px;
            opacity: 0.8;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: auto;
        }

        .card {
            background: white;
            color: #333;
            padding: 30px;
            margin: 30px 0;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .card h2 {
            margin-top: 0;
        }

        .status-ok {
            color: green;
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: #2c5364;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #1b3947;
        }

        footer {
            text-align: center;
            padding: 20px;
            font-size: 14px;
            opacity: 0.7;
        }
    </style>
</head>

<body>

<header>
    <h1>🚀 Mamadou Sall</h1>
    <div class="subtitle">Portfolio DevOps - Vagrant | Tomcat | Maven</div>
</header>

<div class="container">

    <!-- SECTION PROJET -->
    <div class="card">
        <h2>📦 Projet TP1</h2>
        <p>Machine virtuelle provisionnée avec Vagrant.</p>
        <p>Application Java Web buildée avec Maven et déployée sur Tomcat 9.</p>

        <ul>
            <li>✔ Ubuntu Server</li>
            <li>✔ JDK 8 / 11 / 17</li>
            <li>✔ Apache Tomcat 9</li>
            <li>✔ Maven Build</li>
        </ul>
    </div>

    <!-- SECTION STATUT SERVEUR -->
    <div class="card">
        <h2>🟢 Statut du Serveur</h2>

        <p>Statut Tomcat :
            <span class="status-ok">EN FONCTIONNEMENT</span>
        </p>

        <p>Nom du serveur :
            <strong><%= InetAddress.getLocalHost().getHostName() %></strong>
        </p>

        <p>Date du serveur :
            <strong><%= new java.util.Date() %></strong>
        </p>

        <a href="index.jsp" class="btn">🔄 Tester le serveur</a>
    </div>

</div>

<footer>
    © <%= java.time.Year.now() %> Mamadou Sall | Projet DevOps Virtualisation Linux
</footer>

</body>
</html>