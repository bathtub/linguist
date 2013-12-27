#Tongue
###The Everyman's Linguist, or, The Abandonment of the Blob.
Github's [```linguist```](https://github.com/github/linguist) is an impressive piece of software. It's what drives all the automated source code classification and syntax highlighting you see on this site; it is also rather narrowly tailored to the particular needs here. In particular, the blob 'helper' is a quite, um, curious, thing, and its _slow_ — probably because it hoists [libmagic](http://darwinsys.com/file) **and** the entire [ICU library](http://icu-project.org) (appx. 30 MiB of data-rich libraries) into memory from a binary module each time it is invoked. It also is prone to encoding errors, and while it's easy enough to monkeypatch, it can get rather bogged down. The blob helper is also used to exclude 'vendored files' — files which might be added to a repo as dependencies, but are not intrinsic to a project — as well as any files which can't readily be pygmentized in one fell swoop,  making it somewhat limited in its utility as a general purpose classifier.

In this incarnation — maybe the start of something bigger, we'll see — the blob is no longer. _All_ files are read in and encoded as UTF-8, skipping spurious characters and sequences if the file is converted from another valid text encoding. If the text encoding was successful (as it should be, if it was any type of text to begin with), the very possibility of a bad string being parsed is eliminated; and if the encoding isn't successful, we just exclude it. This works since Ruby's econv is pretty efficient and any binary/opaque files read in will either be improperly encoded, or just gibberish. It eliminates the need to use an external tool, resulting is a significant improvement in speed. Note that adopting this method necessarily breaks support of Ruby 1.8, since econv is quintessentially Ruby 1.9+ (and 1.8 will do terrible things if it winds up being forced to use regex on a binary).

At the moment this is pretty quick and dirty, a mockup of the approach — the blob code remains, but its related functions have all been set to return ```true``` (that is, that the file is indeed readable), since anything being handed to the parser is already converted to valid UTF-8. The former dependencies have just been commented out. But it works quite well on the command line, actually, and is quite noticeably faster.

I'm planning to further cut this down to size, and add some additional, more general purpose functionality; check back in a couple of weeks if you've stumbled upon this at this early venture. It might be a neat thing.


On a side note, while its not presently suitable as a drop in for ```linguist``` (as it is currently used on this site) it well could be if one were to separate out the work being done presently in the blob 'helper' into separate functions, i.e.:

  - what is this (ie, what's being done here)  
      and then
  - should I pygmentize this?  
      or
  - should this be counted towards the "project language" (vendored files)?

... an approach that I think might be a more effective methodology in any case.

Onward.
