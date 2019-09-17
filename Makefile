DEBUG ?= 1
ifeq ($(DEBUG), 1)
    BUILD_CONFIG := Debug 
else
    BUILD_CONFIG := Release
endif

TARGET_STRIP := strip

NOVUS_APP_DIR := ./.build/complete/Applications/Novus.app

VERSION := $$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" ./.build/install/Applications/Novus.app/Contents/Info.plist)

export EXPANDED_CODE_SIGN_IDENTITY :=
export EXPANDED_CODE_SIGN_IDENTITY_NAME :=

all:: $(NOVUS_APP_DIR) redchain/bin/redchain

$(NOVUS_APP_DIR):
	set -o pipefail; \
		xcodebuild -project 'Novus.xcodeproj' -scheme 'Novus' -configuration $(BUILD_CONFIG) -arch x86_64 -derivedDataPath './.build' \
		build install \
		CODE_SIGNING_ALLOWED=NO PRODUCT_BUNDLE_IDENTIFIER="org.polarteam.Novus" \
		DSTROOT=./.build/complete
	$(ECHO_NOTHING)function process_exec { \
		$(TARGET_STRIP) $$1; \
	}; \
	function process_bundle { \
		process_exec $$1/Contents/MacOS/$$(/usr/libexec/PlistBuddy -c "Print :CFBundleExecutable" $$1/Contents/Info.plist); \
	}; \
	export -f process_exec process_bundle; \
	find $(NOVUS_APP_DIR) -name '*.dylib' -print0 | xargs -I{} -0 bash -c 'process_exec "$$@"' _ {}; \
	find $(NOVUS_APP_DIR) \( -name '*.framework' -or -name '*.appex' \) -print0 | xargs -I{} -0 bash -c 'process_bundle "$$@"' _ {}; \
	process_bundle $(NOVUS_APP_DIR)$(ECHO_END)

redchain/bin/redchain: redchain/redchain.c
	$(MAKE) -C ./redchain

clean::
	rm -rf ./.build
	$(MAKE) -C ./redchain clean

package:: $(NOVUS_APP_DIR) redchain/bin/redchain
	fakeroot rm -rf ./.build/install
	mkdir -p ./.build/install/Applications
	cp -a ./.build/complete/Applications/Novus.app ./.build/install/Applications
	cp redchain/bin/redchain ./.build/install/Applications/Novus.app/Contents/MacOS
	fakeroot chmod 4755 ./.build/install/Applications/Novus.app/Contents/MacOS/redchain
	rm -f ./.build/install/Applications/Novus.app/Contents/PkgInfo
	gsed -e "s@^\(Version:\).*@\1 $(VERSION)@" Novus.control > ./.build/control
	echo "Installed-Size: $$(du -sk "./.build/install" | cut -f 1)" >> ./.build/control
	mkdir -p ./.build/install/DEBIAN
	mv ./.build/control ./.build/install/DEBIAN
	find ./.build/install -name '.DS_Store' -type f -delete
	fakeroot chown -R 0 ./.build/install
	fakeroot chgrp -R 0 ./.build/install
	mkdir -p ./products
	fakeroot dpkg-deb -b ./.build/install ./products/novusgui_$(VERSION)_darwin-amd64.deb

install:: package
	sudo dpkg -i ./products/novusgui_$(VERSION)_darwin-amd64.deb

.PHONY: all clean $(NOVUS_APP_DIR)