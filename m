Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QtyGm-00043W-Ax
	for kexec@lists.infradead.org; Thu, 18 Aug 2011 08:48:09 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7I8m1j6014187
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 08:48:01 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7I8m07J2302102
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 09:48:00 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7I8m0X9010936
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 02:48:00 -0600
Subject: Re: [patch v3 3/8] kdump: Add size to elfcorehdr kernel parameter
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110817210554.GD14813@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
	<20110812134907.325789470@linux.vnet.ibm.com>
	<20110817210554.GD14813@redhat.com>
Date: Thu, 18 Aug 2011 10:47:59 +0200
Message-ID: <1313657279.3528.6.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Wed, 2011-08-17 at 17:05 -0400, Vivek Goyal wrote:
> On Fri, Aug 12, 2011 at 03:48:52PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > Currently only the address of the pre-allocated ELF header is passed with
> > the elfcorehdr= kernel parameter. In order to reserve memory for the header
> > in the 2nd kernel also the size is required. Current kdump architecture
> > backends use different methods to do that, e.g. x86 uses the memmap= kernel
> > parameter. On s390 there is no easy way to transfer this information.
> > Therefore the elfcorehdr kernel parameter is extended to also pass the size.
> > This now can also be used as standard mechanism by all future kdump
> > architecture backends.
> 
> Michael,
> 
> This version looks much better. A quick question. Who parses this
> elfcorehdr= parameter in s390 and how do we make sure these headers are not
> overwritten.

The parameter is parsed in common code (kernel/crash_dump.c) in
early_param("elfcorehdr", setup_elfcorehdr), as it is already currently
the case.

We use address and size of the ELF core header to reserve the header
memory in setup.c (see patch #8):

+#ifdef CONFIG_CRASH_DUMP
+       if (is_kdump_kernel())
+               reserve_bootmem(elfcorehdr_addr - OLDMEM_BASE,
+                               PAGE_ALIGN(elfcorehdr_size), BOOTMEM_DEFAULT);
+#endif

Does that answer your question?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
