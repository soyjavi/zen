"use strict";

var zenproxy = require('zenproxy');
zenproxy.start()

// setTimeout(function() {
//   zenproxy.addHost("sub.domain.com", "localhost", 1986);
//   zenproxy.addHost("sub.domain.com", "localhost", 1987);
// }, 1000);

// setTimeout(function() {
//   zenproxy.removeHost("domain.com", "127.0.0.1", 1987);
// }, 2000);



var http = require('http');
var hyperquest = require('hyperquest');

/* -- Random NODEJS servers (from :1981 to :1990) --------------------------- */
var delay, i, port, _i;
port = 1980;
delay = 10;
for (i = _i = 1; _i <= 10; i = ++_i) {
  port++;
  http.createServer(function(req, res) {
    setTimeout(function() {
      res.writeHead(200, {"Content-Type": "text/plain"});
      res.write(JSON.stringify(req.headers, true, 2));
      return res.end();
    }, delay);
  }).listen(port);
}

http.createServer(function(req, res) {
setTimeout(function() {
  res.writeHead(302, {
    'Location': 'http://tapquo.com'
  });
  res.end();
}, delay);
}).listen(2001);

/* -- Making calls ---------------------------------------------------------- */
var interval_id = setInterval(function(){proxy();}, 2500);

var j = 0;
var proxy = function() {
  j = (j < 3) ? (j + 1) : 0
  hyperquest('http://localhost:8888/random');
  hyperquest('http://127.0.0.1:8888/roundrobin');
  hyperquest('http://localhost:8888/regex/prefix-' + j + '/hello-' + j);
  hyperquest('http://localhost:8888/unknown/url');
  hyperquest('http://localhost:8888/redirect');
};

proxy();
process.stdout.setMaxListeners(0);
