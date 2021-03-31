import 'dart:convert';
import 'dart:html';

const String serverURL = 'http://127.0.0.1:4040';

late AnchorElement time, resume;
void main() {
  time = document.querySelector('#time') as AnchorElement;
  resume = document.querySelector('#resume') as AnchorElement;

  setupTime();
  setupResume();
}

void setupResume() {
  resume.onClick.listen((event) {
    HttpRequest.request(
      '$serverURL/resume',
      method: 'GET',
      responseType: 'document',
    );
  });
}

void setupTime() {
  time.onClick.listen((event) async {
    final response = await HttpRequest.getString('$serverURL/time');
    final data = json.decode(response);
    window.alert('Server Date-Time is ${data['server-time']}');
  });
}
