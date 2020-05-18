Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajTZ-0007Lt-Kd
 for kexec@lists.infradead.org; Mon, 18 May 2020 17:22:54 +0000
Received: by mail-lf1-x142.google.com with SMTP id 202so8754095lfe.5
 for <kexec@lists.infradead.org>; Mon, 18 May 2020 10:22:50 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id a8sm5962964ljp.102.2020.05.18.10.22.46
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 10:22:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x27so8649388lfg.9
 for <kexec@lists.infradead.org>; Mon, 18 May 2020 10:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
 <87v9ktcs3q.fsf@vostro.fn.ogness.net>
In-Reply-To: <87v9ktcs3q.fsf@vostro.fn.ogness.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 May 2020 10:22:30 -0700
Message-ID: <CAHk-=whSLRiNxehLiuX+ZfHsu8Kpj7R1Sdr3zA7==SMW0zh3ug@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] printk: add lockless buffer
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Mon, May 18, 2020 at 6:04 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> The cmpxchg() needs to be moved out of the while condition so that a
> continue can be used as intended. Patch below.

This seems pointless and wrong (patch edited to remove the '-' lines
so that you see the end result):

>                 smp_mb(); /* LMM(data_push_tail:C) */
>
> +               if (atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> +                               &tail_lpos,
> +                               next_lpos)) { /* LMM(data_push_tail:D) */
> +                       break;
> +               }

Doing an "smp_mb()" followed by a "cmpxchg_relaxed" seems all kinds of
odd and pointless, and is very much non-optimal on x86 for example.,

Just remove the smp_mb(), and use the non-relaxed form of cmpxchg.
It's defined to be fully ordered if it succeeds (and if the cmpxchg
doesn't succeed, it's a no-op and the memory barrier shouldn't make
any difference).

Otherwise you'll do two memory ordering operations on x86 (and
probably some other architectures), since the cmpxchg is always
ordered on x86 and there exists no "relaxed" form of it.

                  Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
