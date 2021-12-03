Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt61q-00FCCz-E4
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:00 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 02/14] fs/proc/vmcore: Update copy_oldmem_page_encrypted()
 for user buffer
Date: Fri,  3 Dec 2021 16:12:19 +0530
Message-Id: <20211203104231.17597-3-amit.kachhap@arm.com>
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
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>

The exported interface copy_oldmem_page_encrypted() passes user pointer
without __user annotation and does unnecessary user/kernel pointer
conversions during the pointer propagation.

Hence it is modified to have a new parameter for user pointer. The
other similar interface copy_oldmem_page() will be updated in the
subsequent patches.

x86_64 crash dump is also modified to use this modified interface.

No functionality change intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: x86 <x86@kernel.org>
Cc: kexec <kexec@lists.infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arch/x86/kernel/crash_dump_64.c | 12 +++++++++---
 fs/proc/vmcore.c                | 24 +++++++++++-------------
 include/linux/crash_dump.h      |  6 +++---
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 6433513ef43a..99cd505628fa 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -66,10 +66,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
  * memory with the encryption mask set to accommodate kdump on SME-enabled
  * machines.
  */
-ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-				   unsigned long offset, int userbuf)
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf,
+				   char *kbuf, size_t csize,
+				   unsigned long offset)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
+	if (ubuf)
+		return __copy_oldmem_page(pfn, (__force char *)ubuf, csize,
+					  offset, 1, true);
+	else
+		return __copy_oldmem_page(pfn, kbuf, csize,
+					  offset, 0, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 39b4353bd37c..fa4492ef6124 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -168,16 +168,10 @@ ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
 			else if (clear_user(ubuf, nr_bytes))
 				tmp = -EFAULT;
 		} else {
-			if (encrypted && ubuf)
-				tmp = copy_oldmem_page_encrypted(pfn,
-								 (__force char *)ubuf,
-								 nr_bytes,
-								 offset, 1);
-			else if (encrypted && kbuf)
-				tmp = copy_oldmem_page_encrypted(pfn,
-								 kbuf,
-								 nr_bytes,
-								 offset, 0);
+			if (encrypted)
+				tmp = copy_oldmem_page_encrypted(pfn, ubuf,
+								 kbuf, nr_bytes,
+								 offset);
 			else if (ubuf)
 				tmp = copy_oldmem_page(pfn, (__force char *)ubuf,
 						       nr_bytes, offset, 1);
@@ -247,10 +241,14 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
  * Architectures which support memory encryption override this.
  */
 ssize_t __weak
-copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
-			   unsigned long offset, int userbuf)
+copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf, char *kbuf,
+			   size_t csize, unsigned long offset)
 {
-	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+	if (ubuf)
+		return copy_oldmem_page(pfn, (__force char *)ubuf, csize,
+					offset, 1);
+	else
+		return copy_oldmem_page(pfn, kbuf, csize, offset, 0);
 }
 
 /*
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index eb0ed423ccc8..36a7f08f4ad2 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,9 +26,9 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
-extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
-					  size_t csize, unsigned long offset,
-					  int userbuf);
+extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn,
+					  char __user *ubuf, char *kbuf,
+					  size_t csize, unsigned long offset);
 
 void vmcore_cleanup(void);
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
