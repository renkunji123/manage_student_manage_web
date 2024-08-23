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
    java.io.File file = new java.io.File(filePath);
    java.util.List<String[]> allLines = new java.util.ArrayList<>();

    if (file.exists()) {
        java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(file));
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
            if (data[0].equals(studentId)) {
                data[1] = fullName;
                data[2] = email;
                data[3] = age;
                data[4] = String.valueOf(dsaScore);
                data[5] = String.valueOf(adScore);
                data[6] = String.valueOf(iotScore);
                data[7] = String.valueOf(averageScore);
                data[8] = evaluation;
            }
            allLines.add(data);
        }
        br.close();
    }

    try (FileWriter fw = new FileWriter(filePath);
         BufferedWriter bw = new BufferedWriter(fw);
         PrintWriter fileOut = new PrintWriter(bw)) {
        for (String[] data : allLines) {
            fileOut.println(String.join(",", data));
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
    response.sendRedirect("index.jsp");
%>
