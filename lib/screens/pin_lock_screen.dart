import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../database/database_provider.dart';
import '../providers/settings_provider.dart';

class PinLockScreen extends ConsumerStatefulWidget {
  final bool isSettingPin;
  const PinLockScreen({super.key, this.isSettingPin = false});

  @override
  ConsumerState<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends ConsumerState<PinLockScreen> {
  String _pin = '';
  String? _expectedPin;
  String _message = 'Enter your PIN';

  @override
  void initState() {
    super.initState();
    if (!widget.isSettingPin) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadPin());
    } else {
      _message = 'Set a new 4-digit PIN';
    }
  }

  Future<void> _loadPin() async {
    final dao = ref.read(settingsDaoProvider);
    final pin = await dao.get('app_pin');
    if (mounted) {
      setState(() => _expectedPin = pin);
    }
  }

  void _onDigitPressed(String digit) {
    if (_pin.length < 4) {
      setState(() {
        _pin += digit;
      });
      if (_pin.length == 4) {
        _processPin();
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _processPin() async {
    if (widget.isSettingPin) {
      final dao = ref.read(settingsDaoProvider);
      await dao.set('app_pin', _pin);
      ref.read(isUnlockedProvider.notifier).setUnlocked(true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN set successfully!'), backgroundColor: Color(0xFF10B981)));
        context.pop();
      }
    } else {
      if (_pin == _expectedPin) {
        ref.read(isUnlockedProvider.notifier).setUnlocked(true);
        context.go('/dashboard');
      } else {
        setState(() {
          _pin = '';
          _message = 'Incorrect PIN. Try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Color(0xFF6366F1)),
            const SizedBox(height: 24),
            Text(_message, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length ? const Color(0xFF6366F1) : Colors.transparent,
                    border: Border.all(color: const Color(0xFF6366F1), width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildKey('1'), _buildKey('2'), _buildKey('3')]),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildKey('4'), _buildKey('5'), _buildKey('6')]),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_buildKey('7'), _buildKey('8'), _buildKey('9')]),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 80),
              _buildKey('0'),
              SizedBox(
                width: 80,
                child: IconButton(
                  onPressed: _onBackspace,
                  icon: const Icon(Icons.backspace_outlined, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String digit) {
    return SizedBox(
      width: 80,
      height: 80,
      child: TextButton(
        onPressed: () => _onDigitPressed(digit),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white.withValues(alpha: 0.05),
        ),
        child: Text(digit, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w300)),
      ),
    );
  }
}
