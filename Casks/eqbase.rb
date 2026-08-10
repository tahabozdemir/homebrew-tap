cask "eqbase" do
  version "1.2.0"
  sha256 "993e35572c1d0accfc2777cef3cb0c97d06293a71b37a8e20d602fbbcdac4f08"

  # The VERSIONED artifact on the download host. Not dl.eqbase.app/EQBase.dmg: that alias is
  # rewritten on every release and its checksum would go stale the moment the next one ships.
  # Not updates.eqbase.app either, even though it serves the same file: that host is the update
  # feed, so a cask install would be booked as an existing user updating rather than a new one.
  url "https://dl.eqbase.app/EQBase-#{version}.dmg"
  name "EQBase"
  desc "System-wide equalizer, volume control and audio router"
  homepage "https://eqbase.app/"

  # The appcast carries both the marketing version and the Sparkle build number;
  # track the marketing version only, since that is what the DMG filename uses.
  livecheck do
    url "https://updates.eqbase.app/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  # The app's REAL floor is macOS 14.4 (LSMinimumSystemVersion, and sparkle:minimumSystemVersion
  # on the appcast): EQBase captures through a Core Audio process tap, which needs 14.2, and taps
  # were unreliable before 14.4. Homebrew cannot express that. A cask floor may only name a major
  # release: `depends_on macos: "14.4"` is rejected outright ("unknown or unsupported macOS
  # version"), and the `">= :sonoma"` string form is deprecated with no replacement. So this stays
  # the bare symbol, which already means ">= 14", and 14.0-14.3 is covered by macOS itself
  # refusing to launch the app rather than by brew refusing to install it. Do not "fix" this to a
  # point release; verify any change with `brew ruby` before trusting `brew style`, which passes
  # a value Homebrew rejects at load time.
  depends_on macos: :sonoma

  app "EQBase.app"

  # A normal EQBase setup installs nothing outside the app bundle: it reads the system mix
  # through a Core Audio process tap. But turning on Audiophile mode or Pro audio routing
  # installs a HAL plug-in (the virtual audio device) plus a privileged helper daemon that
  # performs that install, so uninstall has to clean both up whether or not this Mac ever did.
  # The driver lives outside the app bundle, so removing it needs sudo, and coreaudiod has to be
  # restarted for the virtual device to disappear from the audio list. Every step is
  # must_succeed-tolerant or a no-op on a Mac that never installed the driver.
  uninstall launchctl: "com.boldbiscuit.eqbase.helper",
            quit:      "com.boldbiscuit.eqbase",
            script:    {
              executable:   "/usr/bin/killall",
              args:         ["coreaudiod"],
              sudo:         true,
              must_succeed: false,
            },
            delete:    "/Library/Audio/Plug-Ins/HAL/EQBaseDriver.driver"

  zap trash: [
    "~/Library/Application Support/EQBase",
    "~/Library/Caches/com.boldbiscuit.eqbase",
    "~/Library/HTTPStorages/com.boldbiscuit.eqbase",
    "~/Library/Preferences/com.boldbiscuit.eqbase.plist",
    "~/Library/Saved Application State/com.boldbiscuit.eqbase.savedState",
  ]
end
