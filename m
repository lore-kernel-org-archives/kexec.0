Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufrjc-00074N-IZ
 for kexec@lists.infradead.org; Fri, 24 May 2013 13:08:41 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 24 May 2013 14:02:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AB73A17D8025
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 14:09:22 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4OD80pi54853816
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 13:08:00 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4OD8A1g022872
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 07:08:10 -0600
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 1/2] kdump/mmap: Introduce arch_oldmem_remap_pfn_range()
Date: Fri, 24 May 2013 15:08:08 +0200
Message-Id: <1369400889-11064-2-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1369400889-11064-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org

From: Jan Willeke <willeke@de.ibm.com>

Currently the /proc/vmcore mmap patches are not working on s390. The
problem is that on s390 the kernel in not relocatable and therefore
always runs in the lower memory area. Therefore for kdump on s390 we
swap the lower memory area with the crashkernel area before starting
the kdump kernel:

[0 - OLDMEM_SIZE] is mapped to [OLDMEM_BASE - OLDMEM_BASE + OLDMEM_SIZE]

To fix /proc/vmcore mmap memory below OLDMEMSIZE needs to be mapped
with OLDMEM_BASE as offset. To achieve that, a new weak function
arch_oldmem_remap_pfn_range() is introduced.

Signed-off-by: Jan Willeke <willeke@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c           | 15 ++++++++++++++-
 include/linux/crash_dump.h |  5 +++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 80221d7..3eda0ac 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -123,6 +123,19 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
+/*
+ * Architetures may override this function to map oldmen
+ */
+int __weak arch_oldmem_remap_pfn_range(struct vm_area_struct *vma,
+				       unsigned long from,
+				       unsigned long pfn,
+				       unsigned long size,
+				       pgprot_t prot)
+{
+	return remap_pfn_range(vma, from, pfn, size, prot);
+}
+
+
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
@@ -267,7 +280,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 			if (size < tsz)
 				tsz = size;
 			paddr = m->paddr + start - m->offset;
-			if (remap_pfn_range(vma, vma->vm_start + len,
+			if (arch_oldmem_remap_pfn_range(vma, vma->vm_start + len,
 					    paddr >> PAGE_SHIFT, tsz,
 					    vma->vm_page_prot)) {
 				do_munmap(vma->vm_mm, vma->vm_start, len);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 37e4f8d..da300a7 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -14,6 +14,11 @@ extern unsigned long long elfcorehdr_size;
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+extern int __weak arch_oldmem_remap_pfn_range(struct vm_area_struct *vma,
+					      unsigned long from,
+					      unsigned long pfn,
+					      unsigned long size,
+					      pgprot_t prot);
 
 /* Architecture code defines this if there are other possible ELF
  * machine types, e.g. on bi-arch capable hardware. */
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
