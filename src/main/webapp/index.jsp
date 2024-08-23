<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Student Management System</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            background-color: #FFEBD4; 
            color: white;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            font-size: 3em;
            font-weight: bold;
            color: #FF4E88;
        }
        h2 {
            color: #FF4E88;
        }
        .form-label {
            color: #F0A8D0;
            font-weight: bold;
        }
        .btn-info {
            background-color: #F0A8D0;
            border-color: #1e90ff;
        }
        .btn-info:hover {
            background-color: #FF4E88;
            border-color: #104e8b;
        }
        .btn-warning {
            background-color: #FFDA76;
            border-color: #32cd32;
        }
        .btn-warning:hover {
            background-color: #FFC6C6;
            border-color: #228b22;
        }
        .table {
            color: #468585;
        }
        .table th {
            background-color: #F0A8D0;
            color: white;
        }
        .table td {
            text-align: center;
        }
        .row {
            margin: 20px;
        }
        .form-row {
            margin-bottom: 1rem;
        }
       
    </style>
</head>
<body>
    <h1>Student Management System</h1>
    <div class="container">
        <div class="row">
            <div class="col-md-12 mt-5 border">
                <h2>Add Student Information </h2>
                <form method="POST" action="saveStudent.jsp">
                    <div class="form-group">
                        <label class="form-label">Student ID</label>
                        <input type="text" class="form-control" placeholder="Student ID" name="studentId" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" placeholder="Full Name" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Age</label>
                        <input type="number" class="form-control" placeholder="Age" name="age" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">DSA Score</label>
                        <input type="number" step="0.1" class="form-control" placeholder="0-10" name="dsaScore" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">AD Score</label>
                        <input type="number" step="0.1" class="form-control" placeholder="0-10" name="adScore" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">IoT Score</label>
                        <input type="number" step="0.1" class="form-control" placeholder="0-10" name="iotScore" required>
                    </div>
                    <div align="left">
                        <input type="submit" value="Submit" class="btn btn-info">
                        <input type="reset" value="Reset" class="btn btn-warning">
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 border border-secondary mt-5">
                <h2>Student Data View</h2>
                <form method="GET" action="index.jsp">    
                    <div class="form-group">
                        <input type="text" name="search" placeholder="Search by Student ID, Name, or Email" class="form-control">
                    </div>
                    <div align="left">
                        <button type="submit" class="btn btn-info">Search</button>
                    </div>
                

                <div class="col-md-12 mt-3">
                    <label class="form-label">Sort By:</label>
                    <select name="sort" class="form-control" style="width: 200px; display: inline;">
                        <option value="id">Student ID</option>
                        <option value="name">Full Name</option>
                        <option value="average">Ascending Average Score</option>
                        <option value="average_desc">Descending Average Score</option>
                    </select>
                    <button type="submit" class="btn btn-info">Sort</button>
                </div>
                </form>
                <table id="tbl-student" class="table table-responsive table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Age</th>
                            <th>DSA Score</th>
                            <th>AD Score</th>
                            <th>IoT Score</th>
                            <th>Average Score</th>
                            <th>Evaluation</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<String[]> students = new ArrayList<>();
                            String filePath = application.getRealPath("/") + "students.csv";
                            java.io.File file = new java.io.File(filePath);
                            if (file.exists()) {
                                java.io.BufferedReader br = null;
                                try {
                                    br = new java.io.BufferedReader(new java.io.FileReader(file));
                                    String line;
                                    while ((line = br.readLine()) != null) {
                                        students.add(line.split(","));
                                    }
                                } catch (java.io.IOException e) {
                                    out.println("<tr><td colspan='11'>Error reading the file</td></tr>");
                                } finally {
                                    if (br != null) {
                                        try {
                                            br.close();
                                        } catch (java.io.IOException e) {
                                            out.println("<tr><td colspan='11'>Error closing the file</td></tr>");
                                        }
                                    }
                                }
                            } else {
                                out.println("<tr><td colspan='11'>Student data file not found</td></tr>");
                            }

                            String sortCriteria = request.getParameter("sort");
                            if (sortCriteria != null) {
                                students.sort((a, b) -> {
                                    switch (sortCriteria) {
                                        case "id":
                                            return a[0].compareTo(b[0]);
                                        case "name":
                                            return a[1].compareTo(b[1]);
                                        case "average":
                                            double avgA = (Double.parseDouble(a[4]) + Double.parseDouble(a[5]) + Double.parseDouble(a[6])) / 3;
                                            double avgB = (Double.parseDouble(b[4]) + Double.parseDouble(b[5]) + Double.parseDouble(b[6])) / 3;
                                            return Double.compare(avgA, avgB);
                                        case "average_desc":
                                            avgA = (Double.parseDouble(a[4]) + Double.parseDouble(a[5]) + Double.parseDouble(a[6])) / 3;
                                            avgB = (Double.parseDouble(b[4]) + Double.parseDouble(b[5]) + Double.parseDouble(b[6])) / 3;
                                            return Double.compare(avgB, avgA);
                                        default:
                                            return 0;
                                    }
                                });
                            }

                            String searchQuery = request.getParameter("search");
                            if (searchQuery != null && !searchQuery.isEmpty()) {
                                searchQuery = searchQuery.toLowerCase();
                                List<String[]> filteredStudents = new ArrayList<>();
                                for (String[] student : students) {
                                    if (student[0].toLowerCase().contains(searchQuery) || 
                                        student[1].toLowerCase().contains(searchQuery) || 
                                        student[2].toLowerCase().contains(searchQuery)) {
                                        filteredStudents.add(student);
                                    }
                                }
                                students = filteredStudents;
                            }

                            for (String[] student : students) {
                                double avgScore = (Double.parseDouble(student[4]) + Double.parseDouble(student[5]) + Double.parseDouble(student[6])) / 3;
                                String evaluation;
                                if (avgScore <= 5) {
                                    evaluation = "Fail";
                                } else if (avgScore <= 6.5) {
                                    evaluation = "Pass";
                                } else if (avgScore <= 7.5) {
                                    evaluation = "Good";
                                } else if (avgScore <= 9) {
                                    evaluation = "Very Good";
                                } else {
                                    evaluation = "Excellent";
                                }
                                out.println("<tr>");
                                out.println("<td>" + student[0] + "</td>");
                                out.println("<td>" + student[1] + "</td>");
                                out.println("<td>" + student[2] + "</td>");
                                out.println("<td>" + student[3] + "</td>");
                                out.println("<td>" + student[4] + "</td>");
                                out.println("<td>" + student[5] + "</td>");
                                out.println("<td>" + student[6] + "</td>");
                                out.println("<td>" + String.format("%.2f", avgScore) + "</td>");
                                out.println("<td>" + evaluation + "</td>");
                                out.println("<td><a href='editStudent.jsp?id=" + student[0] + "' class='btn btn-primary'>Edit</a></td>");
                                out.println("<td><a href='deleteStudent.jsp?id=" + student[0] + "' class='btn btn-danger'>Delete</a></td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
            </form>
        </div>
    </div>
</body>
</html>
