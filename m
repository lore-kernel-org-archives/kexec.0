Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt61z-00FCI9-9j
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:08 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 04/14] x86/crash_dump_64: Use the new interface
 copy_oldmem_page_buf
Date: Fri,  3 Dec 2021 16:12:21 +0530
Message-Id: <20211203104231.17597-5-amit.kachhap@arm.com>
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
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Implement the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86 <x86@kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/x86/kernel/crash_dump_64.c | 44 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 99cd505628fa..7a6fa797260f 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -12,9 +12,9 @@
 #include <linux/io.h>
 #include <linux/cc_platform.h>
 
-static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-				  unsigned long offset, int userbuf,
-				  bool encrypted)
+static ssize_t __copy_oldmem_page(unsigned long pfn, char __user *ubuf,
+				  char *kbuf, size_t csize,
+				  unsigned long offset, bool encrypted)
 {
 	void  *vaddr;
 
@@ -29,13 +29,13 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, vaddr + offset, csize)) {
 			iounmap((void __iomem *)vaddr);
 			return -EFAULT;
 		}
 	} else
-		memcpy(buf, vaddr + offset, csize);
+		memcpy(kbuf, vaddr + offset, csize);
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
@@ -43,39 +43,35 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 }
 
 /**
- * copy_oldmem_page - copy one page of memory
+ * copy_oldmem_page_buf - copy one page of memory
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
- * Copy a page from the old kernel's memory. For this page, there is no pte
- * mapped in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ * Copy a page from the old kernel's memory into the buffer pointed either by
+ * @ubuf or @kbuf. For this page, there is no pte mapped in the current kernel.
+ * We stitch up a pte, similar to kmap_atomic.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
-			 unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(pfn, ubuf, kbuf, csize, offset, false);
 }
 
 /**
- * copy_oldmem_page_encrypted - same as copy_oldmem_page() above but ioremap the
- * memory with the encryption mask set to accommodate kdump on SME-enabled
+ * copy_oldmem_page_encrypted - same as copy_oldmem_page_buf() above but ioremap
+ * the memory with the encryption mask set to accommodate kdump on SME-enabled
  * machines.
  */
 ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf,
 				   char *kbuf, size_t csize,
 				   unsigned long offset)
 {
-	if (ubuf)
-		return __copy_oldmem_page(pfn, (__force char *)ubuf, csize,
-					  offset, 1, true);
-	else
-		return __copy_oldmem_page(pfn, kbuf, csize,
-					  offset, 0, true);
+	return __copy_oldmem_page(pfn, ubuf, kbuf, csize, offset, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
