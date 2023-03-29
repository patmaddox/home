# ~patmaddox

In the past, I've created [lots of repos on GitHub](https://github.com/patmaddox?tab=repositories&q=&type=source&language=&sort=).
I have hundreds - possibly thousands - of little repos and experiments that I've never pushed, all sitting on my computer.
I have no idea how many times I've run `mktemp -d` to try something out.
They're not all worth keeping, and certainly not all worth sharing.
But, I find it harder and harder to locate code ideas.
They're spread all over the place.

This is my monorepo.

## Primary Purpose

Iterate my way to a personal computing setup that I love, and that grows with my needs and wants.

## Other considerations

Working with this repo feels a bit like [Jerry Weinberg's Fieldstone Method](https://geraldmweinberg.com/Site/On_Writing.html), applied to code.
I start things in `experiments/`, and grow them as I see fit.
When I've built up something solid, I can incocorporate it into my over all system.

This repo is my home dir on a FreeBSD system.
I had considered trying to make it portable with MacOS.
I ended up getting a FreeBSD laptop instead, and I'm happier for it.

## TODO

- [ ] _Add a project prefix git commit hook._
  With a monorepo, most commit messages end up looking something like "component: the commit message".
  I can type them in, but I might forget.
  I'd like to define a file (e.g. `.project`) that automatically provides a prefix for the commit message.
- [ ] _Set emacs starting state_. Full screen, with the font size I like (might be different per machine)
