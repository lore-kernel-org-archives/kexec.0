Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxuOL-00066E-Nn
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 15:41:18 +0000
Received: by mail-lf1-x144.google.com with SMTP id u12so11911114lff.2
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 08:41:17 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52])
 by smtp.gmail.com with ESMTPSA id j19sm1956219lfe.91.2020.07.21.08.41.14
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 08:41:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id o4so11940619lfi.7
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 08:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
In-Reply-To: <20200721144220.GE44523@jagdpanzerIV.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Jul 2020 08:40:58 -0700
Message-ID: <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
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
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jul 21, 2020 at 7:42 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> we will have more info than just "0x80000000 + raw_smp_processor_id()".

I think it's really preempt_count() that we want to have there.

That has the softirq/hardirq/NMI information in it.

So the "context" identifier of an incomplete write would be { task,
cpu, preempt_count() } of the writer. If a new KERN_CONT writer comes
in, it would have to match in that context to actually combine.

You can probably play "hide the bits" tricks to not *ac tually* use
three words for it. The task structure in particular tends to be very
aligned, you could hide bits in the low bits there. The CPU number
would fit in there, for example.

             Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
