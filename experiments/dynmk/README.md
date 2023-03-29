# Dynamic Make

What I want: run `make` one time to produce files under `out/` and `out2/`.

What happens: I have to run `make` twice.
The first run produces `out/*`, and the second produces `out2/*`.

Why? As I understand it, make builds its targets statically in one pass.
The first time this runs, there is nothing in `out/`, so `NEWFILES != find out -type f` is empty.

Is there a way to add targets after another target runs, or as part of a run?
I don't want to evaluate the `out2/*` targets until after `out/*` has completed.

I have tried "recursive make" where I define a target like:

```make
all:
	make out
	make out2
```

The problem I've found with that is that stderr doesn't seem to be redirected properly.
Any stderr from `make out2` is printed on stdout on the top-level make.

I would like to do this with a single non-recursive make target if possible.
It may not be possible though.
