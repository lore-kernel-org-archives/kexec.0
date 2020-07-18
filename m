Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwqrH-0003S3-Vo
 for kexec@lists.infradead.org; Sat, 18 Jul 2020 17:42:48 +0000
Received: by mail-lj1-x241.google.com with SMTP id q4so16165517lji.2
 for <kexec@lists.infradead.org>; Sat, 18 Jul 2020 10:42:47 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43])
 by smtp.gmail.com with ESMTPSA id r9sm1253189lfc.51.2020.07.18.10.42.44
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2020 10:42:45 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j21so7729936lfe.6
 for <kexec@lists.infradead.org>; Sat, 18 Jul 2020 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
In-Reply-To: <87blkcanps.fsf@jogness.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Jul 2020 10:42:28 -0700
Message-ID: <CAHk-=wgX9Q+en5j8EmYkhxEx8H0EzHhx5WqPGui7KNiV7=ZK-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Jul 18, 2020 at 7:43 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> I expect this is handled correctly since the reader is not given any
> parts until a full line is ready, but I will put more focus on testing
> this to make sure.

Yeah, the patches looked fine, but I only scanned them, and just
wanted to make sure.

Over the years, we've gotten printk wrong so many times that I get a
bit paranoid. Things can look fine on the screen, but then have odd
line breaks in the logs. Or vice versa. Or work fine on some machine,
but consistently show some race on another.

And some of the more complex features are hardly ever actually used -
I'm not sure the optional message context (aka dictionary) is ever
actually used.

Yes, all the "dev_printk()" helpers fill it in with the device
information (create_syslog_header()), and you _can_ use them if you
know about them (ie

    journalctl -b _KERNEL_SUBSYSTEM=pci_bus

but I sometimes wonder how many people use all this complexity. And
how many people even know about it..)

So there are hidden things in there that can easily break *subtly* and
then take ages for people to notice, because while some are very
obvious indeed ("why is my module list message broken up into a
hundred lines?") others might be things people aren't even aware of.

Maybe a lot of system tools use those kernel dictionaries. Maybe it
would break immediately. I just sometimes wonder...

                 Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
