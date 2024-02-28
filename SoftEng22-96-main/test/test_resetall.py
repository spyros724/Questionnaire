import requests
import unittest.mock

def test_resetall():
    url = "http://localhost:9103/intelliq_api/admin/resetall"

    with unittest.mock.patch("requests.post") as mock_post:
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = { "message": "All data have been deleted" }
        
        response = requests.post(url)
    
    expected_status_code = 200
    expected_response = { "message": "All data have been deleted" }
    
    if response.status_code == expected_status_code and response.json() == expected_response:
        print("Resetall test passed")
    else:
        print("Test failed")
        print("Expected status code:", expected_status_code)
        print("Received status code:", response.status_code)
        print("Expected response:", expected_response)
        print("Received response:", response.json())