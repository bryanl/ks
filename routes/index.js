var express = require('express');
var router = express.Router();

var os = require('os');

/* GET home page. */
router.get('/', function (req, res, next) {
  const dataSource = {
    username: "app",
    password: "password",
    database: "app",
    port: 5432,
  };

  res.render('index', {
    dataSource: dataSource,
    region: "east",
    hostname: os.hostname(),
  });
});

module.exports = router;