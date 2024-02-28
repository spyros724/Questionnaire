const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require('path');
let converter = require('json-2-csv');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'intelliq'
});

connection.connect();

// POST endpoint to delete all answer given a questionnaire ID
app.post('/intelliq_api/admin/resetq/:questionnaireID', (req, res) => {
  const id = req.params.questionnaireID;
  var format = req.query.format;
  var response = {
    status: 'OK'
  };
  var stcode = 200;
  connection.query('SELECT answerID FROM answer WHERE questionnaireID = ?;', [id], (error, results, fields) => {
    if (error) {
      response = {
        status: 'failed',
        reason: error
      };
      stcode = 500;
    } else {
      if (results.length == 0) {
        response = {
          message: `No data - Answer data with questionnaire id ${id} were already reset`
        };
        stcode = 402;
      } else {
        connection.query('DELETE FROM answer WHERE questionnaireID = ?;', [id], (error, results, fields) => {
          if (error) {
            response = {
              status: 'failed',
              reason: error
            };
            stcode = 500;
          } else {
            response = {
              status: 'OK'
            };
          }
        });
      }
      if (format == 'csv') {
        converter.json2csv(response, (err, csv) => {
          if (err) {
            throw err
          }
          res.send(csv);
        })
      } else {
        res.status(stcode).json(response)
      }
    }
  });
});

// GET endpoint to confirm end-to-end connectivity between the user and the database
app.get('/intelliq_api/admin/healthcheck', (req, res) => {
  const format = req.query.format;
  var response;
  var stcode = 200;
  connection.query('SELECT 1', (error, results, fields) => {
    var connection_string = "Server=localhost;Port=3306;Database=intelliq;Uid=root;Pwd='';";
    if (error) {
      response = {
        status: 'failed',
        dbconnection: connection_string
      };
      stcode = 500;
    } else {
      response = {
        status: 'OK',
        dbconnection: connection_string
      };
    }
    if (format == 'csv') {
      converter.json2csv(response, (err, csv) => {
        if (err) {
          throw err
        }
        res.send(csv);
      })
    } else {
      res.status(stcode).json(response)
    }
  })
});

// POST endpoint to reset database tables (delete content)
app.post('/intelliq_api/admin/resetall', (req, res) => {
  var format = req.query.format;
  var problem = false;
  var response = {
    status: 'OK'
  };
  var stcode = 200;
  var failed;
  connection.query('SELECT * FROM questionnaire;', (error, results, fields) => {
    if (results.length == 0) {
      response = {
        message: `No data - Entries were already reset`
      };
      stcode = 402;
    } else {
      var delete_query = "DELETE FROM keyword;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
      });
      delete_query = "DELETE FROM answer;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
      });
      delete_query = "DELETE FROM session;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
      });
      delete_query = "DELETE FROM option;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
      });
      delete_query = "DELETE FROM question;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
      });
      delete_query = "DELETE FROM questionnaire;";
      connection.query(delete_query, (error, results, fields) => {
        if (error) {
          problem = true;
          failed = error;
        }
        if (problem) {
          response = {
            status: 'failed',
            reason: failed
          };
          stcode = 500;
        }
      });
    }
    if (format == 'csv') {
      converter.json2csv(response, (err, csv) => {
        if (err) {
          throw err
        }
        res.send(csv);
      })
    } else {
      res.status(stcode).json(response)
    }
  });
});

// POST endpoint to upload JSON file for a new questionnaire
app.post('/intelliq_api/admin/questionnaire_upd', (req, res) => {
  const data = req.body;

  // Insert data into the questionnaire table
  const questionnaire_data = [data.questionnaireID, data.questionnaireTitle];
  connection.query("INSERT IGNORE INTO questionnaire (questionnaireID, questionnaireTitle) VALUES (?, ?)", questionnaire_data, (error, results) => {
    if (error) throw error;
    var questionnaire_id = data.questionnaireID;
    // Insert data into the keywords table
    for (let keyword of data.keywords) {
      const keyword_data = [keyword, questionnaire_id];
      connection.query("INSERT IGNORE INTO keyword (Keywords, questionnaireID) VALUES (?, ?)", keyword_data, (error, results) => {
        if (error) throw error;
      });
    }
    // Insert data into the questions table
    for (let question of data.questions) {
      const question_data = [question.qID, question.qtext, question.required, question.type, questionnaire_id];
      connection.query("INSERT IGNORE INTO question (qID, qText, required, type, questionnaireID) VALUES (?, ?, ?, ?, ?)", question_data, (error, results) => {
        if (error) throw error;
        var question_id = question.qID;
        // Insert data into the options table
        for (let option of question.options) {
          const option_data = [option.optID, option.opttxt, option.nextqID, question_id, questionnaire_id];
          //console.log(`Option data: ${option_data}`);
          connection.query("INSERT IGNORE INTO option (optID, opttxt, nextqID, qID, questionnaireID) VALUES (?, ?, ?, ?, ?)", option_data, (error, results) => {
            if (error) throw error;
            //console.log(`Option inserted: ${option}`);
          });
        }
      });
    }
    res.send(`Data inserted successfully!`);
  });
})


// GET endpoint to retrieve questionnaire and question data given a questionnaireID
app.get('/intelliq_api/questionnaire/:questionnaireID', (req, res) => {
  const id = req.params.questionnaireID;
  var format = req.query.format;
  connection.query('SELECT questionnaireID FROM questionnaire WHERE questionnaireID = ?;', [id], (error, quresults, fields) => { // TODO fix 402
    var stcode = 200;
    var response;
    connection.query('SELECT questionnaireID, questionnaireTitle FROM questionnaire WHERE questionnaireID = ?;', [id], (error, results, fields) => {
      if (error) {
        response = {
          message: `Error retrieving questionnaire data with id ${id}`
        };
        stcode = 500;
      } else {
        connection.query('SELECT Keywords FROM keyword WHERE questionnaireID = ?;', [id], (error, kresults, fields) => {
          if (error) {
            response = {
              message: `Error retrieving keyword data with questionnaire id ${id}`
            }
            stcode = 500;
          } else {
            const keywords = kresults.map(keyword => keyword.Keywords);
            connection.query('SELECT qID, qText, required, type FROM question WHERE questionnaireID = ?;', [id], (error, qresults, fields) => {
              if (error) {
                response = {
                  message: `Error retrieving question data with questionnaire id ${id}`
                };
                stcode = 500;
              } else {
                if (kresults.length == 0 || results.length == 0 || qresults.length == 0) {
                  response = {
                    message: `No answer data with questionnaire id ${id} found`
                  };
                  stcode = 402;
                } else {
                  var questions = qresults.map(question => ({
                    qID: question.qID,
                    qText: question.qText,
                    required: question.required,
                    type: question.type
                  }));
                  response = {
                    questionnaireID: results[0].questionnaireID,
                    questionnaireTitle: results[0].questionnaireTitle,
                    keywords,
                    questions
                  };
                }
                if (format == 'csv') {
                  converter.json2csv(response, (err, csv) => {
                    if (err) {
                      throw err
                    }
                    res.send(csv);
                  })
                } else {
                  res.status(stcode).json(response)
                }
              }
            });
          }
        });
      }
    });
  });
});



// GET endpoint to retrieve questionnaire data by Keyword
app.get('/questionnaire/:keyword', (req, res) => {
  const Keyword = req.params.keyword; //if that doesn't works change "Keyword" to "id", do the same for the next line
  connection.query('SELECT questionnaireTitle, NoQuestions FROM questionnaire WHERE Keyword = ?;', [id], (error, results, fields) => { //if that doesn't works change "Keyword" to "id"
    if (error) {
      res.status(500).json({
        message: `Error retrieving questionnaire data with id ${id}`
      }); //check for number of error (ex. 400 Bad request)
    } else {
      res.json(results[0]);
    }
  });
});

// GET endpoint to retrieve question data by questionnaireID and questionID
app.get('/intelliq_api/question/:questionnaireID/:questionID', (req, res) => {
  const id1 = req.params.questionnaireID;
  const id2 = req.params.questionID;
  var format = req.query.format;
  connection.query("SELECT questionnaireID, qID, qText, required, type FROM question WHERE questionnaireID = ? AND qID = ?;", [id1, id2], (error, results, fields) => {
    var stcode = 200;
    var response;
    connection.query("SELECT optID, opttxt, nextqID FROM option WHERE qID = ? AND questionnaireID = ?;", [id2, id1], (error, oresults, fields) => {
      if (error) {
        console.log(error);
        response = {
          message: `Error retrieving option data with question id ${id2}`
        };
        stcode = 500;
      } else {
        if (oresults.length == 0 || results.length == 0) {
          response = {
            message: `No answer data with questionnaire id ${id1} and question id ${id2} found`
          };
          stcode = 402;
        } else {
          const options = oresults.map(option => ({ //map each sql row from option table to a json object - "options": [the json objects/rows]
            optID: option.optID,
            opttxt: option.opttxt,
            nextqID: option.nextqID
          }));
          response = {
            questionnaireID: results[0].questionnaireID,
            qID: results[0].qID,
            qText: results[0].qText,
            required: results[0].required,
            type: results[0].type,
            options
          };
        }
      }
      if (format == 'csv') {
        converter.json2csv(response, (err, csv) => {
          if (err) {
            throw err
          }
          res.send(csv);
        })
      } else {
        res.status(stcode).json(response)
      }
    });
  })
});


// GET endpoint to retrieve answers data for a specific session by questionnaireID and sessionID
app.get('/intelliq_api/getsessionanswers/:questionnaireID/:sessionID', (req, res) => {
  const id1 = req.params.questionnaireID;
  const id2 = req.params.sessionID;
  var format = req.query.format;
  connection.query("SELECT questionnaireID, sessionID FROM session WHERE questionnaireID = ? AND sessionID = ?;", [id1, id2], (error, results, fields) => {
    var stcode = 200;
    var response;
    if (error) {
      console.log(error);
      response = {
        message: `Error retrieving question data with questionnaire id ${id1} and session id ${id2}`
      };
      stcode = 500;
    } else {
      connection.query("SELECT qID, optID FROM answer WHERE sessionID = ?;", [id2], (error, aresults, fields) => {
        if (error) {
          console.log(error);
          response = {
            message: `Error retrieving answer data with session id ${id2}`
          };
          stcode = 500;
        } else {
          console.log("aresults=", aresults)
          console.log("results=", results)
          if (aresults.length == 0 || results.length == 0) {
            response = {
              message: `No answer data with questionnaire id ${id1} and session id ${id2} found`
            };
            stcode = 402;
          } else {
            var answers = aresults.map(answer => ({
              qID: answer.qID,
              ans: answer.optID
            }));
            response = {
              questionnaireID: results[0].questionnaireID,
              sessionID: results[0].sessionID,
              answers
            };
            console.log(4);
          }
        }
        if (format == 'csv') {
          converter.json2csv(response, (err, csv) => {
            if (err) {
              throw err
            }
            res.send(csv);
          })
        } else {
          res.status(stcode).json(response);
        }
      });
    }
  });
});

//GET endpoint to retrieve anwser data for answers with given questionID and questionnaireID
app.get('/intelliq_api/getquestionanswers/:questionnaireID/:questionID', (req, res) => {
  const id1 = req.params.questionnaireID;
  const id2 = req.params.questionID;
  var format = req.query.format;
  connection.query("SELECT questionnaireID, qID FROM question WHERE questionnaireID = ? AND qID = ?;", [id1, id2], (error, results, fields) => {
    var stcode = 200;
    var response;
    if (error) {
      console.log(error);
      response = {
        message: `Error retrieving question data with questionnaire id ${id1} and question id ${id2}`
      };
      stcode = 500;
    } else {
      connection.query("SELECT optID, sessionID FROM answer WHERE questionnaireID = ? AND qID = ?;", [id1, id2], (error, aresults, fields) => {
        if (error) {
          console.log(error);
          response = {
            message: `Error retrieving answer data with question id ${id2} and questionnaire id ${id1}`
          };
          stcode = 500;
        } else {
          if (aresults.length == 0 || results.length == 0) {
            response = {
              message: `No answer data with questionnaire id ${id1} and question id ${id2} found`
            };
            stcode = 402;
          } else {
            const answers = aresults.map(answer => ({
              session: answer.sessionID,
              ans: answer.optID
            }));
            response = {
              questionnaireID: results[0].questionnaireID,
              questionID: results[0].questionID,
              answers
            };
          }
        }
        if (format == 'csv') {
          converter.json2csv(response, (err, csv) => {
            if (err) {
              throw err
            }
            res.send(csv);
          })
        } else {
          res.status(stcode).json(response)
        }
      });
    }
  })
});

// GET endpoint to retrieve the first question of a questionnaire
app.get('/intelliq_api/minquestion/:questionnaireID', (req, res) => {
  const id = req.params.questionnaireID;
  connection.query('SELECT MIN(qID) AS min_question_id FROM question WHERE questionnaireID = ?', [id], (error, results, fields) => {
    if (error) {
      res.status(500).json({
        message: 'Error retrieving questionnaire data'
      });
    } else {
      res.json(results[0]);
    }
  });
});

// GET endpoint to retrieve questionnaire data by ID
app.get('/questionnairehtml/:questionnaireID', (req, res) => {
  const id = req.params.questionnaireID;
  connection.query('SELECT questionnaireTitle FROM questionnaire WHERE questionnaireID = ?', [id], (error, results, fields) => {
    if (error) {
      res.status(500).json({
        message: 'Error retrieving questionnaire data'
      });
    } else {
      res.json(results[0]);
    }
  });
});

// POST endpoint to upload answer given during a session
app.post('/intelliq_api/doanswer/:questionnaireID/:questionID/:session/:optionID', (req, res) => {
  const id1 = req.params.questionnaireID;
  const id2 = req.params.questionID;
  const id3 = req.params.session;
  const id4 = req.params.optionID;
  var format = req.query.format;

  connection.query("INSERT IGNORE INTO session (questionnaireID, sessionID) VALUES (?, ?)", [id1, id3], (error, results) => {
    var response;
    stcode = 200;
    if (error) {
      console.log(error);
      response = {
        message: `Error inserting session data with questionnaire id ${id1}, session id ${id3} `
      };
      stcode = 500;
      sendResponse(response, stcode);
    } else {
      connection.query("INSERT INTO answer (questionnaireID, qID, sessionID, optID) VALUES (?, ?, ?, ?)", [id1, id2, id3, id4], (error, results) => {
        var response;
        stcode = 200;
        if (error) {
          console.log(error);
          response = {
            message: `Error inserting answer data with question id ${id2}, questionnaire id ${id1}, session id ${id3} and option id ${id4} `
          };
          stcode = 500;
        } else {
          response = {message: "ok"};
        }
        sendResponse(response, stcode);
      });
    }
  });

  function sendResponse(response, stcode) {
    if (format == 'csv') {
      converter.json2csv(response, (err, csv) => {
        if (err) {
          throw err
        }
        res.send(csv);
      })
    } else {
      res.status(stcode).json(response)
    }
  }
})


// GET endpoint to retrieve question data by questionnaireID and questionID
app.get('/intelliq_api/answershtml/:questionnaireID/:questionID', (req, res) => {
  const id1 = req.params.questionnaireID;
  const id2 = req.params.questionID;
  connection.query(`SELECT opttxt, a.optID, COUNT(answerID) as count 
  FROM intelliq.answer a
  INNER JOIN intelliq.option o
  ON (a.optID = o.optID)
  WHERE (a.questionnaireID = ? AND a.qID = ?)
  GROUP BY a.optID;`, [id1, id2], (error, results, fields) => {
    if (error) {
      console.log(error);
      res.status(500).json({
        message: `Error retrieving question data with questionnaire id ${id1} and question id ${id2}`
      });
    } else {
      const answers = results.map(a => ({ //or a?
        optID: a.optID,
        opttxt: a.opttxt,
        count: a.count
      }));
      const response = {
        answers
      };
      res.status(200).json(response);
    }
  })
});

// Function to generate random string for sessionID
function generateRandomString() {
  let result = '';
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  for (let i = 0; i < 4; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
}

// POST endpoint to upload new sessionID
app.post('/intelliq_api/postsession/:questionnaireID', (req, res) => {
  const questionnaireID = req.params.questionnaireID;
  let sessionID = generateRandomString();

  function checkAndInsertSession() {
    connection.query(
      'SELECT * FROM session WHERE sessionID = ?',
      [sessionID],
      (err, results) => {
        if (err) {
          return res.status(500).send({
            error: 'Error checking sessionID'
          });
        }

        if (results.length > 0) {
          // If sessionID already exists, generate a new one
          sessionID = generateRandomString();
          checkAndInsertSession();
        } else {
          // Insert new session into the database
          connection.query(
            'INSERT INTO session (sessionID, questionnaireID) VALUES (?, ?)',
            [sessionID, questionnaireID],
            (err, results) => {
              if (err) {
                return res.status(500).send({
                  error: 'Error inserting new session'
                });
              }
              res.send({
                sessionID
              });
            }
          );
        }
      }
    );
  }

  checkAndInsertSession();
});

// GET endpoint to retrieve questionnaire data by Keyword
app.get('/intelliq_api/searchkeyword/:keyword', (req, res) => {
  const keyword = req.params.keyword;
  const query = `SELECT questionnaire.questionnaireID, questionnaire.questionnaireTitle 
          FROM questionnaire 
          INNER JOIN keyword ON questionnaire.questionnaireID = keyword.questionnaireID 
          WHERE keyword.Keywords = ?`;

  connection.query(query, [keyword], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({
        error: 'Internal server error'
      });
    } else {
      res.status(200).json({
        data: results
      });
    }
  });
});

// GET endpoint to retrieve questions of a certain type (either "profile" or "question")
app.get('/intelliq_api/searchtypeofquestion/:questionnaireID/:type', (req, res) => {
  const id = req.params.questionnaireID;
  const qtype = req.params.type;
  const query = `SELECT qID, qText FROM question WHERE (questionnaireID = ? AND type = ?)`;

  connection.query(query, [id, qtype], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({
        error: 'Internal server error'
      });
    } else {
      res.status(200).json({
        data: results
      });
    }
  });
});

// GET endpoint to retrieve answers given questionnaireID and questionID
app.get('/intelliq_api/answer_count/:questionnaireId/:questionId', (req, res) => {
  const questionnaireId = req.params.questionnaireId;
  const questionId = req.params.questionId;

  let query = `SELECT opt.optID, COALESCE(COUNT(answer.optID), 0) AS count
      FROM option opt
      LEFT JOIN answer ON answer.questionnaireID = opt.questionnaireID
                       AND answer.qID = opt.qID
                       AND answer.optID = opt.optID
      WHERE opt.questionnaireID = ?
        AND opt.qID = ?
      GROUP BY opt.optID`;

  connection.query(query, [questionnaireId, questionId], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({
        error: 'An internal error occurred'
      });
    }

    let data = [];
    let labels = [];
    let backgroundColor = [];
    results.forEach(result => {
      labels.push(result.optID);
      data.push(result.count);
      backgroundColor.push(getRandomColor());
    });

    return res.json({
      labels,
      data,
      backgroundColor
    });
  });
});

// Function to generate random color for statistcs chart
function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

// GET endpoint to retrieve answers for a specific demographic group as answered in a demographic question with demogrqId
app.get('/intelliq_api/advanced_count/:questionnaireId/:questionId/:demogrqId/:demogroptId', (req, res) => {
  const questionnaireId = req.params.questionnaireId;
  const questionId = req.params.questionId;
  const demogrqId = req.params.demogrqId;
  const demogroptId = req.params.demogroptId;

  let query = `SELECT question_answer.optID, count(*) as count 
      FROM answer AS question_answer
      JOIN answer AS profile_answer
      ON question_answer.sessionID = profile_answer.sessionID
      WHERE question_answer.questionnaireID = ? AND profile_answer.questionnaireID = ? AND question_answer.qID = ? AND profile_answer.qID = ? AND profile_answer.optID = ?
      GROUP BY question_answer.optID`;

  connection.query(query, [questionnaireId, questionnaireId, questionId, demogrqId, demogroptId], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({
        error: 'An internal error occurred'
      });
    }

    let data = [];
    let labels = [];
    let backgroundColor = [];
    results.forEach(result => {
      labels.push(result.optID);
      data.push(result.count);
      backgroundColor.push(getRandomColor());
    });

    return res.json({
      labels,
      data,
      backgroundColor
    });
  });
});


// Serve the HTML web app
app.use(express.static(path.join(__dirname, '../frontend')));


app.listen(9103, () => {
  console.log('Server is running on port 9103.');
});