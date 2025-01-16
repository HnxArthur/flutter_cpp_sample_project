# Makefile for building C/C++ shared libraries for all platforms

# Directories
SRC_DIR = .
BUILD_DIR = build
FLUTTER_APP_DIR = ../flutter_app

# Compilers
CC_LINUX = gcc
CC_MACOS = gcc
CC_WINDOWS = x86_64-w64-mingw32-gcc
CC_ANDROID = ${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang
CC_IOS = clang

# Android ABIs
ANDROID_ABIS = arm64-v8a armeabi-v7a x86_64

# Targets
all: linux macos windows android ios

# Linux
linux:
	mkdir -p $(BUILD_DIR)/linux
	$(CC_LINUX) -shared -o $(BUILD_DIR)/linux/libnative_add.so -fPIC $(SRC_DIR)/native_add.c
	cp $(BUILD_DIR)/linux/libnative_add.so $(FLUTTER_APP_DIR)/linux/

# macOS
macos:
	mkdir -p $(BUILD_DIR)/macos
	$(CC_MACOS) -shared -o $(BUILD_DIR)/macos/libnative_add.dylib -fPIC $(SRC_DIR)/native_add.c
	cp $(BUILD_DIR)/macos/libnative_add.dylib $(FLUTTER_APP_DIR)/macos/Frameworks/

# Windows
windows:
	mkdir -p $(BUILD_DIR)/windows
	$(CC_WINDOWS) -shared -o $(BUILD_DIR)/windows/native_add.dll -Wl,--out-implib,$(BUILD_DIR)/windows/libnative_add.a $(SRC_DIR)/native_add.c
	cp $(BUILD_DIR)/windows/native_add.dll $(FLUTTER_APP_DIR)/windows/

# Android
android:
	$(foreach abi,$(ANDROID_ABIS), \
		mkdir -p $(BUILD_DIR)/android/$(abi); \
		$(CC_ANDROID) -shared -o $(BUILD_DIR)/android/$(abi)/libnative_add.so -fPIC $(SRC_DIR)/native_add.c; \
		cp $(BUILD_DIR)/android/$(abi)/libnative_add.so $(FLUTTER_APP_DIR)/android/app/src/main/jniLibs/$(abi)/; \
	)

# iOS
ios:
	mkdir -p $(BUILD_DIR)/ios
	$(CC_IOS) -shared -o $(BUILD_DIR)/ios/libnative_add.dylib -fPIC $(SRC_DIR)/native_add.c
	cp $(BUILD_DIR)/ios/libnative_add.dylib $(FLUTTER_APP_DIR)/ios/Runner/Frameworks/

clean:
	rm -rf $(BUILD_DIR)