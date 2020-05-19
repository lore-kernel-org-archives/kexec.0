Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb8wV-0007qT-Sg
 for kexec@lists.infradead.org; Tue, 19 May 2020 20:34:29 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 2/3] printk: add lockless buffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <87v9ktcs3q.fsf@vostro.fn.ogness.net>
 <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
Date: Tue, 19 May 2020 22:34:19 +0200
In-Reply-To: <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
 (Linus Torvalds's message of "Mon, 18 May 2020 10:22:30 -0700")
Message-ID: <87tv0bhdf8.fsf@vostro.fn.ogness.net>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On 2020-05-18, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>                 smp_mb(); /* LMM(data_push_tail:C) */
>>
>> +               if (atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
>> +                               &tail_lpos,
>> +                               next_lpos)) { /* LMM(data_push_tail:D) */
>> +                       break;
>> +               }
>
> Doing an "smp_mb()" followed by a "cmpxchg_relaxed" seems all kinds of
> odd and pointless, and is very much non-optimal on x86 for example.,
>
> Just remove the smp_mb(), and use the non-relaxed form of cmpxchg.
> It's defined to be fully ordered if it succeeds (and if the cmpxchg
> doesn't succeed, it's a no-op and the memory barrier shouldn't make
> any difference).
>
> Otherwise you'll do two memory ordering operations on x86 (and
> probably some other architectures), since the cmpxchg is always
> ordered on x86 and there exists no "relaxed" form of it.

ACK.

All three smp_mb()'s and both smp_wmb()'s sit directly next to
cmpxchg_relaxed() calls. Having explicit memory barriers was helpful for
identifying, proving, and testing a minimal set of pairs (on arm64), but
all will be folded into full cmpxchg()'s for the next version.

John Ogness

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
