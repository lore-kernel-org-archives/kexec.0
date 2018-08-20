Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1froSI-0002Oc-P6
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 17:59:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id y5-v6so7159402pgv.1
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2018 10:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
 <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
In-Reply-To: <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 Aug 2018 10:58:41 -0700
Message-ID: <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
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
To: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com, "Eric W . Biederman" <ebiederm@xmission.com>, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Nathan Chancellor <natechancellor@gmail.com>

+ akpm, Linus

Bumping for review.

On Mon, Aug 13, 2018 at 2:32 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Simon (kexec)
>
> bumping for review.
> On Wed, Aug 8, 2018 at 4:06 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > bumping for review
> > On Wed, Aug 1, 2018 at 2:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > As part of the effort to reduce the code duplication between _THIS_IP_
> > > and current_text_addr(), let's consolidate callers of
> > > current_text_addr() to use _THIS_IP_.
> > >
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  arch/x86/include/asm/kexec.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> > > index f327236f0fa7..86924d594ecd 100644
> > > --- a/arch/x86/include/asm/kexec.h
> > > +++ b/arch/x86/include/asm/kexec.h
> > > @@ -21,6 +21,7 @@
> > >  #ifndef __ASSEMBLY__
> > >
> > >  #include <linux/string.h>
> > > +#include <linux/kernel.h>
> > >
> > >  #include <asm/page.h>
> > >  #include <asm/ptrace.h>
> > > @@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
> > >                 asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
> > >                 asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
> > >  #endif
> > > -               newregs->ip = (unsigned long)current_text_addr();
> > > +               newregs->ip = _THIS_IP_;
> > >         }
> > >  }
> > >
> > > --
> > > 2.18.0.597.ga71716f1ad-goog
> > >

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
