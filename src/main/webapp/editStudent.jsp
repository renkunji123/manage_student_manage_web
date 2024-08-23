<%@ page import="java.io.*" %>
<%
    String studentId = request.getParameter("id");
    String filePath = application.getRealPath("/") + "students.csv";
    java.io.File file = new java.io.File(filePath);
    java.util.List<String[]> allLines = new java.util.ArrayList<>();
    String[] editStudent = null;
    
    if (file.exists()) {
        java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(file));
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
            if (data[0].equals(studentId)) {
                editStudent = data;
            } else {
                allLines.add(data);
            }
        }
        br.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Student</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            background-color: #FFEBD4; /*  background color */
            color: white; /* White text color */
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        h1 {
            text-align: center;
            color: #FF4E88; /* White color for h1 */
            margin-top: 20px;
            font-size: 3em; /* Make h1 text larger */
            font-weight: bold; /* Make h1 text bold */
        }
        .form-label {
            color: #FF4E88; /* White color for form labels */
            font-weight: bold; /* Make label text bold */
        }
        .form-control {
            margin-bottom: 15px; /* Space between input fields */
        }
        .btn-info {
            background-color: #FF4E88; /* Dodger blue color for buttons */
            border-color: #1e90ff;
        }
        .btn-info:hover {
            background-color: #FFC6C6; /* Darker shade for hover */
            border-color: #104e8b;
        }
        .container {
            margin-top: 20px; /* Top margin for container */
            padding: 20px; /* Padding for container */
            background-color: #FFC6C6; /* Darker background color for the form container */
            border-radius: 8px; /* Rounded corners for the container */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Student Information</h1>
        <form method="POST" action="updateStudent.jsp">
            <div class="form-group">
                <label class="form-label">Student ID</label>
                <input type="text" class="form-control" name="studentId" value="<%= editStudent[0] %>" readonly>
            </div>
            <div class="form-group">
                <label class="form-label">Full Name</label>
                <input type="text" class="form-control" name="fullName" value="<%= editStudent[1] %>" required>
            </div>
            <div class="form-group">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="<%= editStudent[2] %>" required>
            </div>
            <div class="form-group">
                <label class="form-label">Age</label>
                <input type="number" class="form-control" name="age" value="<%= editStudent[3] %>" required>
            </div>
            <div class="form-group">
                <label class="form-label">Data Structure and Algorithms Score</label>
                <input type="number" step="0.1" class="form-control" name="dsaScore" value="<%= editStudent[4] %>" required>
            </div>
            <div class="form-group">
                <label class="form-label">Application Development Score</label>
                <input type="number" step="0.1" class="form-control" name="adScore" value="<%= editStudent[5] %>" required>
            </div>
            <div class="form-group">
                <label class="form-label">Internet of Things Score</label>
                <input type="number" step="0.1" class="form-control" name="iotScore" value="<%= editStudent[6] %>" required>
            </div>
            <div class="form-group text-right">
                <input type="submit" value="Update" class="btn btn-info">
            </div>
        </form>
    </div>
</body>
</html>

