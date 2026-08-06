# homebrew-tap

Homebrew tap for [EQBase](https://eqbase.app), a system-wide equalizer, volume control and audio
router for macOS.

## Install

```sh
brew install --cask tahabozdemir/tap/eqbase
```

That single command taps this repo, trusts the cask and installs EQBase. Naming the cask in full
is what authorises it: Homebrew 6 will not load a cask from a third-party tap unless you either
trusted it beforehand or asked for it by its full `owner/tap/cask` name.

Afterwards the short name works for everything else (`brew upgrade --cask eqbase`,
`brew uninstall --cask eqbase`), since the trust is recorded. To tap first and install by short
name instead, trust the tap explicitly:

```sh
brew tap tahabozdemir/tap
brew trust tahabozdemir/tap
brew install --cask eqbase
```

## Upgrade

EQBase updates itself (Sparkle), so `auto_updates true` is set and `brew upgrade` normally has
nothing to do. To pull a new version through Homebrew anyway:

```sh
brew update && brew upgrade --cask eqbase
```

## Uninstall

```sh
brew uninstall --cask eqbase
```

This also removes the HAL driver at `/Library/Audio/Plug-Ins/HAL/EQBaseDriver.driver` (sudo is
requested for that step) and restarts `coreaudiod` so the virtual device disappears. To remove
presets, settings and caches as well:

```sh
brew uninstall --zap --cask eqbase
```

## Notes

The download is the same notarized, Developer ID-signed DMG served from
`updates.eqbase.app`, the artifact the app's own updater uses. Requires macOS 14 (Sonoma) or later;
universal (Apple Silicon and Intel).
