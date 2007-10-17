Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ii7Dk-0000dT-Q1
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 12:37:56 +0100
Date: Wed, 17 Oct 2007 13:36:51 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
Message-ID: <20071017113651.GA6963@suse.de>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
	<20071017110550.GB17565@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071017110550.GB17565@in.ibm.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

* Vivek Goyal <vgoyal@in.ibm.com> [2007-10-17 13:05]:
> 
> [..]
> > +/*
> > + * If flags is 0, then the return value is always 0 (success). If
> > + * flags contains BOOTMEM_EXCLUSIVE, then -EBUSY is returned if the
> > + * memory already was reserved.
> > + */
> > +extern int reserve_bootmem(unsigned long addr, unsigned long size, int flags);
> >  #define alloc_bootmem(x) \
> >  	__alloc_bootmem(x, SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
> >  #define alloc_bootmem_low(x) \
> > --- a/mm/bootmem.c
> > +++ b/mm/bootmem.c
> > @@ -111,8 +111,8 @@ static unsigned long __init init_bootmem
> >   * might be used for boot-time allocations - or it might get added
> >   * to the free page pool later on.
> >   */
> > -static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
> > -					unsigned long size)
> > +static int __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
> > +					unsigned long size, int flags)
> >  {
> >  	unsigned long sidx, eidx;
> >  	unsigned long i;
> > @@ -133,7 +133,11 @@ static void __init reserve_bootmem_core(
> >  #ifdef CONFIG_DEBUG_BOOTMEM
> >  			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
> >  #endif
> > +			if (flags & BOOTMEM_EXCLUSIVE)
> > +				return -EBUSY;
> 
> I think we should unreserve the chunks of memory we have reserved so
> far (Memory reserved from sidx to i), in case of error.

Unfortunately, that's not possible without using a lock (or counters
instead of a bitmap) any more. If we just do

	for (i--; i >= sidx; i--)
		clear_bit(i, bdata->node_bootmem_map);

then another thread of execution could reserve the memory (without
BOOTMEM_EXCLUSIVE) in between -- and the code would free the memory
which is already reserved.

I think that could be modelled with a rwlock, not changing the default
case where BOOTMEM_EXCLUSIVE is not specified.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
