<!DOCTYPE html>
<html>

<head>
    <title>Ray's Grocery CheckOut Line</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <div class="row d-flex flex-column align-items-center">
            <h1 class='text-center mt-4 p-4 bg-light w-75' style="font-weight: 300;">Enter your Customer ID and Password to complete the transaction:</h1>

            <form method="get" action="order.jsp" class="d-flex flex-column align-items-center">
                <input class="form-control" name="customerId" size="50" type="text" placeholder="Customer ID, e.g., 1,2,3,4, etc.">
                <input type="text" name="password" size="50" placeholder="Password" class="form-control mt-3">
                <input type="submit" value="Submit" class="btn btn-outline-success col-lg-8 mt-3"><input type="reset" value="Reset" class="btn btn-outline-danger col-lg-8 mt-3">
            </form>
        </div>
    </div>

</body>

</html>