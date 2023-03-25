+++
title = "Ideas"
date = 2023-03-24
+++

## just: add porcelain to your plumbing

I'm sensing a good way to work with just.
Write scripts, add them to bin directory.
Call them from just.

It may seem like overkill at first.
It adds consistency to the project.
I can go into any folder and type `just`.
It will print out the main commands I need to know.
I don't need a README just to get going.

Comes from the git idea of plumbing and porcelain.

## Thinkpad E495

I really like it so far.
The only thing I don't like is the screen isn't bright enough for me.
I don't know if that's a limitation of the screen, or if FreeBSD isn't configured correctly.
I believe I have it at 100% brightness, and it's just a tad dim.
Everything else works great so far though, so I will most likely keep it.
I wonder if it's possible to get a new panel?
Also I need to figure out how to disable / soften the beep.
It's loud and stupid.

It's been a couple days now, and it's working great.
Mostly.
It does appear that the battery drained 10% while in hibernate mode for the day, which seems like a lot.
The keyboard is pretty clackey... I kind of like it, but I could see how it could get annoying.

It's still just not quite bright enough.
I've ordered an X1 Carbon Gen 9, which is more powerful, and brighter.
The tradeoff there is that it doesn't have an ethernet port, so I will always need a USB dongle.

The E495 is super quiet.
I never the fan when browsing.
I've heard it lightly when building the kernel.

## git commit prefix

The FreeBSD monorepos use a prefix to indicate which subsystem a commit refers to.
I've been doing the same thing with my monorepo.
I wonder if I could script it?

## auto-shutdown package

I want to have a beefy build server in the cloud.
I don't want to pay for it all the time, only when it's building.
I don't want to accidentally leave it running.
Create a cron job that checks to see if poudriere has been active for some period of time, and shuts down otherwise.
Maybe I could even just have an instance that runs via Cirrus, but attaches the poudriere disk.