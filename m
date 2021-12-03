Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt61v-00FCFG-1D
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:04 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 03/14] fs/proc/vmcore: Update copy_oldmem_page() for user
 buffer
Date: Fri,  3 Dec 2021 16:12:20 +0530
Message-Id: <20211203104231.17597-4-amit.kachhap@arm.com>
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
Cc: Christoph Hellwig <hch@lst.de>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kexec <kexec@lists.infradead.org>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

The exported interface copy_oldmem_page passes user pointer without
__user annotation and does unnecessary user/kernel pointer
conversions during the pointer propagation.

Hence it is modified to have a new parameter for user pointer. However
instead of updating it directly a new interface copy_oldmem_page_buf()
is added as copy_oldmem_page() is used across different archs. This old
interface copy_oldmem_page() will be deleted after all the archs are
modified to use the new interface.

The weak implementation of both copy_oldmem_page() and
copy_oldmem_page_buf() are added temporarily to keep the kernel building
for the subsequent patches. As a consequence, crash dump is temporarily
broken for the archs till the patch where it implements its own
copy_oldmem_page_buf().

Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec <kexec@lists.infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 fs/proc/vmcore.c           | 27 +++++++++++++++++----------
 include/linux/crash_dump.h |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index fa4492ef6124..d01b85c043dd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -172,12 +172,9 @@ ssize_t read_from_oldmem(char __user *ubuf, char *kbuf, size_t count,
 				tmp = copy_oldmem_page_encrypted(pfn, ubuf,
 								 kbuf, nr_bytes,
 								 offset);
-			else if (ubuf)
-				tmp = copy_oldmem_page(pfn, (__force char *)ubuf,
-						       nr_bytes, offset, 1);
 			else
-				tmp = copy_oldmem_page(pfn, kbuf, nr_bytes,
-						       offset, 0);
+				tmp = copy_oldmem_page_buf(pfn, ubuf, kbuf,
+							   nr_bytes, offset);
 		}
 		if (tmp < 0) {
 			up_read(&vmcore_cb_rwsem);
@@ -244,11 +241,21 @@ ssize_t __weak
 copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf, char *kbuf,
 			   size_t csize, unsigned long offset)
 {
-	if (ubuf)
-		return copy_oldmem_page(pfn, (__force char *)ubuf, csize,
-					offset, 1);
-	else
-		return copy_oldmem_page(pfn, kbuf, csize, offset, 0);
+	return copy_oldmem_page_buf(pfn, ubuf, kbuf, csize, offset);
+}
+
+ssize_t __weak
+copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
+		     size_t csize, unsigned long offset)
+{
+	return -EOPNOTSUPP;
+}
+
+ssize_t __weak
+copy_oldmem_page(unsigned long pfn, char *ubuf, size_t csize,
+		 unsigned long offset, int userbuf)
+{
+	return -EOPNOTSUPP;
 }
 
 /*
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 36a7f08f4ad2..725c4e053ecf 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,6 +26,9 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+extern ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf,
+				    char *kbuf, size_t csize,
+				    unsigned long offset);
 extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn,
 					  char __user *ubuf, char *kbuf,
 					  size_t csize, unsigned long offset);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
