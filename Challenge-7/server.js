var http = require('http');

var server = http.createServer(function(req, res) {
res.writeHead(200, {"Content-Type": "text/html"});
res.end('<p><strong>My App V3</strong>!</p>');
});
server.listen(80);
