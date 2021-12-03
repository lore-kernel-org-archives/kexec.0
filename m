Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 06/14] arm64/crash_dump: Use the new interface
 copy_oldmem_page_buf
Date: Fri,  3 Dec 2021 16:12:23 +0530
Message-Id: <20211203104231.17597-7-amit.kachhap@arm.com>
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
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

The current interface copy_oldmem_page() passes user pointer without
__user annotation and hence does unnecessary user/kernel pointer
conversions during its implementation.

Implement the interface copy_oldmem_page_buf() to avoid this issue.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/arm64/kernel/crash_dump.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 58303a9ec32c..ec9d5c80726c 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -14,20 +14,19 @@
 #include <asm/memory.h>
 
 /**
- * copy_oldmem_page() - copy one page from old kernel memory
+ * copy_oldmem_page_buf() - copy one page from old kernel memory
  * @pfn: page frame number to be copied
- * @buf: buffer where the copied page is placed
+ * @ubuf: user buffer where the copied page is placed
+ * @kbuf: kernel buffer where the copied page is placed
  * @csize: number of bytes to copy
  * @offset: offset in bytes into the page
- * @userbuf: if set, @buf is in a user address space
  *
  * This function copies one page from old kernel memory into buffer pointed by
- * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
- * copied or negative error in case of failure.
+ * either @ubuf or @kbuf. Returns number of bytes copied or negative error in
+ * case of failure.
  */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-			 size_t csize, unsigned long offset,
-			 int userbuf)
+ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+			     size_t csize, unsigned long offset)
 {
 	void *vaddr;
 
@@ -38,13 +37,13 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, vaddr + offset, csize)) {
+	if (ubuf) {
+		if (copy_to_user(ubuf, vaddr + offset, csize)) {
 			memunmap(vaddr);
 			return -EFAULT;
 		}
 	} else {
-		memcpy(buf, vaddr + offset, csize);
+		memcpy(kbuf, vaddr + offset, csize);
 	}
 
 	memunmap(vaddr);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
