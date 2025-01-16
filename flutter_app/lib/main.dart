import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef NativeAdd = Int32 Function(Int32 a, Int32 b);

DynamicLibrary _loadNativeLibrary() {
  if (Platform.isLinux) {
    return DynamicLibrary.open('libnative_add.so');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('libnative_add.dylib');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('native_add.dll');
  } else if (Platform.isAndroid) {
    final abi = Platform.version.contains('arm64-v8a')
        ? 'arm64-v8a'
        : Platform.version.contains('armeabi-v7a')
            ? 'armeabi-v7a'
            : 'x86_64';
    return DynamicLibrary.open('lib/$abi/libnative_add.so');
  } else if (Platform.isIOS) {
    return DynamicLibrary.open('Frameworks/libnative_add.dylib');
  }
  throw UnsupportedError('Platform not supported');
}

void main() {
  final dylib = _loadNativeLibrary();
  final add = dylib.lookupFunction<NativeAdd, NativeAdd>('add');

  final result = add(3, 5);
  print('Result: $result'); // Output: Result: 8
}
