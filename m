Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beriL-0000UI-OW
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 22:41:06 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UMXNnU118007
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 18:40:47 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 255365nrbj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 18:40:46 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 31 Aug 2016 04:10:43 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 31FAFE0040
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:09:43 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UMed8U13762584
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:10:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UMecFO015179
 for <kexec@lists.infradead.org>; Wed, 31 Aug 2016 04:10:39 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATHC v2 4/9] ima: serialize the binary_runtime_measurements
Date: Tue, 30 Aug 2016 18:40:06 -0400
In-Reply-To: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1472596811-9596-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1472596811-9596-5-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

The TPM PCRs are only reset on a hard reboot.  In order to validate a
TPM's quote after a soft reboot (eg. kexec -e), the IMA measurement list
of the running kernel must be saved and restored on boot.  This patch
serializes the IMA measurement list in the binary_runtime_measurements
format.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_fs.c    |  2 +-
 security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f9cd08e..634d140 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -133,6 +133,7 @@ void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
+int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c07a384..66e5dd5 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,7 +116,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
  *       [eventdata length]
  *       eventdata[n]=template specific data
  */
-static int ima_measurements_show(struct seq_file *m, void *v)
+int ima_measurements_show(struct seq_file *m, void *v)
 {
 	/* the list never shrinks, so we don't need a lock here */
 	struct ima_queue_entry *qe = v;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 6a046ad..e77ca9d 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -23,6 +23,57 @@
 
 #include "ima.h"
 
+static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+				     unsigned long segment_size)
+{
+	struct ima_queue_entry *qe;
+	struct seq_file file;
+	struct ima_kexec_hdr khdr = {
+		.version = 1, .buffer_size = 0, .count = 0};
+	int ret = 0;
+
+	/* segment size can't change between kexec load and execute */
+	file.buf = vmalloc(segment_size);
+	if (!file.buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	file.size = segment_size;
+	file.read_pos = 0;
+	file.count = sizeof(khdr);	/* reserved space */
+
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (file.count < file.size) {
+			khdr.count++;
+			ima_measurements_show(&file, qe);
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * fill in reserved space with some buffer details
+	 * (eg. version, buffer size, number of measurements)
+	 */
+	khdr.buffer_size = file.count;
+	memcpy(file.buf, &khdr, sizeof(khdr));
+	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
+			16, 1, file.buf,
+			file.count < 100 ? file.count : 100, true);
+
+	*buffer_size = file.count;
+	*buffer = file.buf;
+out:
+	if (ret == -EINVAL)
+		vfree(file.buf);
+	return ret;
+}
+
 /*
  * Restore the measurement list from the previous kernel.
  */
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
