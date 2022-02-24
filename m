From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Thu, 24 Feb 2022 11:52:46 +0900
Subject: [PATCH V6] panic: Move panic_print before kmsg dumpers
In-Reply-To: <5eeba935-d73a-5539-4eb1-298fb6ee0578@igalia.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
 <5eeba935-d73a-5539-4eb1-298fb6ee0578@igalia.com>
Message-ID: <Yhby/n4P+E15zjKj@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

On (22/02/23 10:15), Guilherme G. Piccoli wrote:
> On 22/02/2022 22:27, Sergey Senozhatsky wrote:
> > [...]
> > Hmm. Yeah, well, that's a bit of a tricky interface now
> > 
> > 	panic()
> > 		// everything (if corresponding bits set), no console flush
> > 		panic_print_sys_info(false)
> > 		...
> > 		// console flush only if corresponding bit set
> > 		panic_print_sys_info(true)
> > 
> > 
> > 
> > If everyone is fine then OK.
> > 
> > But I _personally_ would look into changing this to something like this:
> > 
> > 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> > 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
> > 	panic()
> > 		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
> > 		...
> > 		panic_print_sys_info(panic_print & LATE_PANIC_MASK)
> 
> Hi Sergey, notice that panic_print_sys_info() currently doesn't have a
> parameter! The prototype (without this patch) is:

Correct.

> static void panic_print_sys_info(void);
>
> So, it consumes the "panic_print" global variable (which matches the
> command-line parameter / sysctl), hence to implement your suggestion
> either we need a refactor in panic_print_sys_info(), adding a parameter

Correct. That's the idea. Since you are already adding a parameter,
what I'm talking is turning that parameter from true/false to something
more verbose.

> (more or less what the patch is already doing, but with a bit more
> changes) or we override the global variable twice in panic(), before the
> function calls.

We don't need to overwrite the global var. We pass "permitted bits at
this stage of panic" mask to panic_print_sys_info(). The global var
stays intact.

> As you said, it's possible and a matter of personal coding style. I'd be
> fine if more people ask that, but if everyone is fine with the current
> implementation, I'd rather get this patch merged as is, since we need it
> and couldn't even make it for 5.17 heh

Sure, works for me.

