# CLI client

![Python](https://img.shields.io/badge/python-v3.11+-red.svg)

## Python3 packages



- [argparse] - Parser for command-line options, arguments and sub-commands
- [requests] - Python HTTP library.
- [pandas] - pandas 1.5.3
- [mysql.connector] - mysql-connector-python 8.0.32

## Installation
For a quick installation 

```sh
python deploy.py
```
To be able to run scripts without "./", you must place [se2296.bat] in Windows folder or in any other folder in (C:).
## Usage 
```sh
se2296 SCOPE --param1 value1 [--param2 value2 ...]--format fff 
```
To get a help message for each scope
```sh
se2296 SCOPE --help
```
Available SCOPES: 
* healthcheck
* resetall
* questionnaire_upd
* resetq
* questionnaire
* question
* doanswer
* getsessionanswers
* getquestionanswers



   [argparse]: https://docs.python.org/3/library/argparse.html
   [pytest]: https://docs.pytest.org/en/stable/
   [requests]: https://requests.readthedocs.io/en/master/
   [mysql.connector]: https://pypi.org/project/mysql-connector-python/
   [pandas]: https://pypi.org/project/pandas/
   
   [document]: https://courses.pclab.ece.ntua.gr/pluginfile.php/11027/mod_resource/content/1/project-softeng20b-rest-cli-specs-v1.0.pdf
