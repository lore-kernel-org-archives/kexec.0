Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([147.243.1.48] helo=mgw-sa02.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PDv57-00039F-7Z
	for kexec@lists.infradead.org; Thu, 04 Nov 2010 08:22:02 +0000
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 2/2] ARM: don't depend on vmalloc_start
Date: Thu,  4 Nov 2010 10:15:17 +0200
Message-Id: <d7f8e9b169c05bc7643b2c01929e38ac3fadf035.1288788355.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: igawa@mxs.nes.nec.co.jp, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

In ARM, modules are placed in vmalloc'ed area right above user stack and the
rest of the vmalloc area is somewhere after high_memory (this can be different
on different platforms). Since this value is not stored in vmcoreinfo, we have
no means to find out the correct value for vmalloc_start.

So we assume that all V->P translations are within the kernel direct mapped
memory and use translation tables only when '--vtop' option is passed.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arm.c |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arm.c b/arm.c
index 3ea450a..6469f03 100644
--- a/arm.c
+++ b/arm.c
@@ -86,6 +86,9 @@ get_machdep_info_arm(void)
 	info->kernel_start = SYMBOL(_stext);
 	info->section_size_bits = _SECTION_SIZE_BITS;
 
+	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
+	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
+
 	/*
 	 * For the compatibility, makedumpfile should run without the symbol
 	 * vmlist and the offset of vm_struct.addr if they are not necessary.
@@ -95,31 +98,28 @@ get_machdep_info_arm(void)
 		return TRUE;
 	}
 
+	/*
+	 * In ARM the VMALLOC_START can be redefined per platform and we have no
+	 * means to read that from the vmcore (there is currently no vmcoreinfo
+	 * which specifies that), so we are not going to use vmalloc_start for
+	 * anything.
+	 */
 	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
 		ERRMSG("Can't get vmlist.\n");
-		return FALSE;
+		return TRUE;
 	}
 	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
 		     sizeof(vmalloc_start))) {
 		ERRMSG("Can't get vmalloc_start.\n");
-		return FALSE;
+		return TRUE;
 	}
 
 	info->vmalloc_start = vmalloc_start;
-
-	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
-	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
 	return TRUE;
 }
 
-static int
-is_vmalloc_addr_arm(unsigned long vaddr)
-{
-	return (info->vmalloc_start && vaddr >= info->vmalloc_start);
-}
-
 /*
  * vtop_arm() - translate arbitrary virtual address to physical
  * @vaddr: virtual address to translate
@@ -184,17 +184,15 @@ vtop_arm(unsigned long vaddr)
 unsigned long long
 vaddr_to_paddr_arm(unsigned long vaddr)
 {
-	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
-
-	if (paddr != NOT_PADDR)
-		return paddr;
-
-	if (is_vmalloc_addr_arm(vaddr))
-		paddr = vtop_arm(vaddr);
-	else
-		paddr = __pa(vaddr);
+	/*
+	 * Only use translation tables when user has explicitly requested us to
+	 * perform translation for a given address. Otherwise we assume that the
+	 * translation is done within the kernel direct mapped region.
+	 */
+	if (info->vaddr_for_vtop == vaddr)
+		return vtop_arm(vaddr);
 
-	return paddr;
+	return __pa(vaddr);
 }
 
 #endif /* __arm__ */
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
