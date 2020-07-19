Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxE2a-0005Sl-KJ
 for kexec@lists.infradead.org; Sun, 19 Jul 2020 18:28:01 +0000
Received: by mail-lf1-x144.google.com with SMTP id h8so365334lfp.9
 for <kexec@lists.infradead.org>; Sun, 19 Jul 2020 11:27:58 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173])
 by smtp.gmail.com with ESMTPSA id b11sm3281632lfa.50.2020.07.19.11.27.55
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jul 2020 11:27:56 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x9so17874098ljc.5
 for <kexec@lists.infradead.org>; Sun, 19 Jul 2020 11:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
In-Reply-To: <20200719143527.GA566@jagdpanzerIV.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Jul 2020 11:27:39 -0700
Message-ID: <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
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

On Sun, Jul 19, 2020 at 7:35 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Can we merge lines that we don't want to merge?
>
>    pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()

That pr_cont in either IRQ or NMI context would be a bug.

You can't validly have a PR_CONT without the non-cont that precedes it.

                Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
