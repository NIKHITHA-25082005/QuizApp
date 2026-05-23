<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NLP Quiz</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
        }

        .bubbles {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .bubble {
            position: absolute;
            bottom: -100px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
            animation: rise 10s infinite ease-in;
        }

        .bubble:nth-child(1) { left: 10%; width: 20px; height: 20px; animation-duration: 8s; }
        .bubble:nth-child(2) { left: 25%; width: 50px; height: 50px; animation-duration: 12s; animation-delay: 2s; }
        .bubble:nth-child(3) { left: 40%; width: 30px; height: 30px; animation-duration: 9s; animation-delay: 1s; }
        .bubble:nth-child(4) { left: 60%; width: 60px; height: 60px; animation-duration: 11s; animation-delay: 3s; }
        .bubble:nth-child(5) { left: 75%; width: 25px; height: 25px; animation-duration: 7s; animation-delay: 1.5s; }
        .bubble:nth-child(6) { left: 88%; width: 45px; height: 45px; animation-duration: 13s; animation-delay: 4s; }

        @keyframes rise {
            0%   { bottom: -100px; transform: translateX(0); opacity: 0.5; }
            50%  { transform: translateX(40px); opacity: 0.3; }
            100% { bottom: 110%; transform: translateX(-40px); opacity: 0; }
        }

        .container {
            position: relative;
            z-index: 1;
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 30px;
            padding: 40px;
            max-width: 650px;
            width: 92%;
            animation: fadeInUp 0.8s ease forwards;
            box-shadow: 0 25px 60px rgba(0,0,0,0.4);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* Top bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .question-number {
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            color: white;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 0.9rem;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50%       { transform: scale(1.05); }
        }

        .score-badge {
            color: rgba(255,255,255,0.7);
            font-size: 0.9rem;
        }

        /* Progress bar */
        .progress-container {
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
            height: 8px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #6366f1, #a78bfa);
            border-radius: 10px;
            transition: width 0.5s ease;
            box-shadow: 0 0 10px rgba(99,102,241,0.6);
        }

        /* Question */
        .question-text {
            color: #fff;
            font-size: 1.15rem;
            margin-bottom: 30px;
            line-height: 1.6;
            animation: glow 3s infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: none; }
            to   { text-shadow: 0 0 10px rgba(167,139,250,0.3); }
        }

        /* Options */
        .options {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 30px;
        }

        .option-label {
            display: flex;
            align-items: center;
            gap: 15px;
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 15px;
            padding: 14px 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            color: rgba(255,255,255,0.85);
            font-size: 0.95rem;
        }

        .option-label:hover {
            background: rgba(99,102,241,0.25);
            border-color: #6366f1;
            transform: translateX(8px);
            box-shadow: 0 5px 20px rgba(99,102,241,0.3);
        }

        .option-label input[type="radio"] {
            accent-color: #a78bfa;
            width: 18px;
            height: 18px;
        }

        .option-letter {
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
            flex-shrink: 0;
        }

        /* Submit button */
        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            color: white;
            border: none;
            padding: 15px;
            font-size: 1rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(99,102,241,0.4);
            letter-spacing: 1px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(99,102,241,0.6);
        }

        .submit-btn:active {
            transform: scale(0.97);
        }
    </style>
</head>
<body>

    <div class="bubbles">
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
        <div class="bubble"></div>
    </div>

    <div class="container">

        <div class="top-bar">
            <div class="question-number">
                Question <span id="qno">${qno}</span> of 50
            </div>
            <div class="score-badge">🧠 NLP Quiz</div>
        </div>

        <!-- Progress bar -->
        <div class="progress-container">
            <div class="progress-bar" id="progressBar"></div>
        </div>

        <!-- Question -->
        <div class="question-text">
            ${question.questionText}
        </div>

        <!-- Options Form -->
        <form action="quiz" method="post">
            <input type="hidden" name="qno" value="${qno}">
            <input type="hidden" name="correctAnswer" value="${question.correctAnswer}">

            <div class="options">
                <label class="option-label">
                    <input type="radio" name="answer" value="A" required>
                    <span class="option-letter">A</span>
                    ${question.optionA}
                </label>
                <label class="option-label">
                    <input type="radio" name="answer" value="B">
                    <span class="option-letter">B</span>
                    ${question.optionB}
                </label>
                <label class="option-label">
                    <input type="radio" name="answer" value="C">
                    <span class="option-letter">C</span>
                    ${question.optionC}
                </label>
                <label class="option-label">
                    <input type="radio" name="answer" value="D">
                    <span class="option-letter">D</span>
                    ${question.optionD}
                </label>
            </div>

            <button type="submit" class="submit-btn">
                Next Question ➡️
            </button>
        </form>

    </div>

    <script>
        // Progress bar update
        const qno = parseInt(document.getElementById('qno').textContent);
        const percent = (qno / 50) * 100;
        document.getElementById('progressBar').style.width = percent + '%';
    </script>

</body>
</html>



