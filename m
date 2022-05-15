From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Sun, 15 May 2022 19:12:55 -0300
Subject: [PATCH 11/30] um: Improve panic notifiers consistency and ordering
In-Reply-To: <1760d499824f9ef053af7a8dac04b48ab7d7fd3d.camel@sipsolutions.net>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-12-gpiccoli@igalia.com> <Ynp2hRodh04K3pzK@alley>
 <4b003501-f5c3-cd66-d222-88d98c93e141@igalia.com>
 <1760d499824f9ef053af7a8dac04b48ab7d7fd3d.camel@sipsolutions.net>
Message-ID: <178a456d-3961-9bc2-83d2-2b9457d45fbd@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 13/05/2022 11:44, Johannes Berg wrote:
> [...]
>> Maybe Anton / Johannes / Richard could give their opinions - appreciate
>> that, I'm not attached to the priority here, it's more about users'
>> common usage of UML I can think of...
> 
> It's hard to say ... In a sense I'm not sure it matters?
> 
> OTOH something like the ftrace dump notifier (kernel/trace/trace.c)
> might still be useful to run before the mconsole and coredump ones, even
> if you could probably use gdb to figure out the information.
> 
> Personally, I don't have a scenario where I'd care about the trace
> buffers though, and most of the others I found would seem irrelevant
> (drivers that aren't even compiled, hung tasks won't really happen since
> we exit immediately, and similar.)
> 
> johannes

Thanks Johannes, I agree with you.

We don't have great ordering now, one thing we need to enforce is the
order between the 2 UML notifiers, and this patch is doing that..trying
to order against other callbacks like the ftrace dumper is messy in the
current code.

OTOH if this patch set is accepted at some point, we'll likely have 3
lists, and with that we can improve ordering a lot - this notifier for
instance would run in the pre-reboot list, *after* the ftrace dumper (if
a kmsg dumper is set).

So, my intention is to keep this patch as is for V2 (with some changes
Johannes suggested before), unless Petr or the other maintainers want
something different.
Cheers,


Guilherme

