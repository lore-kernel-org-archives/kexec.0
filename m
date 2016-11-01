Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1ZpN-0007nC-KN
 for kexec@lists.infradead.org; Tue, 01 Nov 2016 14:14:14 +0000
Date: Tue, 1 Nov 2016 10:13:34 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <115590076.11735656.1478009614692.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161101053353.GC20838@x1>
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
 <20161101051019.GB4625@dhcp-128-65.nay.redhat.com>
 <20161101053353.GC20838@x1>
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: panand@redhat.com, keescook@chromium.org, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, takahiro akashi <takahiro.akashi@linaro.org>, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, thgarnie@google.com, tonli@redhat.com



----- Original Message -----
> On 11/01/16 at 01:10pm, Dave Young wrote:
> > On 10/06/16 at 04:46pm, Baoquan He wrote:
> > > KASLR memory randomization can randomize the base of the physical memory
> > > mapping (PAGE_OFFSET), vmalloc (VMALLOC_START) and vmemmap
> > > (VMEMMAP_START). These need be exported to VMCOREINFO so that user space
> > > utility, mainly makedumpfile can use them to identify the base of each
> > > memory section. Here using VMCOREINFO_NUMBER we can reuse the existing
> > > struct number_table in makedumpfile to import data easily.
> > > 
> > > Since they are related to x86_64 only, put them into
> > > arch_crash_save_vmcoreinfo. And move the exportion of KERNEL_IMAGE_SIZE
> > > together since it's also for x86_64 only.
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/x86/kernel/machine_kexec_64.c | 4 ++++
> > >  kernel/kexec_core.c                | 3 ---
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/machine_kexec_64.c
> > > b/arch/x86/kernel/machine_kexec_64.c
> > > index 5a294e4..e150dd7 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -337,6 +337,10 @@ void arch_crash_save_vmcoreinfo(void)
> > >  #endif
> > >  	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
> > >  			      kaslr_offset());
> > > +	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
> > > +	VMCOREINFO_NUMBER(PAGE_OFFSET);
> > > +	VMCOREINFO_NUMBER(VMALLOC_START);
> > > +	VMCOREINFO_NUMBER(VMEMMAP_START);
> > 
> > Pratyush has posted makedumpfile patches below to avoid the VMCOREINFO:
> > http://lists.infradead.org/pipermail/kexec/2016-October/017540.html
> > 
> > But we have this in mainline which also introduced the VMCOREINFO
> > numbers, can you send a patch to revert them?
> 
> OK, will do.
> 
> However for find_vmemmap_x86_64() in makedumpfile, vmemmap_start is
> still needed. I checked code, seems no better way to avoid. I am not
> sure how many people are really using "-e" option to exclude unused
> vmemmap pages.
> 
> Maybe just leave it as is, and fix it when people complain?

Speaking of complaints, is there any chance you can make the
x86_64 "phys_base" value available?  The VMCOREINFO_SYMBOL(phys_base)
is useless since its contents are needed in order to access the
symbol address.

Dave



> 
> > commit 0549a3c02efb350776bc869685a361045efd3a29
> > Author: Thomas Garnier <thgarnie@google.com>
> > Date:   Tue Oct 11 13:55:08 2016 -0700
> > 
> >     kdump, vmcoreinfo: report memory sections virtual addresses
> > [snip]]
> > 
> > >  }
> > >  
> > >  /* arch-dependent functionality related to kexec file-based syscall */
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 5616755..8ad3a29e 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1467,9 +1467,6 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >  #endif
> > >  	VMCOREINFO_NUMBER(PG_head_mask);
> > >  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> > > -#ifdef CONFIG_X86
> > > -	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
> > > -#endif
> > 
> > Moving KERNEL_IMAGE_SIZE to x86 should be a standalone patch.
> > I remember Dave Anderson said he use it in crash utility, cced him.
> > 
> > >  #ifdef CONFIG_HUGETLB_PAGE
> > >  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
> > >  #endif
> > > --
> > > 2.5.5
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > Thanks
> > Dave
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
