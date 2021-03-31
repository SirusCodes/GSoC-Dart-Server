import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

const _hostname = '127.0.0.1';
const port = 4040;

const htmlHeader = {'content-type': 'text/html'};

const downloadFileHeader = {
  'content-type': 'application/pdf',
  'content-disposition': 'attachment; filename=resume.pdf'
};

const Map<String, String> _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET,OPTIONS',
  'Access-Control-Allow-Headers': '*',
};

Response _cors(Response response) => response.change(headers: _corsHeaders);

void main(List<String> args) async {
  // For Google Cloud Run, we respect the PORT environment variable

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_fixCORS)
      .addHandler(_handleRequest);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}

Response? _options(Request request) => (request.method == 'OPTIONS')
    ? Response.ok(null, headers: _corsHeaders)
    : null;

Middleware _fixCORS =
    createMiddleware(requestHandler: _options, responseHandler: _cors);

Response _handleRequest(Request request) {
  switch (request.url.path) {
    case 'time':
      return _serveServerTime();
    case 'resume':
      return _downloadResume();
    default:
      return Response.notFound(null);
  }
}

Response _downloadResume() {
  final file = resolvedPath('static/files/resume.pdf');
  if (file.existsSync()) {
    return Response.ok(file.openRead(), headers: downloadFileHeader);
  }
  return Response.notFound(null);
}

Response _serveServerTime() {
  final currenTime = DateTime.now();
  return Response.ok(json.encode({'server-time': currenTime.toString()}));
}

File resolvedPath(String path) => File(File(path).resolveSymbolicLinksSync());
