From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 4 Jan 2022 09:35:42 -0300
Subject: [PATCH] panic: Move panic_print before kmsg dumpers
In-Reply-To: <YdQzU0KkAVq2BWpk@alley>
References: <20211230161828.121858-1-gpiccoli@igalia.com>
 <YdMPJwkfcjRA48sM@alley> <315d9a0b-2494-5d3d-e228-7c957f7c5e4a@igalia.com>
 <YdQzU0KkAVq2BWpk@alley>
Message-ID: <4c3b3e5c-f037-8103-d10d-bd665316d426@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Petr, thanks again for the very comprehensive response.
Comments inline below:


On 04/01/2022 08:45, Petr Mladek wrote:
>[...] 
> To make it clear. panic_printk_sys_info() might overwrite the oldest
> messages stored on the log buffer. This patch moves
> panic_print_sys_info() before kmsg_dump(). It means that even
> kmsg_dump() would not see the overwritten oldest messages.

Oh sure, I understand that, and that's fine - we can increase a lot the
size of the log buffer through "log_buf_len" (and it's OK to lose some
early entries in our case).
My first understanding of your message was that "panic_print_sys_info"
could "eat" recent messages in the log buffer due to the lack of flush -
and that would be potentially bad.


> 
> Good question. I am familiar only with the console problems and there
> are many problems. Serial consoles might be slow. All consoles use
> internal locks that might cause deadlocks. More complicated consoles
> are even more risky.
> 
> My experience is that kexec mostly works when there is enough reserved
> space for booting the crash kernel. And it can be tested before
> the crash.
> 
> So, I personally think that console_flush_on_panic() is more risky
> and should not get called before kexec().
> 
> Also kexec might be simply disabled when it does not work. But
> console_flush_on_panic() could not be disabled if we call it
> too early. We might make it configurable. But it would be
> to complicated for users to get it right.

OK, got it! So let's not mess with the flush machinery, seems a bit
dangerous...


> 
> I think that this is the best solution after all.
> 
> Well, I see one more problem. CONSOLE_REPLAY_ALL replays all messages
> on the console. This flag should be handled when it is now. I mean
> after kmsg_dump(), kexec(), console_flush_on_panic().
> 
> It is pity that PANIC_PRINT_ALL_PRINTK_MSG is in "panic_print" flags.
> It makes sense only for consoles. All the other flags make sense
> also for kmsg_dump().
> 
> A solution would be to add a new kernel parameter that would
> obsolete PANIC_PRINT_ALL_PRINTK_MSG. The parameter can be
> called panic_console_replay or so.
> 

Hmm..makes sense. I've thought a bit about this option, it's kinda odd
compared to "print memory status, print tasks"...it would fit into
another parameter, as you proposed (and I'd be happy to do it as part of
this series). But..with that said, I understand we have quite a big
number of parameters nowadays, and panic_print having this
"CONSOLE_REPLAY_ALL" is kind of a kernel API to userspace, so to avoid
any polemics (either due to "oh no, another parameter" or due to "can't
remove that, break userspace"), what if we split panic_print_sys_info
into an upper and lower parts? I can do that using a function parameter,
like this:

<...>
panic_print_sys_info(0);
kmsg_dump();
<... stuff ...>
panic_print_sys_info(1);

So, "panic_print_sys_info(1)" is the current call, like before this
patch - it would just do the "CONSOLE_REPLAY_ALL", whereas
"panic_print_sys_info(0)" do the rest, before the kmsg dumpers. What do
you think?

If you prefer the new kernel parameter than my idea, I'm all for that as
well - it's your choice.

Thanks again for the good discussion.
Cheers,


Guilherme

