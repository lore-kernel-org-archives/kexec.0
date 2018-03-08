Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1etzzc-00077x-OE
 for kexec@lists.infradead.org; Thu, 08 Mar 2018 18:10:19 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w28I3qRj011892
 for <kexec@lists.infradead.org>; Thu, 8 Mar 2018 13:10:05 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gk847p4ab-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 08 Mar 2018 13:10:04 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 8 Mar 2018 18:10:01 -0000
Subject: [PATCH] makedumpfile: fix for hugepages filtering
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 08 Mar 2018 23:39:55 +0530
MIME-Version: 1.0
Message-Id: <152053259516.24027.9253761946115314214.stgit@hbathini.in.ibm.com>
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
Cc: Dave Young <dyoung@redhat.com>, ptesarik@suse.cz, Kexec-ml <kexec@lists.infradead.org>, piliu@redhat.com, andrej.skvortzov@gmail.com

Kernel commit 036e7aa49fb2 changed 'compound_dtor' & 'compound_order'
types from 'unsigned short' to 'unsigned char'. Fix it here to ensure
hugepages are filtered properly.

Also, makedumpfile tool commit 484c6b18624 used 'int' type for 'dtor'
argument in 'isHugetlb' function. While this works in recent kernels
that use 'unsigned short/char' type for 'compound_dtor', it breaks
older kernels that used address of 'free_huge_page' as dtor. Fix it
by changing 'dtor' type.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 makedumpfile.c |   30 ++++++++++++++++++++++++------
 makedumpfile.h |    1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ed138d3..ac8483d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -241,7 +241,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 }
 
 static inline int
-isHugetlb(int dtor)
+isHugetlb(unsigned long dtor)
 {
         return ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
 		&& (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
@@ -5798,18 +5798,36 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 		 * and PGMM_CACHED is a power of 2.
 		 */
 		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)) {
-			if (order_offset)
-				compound_order = USHORT(pcache + SIZE(page) + order_offset);
+			unsigned long long addr =
+				(unsigned long long)(pcache + SIZE(page));
+
+			if (order_offset) {
+				if (info->kernel_version >=
+				    KERNEL_VERSION(4, 16, 0)) {
+					compound_order =
+						UCHAR(addr + order_offset);
+				} else {
+					compound_order =
+						USHORT(addr + order_offset);
+				}
+			}
 
 			if (dtor_offset) {
 				/*
 				 * compound_dtor has been changed from the address of descriptor
 				 * to the ID of it since linux-4.4.
 				 */
-				if (info->kernel_version >= KERNEL_VERSION(4, 4, 0)) {
-					compound_dtor = USHORT(pcache + SIZE(page) + dtor_offset);
+				if (info->kernel_version >=
+				    KERNEL_VERSION(4, 16, 0)) {
+					compound_dtor =
+						UCHAR(addr + dtor_offset);
+				} else if (info->kernel_version >=
+					   KERNEL_VERSION(4, 4, 0)) {
+					compound_dtor =
+						USHORT(addr + dtor_offset);
 				} else {
-					compound_dtor = ULONG(pcache + SIZE(page) + dtor_offset);
+					compound_dtor =
+						ULONG(addr + dtor_offset);
 				}
 			}
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 01eece2..4cfad98 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -241,6 +241,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 		     string_exists((char *)(B)) &&	\
 	(strncmp((char *)(A), (char *)(B), strlen((char *)(B))) == 0))
 
+#define UCHAR(ADDR)	*((unsigned char *)(ADDR))
 #define USHORT(ADDR)	*((unsigned short *)(ADDR))
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
