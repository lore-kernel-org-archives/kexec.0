Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PFMjv-0001ZB-B9
	for kexec@lists.infradead.org; Mon, 08 Nov 2010 08:06:08 +0000
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 2/2] ARM: don't depend on vmalloc_start
Date: Mon,  8 Nov 2010 09:59:28 +0200
Message-Id: <f8ed2b94b119fefb6c5f86cd6d9c22bc3d5026ad.1289202688.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
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
To: igawa@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

In ARM, modules are placed in vmalloc'ed area right above user stack and the rest
of the vmalloc area is somewhere after high_memory (this can be different from
different platforms). This value is not stored in vmcoreinfo so we have no means
to find out the correct vmalloc_start value.

So we assume that all V->P translations are within the kernel direct mapped
memory and use translation tables only when '--vtop' option is passed.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arm.c |   48 ++++++++----------------------------------------
 1 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arm.c b/arm.c
index 3ea450a..00ca654 100644
--- a/arm.c
+++ b/arm.c
@@ -79,47 +79,17 @@ get_phys_base_arm(void)
 int
 get_machdep_info_arm(void)
 {
-	unsigned long vmlist, vmalloc_start;
-
 	info->page_offset = SYMBOL(_stext) & 0xffff0000UL;
 	info->max_physmem_bits = _MAX_PHYSMEM_BITS;
 	info->kernel_start = SYMBOL(_stext);
 	info->section_size_bits = _SECTION_SIZE_BITS;
 
-	/*
-	 * For the compatibility, makedumpfile should run without the symbol
-	 * vmlist and the offset of vm_struct.addr if they are not necessary.
-	 */
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL) ||
-		OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE) {
-		return TRUE;
-	}
-
-	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
-		ERRMSG("Can't get vmlist.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
-		     sizeof(vmalloc_start))) {
-		ERRMSG("Can't get vmalloc_start.\n");
-		return FALSE;
-	}
-
-	info->vmalloc_start = vmalloc_start;
-
 	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
 	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
-	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
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
@@ -184,17 +154,15 @@ vtop_arm(unsigned long vaddr)
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
