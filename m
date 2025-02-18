Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DCEC021B0
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=842zmq7II7peAIQB44phcmR7CRWWIlAqh7HOqyXvZx8=; b=oRBQ0UEMUXM6h5dYlvb3iE1wp1
	nXN1qVFO3UqYnTNCzKRIvRU4IQp8q96PgoY/d+iCX69M847R/ZTktG6BcMeS9vywagzK9wPqI/2uR
	T6onmNmEjgJnRRfA9zUZ2uyGE1WDbXhc0EEhDq2g0wydVBzqRSf9vxKOEE0M7oA6kG1JHiV++YhrD
	CCTSwUd6pubwgAqM71iZqIbO7CRoc4Hqiv3jddRTd/8uSI+wckrzPZd1WcsOR57QuoVhwKR2/JiqH
	6oC0NwrbTSd2LMylMBsRFkF9lnllM9s5o55oEoZCsuEcq/Wb07ck/60kaPRb+YDEE6GiGJft2+lXx
	1PBynNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRJH-000000099LT-046S;
	Tue, 18 Feb 2025 17:23:03 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkRHE-000000098cz-0Rld
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 17:20:57 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id E47E720376EB;
	Tue, 18 Feb 2025 09:20:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E47E720376EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739899254;
	bh=842zmq7II7peAIQB44phcmR7CRWWIlAqh7HOqyXvZx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRXRR8cDOd77K4uJYIAv7GnjwPMTCAsQ8Q4VpOGftHpnH9NB6en/sdRn8u3rjb+/u
	 J+o1U+9tbJhgaigPoWU2Hj6IruhUuE3RbcNEQp/LgJCFgJnRwHSKxNCBlz6QUahvdj
	 jUzwRNFGKaQ5KcHfGEyv+0/V0Yqr6IC7eN7egjy0=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v7 5/7] ima: kexec: move IMA log copy from kexec load to execute
Date: Tue, 18 Feb 2025 09:20:44 -0800
Message-Id: <20250218172046.649307-6-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218172046.649307-1-chenste@linux.microsoft.com>
References: <20250218172046.649307-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_092056_192618_A38FEBF1 
X-CRM114-Status: GOOD (  19.07  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot.  It needs
to be called during kexec 'execute'.

This patch includes the following changes:
 - Implement kimage_file_post_load() function to be invoked after the new
   Kernel image has been loaded for kexec.
 - Call kimage_file_post_load() from kexec_file_load() syscall only for
   kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
   map the IMA segment, and register reboot notifier for the function
   ima_update_kexec_buffer() which would copy the IMA log at kexec soft
   reboot.
 - Make kexec_segment_size variable local static to the file, for it to be
   accessible both during kexec 'load' and 'execute'.
 - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
   to ima_update_kexec_buffer().
 - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
   that the buffer is being copied at kexec 'execute', and resetting the
   file at kexec 'load' will corrupt the buffer.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 kernel/kexec_file.c                |  8 ++++++
 security/integrity/ima/ima_kexec.c | 43 +++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a3370a0dce20..a523cd209bfc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -202,6 +202,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -429,6 +434,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 854b90d34e2d..d5f004cfeaec 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
 static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
@@ -131,7 +132,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -156,13 +156,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-					kexec_segment_size);
-	if (ret < 0) {
-		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -180,12 +173,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_segment_index = image->nr_segments - 1;
 	image->is_ima_segment_index_set = true;
 
-	/*
-	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-	 * and it will vfree() that buffer.
-	 */
-	ima_reset_kexec_file(&ima_kexec_file);
-
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
@@ -196,7 +183,33 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	void *buf = NULL;
+	size_t buf_size = 0;
+	int ret = NOTIFY_OK;
+
+	if (!kexec_in_progress) {
+		pr_info("No kexec in progress.\n");
+		return ret;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("Kexec buffer not set.\n");
+		return ret;
+	}
+
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_segment_size);
+
+	if (ret)
+		pr_err("Dump measurements failed. Error:%d\n", ret);
+
+	if (buf_size != 0)
+		memcpy(ima_kexec_buffer, buf, buf_size);
+
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	return ret;
 }
 
 struct notifier_block update_buffer_nb = {
-- 
2.25.1


