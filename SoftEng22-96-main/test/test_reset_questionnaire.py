import requests
import unittest.mock

def test_reset_questionnaire():
    url = "http://localhost:9103/intelliq_api/admin/resetq/17"

    with unittest.mock.patch("requests.post") as mock_post:
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = { "message": "Entries with id 17 have been reset" }
        
        response = requests.post(url)
    
    expected_status_code = 200
    expected_response = { "message": "Entries with id 17 have been reset" }
    
    if response.status_code == expected_status_code and response.json() == expected_response:
        print("Resetq test passed")
    else:
        print("Test failed")
        print("Expected status code:", expected_status_code)
        print("Received status code:", response.status_code)
        print("Expected response:", expected_response)
        print("Received response:", response.json())