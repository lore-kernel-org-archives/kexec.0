Return-path: <kexec-bounces@lists.infradead.org>
Received: from over.ny.us.ibm.com ([32.97.182.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiNOv-0003kl-Og
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 05:54:34 +0100
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9I4ZpSr001129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 00:35:52 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9I4WRp8022627
	for <kexec@lists.infradead.org>; Thu, 18 Oct 2007 00:32:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9I4WR1K425404
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 22:32:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9I4WRr3017692
	for <kexec@lists.infradead.org>; Wed, 17 Oct 2007 22:32:27 -0600
Date: Thu, 18 Oct 2007 10:02:37 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
Message-ID: <20071018043237.GA8779@in.ibm.com>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
	<20071017110550.GB17565@in.ibm.com> <20071017113651.GA6963@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071017113651.GA6963@suse.de>
Reply-To: vgoyal@in.ibm.com
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, ak@suse.de

On Wed, Oct 17, 2007 at 01:36:51PM +0200, Bernhard Walle wrote:
[..]
> > > +static int __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr,
> > > +					unsigned long size, int flags)
> > >  {
> > >  	unsigned long sidx, eidx;
> > >  	unsigned long i;
> > > @@ -133,7 +133,11 @@ static void __init reserve_bootmem_core(
> > >  #ifdef CONFIG_DEBUG_BOOTMEM
> > >  			printk("hm, page %08lx reserved twice.\n", i*PAGE_SIZE);
> > >  #endif
> > > +			if (flags & BOOTMEM_EXCLUSIVE)
> > > +				return -EBUSY;
> > 
> > I think we should unreserve the chunks of memory we have reserved so
> > far (Memory reserved from sidx to i), in case of error.
> 
> Unfortunately, that's not possible without using a lock (or counters
> instead of a bitmap) any more. If we just do
> 
> 	for (i--; i >= sidx; i--)
> 		clear_bit(i, bdata->node_bootmem_map);
> 
> then another thread of execution could reserve the memory (without
> BOOTMEM_EXCLUSIVE) in between -- and the code would free the memory
> which is already reserved.
> 
> I think that could be modelled with a rwlock, not changing the default
> case where BOOTMEM_EXCLUSIVE is not specified.

SMP initialization takes place after bootmem allocator has retired. That
would mean only one thread will be using bootmem allocator. Hence I think
unreserving memory without any kind of locking should be safe.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
