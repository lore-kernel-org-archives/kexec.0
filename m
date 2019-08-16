Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyYjR-0005UM-1A
 for kexec@lists.infradead.org; Fri, 16 Aug 2019 09:41:14 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de>
 <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
Date: Fri, 16 Aug 2019 11:40:54 +0200
In-Reply-To: <20190816054651.GA4403@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Fri, 16 Aug 2019 13:46:51 +0800")
Message-ID: <87y2ztwiqh.fsf@linutronix.de>
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
To: Dave Young <dyoung@redhat.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 2019-08-16, Dave Young <dyoung@redhat.com> wrote:
> John, can you cc kexec list for your later series?

Sure.

> On 08/08/19 at 12:32am, John Ogness wrote:
>> This is a major change because the API (and underlying workings) of
>> the new ringbuffer are completely different than the previous
>> ringbuffer. Since there are several components of the printk
>> infrastructure that use the ringbuffer API (console, /dev/kmsg,
>> syslog, kmsg_dump), there are quite a few changes throughout the
>> printk implementation.
>> 
>> This is also a conservative change because it continues to use the
>> logbuf_lock raw spinlock even though the new ringbuffer is lockless.
>> 
>> The externally visible changes are:
>> 
>> 1. The exported vmcore info has changed:
>> 
>>     - VMCOREINFO_SYMBOL(log_buf);
>>     - VMCOREINFO_SYMBOL(log_buf_len);
>>     - VMCOREINFO_SYMBOL(log_first_idx);
>>     - VMCOREINFO_SYMBOL(clear_idx);
>>     - VMCOREINFO_SYMBOL(log_next_idx);
>>     + VMCOREINFO_SYMBOL(printk_rb_static);
>>     + VMCOREINFO_SYMBOL(printk_rb_dynamic);
>
> I assumed this needs some userspace work in kexec, how did you test
> them?

I did not test any direct userspace access to the ringbuffer structures.

> makedumpfile should need changes to dump the kernel log.
>
> Also kexec-tools includes a vmcore-dmesg.c to extrace dmesg from
> /proc/vmcore.

Thanks for the heads up. I'll take a look at it. The code changes should
be straight forward. I expect there will need to be backwards
compatibility. Perhaps it would check first for "printk_rb_*" then
fallback to "log_*"?

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
