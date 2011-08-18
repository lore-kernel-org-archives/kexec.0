Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qu6pq-0000bn-8a
	for kexec@lists.infradead.org; Thu, 18 Aug 2011 17:56:55 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7IHulp8002391
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 17:56:47 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7IHulDM2555916
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 18:56:47 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7IHuk4M016168
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 11:56:47 -0600
Subject: Re: [patch v3 3/8] kdump: Add size to elfcorehdr kernel parameter
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110818172815.GD15413@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
	<20110812134907.325789470@linux.vnet.ibm.com>
	<20110817210554.GD14813@redhat.com> <1313657279.3528.6.camel@br98xy6r>
	<20110818172815.GD15413@redhat.com>
Date: Thu, 18 Aug 2011 19:56:46 +0200
Message-ID: <1313690206.3528.32.camel@br98xy6r>
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

On Thu, 2011-08-18 at 13:28 -0400, Vivek Goyal wrote:
> > The parameter is parsed in common code (kernel/crash_dump.c) in
> > early_param("elfcorehdr", setup_elfcorehdr), as it is already currently
> > the case.
> > 
> > We use address and size of the ELF core header to reserve the header
> > memory in setup.c (see patch #8):
> > 
> > +#ifdef CONFIG_CRASH_DUMP
> > +       if (is_kdump_kernel())
> > +               reserve_bootmem(elfcorehdr_addr - OLDMEM_BASE,
> > +                               PAGE_ALIGN(elfcorehdr_size), BOOTMEM_DEFAULT);
> > +#endif
> > 
> > Does that answer your question?
> 
> Yes it does. Thanks.
> 
> It brings up few more questions about rest of the memory mangement.
> 
> So kdump kernel is loaded in reserved area but does not run from there.
> It reloads itself into lower memory areas and swaps the contents of
> lower memory with reserved memory? If yes, how does it, kernel or
> purgatory?

With the v3 patch series purgatory does that (see
purgatory-s390.c/post_verification_setup_arch()):

> How does kernel come to know about how much memory is to be swapped

2nd kernel knows crash_base and crash_base because kexec tools told him
that. We do it like registering the ramdisk. See kexec-image.c:

+               if (info->kexec_flags & KEXEC_ON_CRASH) {
+                       tmp = krnl_buffer + OLDMEM_BASE_OFFS;
+                       *tmp = crash_base;
+
+                       tmp = krnl_buffer + OLDMEM_SIZE_OFFS;
+                       *tmp = crash_end - crash_base + 1;
+               }

> and how do you bound the memory usage of second kernel so that it
> does not try to use other memory which has not been swapped into
> reserved area.

See kernel patches setup.c:

+/*
+ * Make sure that oldmem, where the dump is stored, is protected
+ */
+static void reserve_oldmem(void)
+{
+#ifdef CONFIG_CRASH_DUMP
+       if (!is_kdump_kernel())
+               return;
+
+       reserve_kdump_bootmem(OLDMEM_BASE, OLDMEM_SIZE, CHUNK_OLDMEM);
+       reserve_kdump_bootmem(OLDMEM_SIZE, memory_end - OLDMEM_SIZE,
+                             CHUNK_OLDMEM);
+       if (OLDMEM_BASE + OLDMEM_SIZE == real_memory_size)
+               saved_max_pfn = PFN_DOWN(OLDMEM_BASE) - 1;
+       else
+               saved_max_pfn = PFN_DOWN(real_memory_size) - 1;
+#endif
+}

Michael











_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
