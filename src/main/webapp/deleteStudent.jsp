<%@ page import="java.io.*" %>
<%
    String studentId = request.getParameter("id");
    String filePath = application.getRealPath("/") + "students.csv";
    java.io.File file = new java.io.File(filePath);
    java.util.List<String[]> allLines = new java.util.ArrayList<>();

    if (file.exists()) {
        java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(file));
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
            if (!data[0].equals(studentId)) {
                allLines.add(data);
            }
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
