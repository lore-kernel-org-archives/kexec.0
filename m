Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5kMn-0004ar-0C
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 16:37:09 +0000
Date: Mon, 9 Jun 2008 18:37:44 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080609183744.4dc04784@halley.suse.de>
In-Reply-To: <877iczmvir.fsf@saeurebad.de>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<877iczmvir.fsf@saeurebad.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

* Johannes Weiner [2008-06-09 00:06]:
>
> > +
> >  #else
> >  	reserve_bootmem(phys, len, BOOTMEM_DEFAULT);  
>                                    ^^^^^^^^^^^^^^^   flags?
> And you ignore the return value here.

Thanks for catching that. Updated patch:

------------------------------------------------------------------
From: Bernhard Walle <bwalle@suse.de>
Subject: Add 'flags' parameter to reserve_bootmem_generic()

This patch adds a 'flags' parameter to reserve_bootmem_generic() like it
already has been added in reserve_bootmem() with commit
72a7fe3967dbf86cb34e24fbf1d957fe24d2f246.

It also changes all users to use BOOTMEM_DEFAULT, which doesn't effectively
change the behaviour. Since the change is x86-specific, I don't think it's
necessary to add a new API for migration. There are only 4 users of that
function.

The change is necessary for the next patch, using reserve_bootmem_generic()
for crashkernel reservation.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/x86/kernel/e820_64.c |    3 ++-
 arch/x86/kernel/efi_64.c  |    3 ++-
 arch/x86/kernel/mpparse.c |    5 +++--
 arch/x86/mm/init_64.c     |   19 +++++++++++++------
 include/asm-x86/proto.h   |    2 +-
 5 files changed, 21 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/e820_64.c
+++ b/arch/x86/kernel/e820_64.c
@@ -118,7 +118,8 @@ void __init early_res_to_bootmem(unsigne
 			continue;
 		printk(KERN_INFO "  early res: %d [%lx-%lx] %s\n", i,
 			final_start, final_end - 1, r->name);
-		reserve_bootmem_generic(final_start, final_end - final_start);
+		reserve_bootmem_generic(final_start, final_end - final_start,
+			BOOTMEM_DEFAULT);
 	}
 }
 
--- a/arch/x86/kernel/efi_64.c
+++ b/arch/x86/kernel/efi_64.c
@@ -100,7 +100,8 @@ void __init efi_call_phys_epilog(void)
 void __init efi_reserve_bootmem(void)
 {
 	reserve_bootmem_generic((unsigned long)memmap.phys_map,
-				memmap.nr_map * memmap.desc_size);
+				memmap.nr_map * memmap.desc_size,
+				BOOTMEM_DEFAULT);
 }
 
 void __iomem * __init efi_ioremap(unsigned long phys_addr, unsigned long size)
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -729,10 +729,11 @@ static int __init smp_scan_config(unsign
 			if (!reserve)
 				return 1;
 
-			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE);
+			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE,
+				BOOTMEM_DEFAULT);
 			if (mpf->mpf_physptr)
 				reserve_bootmem_generic(mpf->mpf_physptr,
-							PAGE_SIZE);
+					PAGE_SIZE, BOOTMEM_DEFAULT);
 #endif
 		return 1;
 		}
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -798,12 +798,13 @@ void free_initrd_mem(unsigned long start
 }
 #endif
 
-void __init reserve_bootmem_generic(unsigned long phys, unsigned len)
+int __init reserve_bootmem_generic(unsigned long phys, unsigned len, int flags)
 {
 #ifdef CONFIG_NUMA
 	int nid, next_nid;
 #endif
 	unsigned long pfn = phys >> PAGE_SHIFT;
+	int ret;
 
 	if (pfn >= end_pfn) {
 		/*
@@ -811,11 +812,11 @@ void __init reserve_bootmem_generic(unsi
 		 * firmware tables:
 		 */
 		if (pfn < max_pfn_mapped)
-			return;
+			return -EFAULT;
 
 		printk(KERN_ERR "reserve_bootmem: illegal reserve %lx %u\n",
 				phys, len);
-		return;
+		return -EFAULT;
 	}
 
 	/* Should check here against the e820 map to avoid double free */
@@ -823,17 +824,23 @@ void __init reserve_bootmem_generic(unsi
 	nid = phys_to_nid(phys);
 	next_nid = phys_to_nid(phys + len - 1);
 	if (nid == next_nid)
-		reserve_bootmem_node(NODE_DATA(nid), phys, len, BOOTMEM_DEFAULT);
+		ret = reserve_bootmem_node(NODE_DATA(nid), phys, len, flags);
 	else
-		reserve_bootmem(phys, len, BOOTMEM_DEFAULT);
+		ret = reserve_bootmem(phys, len, flags);
+
 #else
-	reserve_bootmem(phys, len, BOOTMEM_DEFAULT);
+	ret = reserve_bootmem(phys, len, flags);
 #endif
 
+	if (ret != 0)
+		return ret;
+
 	if (phys+len <= MAX_DMA_PFN*PAGE_SIZE) {
 		dma_reserve += len / PAGE_SIZE;
 		set_dma_reserve(dma_reserve);
 	}
+
+	return 0;
 }
 
 int kern_addr_valid(unsigned long addr)
--- a/include/asm-x86/proto.h
+++ b/include/asm-x86/proto.h
@@ -14,7 +14,7 @@ extern void ia32_syscall(void);
 extern void ia32_cstar_target(void);
 extern void ia32_sysenter_target(void);
 
-extern void reserve_bootmem_generic(unsigned long phys, unsigned len);
+extern int reserve_bootmem_generic(unsigned long phys, unsigned len, int flags);
 
 extern void syscall32_cpu_init(void);
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
