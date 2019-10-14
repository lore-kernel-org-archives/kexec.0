Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK9sj-0003BQ-5l
 for kexec@lists.infradead.org; Mon, 14 Oct 2019 23:36:06 +0000
Received: by mail-ed1-x541.google.com with SMTP id r16so16197772edq.11
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 16:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-16-pasha.tatashin@soleen.com>
 <fe5a4aae-fae3-f30f-db15-f3eced229a6e@arm.com>
In-Reply-To: <fe5a4aae-fae3-f30f-db15-f3eced229a6e@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 14 Oct 2019 19:35:51 -0400
Message-ID: <CA+CK2bBRRQsepxrWnOUOnFfPUe5SYsOurQ3kL_P1ghxze77RFQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/17] arm64: kexec: add expandable argument to
 relocation function
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > +struct kern_reloc_arg {
> > +     unsigned long   head;
> > +     unsigned long   entry_addr;
> > +     unsigned long   kern_arg0;
> > +     unsigned long   kern_arg1;
> > +     unsigned long   kern_arg2;
> > +     unsigned long   kern_arg3;
>
> ... at least one of these should by phys_addr_t!

OK, changed them to phys_addr_t

>
> While the sizes are the same on arm64, this reminds the reader what kind of address this
> is, and lets the compiler warn you if you make a mistake.

OK

>
>
> > +};
>
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 214685760e1c..900394907fd8 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/suspend.h>
> >  #include <linux/kbuild.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/kexec.h>
> >
> >  int main(void)
> >  {
> > @@ -126,6 +127,14 @@ int main(void)
> >  #ifdef CONFIG_ARM_SDE_INTERFACE
> >    DEFINE(SDEI_EVENT_INTREGS, offsetof(struct sdei_registered_event, interrupted_regs));
> >    DEFINE(SDEI_EVENT_PRIORITY,        offsetof(struct sdei_registered_event, priority));
> > +#endif
> > +#ifdef CONFIG_KEXEC_CORE
> > +  DEFINE(KRELOC_HEAD,                offsetof(struct kern_reloc_arg, head));
> > +  DEFINE(KRELOC_ENTRY_ADDR,  offsetof(struct kern_reloc_arg, entry_addr));
> > +  DEFINE(KRELOC_KERN_ARG0,   offsetof(struct kern_reloc_arg, kern_arg0));
> > +  DEFINE(KRELOC_KERN_ARG1,   offsetof(struct kern_reloc_arg, kern_arg1));
> > +  DEFINE(KRELOC_KERN_ARG2,   offsetof(struct kern_reloc_arg, kern_arg2));
> > +  DEFINE(KRELOC_KERN_ARG3,   offsetof(struct kern_reloc_arg, kern_arg3));
>
> Please use kexec as the prefix. The kernel also applies relocations during early boot.
> These are global values, and in isolation doesn't imply kexec.

OK
> >  .align 3     /* To keep the 64-bit values below naturally aligned. */
> > -
> >  .Lcopy_end:
> >  .org KEXEC_CONTROL_PAGE_SIZE
> >
>
> My eyes!
>
> Please don't make unnecessary changes. Its hard enough to read the assembly, moving
> whitespace, comments and re-allocating the register guarantees that no-one can work out
> what is happening.
>
> If something needs cleaning up to make the change obvious, it needs doing as a previous
> patch. Mechanical changes are fairly easy to review.
> Functional changes behind a whirlwind of mechanical changes will cause the reviewer to
> give up.

Sure, I have split this patch into several patches, and moved
clean-ups into separate patches.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
