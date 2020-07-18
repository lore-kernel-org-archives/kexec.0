Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwaHD-0001O7-Ja
 for kexec@lists.infradead.org; Sat, 18 Jul 2020 00:00:28 +0000
Received: by mail-lj1-x242.google.com with SMTP id f5so14596644ljj.10
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 17:00:20 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id x30sm2143602lfn.3.2020.07.17.17.00.17
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 17:00:17 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o4so7001463lfi.7
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 17:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Jul 2020 17:00:00 -0700
Message-ID: <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 4:48 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> Using placeholders avoids tools such as systemd-journald from
> erroneously reporting missed messages. However, it also means that
> empty placeholder records are visible in systemd-journald logs and
> displayed in tools such as dmesg.

As long as the readers still reliably do the joining, this is fine.

HOWEVER.

Make sure you test the case of "fast concurrent readers". The last
time we did things like this, it was a disaster, because a concurrent
reader would see and return the _incomplete_ line, and the next entry
was still being generated on another CPU.

The reader would then decide to return that incomplete line, because
it had something.

And while in theory this could then be handled properly in user space,
in practice it wasn't. So you'd see a lot of logging tools that would
then report all those continuations as separate log events.

Which is the whole point of LOG_CONT - for that *not* to happen.

So this is just a heads-up that I will not pull something that breaks
LOG_CONT because it thinks "user space can handle it". No. User space
does not handle it, and we need to handle it for the user.

So as long as the kernel makes sure the joining does happen it at some
point, it's all fine. It obviously doesn't have to happen at printk()
time, just as long as incomplete records aren't exposed even to
concurrent readers.

A test-case with a short delay in between writes might be a good idea,
although the last time this broke it was very clear in peoples syslogs
and dmesg because it turns out there are lots of concurrent readers at
boot time and _somebody_ will hit the race.

             Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
