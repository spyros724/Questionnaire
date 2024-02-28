import unittest
from unittest.mock import Mock, patch
import requests

def test_healthcheck():
    # Define a mock response for the API
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {
        "status":"OK","dbconnection":"succesfull"
    }

    # Set the mock response for the API
    with patch('requests.get') as mock_get:
        mock_get.return_value = mock_response

        # Call the API
        response = requests.get("http://localhost:9103/intelliq_api/admin/healthcheck")

        # Check if the API call was successful
        if response.status_code == 200:
            print("Healthcheck test passed")
        else:
            print(f"Error completing healthcheck: {response.json()['message']}")
