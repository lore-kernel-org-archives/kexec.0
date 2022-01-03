From: Petr Mladek <pmladek@suse.com>
Date: Mon, 3 Jan 2022 15:58:47 +0100
Subject: [PATCH] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20211230161828.121858-1-gpiccoli@igalia.com>
References: <20211230161828.121858-1-gpiccoli@igalia.com>
Message-ID: <YdMPJwkfcjRA48sM@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu 2021-12-30 13:18:28, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is a pretty interesting debug mechanism, but currently the print
> event happens *after* kmsg_dump(), meaning that Pstore, for example,
> cannot collect a dmesg with the panic_print information.

I see the point. Unfortunately, there is some risk in this change
so I have to ask:

Did you miss this behavior in practice?
Or does it just look like something that might be useful?


> This patch changes that by moving the panic_print_sys_info() function
> call up some lines, in order kmsg_dump() accounts this new information
> and exposes it through Pstore or other kmsg dumpers.

Note that panic_print_sys_info() might produce a lot of lines. There is
non-trivial chance that a lot of information might get lost because
of the limited log buffer size.

It might cause regression even when no dumpers are registered and
crash kernel is not loaded. panic_print_sys_info() might overwrite
the existing messages before we try hard to flush them via
console_flush_on_panic().


> Cc: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> Hey folks, thanks in advance for reviews/comments!
> One alternative I've considered was to move kmsg_dump() some
> lines down, I'm not sure which approach is better, can't see
> much difference. Opinions are very welcome =)

This does not look like a good idea either. The comment below
kmsg_dump(KMSG_DUMP_PANIC) says that it should be called
before crash_kexec() that might fail.


IMHO, the best solution would be to allow dumping messages produced
by panic_print_sys_info() using the registered dumpers directly.
But it might require redesigning the kmsg_dump API.


After all, the proposed patch might be good enough.
panic_print_sys_info() does nothing by default.
It might be enough to document that a large enough log buffer
should be used when some output is enabled, especially when
a dumper is used.

Also we should mention these pitfalls and risks in the commit
message.

Best Regards,
Petr

