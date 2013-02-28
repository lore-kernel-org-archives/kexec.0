Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UB5SR-0002C1-8W
 for kexec@lists.infradead.org; Thu, 28 Feb 2013 15:31:44 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 28 Feb 2013 15:29:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 057021B08069
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2013 15:31:35 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1SFVPB423068752
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2013 15:31:25 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1SEQX7s021090
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2013 09:26:33 -0500
Received: from holzheu (dyn-9-152-212-104.boeblingen.de.ibm.com
 [9.152.212.104])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r1SEQXbo021065
 for <kexec@lists.infradead.org>; Thu, 28 Feb 2013 09:26:33 -0500
Date: Thu, 28 Feb 2013 16:31:32 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: s390x: Allow large page and change override bits
Message-ID: <20130228163132.5282e758@holzheu>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Currently makedumpfile fails if large page or change override bits
are set for region or segment table entries:

Excluding free pages               : [  0 %]
_kl_rsg_table_deref_s390x: Bad region/segment table entry.
readmem: Can't convert a virtual address(3d1015fc028) to physical address.
readmem: type_addr: 0, addr:3d1015fc028, size:8
reset_bitmap_of_free_pages: Can't get prev list_head.
_kl_rsg_table_deref_s390x: Bad region/segment table entry.
readmem: Can't convert a virtual address(3d1015fc028) to physical address.
readmem: type_addr: 0, addr:3d1015fc028, size:8
reset_bitmap_of_free_pages: Can't get prev list_head.
makedumpfile Failed.

Large page support is already implemented for the makedumpfile page table
walk. Only the check is invalid. To fix this we now allow the bits in
rsg_table_entry_bad().

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390x.c   |    4 +++-
 makedumpfile.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -133,7 +133,9 @@ rsg_table_entry_bad(unsigned long entry,
 {
 	unsigned long mask = ~_REGION_ENTRY_INVALID
 				& ~_REGION_ENTRY_TYPE_MASK
-				& ~_REGION_ENTRY_LENGTH;
+				& ~_REGION_ENTRY_LENGTH
+				& ~_SEGMENT_ENTRY_LARGE
+				& ~_SEGMENT_ENTRY_CO;
 
 	if (level)
 		mask &= ~_REGION_ENTRY_ORIGIN;
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -617,6 +617,7 @@ do { \
 /* Bits in the segment table entry */
 #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL
 #define _SEGMENT_ENTRY_LARGE	0x400
+#define _SEGMENT_ENTRY_CO	0x100
 #define _SEGMENT_PAGE_SHIFT	31
 #define _SEGMENT_INDEX_SHIFT	20
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
