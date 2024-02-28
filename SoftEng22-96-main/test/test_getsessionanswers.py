import unittest
from unittest.mock import Mock, patch
import requests

def test_getsessionanswers():
    # Define a mock response for the API
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {
        "questionnaireID": 1,
        "session":2,
        "answers": [
            {"qID": 1, "ans": 2},
            {"qID": 2, "ans": 3}
        ]
    }

    # Set the mock response for the API
    with patch('requests.get') as mock_get:
        mock_get.return_value = mock_response

        # Call the API
        response = requests.get("http://localhost:9103/intelliq_api/getsessionanswers/:1/:2")

        # Check if the API call was successful
        if response.status_code == 200:
            print("Question test passed")
        else:
            print(f"Error retrieving question data: {response.json()['message']}")