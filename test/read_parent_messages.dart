import 'dart:io';
import 'dart:convert';

void main() async {
  final file = File(r'C:\Users\LaptopValley\.gemini\antigravity\brain\1c238ead-c3d8-4c85-8d80-b59d6217b497\.system_generated\logs\transcript.jsonl');
  if (!file.existsSync()) {
    print('Logs do not exist');
    return;
  }
  
  final lines = await file.readAsLines();
  
  for (final line in lines) {
    if (line.contains('0691d14b') || line.contains('e189086b') || line.contains('4d7f3766')) {
      try {
        final parsed = jsonDecode(line);
        print('Step ${parsed['step_index']} (${parsed['source']}, ${parsed['type']})');
        final content = parsed['content'] ?? '';
        if (content.length > 500) {
          print(content.substring(0, 500) + '...');
        } else {
          print(content);
        }
        print('-------------------------------------------');
      } catch (e) {
        // ignore
      }
    }
  }
}
