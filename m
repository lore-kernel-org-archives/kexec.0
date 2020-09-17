Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIyBo-0002DP-Cl
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 17:59:25 +0000
Received: by mail-lf1-x141.google.com with SMTP id b12so3150399lfp.9
 for <kexec@lists.infradead.org>; Thu, 17 Sep 2020 10:59:23 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173])
 by smtp.gmail.com with ESMTPSA id t19sm52279lfg.161.2020.09.17.10.59.16
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 10:59:17 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a22so2775604ljp.13
 for <kexec@lists.infradead.org>; Thu, 17 Sep 2020 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200917131644.25838-1-john.ogness@linutronix.de>
 <20200917131644.25838-4-john.ogness@linutronix.de>
In-Reply-To: <20200917131644.25838-4-john.ogness@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Sep 2020 10:59:00 -0700
Message-ID: <CAHk-=wiUp2=szOdVP8A7+iG8iguNvHo4gnU6f9QBuj1hh3DBvA@mail.gmail.com>
Subject: Re: [PATCH printk 3/3] printk: remove dict ring
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
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Sep 17, 2020 at 6:16 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Since there is no code that will ever store anything into the dict
> ring, remove it. If any future dictionary properties are to be
> added, these should be added to the struct printk_info.

Ack. I'm very happy to see the dictionary stuff go. It was one of
those over-designed things in the printk rewrite years and years ago.

              Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
