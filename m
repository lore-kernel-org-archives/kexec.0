Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt62K-00FCVr-Ll
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:30 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 09/14] sh/crash_dump: Use the new interface
 copy_oldmem_page_buf
Date: Fri,  3 Dec 2021 16:12:26 +0530
Message-Id: <20211203104231.17597-10-amit.kachhap@arm.com>
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
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Use the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
CC: linux-sh <linux-sh@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/sh/kernel/crash_dump.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 5b41b59698c1..a80dedf1ace5 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -11,20 +11,21 @@
 #include <linux/uaccess.h>
 
 /**
- * copy_oldmem_page - copy one page from "oldmem"
+ * copy_oldmem_page_buf - copy one page from "oldmem"
  * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
+ * @ubuf: target user memory pointer for the copy; use copy_to_user() if this
+ * pointer is not NULL
+ * @kbuf: target kernel memory pointer for the copy; use memcpy() if this
+ * pointer is not NULL
  * @csize: number of bytes to copy
  * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
  *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ * Copy a page from "oldmem" into the buffer pointed by either @ubuf or @kbuf.
+ * For this page, there is no pte mapped in the current kernel. We stitch up a
+ * pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-                               size_t csize, unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void  __iomem *vaddr;
 
@@ -33,13 +34,13 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, (vaddr + offset), csize)) {
 			iounmap(vaddr);
 			return -EFAULT;
 		}
 	} else
-	memcpy(buf, (vaddr + offset), csize);
+		memcpy(kbuf, (vaddr + offset), csize);
 
 	iounmap(vaddr);
 	return csize;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
