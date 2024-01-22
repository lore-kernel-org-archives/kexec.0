Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA7EC47E49
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B4NN7nW9QaJ918jFDytl+Ct9ob0h7C3b/Nn6ajFewPc=; b=yDCVyWwJfFn/zW
	u6wqfuh4awXz6ycoQ0lEYEzWemB9JqQA3I+yusR/VnxE+zRqKVmtrgvjIe8aTcSL+l21bgcOIQWOi
	Uq+jskwA33QP95cZc+2C+jct4wEFzjxfPIkt2/XfgHYZJW49TK6sskGDh9CM/RjQ2ZizhokJDXkL2
	q0tOpBZpB0798i7W5XN7hc9wd/KKYcgb4XzIx+5PZMWiem0r48Y6jWNHQvvF5cBQECjMVgp5sjAoc
	YoS7TqJ9yT3TgtzSCNZcBPIBTzwYiPRfjfr1ZqDQbhm4dBp1LkQOmohwrBU5LDcxd+O7btFNBHShz
	+OAT7sYO/pUzFy56wn9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBh-00DYdu-0I;
	Mon, 22 Jan 2024 18:38:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBb-00DYYz-2b
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:22 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46E7920E2C1E;
	Mon, 22 Jan 2024 10:38:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46E7920E2C1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948696;
	bh=Vioe34zsK0dJO7/3HnBy+QyD5TmI5M0Zcz+q4dbfEKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fA3/ssD3T7v37xzv8e6aMG/kyda4oALnVI+T8J2c4xdDWqHQeGgrV2Vg5E6kwoQ3F
	 PvlOKaL4AABuV+Tk/Ail9HJ6eeBXYcvNqIA3wYIjPhfSIf87hrt70vAOxbjdYTmn5U
	 q1btsjOEBV72BSUUruY2xVpHIkQwq1Qor7Q1zL3w=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to execute
Date: Mon, 22 Jan 2024 10:38:01 -0800
Message-Id: <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103820_028897_71374356 
X-CRM114-Status: GOOD (  20.35  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot.  It needs
to be called during kexec 'execute'.

The below changes need to be part of the same patch to ensure this
patch series remains bisect-safe by ensuring the IMA log gets copied over
during kexec soft reboot both before and after this patch.

Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
ima_update_kexec_buffer().  Make the necessary variables local static to
the file, so that they are accessible during both kexec 'load' - where
the memory is allocated and mapped to a segment in the new Kernel, and
during 'execute' - where the IMA log gets copied over.

Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
after the new Kernel image has been loaded for kexec.
ima_kexec_post_load() will map the IMA buffer to a segment in the newly
loaded Kernel.  It will also register the reboot notifier_block to trigger
ima_update_kexec_buffer() at exec 'execute'.

Modify kexec_file_load() syscall to call kimage_file_post_load() after the
image has been loaded and prepared for kexec.  Call it only on kexec soft
reboot and not for KEXEC_FILE_ON_CRASH.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 kernel/kexec_file.c                |  8 +++
 security/integrity/ima/ima_kexec.c | 82 ++++++++++++++++++++++++++----
 3 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..006db20f852d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bf758fd5062c..ee38799ff1a3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d92a48284cc4..25150bfc7129 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,10 +12,15 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
+static bool ima_kexec_update_registered;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -120,7 +125,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -145,14 +149,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-					kexec_segment_size);
-	if (ret < 0) {
-		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
-		       __func__, ret);
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -174,6 +170,74 @@ void ima_add_kexec_buffer(struct kimage *image)
 		 kbuf.mem);
 }
 
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	void *buf = NULL;
+	size_t buf_size;
+	int ret = NOTIFY_OK;
+
+	if (!kexec_in_progress) {
+		pr_info("%s: No kexec in progress.\n", __func__);
+		return ret;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Kexec buffer not set.\n", __func__);
+		return ret;
+	}
+
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_segment_size);
+
+	if (!buf) {
+		pr_err("%s: Dump measurements failed. Error:%d\n",
+		       __func__, ret);
+		goto out;
+	}
+	memcpy(ima_kexec_buffer, buf, buf_size);
+out:
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	return ret;
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Could not map measurements buffer.\n", __func__);
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
