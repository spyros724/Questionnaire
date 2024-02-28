import subprocess
import json

# Test for healthcheck subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'healthcheck', '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Healthcheck is working")
else:
    print("Error: Healthcheck is not working")

# Test for resetall subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'resetall', '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Resetall is working")
else:
    print("Error: Resetall is not working")

# Test for resetq subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'resetq', '--questionnaire_id', '17', '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Resetq is working")
else:
    print("Error: Resetq is not working")

# Test for questionnaire_upd subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'questionnaire_upd', '--source', '../cli/dummy_data.json', '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Questionnaire_upd is working")
else:
    print("Error: Questionnaire_upd is not working")

# Test for question subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'question', '--questionnaire_id', '17', '--question_id' , 'q3' , '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Question is working")
else:
    print("Error: Question is not working")

# Test for doanswer subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'doanswer', '--questionnaire_id', '17', '--question_id' , 'q3' , '--session_id' , 'aaaa' , '--option_id' , 'o1' , '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Doanswer is working")
else:
    print("Error: Doanswer is not working")
    
# Test for questionnaire subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'questionnaire', '--questionnaire_id', '17', '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Quesrtionnaire is working")
else:
    print("Error: Questionnaire is not working")

# Test for getsessionanswers subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'getsessionanswers', '--questionnaire_id', '17', '--session_id' , 'aaaa' , '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Getsessionanswers is working")
else:
    print("Error: Getsessionanswers is not working")


# Test for getquestionanswers subcommand
result = subprocess.run(['python', '../cli/se2296.py', 'getquestionanswers', '--questionnaire_id', '17', '--question_id' , 'q3' , '--format', 'json'], stdout=subprocess.PIPE)
if result.returncode == 0:
    print("Getquestionanswers is working")
else:
    print("Error: Getquestionanswers is not working")
    
