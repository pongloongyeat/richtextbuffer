/*
 * Copyright 2021 Pong Loong Yeat (https://github.com/pongloongyeat/richtextview)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 */

public class Demo.Application : Gtk.Application {

    public Application () {
        Object (
            application_id: "com.github.pongloongyeat.elementary-template-app",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        var window = new Gtk.ApplicationWindow (this) {
            title = "RichTextView Demo",
            resizable = false
        };
        window.set_default_size (480, 320);

        var richtextbuff = new Widgets.RichTextBuffer () {
            text = "Hello world! This should be highlighted. Type more 'This' keywords below\u2026"
        };

        var tag = richtextbuff.create_tag ("highlight", "background", "orange", null);
        var regex = new GLib.Regex ("this", GLib.RegexCompileFlags.CASELESS);
        richtextbuff.add_tag_with_regex (tag, regex);
        richtextbuff.init ();

        window.add (new Gtk.TextView.with_buffer (richtextbuff));

		window.show_all ();
    }



    public static int main (string[] args) {
        return new Application ().run (args);
    }
}
