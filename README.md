Object Completion
=================

This Vim extension provides insert-mode commands for completing certain types
of objects.

It can complete the following pairs, based on previous occurences in the same
buffer: ``()``, ``{}``, ``''``, ``""``.

It seems to work reasonably well, but I would consider it an experiment at this
point.

The commands are:
- Ctrl+X 0 for completing ``()``
- Ctrl+X [ for completing ``{}``
- Ctrl+X ' for completing ``''`` or ``""``

Again, it only completes from the current buffer. I would love to have it pull
from all open buffers the way Ctrl-X Ctrl-L and Ctrl-N do, but I think that
would be a performance concern. The parsing is currently done using Vim regexs.

The other major limitation is that it currently gets confused by nested ``()``
and ``{}``, and strings containing escaped quotes. These do not prevent the
completion from working. Nested pairs will result in truncated completions
(only for the pair that was nested, it doesn't affect other completion
options). Escaped quotes sometime result in the text in between two strings
being interpreted as a string, which can sometimes cause performance problems.
