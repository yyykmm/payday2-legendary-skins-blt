# PAYDAY 2 Legendary Skins BLT

A lightweight BLT mod that exposes legendary-skin entries in the local inventory UI without per-frame polling or bundled copyrighted assets.

## Scope

- Local/offline inventory presentation only.
- No online-service bypass, matchmaking manipulation, or asset redistribution.
- Legendary skin IDs are configured in `lib/LegendarySkinsManager.lua`.
- The hook runs once when the inventory manager is initialized; it does not use an `update()` loop.

## Install

1. Install SuperBLT.
2. Copy this repository folder to `PAYDAY 2/mods/LegendarySkinsBLT/`.
3. Edit the IDs in `lib/LegendarySkinsManager.lua` if your game build uses different definitions.
4. Start the game and check the local inventory UI.

## Compatibility

PAYDAY 2 builds and game/mod APIs can differ. This mod intentionally fails closed when an expected API is unavailable. Test offline first and keep backups of your save files.
