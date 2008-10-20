Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KrmwJ-0004SR-3q
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 05:04:23 +0000
Message-ID: <48FC0E68.50902@mxs.nes.nec.co.jp>
Date: Mon, 20 Oct 2008 13:51:52 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] kdump: Fix invalid access on i386 sparsemem.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0851964508=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

--===============0851964508==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

Since linux-2.6.27, kdump has failed on i386 sparsemem kernel.
1st-kernel gets a panic just before switching to 2nd-kernel.

The cause is that a kernel accesses invalid mem_section by
page_to_pfn(image->swap_page) at machine_kexec().
image->swap_page is allocated if kexec for hibernation, but
it is not allocated if kdump. So if kdump, a kernel should
not access the mem_section corresponding to image->swap_page.
The attached patch fixes this invalid access.


Thanks
Ken'ichi Ohmichi

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
--- a/arch/x86/kernel/machine_kexec_32.c	2008-10-10 07:13:53.000000000 +0900
+++ b/arch/x86/kernel/machine_kexec_32.c	2008-10-17 20:38:37.000000000 +0900
@@ -162,7 +162,10 @@ void machine_kexec(struct kimage *image)
 	page_list[VA_PTE_0] = (unsigned long)kexec_pte0;
 	page_list[PA_PTE_1] = __pa(kexec_pte1);
 	page_list[VA_PTE_1] = (unsigned long)kexec_pte1;
-	page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page) << PAGE_SHIFT);
+
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
+						<< PAGE_SHIFT);
 
 	/* The segment registers are funny things, they have both a
 	 * visible and an invisible part.  Whenever the visible part is
_


--===============0851964508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0851964508==--
