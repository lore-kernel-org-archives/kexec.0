Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JC9rP-0002rv-Sh
	for kexec@lists.infradead.org; Tue, 08 Jan 2008 08:31:07 +0000
Date: Tue, 8 Jan 2008 09:30:44 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] i386: handle an initrd in highmem (version 2)
Message-ID: <20080108083044.GI31838@elte.hu>
References: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hbabu@us.ibm.com, Ingo Molnar <mingo@redhat.com>, Thomas Gleixer <tglx@linutronix.de>, vgoyal@redhat.com


* H. Peter Anvin <hpa@zytor.com> wrote:

> Fix crash on NUMA reported by Dhaval Giani (reported as being a kexec 
> issue.)

here's the delta fix.

	Ingo

Index: linux-x86.q/arch/x86/kernel/setup_32.c
===================================================================
--- linux-x86.q.orig/arch/x86/kernel/setup_32.c
+++ linux-x86.q/arch/x86/kernel/setup_32.c
@@ -510,16 +510,20 @@ static void __init reserve_initrd(void)
 	unsigned long end_of_lowmem = max_low_pfn << PAGE_SHIFT;
 	unsigned long ramdisk_here;
 
+	initrd_start = 0;
+
+	if (!boot_params.hdr.type_of_loader ||
+	    !ramdisk_image || !ramdisk_size)
+		return;		/* No initrd provided by bootloader */
+
 	if (ramdisk_end < ramdisk_image) {
-		printk(KERN_ERR "initrd wraps around end of memory\n"
-		       KERN_ERR "disabling initrd\n");
-		initrd_start = 0;
+		printk(KERN_ERR "initrd wraps around end of memory, "
+		       "disabling initrd\n");
 		return;
 	}
 	if (ramdisk_size >= end_of_lowmem/2) {
-		printk(KERN_ERR "initrd too large to handle\n"
-		       KERN_ERR "disabling initrd\n");
-		initrd_start = 0;
+		printk(KERN_ERR "initrd too large to handle, "
+		       "disabling initrd\n");
 		return;
 	}
 	if (ramdisk_end <= end_of_lowmem) {
@@ -554,9 +558,10 @@ static void __init relocate_initrd(void)
 	char *p, *q;
 
 	if (!do_relocate_initrd)
-		return;		/* Nothing to do here... */
+		return;
 
 	ramdisk_here = initrd_start - PAGE_OFFSET;
+
 	q = (char *)initrd_start;
 
 	/* Copy any lowmem portion of the initrd */
@@ -642,11 +647,10 @@ void __init setup_bootmem_allocator(void
 	 */
 	find_smp_config();
 #endif
-	numa_kva_reserve();
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (boot_params.hdr.type_of_loader && boot_params.hdr.ramdisk_image)
-		reserve_initrd();
+	reserve_initrd();
 #endif
+	numa_kva_reserve();
 	reserve_crashkernel();
 }
 
@@ -799,12 +803,13 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
-	paravirt_post_allocator_init();
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	relocate_initrd();
 #endif
 
+	paravirt_post_allocator_init();
+
 	dmi_scan_machine();
 
 	io_delay_init();
Index: linux-x86.q/arch/x86/mm/discontig_32.c
===================================================================
--- linux-x86.q.orig/arch/x86/mm/discontig_32.c
+++ linux-x86.q/arch/x86/mm/discontig_32.c
@@ -288,8 +288,8 @@ unsigned long __init setup_memory(void)
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Numa kva area is below the initrd */
-	if (boot_params.hdr.type_of_loader && boot_params.hdr.ramdisk_image)
-		kva_start_pfn = PFN_DOWN(boot_params.hdr.ramdisk_image)
+	if (initrd_start)
+		kva_start_pfn = PFN_DOWN(initrd_start - PAGE_OFFSET)
 			- kva_pages;
 #endif
 	kva_start_pfn -= kva_start_pfn & (PTRS_PER_PTE-1);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
