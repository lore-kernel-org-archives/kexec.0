Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFutj-0000dh-90
 for kexec@lists.infradead.org; Wed, 09 Sep 2020 07:52:14 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 3/3] x86_64: implement copy_to_oldmem_page
Date: Wed,  9 Sep 2020 15:50:16 +0800
Message-Id: <20200909075016.104407-4-kasong@redhat.com>
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com>
References: <20200909075016.104407-1-kasong@redhat.com>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

Previous commit introduced writing support for vmcore, it requires
per-architecture implementation for the writing function.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/crash_dump_64.c | 49 +++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..ec80da75b287 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -13,7 +13,7 @@
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
-				  bool encrypted)
+				  bool encrypted, bool is_write)
 {
 	void  *vaddr;
 
@@ -28,13 +28,25 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
-			iounmap((void __iomem *)vaddr);
-			return -EFAULT;
+	if (is_write) {
+		if (userbuf) {
+			if (copy_from_user(vaddr + offset, (void __user *)buf, csize)) {
+				iounmap((void __iomem *)vaddr);
+				return -EFAULT;
+			}
+		} else {
+			memcpy(vaddr + offset, buf, csize);
 		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	} else {
+		if (userbuf) {
+			if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+				iounmap((void __iomem *)vaddr);
+				return -EFAULT;
+			}
+		} else {
+			memcpy(buf, vaddr + offset, csize);
+		}
+	}
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
@@ -57,7 +69,7 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 			 unsigned long offset, int userbuf)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false, false);
 }
 
 /**
@@ -68,7 +80,26 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 				   unsigned long offset, int userbuf)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true, false);
+}
+
+/**
+ * copy_to_oldmem_page - similar to copy_oldmem_page but in opposite direction.
+ */
+ssize_t copy_to_oldmem_page(unsigned long pfn, char *src, size_t csize,
+		unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, src, csize, offset, userbuf, false, true);
+}
+
+/**
+ * copy_to_oldmem_page_encrypted - similar to copy_oldmem_page_encrypted but
+ * in opposite direction.
+ */
+ssize_t copy_to_oldmem_page_encrypted(unsigned long pfn, char *src, size_t csize,
+		unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, src, csize, offset, userbuf, true, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
