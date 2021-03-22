Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOSZW-00Cdto-Dt
 for kexec@lists.infradead.org; Mon, 22 Mar 2021 21:58:52 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <YFjbwxhZNnC52aSP@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFbY8kF7ilYoxvYp@google.com> <87k0pzmoao.fsf@jogness.linutronix.de>
 <YFjbwxhZNnC52aSP@alley>
Date: Mon, 22 Mar 2021 22:58:47 +0100
Message-ID: <87ft0mg8a0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rafael Aquini <aquini@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Guilherme G.
 Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-03-22, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2021-03-22 12:16:15, John Ogness wrote:
>> On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> >> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>> >>  	 * Use the main logbuf even in NMI. But avoid calling console
>> >>  	 * drivers that might have their own locks.
>> >>  	 */
>> >> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>> >> +	if (this_cpu_read(printk_context) &
>> >> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
>> >> +	     PRINTK_NMI_CONTEXT_MASK |
>> >> +	     PRINTK_SAFE_CONTEXT_MASK)) {
>> >
>> > Do we need printk_nmi_direct_enter/exit() and
>> > PRINTK_NMI_DIRECT_CONTEXT_MASK?  Seems like all printk_safe() paths
>> > are now DIRECT - we store messages to the prb, but don't call console
>> > drivers.
>>
>> I was planning on waiting until the kthreads are introduced, in which
>> case printk_safe.c is completely removed.
>
> You want to keep printk_safe() context because it prevents calling
> consoles even in normal context. Namely, it prevents deadlock by
> recursively taking, for example, sem->lock in console_lock() or
> console_owner_lock in console_trylock_spinning(). Am I right?

Correct.

>> But I suppose I could switch
>> the 1 printk_nmi_direct_enter() user to printk_nmi_enter() so that
>> PRINTK_NMI_DIRECT_CONTEXT_MASK can be removed now. I would do this in a
>> 4th patch of the series.
>
> Yes, please unify the PRINTK_NMI_CONTEXT. One is enough.

Agreed. (But I'll go even further. See below.)

> I wonder if it would make sense to go even further at this stage.
> There will still be 4 contexts that modify the printk behavior after
> this patchset:
>
>   + printk_count set by printk_enter()/exit()
>       + prevents: infinite recursion
>       + context: any context
>       + action: skips entire printk at 3rd recursion level
>
>   + prink_context set by printk_safe_enter()/exit()
>       + prevents: dead lock caused by recursion into some
> 		console code in any context
>       + context: any
>       + action: skips console call at 1st recursion level

Technically, at this point printk_safe_enter() behavior is identical to
printk_nmi_enter(). Namely, prevent any recursive printk calls from
calling into the console code.

>   + printk_context set by printk_nmi_enter()/exit()
>       + prevents: dead lock caused by any console lock recursion
>       + context: NMI
>       + action: skips console calls at 0th recursion level
>
>   + kdb_trap_printk
>       + redirects printk() to kdb_printk() in kdb context
>
>
> What is possible?
>
> 1. We could get rid of printk_nmi_enter()/exit() and
>    PRINTK_NMI_CONTEXT completely already now. It is enough
>    to check in_nmi() in printk_func().
>
>    printk_nmi_enter() was added by the commit 42a0bb3f71383b457a7db362
>    ("printk/nmi: generic solution for safe printk in NMI"). It was
>    really needed to modify @printk_func pointer.
>
>    We did not remove it later when printk_function became a real
>    function. The idea was to track all printk contexts in a single
>    variable. But we never added kdb context.
>
>    It might make sense to remove it now. Peter Zijstra would be happy.
>    There already were some churns with tracking printk_context in NMI.
>    For example, see
>    https://lore.kernel.org/r/20200219150744.428764577@infradead.org
>
>    IMHO, it does not make sense to wait until the entire console-stuff
>    rework is done in this case.

Agreed. in_nmi() within vprintk_emit() is enough to detect if the
console code should be skipped:

    if (!in_sched && !in_nmi()) {
        ...
    }

> 2. I thought about unifying printk_safe_enter()/exit() and
>    printk_enter()/exit(). They both count recursion with
>    IRQs disabled, have similar name. But they are used
>    different way.
>
>    But better might be to rename printk_safe_enter()/exit() to
>    console_enter()/exit() or to printk_deferred_enter()/exit().
>    It would make more clear what it does now. And it might help
>    to better distinguish it from the new printk_enter()/exit().
>
>    This patchset actually splits the original printk_safe()
>    functionality into two:
>
>        + printk_count prevents infinite recursion
>        + printk_deferred_enter() deffers console handling.
>
>    I am not sure if it is worth it. But it might help people (even me)
>    when digging into the printk history. Different name will help to
>    understand the functionality at the given time.

I am also not sure if it is worth the extra "noise" just to give the
function a more appropriate name. The plan is to remove it completely
soon anyway. My vote is to leave the name as it is.

But I am willing to do the rename in an addtional patch if you
want. printk_deferred_enter() sounds fine to me. Please confirm if you
want me to do this.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
