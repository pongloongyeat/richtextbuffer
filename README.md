# RichTextBuffer

<!-- ![screenshot](data/screenshot.png?raw=true) -->

RichTextBuffer is a simple widget wrapped around `Gtk.TextBuffer`.
The purpose of this is to be able to easily create a rich
`Gtk.TextView` widget with string matching via regex to
apply tags as the end-user types.

## Feature list:
- [x] Some sort of method to add `GLib.Regex` with a `Gtk.TextTag`.
    - [ ] Event handler (i.e. for clickable links, etc.)
- [x] Store tags so they can be used when the text buffer changes.
- [ ] Dynamically add tags as the text buffer changes.
    - [ ] (Optimisation) Don't check the whole thing via regex, only do it during `init ()`.
    - [ ] Check if an existing tag/regex already exists.
- [ ] Some sane defaults? i.e. (h1–h6, bold, italic, underline, link, highlight)
- [ ] Tooltips. Useful for showing links (<kbd>CTRL</kbd>+<kbd>Left-click</kbd> to open link)

## Building

You'll need the following dependencies:

- libgranite-dev
- libgtk-3-dev
- meson
- valac

Run `meson build` to configure the build environment. Change to the build directory and run `ninja` to build

```bash
meson build --prefix=/usr
cd build
ninja
```

This creates an executable in the `build/` directory. Execute with

```bash
cd build
./com.github.pongloongyeat.richtextbuffer-demo
```
