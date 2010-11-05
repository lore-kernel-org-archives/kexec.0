Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.105.134] helo=mgw-mx09.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PEFTr-00031V-Fm
	for kexec@lists.infradead.org; Fri, 05 Nov 2010 06:08:56 +0000
Date: Fri, 5 Nov 2010 08:02:26 +0200
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH 2/2] ARM: don't depend on vmalloc_start
Message-ID: <20101105060226.GC17801@esdhcp04058.research.nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<d7f8e9b169c05bc7643b2c01929e38ac3fadf035.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<20101105.111842.14992809.igawa@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101105.111842.14992809.igawa@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ext Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Fri, Nov 05, 2010 at 11:18:42AM +0900, ext Masayuki Igawa wrote:
> 
> Some comments are below.

Thanks for the comments.

> 
> 
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Subject: [PATCH 2/2] ARM: don't depend on vmalloc_start
> Date: Thu,  4 Nov 2010 10:15:17 +0200
> 
> > In ARM, modules are placed in vmalloc'ed area right above user stack and the
> > rest of the vmalloc area is somewhere after high_memory (this can be different
> > on different platforms). Since this value is not stored in vmcoreinfo, we have
> > no means to find out the correct value for vmalloc_start.
> > 
> > So we assume that all V->P translations are within the kernel direct mapped
> > memory and use translation tables only when '--vtop' option is passed.
> > 
> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> > ---
> >  arm.c |   40 +++++++++++++++++++---------------------
> >  1 files changed, 19 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arm.c b/arm.c
> > index 3ea450a..6469f03 100644
> > --- a/arm.c
> > +++ b/arm.c
> > @@ -86,6 +86,9 @@ get_machdep_info_arm(void)
> >  	info->kernel_start = SYMBOL(_stext);
> >  	info->section_size_bits = _SECTION_SIZE_BITS;
> >  
> > +	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
> > +	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
> > +
> >  	/*
> >  	 * For the compatibility, makedumpfile should run without the symbol
> >  	 * vmlist and the offset of vm_struct.addr if they are not necessary.
> > @@ -95,31 +98,28 @@ get_machdep_info_arm(void)
> >  		return TRUE;
> >  	}
> >  
> > +	/*
> > +	 * In ARM the VMALLOC_START can be redefined per platform and we have no
> > +	 * means to read that from the vmcore (there is currently no vmcoreinfo
> > +	 * which specifies that), so we are not going to use vmalloc_start for
> > +	 * anything.
> > +	 */
> >  	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
> >  		ERRMSG("Can't get vmlist.\n");
> > -		return FALSE;
> > +		return TRUE;
> >  	}
> >  	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
> >  		     sizeof(vmalloc_start))) {
> >  		ERRMSG("Can't get vmalloc_start.\n");
> > -		return FALSE;
> > +		return TRUE;
> >  	}
> 
> I think this code can be removed.
> Because this code is easy to misunderstand for users and
> there are no means to check now.

Ok, will do.

> 
> >  
> >  	info->vmalloc_start = vmalloc_start;
> > -
> > -	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
> > -	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
> >  	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
> 
> These codes too?
> There is no need 'info->vmalloc_start' by removing is_vmalloc_addr_arm() in ARM now.
> 

True, will remove that also.

> >  
> >  	return TRUE;
> >  }
> >  
> > -static int
> > -is_vmalloc_addr_arm(unsigned long vaddr)
> > -{
> > -	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
> > -}
> > -
> >  /*
> >   * vtop_arm() - translate arbitrary virtual address to physical
> >   * @vaddr: virtual address to translate
> > @@ -184,17 +184,15 @@ vtop_arm(unsigned long vaddr)
> >  unsigned long long
> >  vaddr_to_paddr_arm(unsigned long vaddr)
> >  {
> > -	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
> > -
> > -	if (paddr != NOT_PADDR)
> > -		return paddr;
> > -
> > -	if (is_vmalloc_addr_arm(vaddr))
> > -		paddr = vtop_arm(vaddr);
> > -	else
> > -		paddr = __pa(vaddr);
> > +	/*
> > +	 * Only use translation tables when user has explicitly requested us to
> > +	 * perform translation for a given address. Otherwise we assume that the
> > +	 * translation is done within the kernel direct mapped region.
> > +	 */
> > +	if (info->vaddr_for_vtop == vaddr)
> > +		return vtop_arm(vaddr);
> >  
> > -	return paddr;
> > +	return __pa(vaddr);
> >  }
> 
> Why do you use vtop tranlation only when '--vtop' option is passed?

Normal makedumpfile run (at least on ARM) only does V->P translation on kernel
directly mapped memory so I considered this to save few clock cycles since that
translation is trivial compared to the one using page tables.

> I think if you don't need vtop translation, vtop_arm() can be removed
> and vaddr_to_paddr_arm() can be like below.

Well my intention was to leave user a option to use '--vtop' for all the kernel
memory (not just for kernel directly mapped memory). IMO, it is useful to have
such option available for debugging etc. Is it ok for you?

I'll prepare v2 of the patches soonish.

Thanks again,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
