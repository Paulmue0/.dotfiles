# My Karabiner-Elements Keyboard Remaps

This file explains my main keyboard modifications in Karabiner-Elements.

***

### 1. Tab as a Hyper Key

The `Tab` key's function changes based on how you press it. This is the most complex modification and creates layers for shortcuts.

* **If you tap `Tab`:** It works like a normal `Tab` key.
* **If you hold `Tab`:** It becomes a "Hyper Key" that activates different shortcut layers, shown below.

This behaviour is adapted by [Henry Misc](https://www.youtube.com/@henrymisc)

#### **Hyper Key Layers**

**Base Layer (Hold `Tab`)**
This is the default layer when holding `Tab`. It's used for navigation and system control.

| Key | Action | Description |
| :-- | :--- | :--- |
| `h` | `←` | Left Arrow |
| `j` | `↓` | Down Arrow |
| `k` | `↑` | Up Arrow |
| `l` | `→` | Right Arrow |
| `,` | `Ctrl` + `←` | Move cursor one word left |
| `.` | `Ctrl` + `→` | Move cursor one word right |
| `m` | `Ctrl` + `↑` | Mission Control |
| `1`-`9`| `Ctrl` + `1-9`| Switch to Desktop 1-9 |

**App Launcher Layer (Hold `Tab`, then hold `e`)**
This layer opens your most-used applications.

| Key | Application |
| :-- | :--- |
| `h` | Finder |
| `j` | Firefox Developer Edition |
| `k` | Ghostty (Terminal) |
| `l` | Firefox |
| `i` | Calendar |
| `u` | Outlook |
| `m` | Slack |
| `n` | Spotify |
| `o` | Preview |
| `,` | VSCodium |
| `.` | Affinity Photo 2 |
| `y` | Final Cut Pro |

**Window Management Layer (Hold `Tab`, then hold `w`)**
This layer controls window positions. **Note:** The [Rectangle App](https://rectangleapp.com/) must be installed for this to work.

| Key | Action | Key | Action |
| :-- | :--- | :-- | :--- |
| `h` | Left Half | `y` | First Third |
| `l` | Right Half | `o` | Last Third |
| `j` | Center Half | `u` | First Fourth |
| `k` | Custom Shortcut¹ | `i` | Last Fourth |
| `return` | Maximize | `m` | First Two Thirds |
| `space`| Almost Maximize| `,` | Last Two Thirds |
| `p` | Next Window | `=` | Make Larger |
| `n` | First Three Fourths | `-` | Make Smaller |
| `.` | Last Three Fourths | | |
¹Triggers the custom Rectangle shortcut `⌃⌥⇧⌘+N`.

***

### 2. Caps Lock Remap

The `Caps Lock` key is changed to be more useful for programming and general use.

* **If you tap `Caps Lock`:** It acts as the `Escape` key.
* **If you hold `Caps Lock` with another key:** It acts as the `Left Control` key.

***

### 3. German Programming Shortcuts 🇩🇪

These shortcuts make it easier to type common programming symbols on a German (QWERTZ) keyboard.

| To Type This Symbol | Press This Combination |
| :---: | :--- |
| `[` | `Left ⌘` + `ö` |
| `]` | `Left ⌘` + `ä` |
| `{` | `Left ⌃` + `ö` |
| `}` | `Left ⌃` + `ä` |
| `~` | `Left ⌃` + `ü` |
