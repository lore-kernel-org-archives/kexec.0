From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 13 May 2022 16:44:36 +0200
Subject: [PATCH 11/30] um: Improve panic notifiers consistency and ordering
In-Reply-To: <4b003501-f5c3-cd66-d222-88d98c93e141@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-12-gpiccoli@igalia.com> <Ynp2hRodh04K3pzK@alley>
 <4b003501-f5c3-cd66-d222-88d98c93e141@igalia.com>
Message-ID: <1760d499824f9ef053af7a8dac04b48ab7d7fd3d.camel@sipsolutions.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 2022-05-11 at 17:22 -0300, Guilherme G. Piccoli wrote:
> On 10/05/2022 11:28, Petr Mladek wrote:
> > [...]
> > It is not clear to me why user mode linux should not care about
> > the other notifiers. It might be because I do not know much
> > about the user mode linux.
> > 
> > Is the because they always create core dump or are never running
> > in a hypervisor or ...?
> > 
> > AFAIK, the notifiers do many different things. For example, there
> > is a notifier that disables RCU watchdog, print some extra
> > information. Why none of them make sense here?
> > 
> 
> Hi Petr, my understanding is that UML is a form of running Linux as a
> regular userspace process for testing purposes.

Correct.

> With that said, as soon
> as we exit in the error path, less "pollution" would happen, so users
> can use GDB to debug the core dump for example.
> 
> In later patches of this series (when we split the panic notifiers in 3
> lists) these UML notifiers run in the pre-reboot list, so they run after
> the informational notifiers for example (in the default level).
> But without the list split we cannot order properly, so my gut feeling
> is that makes sense to run them rather earlier than later in the panic
> process...
> 
> Maybe Anton / Johannes / Richard could give their opinions - appreciate
> that, I'm not attached to the priority here, it's more about users'
> common usage of UML I can think of...

It's hard to say ... In a sense I'm not sure it matters?

OTOH something like the ftrace dump notifier (kernel/trace/trace.c)
might still be useful to run before the mconsole and coredump ones, even
if you could probably use gdb to figure out the information.

Personally, I don't have a scenario where I'd care about the trace
buffers though, and most of the others I found would seem irrelevant
(drivers that aren't even compiled, hung tasks won't really happen since
we exit immediately, and similar.)

johannes

