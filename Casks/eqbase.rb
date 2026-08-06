cask "eqbase" do
  version "1.0.4"
  sha256 "059ebfca8d58f83b7b359ef7f1d99e74e98bbff6fc2c464b15a0f6960c2ffa34"

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
  depends_on macos: :sonoma

  app "EQBase.app"

  # EQBase installs a HAL plug-in (the virtual audio device) and a privileged
  # helper daemon that performs that install. Both are removed here; the driver
  # lives outside the app bundle, so its removal needs sudo, and coreaudiod has
  # to be restarted for the virtual device to disappear from the audio list.
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
