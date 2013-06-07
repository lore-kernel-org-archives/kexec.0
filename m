Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ukzxk-0001wI-2z
 for kexec@lists.infradead.org; Fri, 07 Jun 2013 16:56:29 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 7 Jun 2013 17:51:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E37B51B0805D
 for <kexec@lists.infradead.org>; Fri,  7 Jun 2013 17:56:02 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r57GtqDm47251534
 for <kexec@lists.infradead.org>; Fri, 7 Jun 2013 16:55:52 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r57Gu2fS005615
 for <kexec@lists.infradead.org>; Fri, 7 Jun 2013 10:56:02 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v5 4/5] s390/vmcore: Implement remap_oldmem_pfn_range for s390
Date: Fri,  7 Jun 2013 18:56:00 +0200
Message-Id: <1370624161-2298-5-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Jan Willeke <willeke@de.ibm.com>

This patch introduces the s390 specific way to map pages from oldmem.
The memory area below OLDMEM_SIZE is mapped with offset OLDMEM_BASE.
The other old memory is mapped directly.

Signed-off-by: Jan Willeke <willeke@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/kernel/crash_dump.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index a17f8d4..12ccc3c 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -56,6 +56,32 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 }
 
 /*
+ * Remap "oldmem"
+ *
+ * For the kdump reserved memory this functions performs a swap operation:
+ * [0 - OLDMEM_SIZE] is mapped to [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]
+ */
+int remap_oldmem_pfn_range(struct vm_area_struct *vma, unsigned long from,
+			   unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	unsigned long size_old;
+	int rc;
+
+	if (pfn < OLDMEM_SIZE >> PAGE_SHIFT) {
+		size_old = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));
+		rc = remap_pfn_range(vma, from,
+				     pfn + (OLDMEM_BASE >> PAGE_SHIFT),
+				     size_old, prot);
+		if (rc || size == size_old)
+			return rc;
+		size -= size_old;
+		from += size_old;
+		pfn += size_old >> PAGE_SHIFT;
+	}
+	return remap_pfn_range(vma, from, pfn, size, prot);
+}
+
+/*
  * Copy memory from old kernel
  */
 int copy_from_oldmem(void *dest, void *src, size_t count)
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
