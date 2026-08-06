# homebrew-eqbase

Homebrew tap for [EQBase](https://eqbase.app), a system-wide equalizer, volume control and audio
router for macOS.

## Install

```sh
brew install --cask tahabozdemir/eqbase/eqbase
```

Or tap first, then install by name:

```sh
brew tap tahabozdemir/eqbase
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
