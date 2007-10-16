Return-path: <kexec-bounces@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhroU-00086t-5A
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 20:10:50 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9GIwEec032386
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 14:58:14 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9GIwDMr408436
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 12:58:13 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9GIwDkQ021874
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 12:58:13 -0600
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20071016184440.GA19844@suse.de>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
	<1192558097.17464.15.camel@localhost> <20071016184440.GA19844@suse.de>
Date: Tue, 16 Oct 2007 11:58:13 -0700
Message-Id: <1192561093.17464.21.camel@localhost>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

On Tue, 2007-10-16 at 20:44 +0200, Bernhard Walle wrote:
> * Dave Hansen <haveblue@us.ibm.com> [2007-10-16 20:08]:
> > On Tue, 2007-10-16 at 18:28 +0200, Bernhard Walle wrote:
> > > 
> > > @@ -736,7 +736,7 @@ static int __init smp_scan_config (unsig
> > >                         smp_found_config = 1;
> > >                         printk(KERN_INFO "found SMP MP-table at %08lx\n",
> > >                                                 virt_to_phys(mpf));
> > > -                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
> > > +                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE, 0);
> > >                         if (mpf->mpf_physptr) {
> > >                                 /* 
> > 
> > Could you give all of these 0's a name?  I really hate seeing random
> > magic numbers in these things.  0 completely kills the ability of
> > someone to read the code and figure out what it is trying to do without
> > going and looking at reserve_bootmem().
> 
> Of course I can replace that zeroes with something like BOOTMEM_DEFAULT.

Cool.

> > Or, alternatively, do something like this:
> > 
> > -extern void reserve_bootmem(unsigned long addr, unsigned long size);
> 
> Andi was against more bootmem functions. ;)

Yeah, I can't really blame him.

-- Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
