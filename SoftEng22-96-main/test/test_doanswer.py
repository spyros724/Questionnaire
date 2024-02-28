import requests
import unittest.mock

def test_doanswer():
    url = "http://localhost:9103/intelliq_api/doanswer/:1/:1/:abcd/:1"

    with unittest.mock.patch("requests.post") as mock_post:
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = { "message": "Answer registered" }
        
        response = requests.post(url)
    
    expected_status_code = 200
    expected_response = { "message": "Answer registered" }
    
    if response.status_code == expected_status_code and response.json() == expected_response:
        print("doanswer test passed")
    else:
        print("Test failed")
        print("Expected status code:", expected_status_code)
        print("Received status code:", response.status_code)
        print("Expected response:", expected_response)
        print("Received response:", response.json())