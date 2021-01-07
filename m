Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from elvis.franken.de ([193.175.24.41])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxZNa-0007y3-Ef
 for kexec@lists.infradead.org; Thu, 07 Jan 2021 17:47:23 +0000
Date: Thu, 7 Jan 2021 18:26:20 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH V3] MIPS: Loongson64: Add kexec/kdump support
Message-ID: <20210107172620.GA13201@alpha.franken.de>
References: <20201221120220.3186744-1-chenhuacai@kernel.org>
 <a671a323-768b-b461-2ce4-ecc1e92d4cc6@loongson.cn>
 <CAAhV-H4GDxhg1YqWy-g7VuCeE7BZ0ibaVSr1ibzJqXjuaBn3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAhV-H4GDxhg1YqWy-g7VuCeE7BZ0ibaVSr1ibzJqXjuaBn3_w@mail.gmail.com>
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
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Jinyang He <hejinyang@loongson.cn>, Baoquan He <bhe@redhat.com>, Youling Tang <tangyouling@loongson.cn>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 31, 2020 at 09:23:33AM +0800, Huacai Chen wrote:
> > Thanks, :-)
> > Jinyang
> Any comments?

sure...

> > > --- a/arch/mips/kernel/relocate_kernel.S
> > > +++ b/arch/mips/kernel/relocate_kernel.S
> > > @@ -6,6 +6,7 @@
> > >
> > >   #include <asm/asm.h>
> > >   #include <asm/asmmacro.h>
> > > +#include <asm/cpu.h>
> > >   #include <asm/regdef.h>
> > >   #include <asm/mipsregs.h>
> > >   #include <asm/stackframe.h>
> > > @@ -133,6 +134,33 @@ LEAF(kexec_smp_wait)
> > >   #else
> > >       sync
> > >   #endif
> > > +
> > > +#ifdef CONFIG_CPU_LOONGSON64

Is there a reason why you can't use the already existing infrastructure
the way cavium-octeon is doing it ? If you can't please explain why
so we can find a way to extend it. But having some sort of poking
loongson registers in generic MIPS code is a non starter.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
