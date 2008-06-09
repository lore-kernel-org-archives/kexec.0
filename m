Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5hKC-0007HS-19
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 13:22:16 +0000
Date: Mon, 9 Jun 2008 09:22:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080609132207.GC3542@redhat.com>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<87bq2bmvro.fsf@saeurebad.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bq2bmvro.fsf@saeurebad.de>
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
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de

On Mon, Jun 09, 2008 at 12:01:15AM +0200, Johannes Weiner wrote:
> Hi,
> 
> Bernhard Walle <bwalle@suse.de> writes:
> 
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -798,12 +798,13 @@ void free_initrd_mem(unsigned long start
> >  }
> >  #endif
> >  
> > -void __init reserve_bootmem_generic(unsigned long phys, unsigned len)
> > +int __init reserve_bootmem_generic(unsigned long phys, unsigned len, int flags)
> >  {
> >  #ifdef CONFIG_NUMA
> >  	int nid, next_nid;
> >  #endif
> >  	unsigned long pfn = phys >> PAGE_SHIFT;
> > +	int ret;
> >  
> >  	if (pfn >= end_pfn) {
> >  		/*
> > @@ -811,11 +812,11 @@ void __init reserve_bootmem_generic(unsi
> >  		 * firmware tables:
> >  		 */
> >  		if (pfn < max_pfn_mapped)
> > -			return;
> > +			return -EFAULT;
> 
> This seemed to be `just do nothing' behaviour.  Wouldn't 0 be more
> correct here?  Or something else so there is a difference between the
> path that does not print a warning (the one below) and the path that
> does?

Bernard,

This is interesting. IIUC, end_pfn represents end of physical RAM and
max_pfn_mapped represents, end of other tables like ACPI which are
mapped in higher regions.

Kdump first kernel always tries to reserve just physical RAM and nothing
else. So I am not sure what does above code do. Try to reserve a memory
which is not RAM but is in the region less than highest mapped entity and
in that case return silently without any warning. In what case do we
exercise this path?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
