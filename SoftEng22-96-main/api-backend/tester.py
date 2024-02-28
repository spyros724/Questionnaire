import requests

url = "http://localhost:9103/intelliq_api/advanced_count/17/q3/p1/o2"

response = requests.get(url)

if response.status_code == 200:
    data = response.text
    print(data)
else:
    print("Request failed with status code:", response.status_code)
