Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTjSE-002GGS-VZ
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 11:01:09 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <YGXV8LJarjUJDhvy@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de> <YGW63/elFr/gYW1u@alley>
 <87a6qiqgzr.fsf@jogness.linutronix.de> <YGXV8LJarjUJDhvy@alley>
Date: Tue, 06 Apr 2021 13:01:02 +0200
Message-ID: <87im4zoexd.fsf@jogness.linutronix.de>
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
>> Caller-id solves this problem and is easy to sort for anyone with
>> `grep'. Yes, it is a shame that `dmesg' does not show it, but
>> directly using any of the printk interfaces does show it (kmsg_dump,
>> /dev/kmsg, syslog, console).
>
> True but frankly, the current situation is _far_ from convenient:
>
>    + consoles do not show it by default
>    + none userspace tool (dmesg, journalctl, crash) is able to show it
>    + grep is a nightmare, especially if you have more than handful of CPUs
>
> Yes, everything is solvable but not easily.
>
>> >     I get this with "echo l >/proc/sysrq-trigger" and this patchset:
>> 
>> Of course. Without caller-id, it is a mess. But this has nothing to do
>> with NMI. The same problem exists for WARN_ON() on multiple CPUs
>> simultaneously. If the user is not using caller-id, they are
>> lost. Caller-id is the current solution to the interlaced logs.
>
> Sure. But in reality, the risk of mixed WARN_ONs is small. While
> this patch makes backtraces from all CPUs always unusable without
> caller_id and non-trivial effort.

I would prefer we solve the situation for non-NMI as well, not just for
the sysrq "l" case.

>> For the long term, we should introduce a printk-context API that allows
>> callers to perfectly pack their multi-line output into a single
>> entry. We discussed [0][1] this back in August 2020.
>
> We need a "short" term solution. There are currently 3 solutions:
>
> 1. Keep nmi_safe() and all the hacks around.
>
> 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
>    the special lock used also by atomic consoles.
>
> 3. Tell complaining people how to sort the messed logs.

Or we look into the long term solution now. If caller-id's cannot not be
used as the solution (because nobody turns it on, nobody knows about it,
and/or distros do not enable it), then we should look at how to make at
least the backtraces contiguous. I have a few ideas here.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
