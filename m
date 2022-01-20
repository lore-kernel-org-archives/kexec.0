From: Petr Mladek <pmladek@suse.com>
Date: Thu, 20 Jan 2022 10:39:08 +0100
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com>
Message-ID: <YektvNyN6mAHv9jJ@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed 2022-01-19 13:03:15, Guilherme G. Piccoli wrote:
> Thanks again Petr, for the deep analysis! Much appreciated.
> Some comments inline below:
> 
> 
> On 19/01/2022 12:48, Petr Mladek wrote:
> >[...]
> > From my POV, the function of panic notifiers is not well defined. They
> > do various things, for example:
> > [...] 
> > 
> > The do more that just providing information. Some are risky. It is not
> > easy to disable a particular one.
> 
> We are trying to change that here:
> https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli at igalia.com/
> 
> Your review/comments are very welcome =)
> 
> 
> > [...] 
> > It might make sense to allow to call kmsg_dump before panic notifiers
> > to reduce the risk of a breakage. But I do not have enough experience
> > with them to judge this.
> > 
> > I can't remember any bug report in this code. I guess that only
> > few people use kmsg_dump.
> 
> One of the problems doing that is that RCU and hung task detector, for
> example, have panic notifiers to disable themselves in the panic
> scenario - if we kmsg_dump() _before_ the panic notifiers, we may have
> intermixed messages, all messy...so for me it makes sense to keep the
> kmsg_dump() after panic notifiers.

It makes perfect sense to disable the watchdogs during panic().
For example, rcu_panic() just sets a variable:

static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
{
	rcu_cpu_stall_suppress = 1;
	return NOTIFY_DONE;
}

It is quick and super-safe. It might make sense to implement similar
thing for other watchdogs and do something like:

void panic_supress_watchdogs(void)
{
	rcu_panic();
	softlockup_watchog_panic();
	wq_watchog_panic();
}

It might be caller early in panic().

> 
> > [...]
> > Yes, panic_print_sys_info() increases the risk that the crash dump
> > will not succeed. But the change makes sense because:
> > 
> >   + panic_print_sys_info() might be useful even with full crash dump.
> >     For example, ftrace messages are not easy to read from the memory
> >     dump.
> 
> The last point is really good, I didn't consider that before but makes a
> lot of sense - we can now dump (a hopefully small!) ftrace/event trace
> buffer to dmesg before a kdump, making it pretty easy to read that later.
> Cheers,

JFYI, there is an extension for the crash tool that might be able to read
the trace log, see https://crash-utility.github.io/extensions.html

I haven't tested it myself yet.

Best Regards,
Petr

