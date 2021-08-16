# BetterWait

### For any work that depends on DeltaTime, something like UI or something like it, I recommend testing this out. Otherwise, you're fine with `task.wait`.

For those, who want to test this out and figure out what it's good with, here's some things:

* Friendlier to thread scheduler, therefore more wait calls don't hurt *as much.*
* Same results as a loop with `Stepped:Wait` and checking time using DeltaTime.
* Behaves in the same order as a loop with `Stepped:Wait`.
* Uses a doubly-linked list, *that's what I think the name for it is :)*
* Pretty well optimized;
