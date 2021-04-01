Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRxEq-009fUq-C5
 for kexec@lists.infradead.org; Thu, 01 Apr 2021 13:19:58 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <YGW63/elFr/gYW1u@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de> <YGW63/elFr/gYW1u@alley>
Date: Thu, 01 Apr 2021 15:19:52 +0200
Message-ID: <87a6qiqgzr.fsf@jogness.linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On 2021-04-01, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1142,24 +1128,37 @@ void __init setup_log_buf(int early)
>>  		 new_descs, ilog2(new_descs_count),
>>  		 new_infos);
>>  
>> -	printk_safe_enter_irqsave(flags);
>> +	local_irq_save(flags);
>
> IMHO, we actually do not have to disable IRQ here. We already copy
> messages that might appear in the small race window in NMI. It would
> work the same way also for IRQ context.

We do not have to, but why open up this window? We are still in early
boot and interrupts have always been disabled here. I am not happy that
this window even exists. I really prefer to keep it NMI-only.

>> --- a/lib/nmi_backtrace.c
>> +++ b/lib/nmi_backtrace.c
>> @@ -75,12 +75,6 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>>  		touch_softlockup_watchdog();
>>  	}
>>  
>> -	/*
>> -	 * Force flush any remote buffers that might be stuck in IRQ context
>> -	 * and therefore could not run their irq_work.
>> -	 */
>> -	printk_safe_flush();
>
> Sigh, this reminds me that the nmi_safe buffers serialized backtraces
> from all CPUs.
>
> I am afraid that we have to put back the spinlock into
> nmi_cpu_backtrace().

Please no. That spinlock is a disaster. It can cause deadlocks with
other cpu-locks (such as in kdb) and it will cause a major problem for
atomic consoles. We need to be very careful about introducing locks
where NMIs are waiting on other CPUs.

> It has been repeatedly added and removed depending
> on whether the backtrace was printed into the main log buffer
> or into the per-CPU buffers. Last time it was removed by
> the commit 03fc7f9c99c1e7ae2925d ("printk/nmi: Prevent deadlock
> when accessing the main log buffer in NMI").
>
> It should be safe because there should not be any other locks in the
> code path. Note that only one backtrace might be triggered at the same
> time, see @backtrace_flag in nmi_trigger_cpumask_backtrace().

It is adding a lock around a lockless ringbuffer. For me that is a step
backwards.

> We _must_ serialize it somehow[*]. The lock in nmi_cpu_backtrace()
> looks less evil than the nmi_safe machinery. nmi_safe() shrinks
> too long backtraces, lose timestamps, needs to be explicitely
> flushed here and there, is a non-trivial code.
>
> [*] Non-serialized bactraces are real mess. Caller-id is visible
>     only on consoles or via syslogd interface. And it is not much
>     convenient.

Caller-id solves this problem and is easy to sort for anyone with
`grep'. Yes, it is a shame that `dmesg' does not show it, but directly
using any of the printk interfaces does show it (kmsg_dump, /dev/kmsg,
syslog, console).

>     I get this with "echo l >/proc/sysrq-trigger" and this patchset:

Of course. Without caller-id, it is a mess. But this has nothing to do
with NMI. The same problem exists for WARN_ON() on multiple CPUs
simultaneously. If the user is not using caller-id, they are
lost. Caller-id is the current solution to the interlaced logs.

For the long term, we should introduce a printk-context API that allows
callers to perfectly pack their multi-line output into a single
entry. We discussed [0][1] this back in August 2020.

John Ogness

[0] https://lore.kernel.org/lkml/472f2e553805b52d9834d64e4056db965edee329.camel@perches.com
[1] offlist message-id: 87d03k9ymz.fsf@jogness.linutronix.de

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
