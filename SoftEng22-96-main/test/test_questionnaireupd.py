import requests
import unittest.mock
import json

def test_questionnaire_upd():

    with unittest.mock.patch("requests.post") as mock_post:
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = { "message": "Questionnaire registered" }
    response = requests.post('http://localhost:9103/intelliq_api/admin/questionnaire_upd', json={
            "questionnaireID": 1,
            "questionnaireTitle": "Sample Questionnaire",
            "keywords": ["keyword1", "keyword2"],
            "questions": [
                  {
                        "qID": 1,
                        "qtext": "Question 1",
                        "required": True,
                        "type": "radio",
                        "options": [
                            {
                                "optID": 1,
                                "opttxt": "Option 1",
                                "nextqID": 2
                            },
                            {
                                "optID": 2,
                                "opttxt": "Option 2",
                                "nextqID": 3
                            }
                        ]
                    },
                    {
                        "qID": 2,
                        "qtext": "Question 2",
                        "required": False,
                        "type": "checkbox",
                        "options": [
                            {
                                "optID": 1,
                                "opttxt": "Option 1",
                                "nextqID": 3
                            },
                            {
                                "optID": 2,
                                "opttxt": "Option 2",
                                "nextqID": 3
                            }
                        ]
                    }
                ]
            })
    
    expected_status_code = 200
    expected_response = { "message": "Questionnaire stored" }
    
    if response.status_code == 200:
            print("Success: Data inserted successfully!")
    else:
            print(f"Error: {response.json()['message']}")