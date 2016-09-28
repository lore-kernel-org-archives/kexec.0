Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bp7D4-00012W-NN
 for kexec@lists.infradead.org; Wed, 28 Sep 2016 05:15:11 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S5CiQb143005
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:54 -0400
Received: from e28smtp02.in.ibm.com ([125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qy5sb9j6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 01:14:54 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 10:44:49 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 987961258060
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:45:08 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S5EkiG31523002
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S5Ejlf023481
 for <kexec@lists.infradead.org>; Wed, 28 Sep 2016 10:44:46 +0530
Subject: [RESEND PATCH 6/8] makedumpfile/ppc64: support big endian Linux
 page tables
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 28 Sep 2016 10:44:43 +0530
In-Reply-To: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
References: <147503943620.1199.14586683563637783549.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147503966970.1199.16098946564660944300.stgit@hbathini.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

Power ISA 3.0 defines a new MMU mode, known as Radix Tree Translation,
where hardware can directly operate on the Linux page tables. However
the hardware requires that the page tables be in big endian format.
Starting with kernel v4.7, Linux page tables are big endian for both
radix and hash MMU modes on server processors. This patch makes the
corresponding changes here.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 69f6348..6b82cc2 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -23,6 +23,25 @@
 #include "../print_info.h"
 #include "../elf_info.h"
 #include "../makedumpfile.h"
+#include <endian.h>
+
+/*
+ * Swaps a 8 byte value
+ */
+static ulong swap64(ulong val, uint swap)
+{
+	if (swap)
+		return (((val & 0x00000000000000ffULL) << 56) |
+			((val & 0x000000000000ff00ULL) << 40) |
+			((val & 0x0000000000ff0000ULL) << 24) |
+			((val & 0x00000000ff000000ULL) <<  8) |
+			((val & 0x000000ff00000000ULL) >>  8) |
+			((val & 0x0000ff0000000000ULL) >> 24) |
+			((val & 0x00ff000000000000ULL) >> 40) |
+			((val & 0xff00000000000000ULL) >> 56));
+	else
+		return val;
+}
 
 /*
  * Convert physical address to kernel virtual address
@@ -325,6 +344,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 	unsigned long long pgd_pte, pud_pte;
 	unsigned long long pmd_pte, pte;
 	unsigned long long paddr = NOT_PADDR;
+	uint swap = 0;
 
 	if (info->page_buf == NULL) {
 		/*
@@ -338,13 +358,23 @@ ppc64_vtop_level4(unsigned long vaddr)
 		}
 	}
 
+	if (info->kernel_version >= KERNEL_VERSION(4, 7, 0)) {
+		/*
+		 * Starting with kernel v4.7, page table entries are always
+		 * big endian on server processors. Set this flag if
+		 * kernel is not big endian.
+		 */
+		if (__BYTE_ORDER == __LITTLE_ENDIAN)
+			swap = 1;
+	}
+
 	level4 = (ulong *)info->kernel_pgd;
 	pgdir = (ulong *)((ulong *)level4 + PGD_OFFSET_L4(vaddr));
 	if (!readmem(VADDR, PAGEBASE(level4), info->page_buf, PAGESIZE())) {
 		ERRMSG("Can't read PGD page: 0x%llx\n", PAGEBASE(level4));
 		return NOT_PADDR;
 	}
-	pgd_pte = ULONG((info->page_buf + PAGEOFFSET(pgdir)));
+	pgd_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(pgdir))), swap);
 	if (!pgd_pte)
 		return NOT_PADDR;
 
@@ -358,7 +388,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 			ERRMSG("Can't read PUD page: 0x%llx\n", PAGEBASE(pgd_pte));
 			return NOT_PADDR;
 		}
-		pud_pte = ULONG((info->page_buf + PAGEOFFSET(page_upper)));
+		pud_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(page_upper))), swap);
 		if (!pud_pte)
 			return NOT_PADDR;
 	} else {
@@ -371,7 +401,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 		ERRMSG("Can't read PMD page: 0x%llx\n", PAGEBASE(pud_pte));
 		return NOT_PADDR;
 	}
-	pmd_pte = ULONG((info->page_buf + PAGEOFFSET(page_middle)));
+	pmd_pte = swap64(ULONG((info->page_buf + PAGEOFFSET(page_middle))), swap);
 	if (!(pmd_pte))
 		return NOT_PADDR;
 
@@ -382,7 +412,7 @@ ppc64_vtop_level4(unsigned long vaddr)
 		ERRMSG("Can't read page table: 0x%llx\n", PAGEBASE(pmd_pte));
 		return NOT_PADDR;
 	}
-	pte = ULONG((info->page_buf + PAGEOFFSET(page_table)));
+	pte = swap64(ULONG((info->page_buf + PAGEOFFSET(page_table))), swap);
 	if (!(pte & _PAGE_PRESENT)) {
 		ERRMSG("Page not present!\n");
 		return NOT_PADDR;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
