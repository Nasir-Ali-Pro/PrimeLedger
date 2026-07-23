import 'dart:io';
import 'dart:convert';

void main() async {
  final ids = [
    '0691d14b-f7c7-47ba-bae3-038ed0540d7d', // DB & Models
    'e189086b-3424-4f03-8a3b-958145056dac', // Providers & Logic
    '4d7f3766-5b70-473a-a1d8-54003a4d85d8'  // UI & Screens
  ];
  
  for (final id in ids) {
    final file = File('C:\\Users\\LaptopValley\\.gemini\\antigravity\\brain\\$id\\.system_generated\\logs\\transcript.jsonl');
    if (!file.existsSync()) {
      continue;
    }
    
    print('===========================================');
    print('SUBAGENT MESSAGES: $id');
    print('===========================================');
    
    final lines = await file.readAsLines();
    for (final line in lines) {
      try {
        final parsed = jsonDecode(line);
        final toolCalls = parsed['tool_calls'] as List?;
        if (toolCalls != null) {
          for (final tc in toolCalls) {
            if (tc['name'] == 'send_message') {
              print(tc['args']['Message']);
              print('---');
            }
          }
        }
      } catch (e) {
        // ignore
      }
    }
  }
}
