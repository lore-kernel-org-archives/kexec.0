Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PEH0J-0003dI-SL
	for kexec@lists.infradead.org; Fri, 05 Nov 2010 07:46:34 +0000
Date: Fri, 5 Nov 2010 16:41:34 +0900
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH 2/2] ARM: don't depend on vmalloc_start
Message-Id: <20101105164134.314fd489.igawa@mxs.nes.nec.co.jp>
In-Reply-To: <20101105060226.GC17801@esdhcp04058.research.nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<d7f8e9b169c05bc7643b2c01929e38ac3fadf035.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<20101105.111842.14992809.igawa@mxs.nes.nec.co.jp>
	<20101105060226.GC17801@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
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
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: kexec@lists.infradead.org

Thanks for quick reply.

On Fri, 5 Nov 2010 08:02:26 +0200, Mika Westerberg wrote:
> On Fri, Nov 05, 2010 at 11:18:42AM +0900, ext Masayuki Igawa wrote:

> > >  
> > >  	return TRUE;
> > >  }
> > >  
> > > -static int
> > > -is_vmalloc_addr_arm(unsigned long vaddr)
> > > -{
> > > -	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
> > > -}
> > > -
> > >  /*
> > >   * vtop_arm() - translate arbitrary virtual address to physical
> > >   * @vaddr: virtual address to translate
> > > @@ -184,17 +184,15 @@ vtop_arm(unsigned long vaddr)
> > >  unsigned long long
> > >  vaddr_to_paddr_arm(unsigned long vaddr)
> > >  {
> > > -	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
> > > -
> > > -	if (paddr != NOT_PADDR)
> > > -		return paddr;
> > > -
> > > -	if (is_vmalloc_addr_arm(vaddr))
> > > -		paddr = vtop_arm(vaddr);
> > > -	else
> > > -		paddr = __pa(vaddr);
> > > +	/*
> > > +	 * Only use translation tables when user has explicitly requested us to
> > > +	 * perform translation for a given address. Otherwise we assume that the
> > > +	 * translation is done within the kernel direct mapped region.
> > > +	 */
> > > +	if (info->vaddr_for_vtop == vaddr)
> > > +		return vtop_arm(vaddr);
> > >  
> > > -	return paddr;
> > > +	return __pa(vaddr);
> > >  }
> > 
> > Why do you use vtop tranlation only when '--vtop' option is passed?
> 
> Normal makedumpfile run (at least on ARM) only does V->P translation on kernel
> directly mapped memory so I considered this to save few clock cycles since that
> translation is trivial compared to the one using page tables.

Unfortunately, I'm not good at ARM. So I have a few questions.
In (all) ARM, is all the kernel memory directly mapped?
The result of vtop_arm()'s translation is always equals __pa()'s in ARM?

> 
> > I think if you don't need vtop translation, vtop_arm() can be removed
> > and vaddr_to_paddr_arm() can be like below.
> 
> Well my intention was to leave user a option to use '--vtop' for all the kernel
> memory (not just for kernel directly mapped memory). IMO, it is useful to have
> such option available for debugging etc. Is it ok for you?

IIUC, is there the kernel memory which isn't directly mapped?
If so, the memory(which isn't directly mapped) is not supported by your patch?

> 
> I'll prepare v2 of the patches soonish.

Thanks!
-- Masayuki Igawa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
