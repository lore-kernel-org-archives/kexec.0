Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5T1p-0002ZP-8i
 for kexec@lists.infradead.org; Tue, 11 Aug 2020 12:05:18 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono,
 boot and real
In-Reply-To: <20200811094413.GA12903@alley>
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley>
Date: Tue, 11 Aug 2020 14:05:12 +0200
Message-ID: <87zh7175hj.fsf@nanos.tec.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>, Orson Zhai <orsonzhai@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>, John Ogness <john.ogness@linutronix.de>, Orson Zhai <orson.zhai@unisoc.com>, Baoquan He <bhe@redhat.com>, Stephen Boyd <sboyd@kernel.org>, zhang.lyra@gmail.com, Steven Sistare <steven.sistare@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Jon DeVree <nuxi@vault24.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, ruifeng.zhang1@unisoc.com, cixi.geng1@unisoc.com, Salvatore Bonaccorso <carnil@debian.org>, Dave Young <dyoung@redhat.com>, Dominique Martinet <asmadeus@codewreck.org>, Vivek Goyal <vgoyal@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>

Petr Mladek <pmladek@suse.com> writes:
> On Tue 2020-08-11 12:40:22, Orson Zhai wrote:
>> This is an updated version which comes from patch [1] written by Thomas
>> and suggestion [2] about VMCORE_INFO given by Linus.

All of that want's to be properly distangled into seperate patches.
 
>> This patch has been tested in qemu-x86-system. One problem is the timestamp
>> in kernel log will be printed [    0.000000] for longer time than before. 
>
> This would be a regression. People put huge effort into having early boot
> timestamps, see
> https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com/
> Adding some active people from this patchset into CC.
>
> I wonder if we could have these early timestamps also in the mono
> clock.

Not really. timekeeping init happens way after the early TSC (or
whatever clock) is registered as sched_clock(). And there is no
realistic way to move timekeeping init earlier.

What we could do instead is to utilize sched_clock() up to the point
where timekeeping becomes available and ensure that monotonic time is
not jumping backwards vs. sched_clock() when switching over. For this
early boot phase, clock realtime timestamps would be invalid of course
and they can stay invalid even after timekeeping is initialized on
systems where the RTC is not available in the early boot process.

> At least "crash" tool would need an update anyway. AFAIK, it checks
> the size of struct printk_log and refuses to read it when it changes.
>
> It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
> needed because we would need to update the crashdump-related tools anyway.
>
> Well, the timing is good. We are about to switch the printk ring
> buffer into a lockless one. It requires updating the crashdump tools
> as well. We could do this at the same time. The lockless ring buffer
> already is in linux-next. It is aimed for 5.10 or 5.11.
...
> It would be great to synchronize all these changes changes of the
> printk log buffer structures.

I agree that having one update is a good thing, but pretty please can we
finally make progress with this and not create yet another dependency?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
