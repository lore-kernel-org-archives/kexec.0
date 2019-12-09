Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieEug-0001Ar-0T
 for kexec@lists.infradead.org; Mon, 09 Dec 2019 09:01:07 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191209074249.GC88619@google.com>
Date: Mon, 09 Dec 2019 10:00:57 +0100
In-Reply-To: <20191209074249.GC88619@google.com> (Sergey Senozhatsky's message
 of "Mon, 9 Dec 2019 16:42:50 +0900")
Message-ID: <87v9qpzxdi.fsf@linutronix.de>
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
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org

On 2019-12-09, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> +#define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
>> +#define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
>> +#define DESC_SV_BITS			(sizeof(int) * 8)
>> +#define DESC_COMMITTED_MASK		(1U << (DESC_SV_BITS - 1))
>
> What does SV state for? State Value?

Yes. Originally this thing was just called the state. But it was a bit
confusing in the code because there is also an enum desc_state (used for
state queries), which is _not_ the value that is stored in the state
variable. That's why the code is using state_var/state_val (SV) for the
actual data values, keeping it separate from desc_state/d_state for the
the state queries.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
