var http        = require('http');
var request     = require('request');

/* -- Making calls ---------------------------------------------------------- */
var interval_id = setInterval(function(){proxy();}, 5000);

query = function(method, url, form, headers) {
  request({uri: url, method: method, form: form, headers: (headers || {})} , function(error, response, body) {
    console.log("\n", method, url, body, error);
  });
};

var proxy = function() {
  var server = 'http://localhost:1337/';
  /* -- RESTful ------------------------------------------------------------- */
  query('GET', server + 'api');
  query('POST', server + 'api');
  query('PUT', server + 'api');
  query('DELETE', server + 'api');
  query('HEAD', server + 'api');
  query('OPTIONS', server + 'api');
  /* -- Required parameters & Authentication via header --------------------- */
  var url = server + 'domain/user/soyjavi?name=Javi'
  query('GET', url);
  query('GET', url, undefined, {zenauth: "tapquo"});
  /* -- Example of REST status ---------------------------------------------- */
  query('GET', server + 'status/201');
  query('GET', server + 'status/401');
  query('GET', server + 'status/501');
  /* -- Appnima login/signup ------------------------------------------------ */
  var query_string = '&mail=javi.jimenez.villar@gmail.com&password=pass';
  query('GET', server + 'appnima?method=signup' + query_string);
  query('GET', server + 'appnima?method=login' + query_string);
  /* -- form-data and HTML response ----------------------------------------- */
  var form = { field1: "Javi", field2: "@soyjavi" };
  query("POST", "http://localhost:1337/form?extra=true", form);
};

proxy();

process.stdout.setMaxListeners(0);
