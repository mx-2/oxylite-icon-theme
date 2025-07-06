If you like to help improving oxylite icons please create a pull request.
Please note that contributed graphics may (and probably will) be modified,
reused or even deleted later.

Contributed icons shall follow the following styleguide:

- Icons use skeuomorphic design and fit into the style of this theme.
- Icons are in SVG format and do not embed pixel graphics.
- Icons shall have a reasonable amount of details, i.e. there are
  no barely visible details in them when viewed fullscreen.
- One icon file shall fit all view sizes, from taskbar to fullscreen view.

The following checklist helps you to create a good pull request:

- Use one commit per icon, including its license.
- New icons are added to licenses.yml in alphabetic order.
- New icons are compatible to GPLv3-or-later.
  As an exception, derived icons may be GPLv3-only.
- Combine existing icons where possible and reasonable.
- Use symlinks to reuse icons under different names.
- Symlinks can be grouped into one commit.
- SVG `use` elements are used for repeating icon components.
- The branch is rebased onto latest upstream/master.
- All symlinks point to the original file not to other symlinks.
  The script `check_symlinks.sh` checks this automatically.
- SVGs are minified through [svgcleaner](https://github.com/RazrFalcon/svgcleaner)
  with the `cleansvg.sh` script.
