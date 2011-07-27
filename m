Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qm3gk-0006Ta-Of
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 12:58:19 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6RCwAcd025175
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 12:58:10 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
	[9.149.37.229])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6RCwAIQ2171114
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 13:58:10 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6RCw9Ge001639
	for <kexec@lists.infradead.org>; Wed, 27 Jul 2011 06:58:09 -0600
Message-Id: <20110727125808.670392469@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:12 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 08/10] s390: Add real memory access functions
References: <20110727125504.491183728@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-maccess.patch
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Add access function for real memory needed by s390 kdump backend.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/include/asm/system.h |    2 +
 arch/s390/mm/maccess.c         |   57 +++++++++++++++++++++++++++++++++++++++++
 drivers/s390/char/zcore.c      |   20 +-------------
 3 files changed, 61 insertions(+), 18 deletions(-)

--- a/arch/s390/include/asm/system.h
+++ b/arch/s390/include/asm/system.h
@@ -114,6 +114,8 @@ extern void pfault_fini(void);
 extern void cmma_init(void);
 extern int memcpy_real(void *, void *, size_t);
 extern void copy_to_absolute_zero(void *dest, void *src, size_t count);
+extern int copy_to_user_real(void __user *dest, void *src, size_t count);
+extern int copy_from_user_real(void *dest, void __user *src, size_t count);
 
 #define finish_arch_switch(prev) do {					     \
 	set_fs(current->thread.mm_segment);				     \
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/gfp.h>
 #include <asm/system.h>
 
 /*
@@ -60,6 +61,9 @@ long probe_kernel_write(void *dst, const
 	return copied < 0 ? -EFAULT : 0;
 }
 
+/*
+ * Copy memory in real mode (kernel to kernel)
+ */
 int memcpy_real(void *dest, void *src, size_t count)
 {
 	register unsigned long _dest asm("2") = (unsigned long) dest;
@@ -101,3 +105,56 @@ void copy_to_absolute_zero(void *dest, v
 	__ctl_load(cr0, 0, 0);
 	preempt_enable();
 }
+
+/*
+ * Copy memory from kernel (real) to user (virtual)
+ */
+int copy_to_user_real(void __user *dest, void *src, size_t count)
+{
+	int offs = 0, size, rc;
+	char *buf;
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rc = -EFAULT;
+	while (offs < count) {
+		size = min(PAGE_SIZE, count - offs);
+		if (memcpy_real(buf, src + offs, size))
+			goto out;
+		if (copy_to_user(dest + offs, buf, size))
+			goto out;
+		offs += size;
+	}
+	rc = 0;
+out:
+	free_page((unsigned long) buf);
+	return rc;
+}
+
+/*
+ * Copy memory from user (virtual) to kernel (real)
+ */
+int copy_from_user_real(void *dest, void __user *src, size_t count)
+{
+	int offs = 0, size, rc;
+	char *buf;
+
+	buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	rc = -EFAULT;
+	while (offs < count) {
+		size = min(PAGE_SIZE, count - offs);
+		if (copy_from_user(buf, src + offs, size))
+			goto out;
+		if (memcpy_real(dest + offs, buf, size))
+			goto out;
+		offs += size;
+	}
+	rc = 0;
+out:
+	free_page((unsigned long) buf);
+	return rc;
+}
+
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -142,22 +142,6 @@ static int memcpy_hsa_kernel(void *dest,
 	return memcpy_hsa(dest, src, count, TO_KERNEL);
 }
 
-static int memcpy_real_user(void __user *dest, unsigned long src, size_t count)
-{
-	static char buf[4096];
-	int offs = 0, size;
-
-	while (offs < count) {
-		size = min(sizeof(buf), count - offs);
-		if (memcpy_real(buf, (void *) src + offs, size))
-			return -EFAULT;
-		if (copy_to_user(dest + offs, buf, size))
-			return -EFAULT;
-		offs += size;
-	}
-	return 0;
-}
-
 static int __init init_cpu_info(enum arch_id arch)
 {
 	struct save_area *sa;
@@ -346,8 +330,8 @@ static ssize_t zcore_read(struct file *f
 
 	/* Copy from real mem */
 	size = count - mem_offs - hdr_count;
-	rc = memcpy_real_user(buf + hdr_count + mem_offs, mem_start + mem_offs,
-			      size);
+	rc = copy_to_user_real(buf + hdr_count + mem_offs,
+			       (void *) mem_start + mem_offs, size);
 	if (rc)
 		goto fail;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
