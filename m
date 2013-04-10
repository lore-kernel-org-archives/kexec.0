Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPpI5-0005ZE-4u
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 07:17:58 +0000
Date: Wed, 10 Apr 2013 16:10:52 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RESEND PATCH 3/4] Use vmap_area_list to get vmalloc_start for ppc32.
Message-Id: <20130410161052.f25fe041330732e3c2252305@mxc.nes.nec.co.jp>
In-Reply-To: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
References: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
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
Cc: linuxppc-dev@lists.ozlabs.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Fri, 15 Mar 2013 19:30:23 +0900
Subject: [PATCH 3/4] Use vmap_area_list to get vmalloc_start for ppc32.

Try to get vmalloc_start value from vmap_area_list first for
newer ppc32 kernels.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 arch/ppc.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index 2bc8d5f..a9b4812 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -44,22 +44,40 @@ get_machdep_info_ppc(void)
 	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
 
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
+		 * vmlist and the offset of vm_struct.addr if they are not necessary.
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
