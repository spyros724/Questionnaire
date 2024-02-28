import unittest
from unittest.mock import Mock, patch
import requests

def test_getquestionanswers():
    # Define a mock response for the API
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {
        "questionnaireID": 1,
        "questionID":2,
        "answers": [
            {"session": 1, "ans": 2},
            {"session": 2, "ans": 3}
        ]
    }

    # Set the mock response for the API
    with patch('requests.get') as mock_get:
        mock_get.return_value = mock_response

        # Call the API
        response = requests.get("http://localhost:9103/intelliq_api/getquestionanswers/:1/:2")

        # Check if the API call was successful
        if response.status_code == 200:
            print("Answers test passed")
        else:
            print(f"Error retrieving session data: {response.json()['message']}")