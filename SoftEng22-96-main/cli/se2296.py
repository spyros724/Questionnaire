import argparse
import json
import requests
import csv
from json_to_csv import json_to_csv
parser = argparse.ArgumentParser(description='A command-line interface for interacting with API')

subparsers = parser.add_subparsers(dest='scope', help='Available scopes')

# healthcheck subcommand
healthcheck_parser = subparsers.add_parser('healthcheck', help='Check API health')
healthcheck_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# resetall subcommand
resetall_parser = subparsers.add_parser('resetall', help='Reset the database')
resetall_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# resetq subcommand
resetq_parser = subparsers.add_parser('resetq', help='Reset Questionnaire')
resetq_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
resetq_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# question subcommand
question_parser = subparsers.add_parser('question', help='Get question')
question_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
question_parser.add_argument('--question_id', type=str, required=True, help='Question id')
question_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# questionnaire subcommand
questionnaire_parser = subparsers.add_parser('questionnaire', help='Get questionnaire')
questionnaire_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
questionnaire_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# questionnaire_upd subcommand
questionnaire_upd_parser = subparsers.add_parser('questionnaire_upd', help='Insert data')
questionnaire_upd_parser.add_argument('--source', type=argparse.FileType('r'), help='Path to the JSON file')
questionnaire_upd_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# getsessionanswers subcommand
getsessionanswers_parser = subparsers.add_parser('getsessionanswers', help='Get session answers')
getsessionanswers_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
getsessionanswers_parser.add_argument('--session_id', type=str, required=True, help='Session id')
getsessionanswers_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# getquestionanswers subcommand
getquestionanswers_parser = subparsers.add_parser('getquestionanswers', help='Get question answers')
getquestionanswers_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
getquestionanswers_parser.add_argument('--question_id', type=str, required=True, help='Question id')
getquestionanswers_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')

# doanswer subcommand
doanswer_parser = subparsers.add_parser('doanswer', help='Post answer')
doanswer_parser.add_argument('--questionnaire_id', type=str, required=True, help='Questionnaire id')
doanswer_parser.add_argument('--question_id', type=str, required=True, help='Question id')
doanswer_parser.add_argument('--session_id', type=str, required=True, help='Session id')
doanswer_parser.add_argument('--option_id', type=str, required=True, help='Option id')
doanswer_parser.add_argument('--format', type=str, required=True, help='Format of the response, json or csv')


args = parser.parse_args()

if args.scope == 'healthcheck':
    response = requests.get('http://localhost:9103/intelliq_api/admin/healthcheck')
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        print(json_to_csv(response.json()))
    else:
        print("Invalid format")

elif args.scope == 'resetall':
    response = requests.post('http://localhost:9103/intelliq_api/admin/resetall')
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'resetq':
    data = {'questionnaire_id': args.questionnaire_id}
    id=args.questionnaire_id
    url = 'http://localhost:9103/intelliq_api/admin/resetq/{}'.format(id)
    response = requests.post(url, json=data)
    if args.format == 'json':
        # print('hi')
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'questionnaire':
    data = {'questionnaire_id': args.questionnaire_id}
    id=args.questionnaire_id
    url = 'http://localhost:9103/intelliq_api/questionnaire/{}'.format(id)
    response = requests.get(url, json=data)
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'question':
    data = {'questionnaire_id': args.questionnaire_id, 'question_id': args.question_id}
    id1 = args.questionnaire_id
    id2 = args.question_id
    url = 'http://localhost:9103/intelliq_api/question/'+id1+'/'+id2+''
    response = requests.get(url, json=data)
    if args.format == 'json':
        print(response.json()) 
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'getsessionanswers':
    data = {'questionnaire_id': args.questionnaire_id, 'session_id': args.session_id}
    id1 = args.questionnaire_id
    id2 = args.session_id
    url = 'http://localhost:9103/intelliq_api/getsessionanswers/'+id1+'/'+id2+''
    response = requests.get(url, json=data)
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'getquestionanswers':
    data = {'questionnaire_id': args.questionnaire_id, 'question_id': args.question_id}
    id1 = args.questionnaire_id
    id2 = args.question_id
    url = 'http://localhost:9103/intelliq_api/getquestionanswers/'+id1+'/'+id2+''
    response = requests.get(url, json=data)
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'doanswer':
    data = {'questionnaire_id': args.questionnaire_id, 'question_id': args.question_id, 'session_id': args.session_id, 'option_id': args.option_id}
    id1 = args.questionnaire_id
    id2 = args.question_id
    id3 = args.session_id
    id4 = args.option_id
    url = 'http://localhost:9103/intelliq_api/doanswer/'+id1+'/'+id2+'/'+id3+'/'+id4+''
    response = requests.post(url, json=data)
    if args.format == 'json':
        print(response.json())
    elif args.format == 'csv':
        # convert json to csv
        print(json_to_csv(response.json()))
        #print('I will fix this bug')
    else:
        print("Invalid format")

elif args.scope == 'questionnaire_upd':
    with open(args.source.name, 'r', encoding='utf-8') as f:
        data = json.load(f)
    response = requests.post('http://localhost:9103/intelliq_api/admin/questionnaire_upd', json=data)
    if args.format == 'json':
        print(response.text)
    elif args.format == 'csv':
        # convert json to csv
        print(response.text)
        print('I will fix this bug')
    else:
        print("Invalid format")

else:
    print("Invalid scope")