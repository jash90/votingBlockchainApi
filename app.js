var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/index');

var loginUser = require("./routes/auth/loginUser");
var registerUser = require("./routes/auth/registerUser");
var getUserRequest = require("./routes/auth/getUserRequest");
var changeUserRequest = require("./routes/auth/changeUserRequest");

var getQuestionsMod = require("./routes/question/getQuestionsMod");
var getQuestionsUser = require("./routes/question/getQuestionsUser");
var addQuestion = require("./routes/question/addQuestion");
var editQuestion = require("./routes/question/editQuestion");
var removeQuestion = require("./routes/question/removeQuestion");

var getAnswers = require("./routes/answer/getAnswers");
var addAnswer = require("./routes/answer/addAnswer");
var editAnswer = require("./routes/answer/editAnswer");
var removeAnswer = require("./routes/answer/removeAnswer");

var addAnswerUser = require("./routes/answerUser/addAnswerUser");
var getAnswerUser = require("./routes/answerUser/getAnswerUsers");

var getUserRole = require("./routes/userRole/getUserRole");
var addUserRole = require("./routes/userRole/addUserRole");
var editUserRole = require("./routes/userRole/editUserRole");
var removeUserRole = require("./routes/userRole/removeUserRole");

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);

app.use('/register',registerUser);
app.use('/login', loginUser);
app.use('/getuserrequest',getUserRequest);
app.use('/changeuserrequest', changeUserRequest);

app.use("/questionsMod", getQuestionsMod);
app.use("/questionsUser", getQuestionsUser);
app.use("/editquestion", editQuestion);
app.use("/addquestion", addQuestion);
app.use("/removequestions", removeQuestion);

app.use("/answers", getAnswers);
app.use("/addanswer", addAnswer);
app.use("/editanswer",editAnswer);
app.use("/removeanswer",removeAnswer)

app.use("/addansweruser", addAnswerUser);
app.use("/getansweruser", getAnswerUser);

app.use("/getuserrole", getUserRole);
app.use("/adduserrole", addUserRole);
app.use("/edituserrole", editUserRole);
app.use("/removeuserrole", removeUserRole);




// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  err.message = res;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
