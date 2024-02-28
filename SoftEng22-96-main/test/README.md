# Testing

## Testing Tools
[unittest.mock] - mock object library
 
## Usage

* **CLI testing** - Tests functionality of CLI commands
 
```sh
python functional_test_cli.py
```
  *Expected Output*
```sh
Healthcheck is working
Resetall is working
Resetq is working
Questionnaire_upd is working
Question is working
Doanswer is working
Quesrtionnaire is working
Getsessionanswers is working
Getquestionanswers is working

```
</br>

* **API testing** - Tests Functionality of APIs
 
```sh
python apitesting.py
```
  *Expected Output*
```sh
Resetq test passed
Questionnaire test passed
Question test passed
Healthcheck test passed
Question test passed
Resetall test passed
doanswer test passed
Answers test passed
Success: Data inserted successfully!

```










  [unittest.mock]: https://docs.python.org/3/library/unittest.mock.html
