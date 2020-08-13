Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6AUX-00042o-TX
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 10:29:50 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
In-Reply-To: <20200813084136.GK12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
Date: Thu, 13 Aug 2020 12:35:47 +0206
Message-ID: <87v9hmrg84.fsf@jogness.linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 2020-08-13, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2020-08-13 09:50:25, John Ogness wrote:
>> On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> > This is not an unseen pattern, I'm afraid. And the problem here can
>> > be more general:
>> >
>> > 	pr_info("text");
>> > 	pr_cont("1");
>> > 	exception/IRQ/NMI
>> > 		pr_alert("text\n");
>> > 	pr_cont("2");
>> > 	pr_cont("\n");
>> >
>> > I guess the solution would be to store "last log_level" in task_struct
>> > and get current (new) timestamp for broken cont line?
>> 
>> (Warning: new ideas ahead)
>> 
>> The fundamental problem is that there is no real association between
>> the cont parts. So any interruption results in a broken record. If we
>> really want to do this correctly, we need real association.

I believe I failed to recognize the fundamental problem. The fundamental
problem is that the pr_cont() semantics are very poor. I now strongly
believe that we need to fix those semantics by having the pr_cont() user
take responsibility for buffering the message. Patching the ~2000
pr_cont() users will be far easier than continuing to twist ourselves
around this madness.

Here is an example for a new pr_cont() API:

    struct pr_cont c;

    pr_cont_alloc_info(&c);
       (or alternatively)
    dev_cont_alloc_info(dev, &c);

    pr_cont(&c, "1");
    pr_cont(&c, "2");

    pr_cont_flush(&c);

Using macro magic, there can be the usual dbg, warn, err, etc. variants
of the alloc functions.

The alloc function would need to work for any context, but that would
not be an issue. If the cont message started to get too large, pr_cont()
could do its own flushing in between, while still holding on to the
context information. If for some reason the alloc function could not
allocate a buffer, all the pr_cont() calls could fallback to logging the
individual cont parts.

I believe this would solve all cont-related problems while also allowing
the new ringbuffer to remain as it already is in linux-next.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
