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

## First launch

EQBase sets itself up without installing a driver and without an administrator password. It asks
for one permission, System Audio Recording, which is how macOS classes reading the sound your Mac
plays. Two optional features (Audiophile mode and Pro audio routing) do use a small user-space
Core Audio driver, and the app offers to install it at the moment you turn one of them on.

## Uninstall

```sh
brew uninstall --cask eqbase
```

If you ever turned on a feature that installed the driver, this also removes the HAL plug-in at
`/Library/Audio/Plug-Ins/HAL/EQBaseDriver.driver` (sudo is requested for that step) and restarts
`coreaudiod` so the virtual device disappears. To remove presets, settings and caches as well:

```sh
brew uninstall --zap --cask eqbase
```

## Notes

The download is the same notarized, Developer ID-signed DMG the site serves, fetched from
`dl.eqbase.app` at its versioned URL so the pinned checksum stays valid. Requires macOS 14
(Sonoma) or later; universal (Apple Silicon and Intel).
