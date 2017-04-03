GO_EASY_ON_ME = 1
DEBUG = 0
ARCHS = armv7 armv7s arm64
PACKAGE_VERSION = 1.0.0
SDKVERSION = 10.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = QuickNowPlaying
QuickNowPlaying_FILES = Tweak.xm
QuickNowPlaying_LIBRARIES = substrate activator
QuickNowPlaying_PRIVATE_FRAMEWORKS = MediaRemote


include $(THEOS_MAKE_PATH)/tweak.mk