Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPUVP-0004M2-7q
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 09:06:20 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3996DnK008294
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:06:13 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id r3996D411516 for kexec@lists.infradead.org;
 Tue, 9 Apr 2013 18:06:13 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3996Cbn008113
 for <kexec@lists.infradead.org>; Tue, 9 Apr 2013 18:06:12 +0900 (JST)
Date: Tue, 9 Apr 2013 17:28:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 2/4] Use vmap_area_list to get vmalloc_start for i386.
Message-Id: <20130409172835.e7d6216f792f3576a6ab6671@mxc.nes.nec.co.jp>
In-Reply-To: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
References: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 14 Mar 2013 19:10:49 +0900
Subject: [PATCH 2/4] Use vmap_area_list to get vmalloc_start for i386.

Try to get vmalloc_start value from vmap_area_list first for
newer i386 kernels.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 arch/x86.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/x86.c b/arch/x86.c
index ef29e3c..e397905 100644
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -70,7 +70,7 @@ remap_init(void)
 int
 get_machdep_info_x86(void)
 {
-	unsigned long vmlist, vmalloc_start;
+	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
 	/* PAE */
 	if ((vt.mem_flags & MEMORY_X86_PAE)
@@ -100,22 +100,40 @@ get_machdep_info_x86(void)
 		return FALSE;
 
 	/*
-	 * For the compatibility, makedumpfile should run without the symbol
-	 * vmlist and the offset of vm_struct.addr if they are not necessary.
+	 * Get vmalloc_start value from either vmap_area_list or vmlist.
 	 */
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+	if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
+	    && (OFFSET(vmap_area.va_start) != NOT_FOUND_STRUCTURE)
+	    && (OFFSET(vmap_area.list) != NOT_FOUND_STRUCTURE)) {
+		if (!readmem(VADDR, SYMBOL(vmap_area_list) + OFFSET(list_head.next),
+			     &vmap_area_list, sizeof(vmap_area_list))) {
+			ERRMSG("Can't get vmap_area_list.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR, vmap_area_list - OFFSET(vmap_area.list) +
+			     OFFSET(vmap_area.va_start), &vmalloc_start,
+			     sizeof(vmalloc_start))) {
+			ERRMSG("Can't get vmalloc_start.\n");
+			return FALSE;
+		}
+	} else if ((SYMBOL(vmlist) != NOT_FOUND_SYMBOL)
+		   && (OFFSET(vm_struct.addr) != NOT_FOUND_STRUCTURE)) {
+		if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
+			ERRMSG("Can't get vmlist.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
+			     sizeof(vmalloc_start))) {
+			ERRMSG("Can't get vmalloc_start.\n");
+			return FALSE;
+		}
+	} else {
+		/*
+		 * For the compatibility, makedumpfile should run without the symbol
+		 * used to get vmalloc_start value if they are not necessary.
+		 */
 		return TRUE;
 	}
-	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
-		ERRMSG("Can't get vmlist.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
-	    sizeof(vmalloc_start))) {
-		ERRMSG("Can't get vmalloc_start.\n");
-		return FALSE;
-	}
 	info->vmalloc_start = vmalloc_start;
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
-- 
1.8.0.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
