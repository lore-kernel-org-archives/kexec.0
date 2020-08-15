Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6m1J-00082I-Eh
 for kexec@lists.infradead.org; Sat, 15 Aug 2020 02:34:12 +0000
Received: by mail-lj1-x244.google.com with SMTP id i10so11893034ljn.2
 for <kexec@lists.infradead.org>; Fri, 14 Aug 2020 19:34:07 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id b204sm2254943lfd.48.2020.08.14.19.34.03
 for <kexec@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 19:34:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v4so11916144ljd.0
 for <kexec@lists.infradead.org>; Fri, 14 Aug 2020 19:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley> <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
 <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
In-Reply-To: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Aug 2020 19:33:46 -0700
Message-ID: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
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
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, John Ogness <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Aug 14, 2020 at 4:52 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> >
> > This is why I think any discussion that says "people should buffer
> > their lines themselves and we should get rid if pr_cont()" is
> > fundamentally broken.
> >
> > Don't go down that hole. I won't take it. It's wrong.
>
> I don't think it's wrong per se.

It's *absolutely* and 100% wrong.

Yes, any random *user* of pr_cont() can decide to buffer on it's own.

But when the discussion is about printk() - the implementation, not
the users - then it's complete and utter BS to talk about trying to
get rid of pr_cont().

See the difference?

                Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
