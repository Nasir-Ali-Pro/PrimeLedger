import 'dart:io';
import 'dart:convert';

void main() async {
  final file = File(r'C:\Users\LaptopValley\.gemini\antigravity\brain\1c238ead-c3d8-4c85-8d80-b59d6217b497\.system_generated\logs\transcript.jsonl');
  if (!file.existsSync()) {
    print('Logs do not exist');
    return;
  }
  
  final lines = await file.readAsLines();
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    try {
      final parsed = jsonDecode(line);
      final step = parsed['step_index'];
      if (step == 100) {
        final content = parsed['content'] ?? '';
        final outFile = File(r'C:\Users\LaptopValley\.gemini\antigravity\scratch\original_implementation_plan.md');
        await outFile.writeAsString(content);
        print('Wrote ${content.length} chars to ${outFile.path}');
        break;
      }
    } catch (e) {
      // ignore
    }
  }
}
