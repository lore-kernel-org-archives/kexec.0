Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZM4a-0000Xw-EZ
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 13:35:10 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 13:35:02 -0000
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAGDYqVf57999402
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 13:34:52 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAGDYxCK015717
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 06:34:59 -0700
Received: from holzheu (dyn-9-152-212-147.boeblingen.de.ibm.com
 [9.152.212.147])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 qAGDYxTr015712
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 06:34:59 -0700
Date: Fri, 16 Nov 2012 14:34:58 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: s390x: Allow HW Change-bit override for page
 table entries
Message-ID: <20121116143458.2d1a66e3@holzheu>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

The HW Change-bit override (0x100) is used now for s390x. This patch allows
page table entries that have set this bit.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390x.c   |    4 ++--
 makedumpfile.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -195,10 +195,10 @@ static ulong _kl_pg_table_deref_s390x(un
 	readmem(VADDR, table + offset, &entry, sizeof(entry));
 	/*
 	 * Check if the page table entry could be read and doesn't have
-	 * any of the reserved bits set.
+	 * the reserved bit set.
 	 * Check if the page table entry has the invalid bit set.
 	 */
-	if (entry &  (_PAGE_CO | _PAGE_ZERO | _PAGE_INVALID)) {
+	if (entry &  (_PAGE_ZERO | _PAGE_INVALID)) {
 		ERRMSG("Invalid page table entry.\n");
 		return 0;
 	}
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -575,7 +575,6 @@ do { \
 #define _SEGMENT_INDEX_SHIFT	20
 
 /* Hardware bits in the page table entry */
-#define _PAGE_CO		0x100	/* HW Change-bit override */
 #define _PAGE_ZERO		0x800	/* Bit pos 52 must conatin zero */
 #define _PAGE_INVALID		0x400	/* HW invalid bit */
 #define _PAGE_INDEX_SHIFT	12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
