<!DOCTYPE html>
<html>

<head>
        <title>Ray's Grocery Main Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css">

</head>

<body class="d-flex align-items-center shopBody">
        <div class="container">
                <div class="row d-flex flex-column align-items-center">
                        <h1 align="center">Welcome to <span class="name">Tech</span>Kelo Company!</h1>
                        <br>
                        <a href="login.jsp"><button type="button" class="btn btn-secondary">Login</button></a>
                        <br>
                        


<% // TODO: Display user name that is logged in (or nothing if not logged in)
        if(session.getAttribute("authenticatedUser") !=null){ 
                out.println("<h4 class='loggedIn'>Logged in as: "+session.getAttribute("authenticatedUser").toString()+"</h4>");
        }
        %>
        </body>
</div>
</div>
        <style>
                .loggedIn{
                        margin-top: 20px;
                }
        </style>
        </head>
</html>