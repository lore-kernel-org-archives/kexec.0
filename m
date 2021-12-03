Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt62c-00FCjY-0Q
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:47 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 13/14] s390/crash_dump: Use the new interface
 copy_oldmem_page_buf
Date: Fri,  3 Dec 2021 16:12:30 +0530
Message-Id: <20211203104231.17597-14-amit.kachhap@arm.com>
In-Reply-To: <20211203104231.17597-1-amit.kachhap@arm.com>
References: <20211203104231.17597-1-amit.kachhap@arm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Use the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/s390/kernel/crash_dump.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 785d54c9350c..b1f8a908e8ca 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -214,8 +214,8 @@ static int copy_oldmem_user(void __user *dst, void *src, size_t count)
 /*
  * Copy one page from "oldmem"
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void *src;
 	int rc;
@@ -223,10 +223,10 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!csize)
 		return 0;
 	src = (void *) (pfn << PAGE_SHIFT) + offset;
-	if (userbuf)
-		rc = copy_oldmem_user((void __force __user *) buf, src, csize);
+	if (ubuf)
+		rc = copy_oldmem_user((void __user *) ubuf, src, csize);
 	else
-		rc = copy_oldmem_kernel((void *) buf, src, csize);
+		rc = copy_oldmem_kernel((void *) kbuf, src, csize);
 	return rc;
 }
 
@@ -261,7 +261,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
  * Remap "oldmem" for zfcp/nvme dump
  *
  * We only map available memory above HSA size. Memory below HSA size
- * is read on demand using the copy_oldmem_page() function.
+ * is read on demand using the copy_oldmem_page_buf() function.
  */
 static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
 					   unsigned long from,
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
