Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSLo2-0005K7-Ep
	for kexec@lists.infradead.org; Mon, 11 Aug 2008 01:02:42 +0000
Subject: Re: [PATCH -v2 3/8] kexec jump: check code size in control page
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080808140938.GE3840@redhat.com>
References: <1218178356.22039.76.camel@caritas-dev.intel.com>
	<20080808140938.GE3840@redhat.com>
Date: Mon, 11 Aug 2008 09:02:38 +0800
Message-Id: <1218416558.30464.12.camel@caritas-dev.intel.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

Hi, Vivek,

On Fri, 2008-08-08 at 10:09 -0400, Vivek Goyal wrote:
[...]
> > --- a/arch/x86/kernel/relocate_kernel_32.S
> > +++ b/arch/x86/kernel/relocate_kernel_32.S
> > @@ -20,10 +20,11 @@
> >  #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
> >  #define PAE_PGD_ATTR (_PAGE_PRESENT)
> >  
> > -/* control_page + PAGE_SIZE/2 ~ control_page + PAGE_SIZE * 3/4 are
> > - * used to save some data for jumping back
> > +/* control_page + KEXEC_CONTROL_CODE_MAX_SIZE
> > + * ~ control_page + PAGE_SIZE * 3/4 are used to save some data for
> > + * jumping back
> >   */
> 
> Hi Huang,
> 
> Above comment is not very clear. Can you please elaborate it. I thought
> that PAGE_SIZE/2 is used for control code and rest half is shared between
> kjump data and stack. What is PAGE_SIZE *3/4?

Yes. Rest half is shared between kjump data and stack. I will change it.

> > +++ b/arch/x86/kernel/vmlinux_check_32.lds.S
> > @@ -0,0 +1,7 @@
> > +/*
> > + * Link time checks
> > + */
> > +
> > +#include <asm/kexec.h>
> > +
> > +ASSERT(kexec_control_code_size <= KEXEC_CONTROL_CODE_MAX_SIZE,
> "kexec control code size is too big")
> 
> Will it make sense to move it into vmlinux_32.lds.S itself? Creating a
> separate
> file for a single check seems superfluous.

I hope other ones can use it. But for now, put it in vmlinux_32.lds.S is
better. I will change it.

Best Regards,
HUang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
