# Use `task.wait` instead!

# BetterWait

For those, who want to test this out and figure out what it's good with, here's some things:

* Friendlier to task scheduler, therefore more wait calls don't hurt *as much.*
* Same results as a loop with `Heartbeat:Wait` and checking time using DeltaTime.
* Behaves in the same order as a loop with `Heartbeat:Wait`.
* Uses a doubly-linked list, *that's what I think the name for it is :)*
* Pretty well optimized;
