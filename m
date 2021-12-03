Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mt62g-00FCm0-89
 for kexec@lists.infradead.org; Fri, 03 Dec 2021 10:43:51 +0000
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [RFC PATCH 14/14] fs/proc/vmcore: Remove the unused old interface
 copy_oldmem_page
Date: Fri,  3 Dec 2021 16:12:31 +0530
Message-Id: <20211203104231.17597-15-amit.kachhap@arm.com>
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

As all archs have upgraded to use the new interface copy_oldmem_page_buf()
so remove the unused copy_oldmem_page. Also remove the weak definitions.

Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec <kexec@lists.infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 fs/proc/vmcore.c           | 14 --------------
 include/linux/crash_dump.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index d01b85c043dd..1edababe4bde 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -244,20 +244,6 @@ copy_oldmem_page_encrypted(unsigned long pfn, char __user *ubuf, char *kbuf,
 	return copy_oldmem_page_buf(pfn, ubuf, kbuf, csize, offset);
 }
 
-ssize_t __weak
-copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf, char *kbuf,
-		     size_t csize, unsigned long offset)
-{
-	return -EOPNOTSUPP;
-}
-
-ssize_t __weak
-copy_oldmem_page(unsigned long pfn, char *ubuf, size_t csize,
-		 unsigned long offset, int userbuf)
-{
-	return -EOPNOTSUPP;
-}
-
 /*
  * Copy to either kernel or user space buffer
  */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 725c4e053ecf..e897bdc0b7bf 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -24,8 +24,6 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long from, unsigned long pfn,
 				  unsigned long size, pgprot_t prot);
 
-extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
 extern ssize_t copy_oldmem_page_buf(unsigned long pfn, char __user *ubuf,
 				    char *kbuf, size_t csize,
 				    unsigned long offset);
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
