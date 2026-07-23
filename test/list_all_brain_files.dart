import 'dart:io';

void main() {
  final brainDir = Directory(r'C:\Users\LaptopValley\.gemini\antigravity\brain\1c238ead-c3d8-4c85-8d80-b59d6217b497');
  if (!brainDir.existsSync()) {
    print('Brain dir does not exist');
    return;
  }
  
  brainDir.listSync(recursive: true).forEach((entity) {
    if (entity is File) {
      final path = entity.path;
      if (!path.contains('.system_generated') && !path.contains('.agents')) {
        print(path);
      }
    }
  });
}
