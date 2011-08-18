Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qu6OJ-0000WR-VI
	for kexec@lists.infradead.org; Thu, 18 Aug 2011 17:28:28 +0000
Date: Thu, 18 Aug 2011 13:28:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v3 3/8] kdump: Add size to elfcorehdr kernel parameter
Message-ID: <20110818172815.GD15413@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
	<20110812134907.325789470@linux.vnet.ibm.com>
	<20110817210554.GD14813@redhat.com>
	<1313657279.3528.6.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313657279.3528.6.camel@br98xy6r>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Thu, Aug 18, 2011 at 10:47:59AM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Wed, 2011-08-17 at 17:05 -0400, Vivek Goyal wrote:
> > On Fri, Aug 12, 2011 at 03:48:52PM +0200, Michael Holzheu wrote:
> > > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > 
> > > Currently only the address of the pre-allocated ELF header is passed with
> > > the elfcorehdr= kernel parameter. In order to reserve memory for the header
> > > in the 2nd kernel also the size is required. Current kdump architecture
> > > backends use different methods to do that, e.g. x86 uses the memmap= kernel
> > > parameter. On s390 there is no easy way to transfer this information.
> > > Therefore the elfcorehdr kernel parameter is extended to also pass the size.
> > > This now can also be used as standard mechanism by all future kdump
> > > architecture backends.
> > 
> > Michael,
> > 
> > This version looks much better. A quick question. Who parses this
> > elfcorehdr= parameter in s390 and how do we make sure these headers are not
> > overwritten.
> 
> The parameter is parsed in common code (kernel/crash_dump.c) in
> early_param("elfcorehdr", setup_elfcorehdr), as it is already currently
> the case.
> 
> We use address and size of the ELF core header to reserve the header
> memory in setup.c (see patch #8):
> 
> +#ifdef CONFIG_CRASH_DUMP
> +       if (is_kdump_kernel())
> +               reserve_bootmem(elfcorehdr_addr - OLDMEM_BASE,
> +                               PAGE_ALIGN(elfcorehdr_size), BOOTMEM_DEFAULT);
> +#endif
> 
> Does that answer your question?

Yes it does. Thanks.

It brings up few more questions about rest of the memory mangement.

So kdump kernel is loaded in reserved area but does not run from there.
It reloads itself into lower memory areas and swaps the contents of
lower memory with reserved memory? If yes, how does it, kernel or
purgatory?

How does kernel come to know about how much memory is to be swapped
and how do you bound the memory usage of second kernel so that it
does not try to use other memory which has not been swapped into
reserved area.

Thanks
Vivek 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
