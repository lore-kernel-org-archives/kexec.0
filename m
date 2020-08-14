Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6iTK-0004fH-S1
 for kexec@lists.infradead.org; Fri, 14 Aug 2020 22:46:51 +0000
Received: by mail-lj1-x244.google.com with SMTP id i10so11555155ljn.2
 for <kexec@lists.infradead.org>; Fri, 14 Aug 2020 15:46:49 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id n82sm2156862lfa.40.2020.08.14.15.46.46
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 15:46:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t6so11507267ljk.9
 for <kexec@lists.infradead.org>; Fri, 14 Aug 2020 15:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley> <20200813115435.GB483@jagdpanzerIV.localdomain>
In-Reply-To: <20200813115435.GB483@jagdpanzerIV.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Aug 2020 15:46:30 -0700
Message-ID: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
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

On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> I think what Linus said a long time ago was that the initial purpose of
> pr_cont was
>
>         pr_info("Initialize feature foo...");
>         if (init_feature_foo() == 0)
>                 pr_cont("ok\n");
>         else
>                 pr_cont("not ok\n");
>
>         And if init_feature_foo() crashes the kernel then the first printk()
>         form panic() will flush the cont buffer.

Right.

This is why I think any discussion that says "people should buffer
their lines themselves and we should get rid if pr_cont()" is
fundamentally broken.

Don't go down that hole. I won't take it. It's wrong.

The fact is, pr_cont() goes back to the original kernel. No, it wasn't
pr_cont() back then, and no, there were no actual explicit markers for
"this is a continuation" at all, it was all just "the last printk
didn't have a newline, so we continue where we left off".

We've added pr_cont (and KERN_CONT) since then, and I realize that a
lot of people hate the complexity it introduces, but it's a
fundamental complexity that you have to live with.

If you can't live with pr_cont(), you shouldn't be working on
printk(), and find some other area of the kernel that you _can_ live
with.

It really is that simple.

            Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
