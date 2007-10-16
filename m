Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhrQF-00074z-Kk
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 19:45:46 +0100
Date: Tue, 16 Oct 2007 20:44:40 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
Message-ID: <20071016184440.GA19844@suse.de>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
	<1192558097.17464.15.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1192558097.17464.15.camel@localhost>
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
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

Hi,

* Dave Hansen <haveblue@us.ibm.com> [2007-10-16 20:08]:
> On Tue, 2007-10-16 at 18:28 +0200, Bernhard Walle wrote:
> > 
> > @@ -736,7 +736,7 @@ static int __init smp_scan_config (unsig
> >                         smp_found_config = 1;
> >                         printk(KERN_INFO "found SMP MP-table at %08lx\n",
> >                                                 virt_to_phys(mpf));
> > -                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
> > +                       reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE, 0);
> >                         if (mpf->mpf_physptr) {
> >                                 /* 
> 
> Could you give all of these 0's a name?  I really hate seeing random
> magic numbers in these things.  0 completely kills the ability of
> someone to read the code and figure out what it is trying to do without
> going and looking at reserve_bootmem().

Of course I can replace that zeroes with something like BOOTMEM_DEFAULT.

> Or, alternatively, do something like this:
> 
> -extern void reserve_bootmem(unsigned long addr, unsigned long size);

Andi was against more bootmem functions. ;)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
