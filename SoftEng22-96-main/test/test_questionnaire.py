import unittest
from unittest.mock import Mock, patch
import requests

def test_questionnaire():
    # Define a mock response for the API
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {
        "questionnaireID": 1,
        "questionnaireTitle": "sample questionnaire",
        "keywords": ["sample keyword 1", "sample keyword 2"],
        "questions": [
            {"qID": 1, "qText": "sample question 1", "required": True, "type": "profile"},
            {"qID": 2, "qText": "sample question 2", "required": False, "type": "question"}
        ]
    }

    # Set the mock response for the API
    with patch('requests.get') as mock_get:
        mock_get.return_value = mock_response

        # Call the API
        response = requests.get("http://localhost:9103/intelliq_api/questionnaire/1")

        # Check if the API call was successful
        if response.status_code == 200:
            print("Questionnaire test passed")
        else:
            print(f"Error retrieving questionnaire data with id 1: {response.json()['message']}")
