import 'dart:io';
import 'dart:convert';

void main() async {
  final file = File(r'C:\Users\LaptopValley\.gemini\antigravity\brain\1c238ead-c3d8-4c85-8d80-b59d6217b497\.system_generated\logs\transcript.jsonl');
  if (!file.existsSync()) {
    print('Logs do not exist');
    return;
  }
  
  final lines = await file.readAsLines();
  print('Total steps: ${lines.length}');
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.contains('accounting') || line.contains('discrep') || line.contains('findings')) {
      try {
        final parsed = jsonDecode(line);
        final step = parsed['step_index'] ?? i;
        final type = parsed['type'];
        final source = parsed['source'];
        print('Step $step ($source, $type)');
        final content = parsed['content'] ?? '';
        if (content.length > 300) {
          print(content.substring(0, 300) + '...');
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
