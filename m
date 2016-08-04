Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVHiL-0000th-CE
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 12:25:31 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74COEHg126150
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 08:25:09 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkahhqba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 04 Aug 2016 08:25:09 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 22:25:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8215A2CE8054
 for <kexec@lists.infradead.org>; Thu,  4 Aug 2016 22:25:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74CP4kl22937672
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 22:25:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74CP40k019661
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 22:25:04 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 5/7] ima: on soft reboot, save the measurement list
Date: Thu,  4 Aug 2016 08:24:33 -0400
In-Reply-To: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1470313475-20090-6-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

This patch uses the kexec buffer passing mechanism to pass the
serialized IMA binary_runtime_measurements to the next kernel.

Changelog:
- updated to call IMA functions  (Mimi)
- move code from ima_template.c to ima_kexec.c (Mimi)

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/ima.h                | 15 +++++++
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima_kexec.c | 83 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b553367..ba484ed 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/kexec.h>
 struct linux_binprm;
 
 enum ima_buffer_id {
@@ -35,6 +36,14 @@ extern int ima_add_measurement_check(const char *hashname, u8 *digest,
 				     loff_t size, enum ima_buffer_id buffer_id,
 				     char *hint);
 
+#ifdef CONFIG_IMA_KEXEC
+extern void ima_add_kexec_buffer(struct kimage *image);
+#else
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{
+}
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
@@ -85,6 +94,12 @@ static inline int ima_add_measurement_check(const char *hashname, u8 *digest,
 {
 	return 0;
 }
+
+#ifdef CONFIG_IMA_KEXEC
+static inline void ima_add_kexec_buffer(struct kimage *image)
+{
+}
+#endif
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_IMA_APPRAISE
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 852adb2..622c126 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -202,6 +202,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		return ret;
 	image->kernel_buf_len = size;
 
+	/* IMA needs to pass the measurement list to the next kernel. */
+	ima_add_kexec_buffer(image);
+
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
 					    image->kernel_buf_len);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e77ca9d..3fed417 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -23,6 +23,11 @@
 
 #include "ima.h"
 
+#ifdef CONFIG_IMA_KEXEC
+/* Physical address of the measurement buffer in the next kernel. */
+static unsigned long kexec_buffer_load_addr;
+static size_t kexec_segment_size;
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -75,6 +80,84 @@ out:
 }
 
 /*
+ * Called during kexec execute so that IMA can save the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	void *kexec_buffer = NULL;
+	size_t kexec_buffer_size;
+	int ret;
+
+	if (!kexec_in_progress)
+		return NOTIFY_OK;
+
+	kexec_buffer_size = ima_get_binary_runtime_size();
+	if (kexec_buffer_size >
+	    (kexec_segment_size - sizeof(struct ima_kexec_hdr))) {
+		pr_err("Binary measurement list grew too large.\n");
+		goto out;
+	}
+
+	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+				  kexec_segment_size);
+	if (!kexec_buffer) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		goto out;
+	}
+	ret = kexec_update_segment(kexec_buffer, kexec_buffer_size,
+				   kexec_buffer_load_addr, kexec_segment_size);
+	if (ret)
+		pr_err("Error updating kexec buffer: %d\n", ret);
+out:
+	return NOTIFY_OK;
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Called during kexec_file_load so that IMA can add a segment to the kexec
+ * image for the measurement list for the next kernel.
+ */
+void ima_add_kexec_buffer(struct kimage *image)
+{
+	struct kexec_buf kbuf = { .image = image, .buf_align = PAGE_SIZE,
+				  .buf_min = 0, .buf_max = ULONG_MAX,
+				  .top_down = true };
+	int ret;
+
+	if (!kexec_can_hand_over_buffer())
+		return;
+
+	kexec_segment_size = ALIGN(ima_get_binary_runtime_size() + PAGE_SIZE,
+				   PAGE_SIZE);
+
+	if (kexec_segment_size >= (ULONG_MAX - sizeof(long))) {
+		pr_err("Binary measurement list too large.\n");
+		return;
+	}
+
+	/* Ask not to checksum the segment, we will update it later. */
+	kbuf.buffer = NULL;
+	kbuf.bufsz = 0;
+	kbuf.memsz = kexec_segment_size;
+	ret = kexec_add_handover_buffer(&kbuf, false);
+	if (ret) {
+		pr_err("Error passing over kexec measurement buffer.\n");
+		return;
+	}
+	kexec_buffer_load_addr = kbuf.mem;
+
+	register_reboot_notifier(&update_buffer_nb);
+
+	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+		 kexec_buffer_load_addr);
+}
+#endif /* IMA_KEXEC */
+
+/*
  * Restore the measurement list from the previous kernel.
  */
 void ima_load_kexec_buffer(void)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
