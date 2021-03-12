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

public class Demo.Widgets.RichTextBuffer : Gtk.TextBuffer {
    public GLib.List<RichTag?> tags;
    public struct RichTag {
        Gtk.TextTag tag;
        GLib.Regex regex;
    }

    construct {
        tags = new GLib.List<RichTag?> ();
    }

    public void add_tag_with_regex (Gtk.TextTag tag, GLib.Regex regex) {
        RichTag rich_tag = { tag, regex };

        /* TODO: Don't add duplicates
        Should I update the duplicated
        tag to the latest?
        */
        tags.append (rich_tag);

        changed.connect (init);
    }

    /* Apply all tags to existing text. Usually called at start when
    a TextBuffer already has text in it. */
    public void init () {
        foreach (RichTag rich_tag in tags) {
            GLib.MatchInfo match_info;
            Gtk.TextIter text_iter;

            get_start_iter (out text_iter);
            if (rich_tag.regex.match (text, 0, out match_info)) {
                do {
                    int start, end;
                    match_info.fetch_pos (0, out start, out end);
                    var tag_text = text.substring (start, end - start);

                    Gtk.TextIter start_iter, end_iter;
                    text_iter.forward_search (tag_text, Gtk.TextSearchFlags.TEXT_ONLY, out start_iter, out end_iter, null);

                    apply_tag (rich_tag.tag, start_iter, end_iter);
                    text_iter.forward_chars (tag_text.length);
                } while (match_info.next ());
            }
        }
    }
}
