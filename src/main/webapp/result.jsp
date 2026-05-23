<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result</title>
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
            padding: 50px 40px;
            max-width: 500px;
            width: 92%;
            text-align: center;
            animation: fadeInUp 0.8s ease forwards;
            box-shadow: 0 25px 60px rgba(0,0,0,0.4);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .trophy {
            font-size: 80px;
            display: block;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50%       { transform: translateY(-15px); }
        }

        h1 {
            color: #fff;
            font-size: 2rem;
            margin: 20px 0 10px;
            animation: glow 2s infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: 0 0 10px #a78bfa; }
            to   { text-shadow: 0 0 25px #818cf8, 0 0 40px #6366f1; }
        }

        /* Score circle */
        .score-circle {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 25px auto;
            box-shadow: 0 0 40px rgba(99,102,241,0.6);
            animation: scorePop 1s ease forwards, pulse 2s infinite 1s;
        }

        @keyframes scorePop {
            0%   { transform: scale(0); opacity: 0; }
            70%  { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }

        @keyframes pulse {
            0%, 100% { box-shadow: 0 0 40px rgba(99,102,241,0.6); }
            50%       { box-shadow: 0 0 60px rgba(99,102,241,0.9); }
        }

        .score-number {
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
        }

        .score-total {
            color: rgba(255,255,255,0.8);
            font-size: 0.9rem;
        }

        /* Message */
        .message {
            color: rgba(255,255,255,0.85);
            font-size: 1.1rem;
            margin-bottom: 15px;
        }

        .percentage {
            display: inline-block;
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            color: white;
            padding: 6px 20px;
            border-radius: 20px;
            font-size: 0.95rem;
            margin-bottom: 30px;
            animation: pulse2 2s infinite;
        }

        @keyframes pulse2 {
            0%, 100% { transform: scale(1); }
            50%       { transform: scale(1.05); }
        }

        /* Buttons */
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .retry-btn {
            background: linear-gradient(135deg, #6366f1, #a78bfa);
            color: white;
            border: none;
            padding: 13px 35px;
            font-size: 1rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(99,102,241,0.4);
        }

        .retry-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(99,102,241,0.6);
        }

        .home-btn {
            background: transparent;
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            padding: 13px 35px;
            font-size: 1rem;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .home-btn:hover {
            background: rgba(255,255,255,0.1);
            transform: translateY(-3px);
        }

        /* Confetti */
        .confetti {
            position: fixed;
            width: 10px;
            height: 10px;
            border-radius: 2px;
            animation: confettiFall linear infinite;
            z-index: 0;
        }

        @keyframes confettiFall {
            0%   { top: -10px; transform: rotate(0deg); opacity: 1; }
            100% { top: 110vh; transform: rotate(720deg); opacity: 0; }
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
        <span class="trophy">🏆</span>
        <h1>Quiz Completed!</h1>

        <div class="score-circle">
            <div class="score-number">${score}</div>
            <div class="score-total">out of 50</div>
        </div>

        <div class="message" id="message"></div>
        <div class="percentage" id="percentage"></div>

        <div class="btn-group">
            <a href="quiz?qno=1">
                <button class="retry-btn">🔄 Try Again</button>
            </a>
            <a href="index.html">
                <button class="home-btn">🏠 Home</button>
            </a>
        </div>
    </div>

    <script>
        // Score from servlet
        const score = parseInt("${score}");
        const percent = Math.round((score / 50) * 100);

        // Percentage display
        document.getElementById('percentage').textContent = percent + '% Score';

        // Message based on score
        let message = '';
        if (percent >= 90)      message = '🌟 Outstanding! You are an NLP Expert!';
        else if (percent >= 75) message = '🎉 Great job! Keep it up!';
        else if (percent >= 50) message = '👍 Good effort! Practice more!';
        else                    message = '💪 Don\'t give up! Try again!';

        document.getElementById('message').textContent = message;

        // Confetti for good scores
        if (percent >= 50) {
            const colors = ['#6366f1', '#a78bfa', '#818cf8', '#fff', '#f472b6'];
            for (let i = 0; i < 60; i++) {
                const conf = document.createElement('div');
                conf.classList.add('confetti');
                conf.style.left = Math.random() * 100 + 'vw';
                conf.style.background = colors[Math.floor(Math.random() * colors.length)];
                conf.style.width = (Math.random() * 8 + 5) + 'px';
                conf.style.height = (Math.random() * 8 + 5) + 'px';
                conf.style.animationDuration = (Math.random() * 3 + 2) + 's';
                conf.style.animationDelay = (Math.random() * 3) + 's';
                document.body.appendChild(conf);
            }
        }
    </script>

</body>
</html>