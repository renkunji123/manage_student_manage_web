<%@ page import="java.io.*" %>
<%
    String studentId = request.getParameter("studentId");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String age = request.getParameter("age");
    double dsaScore = Double.parseDouble(request.getParameter("dsaScore"));
    double adScore = Double.parseDouble(request.getParameter("adScore"));
    double iotScore = Double.parseDouble(request.getParameter("iotScore"));

    double averageScore = (dsaScore + adScore + iotScore) / 3;
    String evaluation;
    if (averageScore <= 5) {
        evaluation = "fail";
    } else if (averageScore <= 6.5) {
        evaluation = "pass";
    } else if (averageScore <= 7.5) {
        evaluation = "good";
    } else if (averageScore <= 9) {
        evaluation = "very good";
    } else {
        evaluation = "excellent";
    }

    String filePath = application.getRealPath("/") + "students.csv";
    try (FileWriter fw = new FileWriter(filePath, true);
         BufferedWriter bw = new BufferedWriter(fw);
         PrintWriter fileOut = new PrintWriter(bw)) {
        fileOut.println(studentId + "," + fullName + "," + email + "," + age + "," + dsaScore + "," + adScore + "," + iotScore + "," + averageScore + "," + evaluation);
    } catch (IOException e) {
        e.printStackTrace();
    }
    response.sendRedirect("index.jsp");
%>
