# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Sapphire Moonlight** is a VS Code color theme extension focused on accessibility and readability (formerly "A11y Sapphire Moon"; the `a11y` framing now lives in the package keywords/description rather than the name). It provides a high-contrast dark theme ("Sapphire Moonlight") with signature sapphire cyan for functions (`#3ed4d4` text; vivid `#00e0e0` kept on the status bar) and golden-yellow (`#e8c44e`) for types. Syntax colors are deliberately kept at moderate chroma to avoid halation/eye strain on the dark background.

## Architecture

This is a theme-only VS Code extension — no TypeScript/JavaScript code, no build step, no tests.

- `themes/Sapphire Moonlight-color-theme.json` — The main theme definition (UI colors + token colors)
- `test-samples/` — Sample files (JS, TS, Python, Go, Ruby, PHP, HTML, CSS, JSON, Markdown, YAML, Shell, Rust, SQL) for visually testing the theme
- `package.json` — Extension manifest; registers the theme under `contributes.themes`

## Development

**Preview the theme:** Press F5 in VS Code (uses `.vscode/launch.json`) to open an Extension Development Host window with the theme applied and test-samples loaded.

**Package for distribution:**
```
npx @vscode/vsce package
```

## Key Color Palette

| Token          | Color     |
|----------------|-----------|
| Functions      | `#3ed4d4` (sapphire cyan; also tags & MD headings) — status bar keeps vivid `#00e0e0` |
| Types/Classes  | `#e8c44e` (muted gold) |
| Comments       | `#4c9474` italic (subdued green, AA floor) |
| Keywords       | `#dcc6e0` (lavender) |
| Variables      | `#b09ffa` (soft purple) |
| Strings/Operators | `#9fc15e` (muted lime) |
| Parameters     | `#5fa8e8` (sky blue) — distinct from types/gold, color-blind safe vs lime |
| Accents (this/self, regex, blockquote, invalid) | `#ffa07a` (light salmon) |
| Numbers/Literals | `#cf609f` (rose) — numbers + `true`/`false`/`null` |
| Background     | `#1b1e23` |
| Foreground     | `#f8f8f2` |

## Notes

- When modifying token colors, verify against all sample files in `test-samples/` using the Extension Development Host
- The `.vscodeignore` excludes `.vscode/`, `.vscode-test/`, `.gitignore`, and `vsc-extension-quickstart.md` from the packaged extension
- やり取りは日本語でお願いします

- 色に関して変更があった場合README.mdと本ファイルの両方を更新してください