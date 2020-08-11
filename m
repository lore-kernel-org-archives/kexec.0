Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5UaG-000271-HN
 for kexec@lists.infradead.org; Tue, 11 Aug 2020 13:44:57 +0000
Subject: Re: [RFC PATCH] printk: Change timestamp to triplet as mono, boot and
 real
References: <1597120822-11999-1-git-send-email-orsonzhai@gmail.com>
 <20200811094413.GA12903@alley> <87zh7175hj.fsf@nanos.tec.linutronix.de>
 <20200811130218.GI6215@alley>
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <ea1def14-3f03-e0e7-6658-6bbcd9861b2e@redhat.com>
Date: Tue, 11 Aug 2020 09:43:28 -0400
MIME-Version: 1.0
In-Reply-To: <20200811130218.GI6215@alley>
Content-Language: en-US
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
To: Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Orson Zhai <orson.zhai@unisoc.com>, Baoquan He <bhe@redhat.com>, cixi.geng1@unisoc.com, Stephen Boyd <sboyd@kernel.org>, zhang.lyra@gmail.com, Steven Sistare <steven.sistare@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Jon DeVree <nuxi@vault24.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, John Stultz <john.stultz@linaro.org>, ruifeng.zhang1@unisoc.com, Orson Zhai <orsonzhai@gmail.com>, Salvatore Bonaccorso <carnil@debian.org>, Dave Young <dyoung@redhat.com>, Dominique Martinet <asmadeus@codewreck.org>, Vivek Goyal <vgoyal@redhat.com>, Pavel Tatashin <pasha.tatashin@soleen.com>



On 8/11/20 9:02 AM, Petr Mladek wrote:
> On Tue 2020-08-11 14:05:12, Thomas Gleixner wrote:
>> Petr Mladek <pmladek@suse.com> writes:
>>> At least "crash" tool would need an update anyway. AFAIK, it checks
>>> the size of struct printk_log and refuses to read it when it changes.
>>>
>>> It means that the hack with VMCOREINFO_FIELD_OFFSET probably is not
>>> needed because we would need to update the crashdump-related tools anyway.
>>>
>>> Well, the timing is good. We are about to switch the printk ring
>>> buffer into a lockless one. It requires updating the crashdump tools
>>> as well. We could do this at the same time. The lockless ring buffer
>>> already is in linux-next. It is aimed for 5.10 or 5.11.
>> ...
>>> It would be great to synchronize all these changes changes of the
>>> printk log buffer structures.
>>
>> I agree that having one update is a good thing, but pretty please can we
>> finally make progress with this and not create yet another dependency?
> 
> To make it clear. I definitely do not want to block lockless printk by
> this.

Thanks for clarifying that.  I had the same concern that tglx had.

> 
> BTW: I am not 100% convinced that storing all three timestamps is
> worth it. It increases the code complexity, metadata size. It needs
> an interface with the userspace that has to stay backward compatible.
> 
> Also it still will be racy because the timestamp is taken when the message
> is printed. It might be "long" before or after the event that
> it talks about.

That scenario plays out today with the current timestamp.  Printing debug with a
better timestamp doesn't resolve that problem nor is it intended to.

> 
> There is still the alternative to print all three timestamps regularly
> for those interested. It is less user convenient but much easier
> to maintain.

While I agree, in general, your alternative is useful for in-person debugging it
is not helpful in cases where a user only has an image of a panic where the
printk time-synch message has scrolled off the screen.

Consider this real debug case where I hacked the boottime stamp into printk:  We
had some systems with flaky HW that hit panics at 10 hours [1] of uptime.  Since
these systems came from different vendors with different HW the clocks were
out-of-sync.  I had a suspicion that it was some human-coded event causing the
HW to die but wasn't sure until I did a boottime-stamped printk to prove that
all the systems died after 10 hours.

I could have set a stopwatch or timer to somehow catch this kind of event.  I
could have set up video cameras to watch the consoles, etc.  There are a lot of
other ways I could have debugged this situation but ultimately the fastest thing
to do was code and provide kernels to the various HW companies and see if
everything lined up as I thought it would.

This problem happens far more often then I'd like to admit and we still see this
type of problem with new HW and FW.  I also recall that other kernel groups
(storage, networking, etc.) were interested in the timestamps as it would make
their debugging easier to have a true synchronized timestamp available.

One other thing -- IIRC I had to modify the dmesg code by providing a sysfs (or
proc?) interface for dmesg to identify the stamp.  It's something that should be
investigated with this code too.

P.

[1] It was 3+ years ago.  I can't remember if it was 10 or 100 but you get the
point.

> 
> Best Regards,
> Petr
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
