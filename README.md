# GSoC-Dart Server

This project is a [Sample project for GSoC dart](https://github.com/dart-lang/sdk/wiki/Dart-GSoC-2021-Project-Ideas#idea-standalone-pub-server) and it is divided in 2 parts.

1. Server side (./server)
2. Client side (./client)

### APIs implemented on server side

`GET: site-url/time`

This will return current time from server as response.

`GET: site-url/resume`

This will return a file(my resume) as response.

### How to run

1. Clone this repo

`git clone https://github.com/SirusCodes/GSoC-Dart-Server`

2. Initialize the server

`dart server/bin/server.dart`

3. Open client webpage
```
cd client
webdev build
client/build/index.html
```
