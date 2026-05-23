import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int qno = 1;
        String qParam = request.getParameter("qno");
        if (qParam != null) {
            qno = Integer.parseInt(qParam);
        }

        // Store name and roll number in session
        HttpSession session = request.getSession();
        String studentName = request.getParameter("studentName");
        String rollNumber = request.getParameter("rollNumber");

        if (studentName != null) session.setAttribute("studentName", studentName);
        if (rollNumber != null) session.setAttribute("rollNumber", rollNumber);

        // Reset score for new quiz
        if (qno == 1) {
            session.setAttribute("score", 0);
        }

        Question question = null;

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM questions WHERE question_id = ?");
            ps.setInt(1, qno);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setQuestionText(rs.getString("question_text"));
                question.setOptionA(rs.getString("option_a"));
                question.setOptionB(rs.getString("option_b"));
                question.setOptionC(rs.getString("option_c"));
                question.setOptionD(rs.getString("option_d"));
                question.setCorrectAnswer(rs.getString("correct_answer"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("question", question);
        request.setAttribute("qno", qno);
        RequestDispatcher rd = request.getRequestDispatcher("/quiz.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int qno = Integer.parseInt(request.getParameter("qno"));
        String selected = request.getParameter("answer");
        String correct = request.getParameter("correctAnswer");

        HttpSession session = request.getSession();
        Integer score = (Integer) session.getAttribute("score");
        if (score == null) score = 0;

        if (selected != null && selected.equals(correct)) {
            score++;
        }
        session.setAttribute("score", score);

        if (qno < 50) {
            response.sendRedirect("quiz?qno=" + (qno + 1));
        } else {
            // Save result to DB
            String studentName = (String) session.getAttribute("studentName");
            String rollNumber = (String) session.getAttribute("rollNumber");

            try {
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO results (student_name, roll_number, score, total) VALUES (?, ?, ?, ?)");
                ps.setString(1, studentName);
                ps.setString(2, rollNumber);
                ps.setInt(3, score);
                ps.setInt(4, 50);
                ps.executeUpdate();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect("result.jsp");
        }
    }
}