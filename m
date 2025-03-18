Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A82C35FFB
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 01:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mI2ZxU7Sw/KQ7e8aWJaQUjOuf7ihC69n+BKL3G34WUQ=; b=QjR8tzDAHOlqRDXYlsJ3OWPIbo
	3ORB/Igy2dy0iRPKj9NJNzb5x8AzL7229eVivn6x/tXfxx24DkyfeqsncDMuCDklL5nZD7xDj3bTH
	Mygb2UBwXSeeXYXxnXMK/Gb4dCBZh4ZRoMEMAD60WKWjnQ4MMOgocuMX2txA6+qSpnb2f3EOijE5q
	q5+bgFr85H7Z6nyy3n7z/CmFLwOIESEFS78V1C4+VSxGgmE2CWixFP6IYtN17U2KPWeLNp9SouQOb
	Ua4b4VX1/iOEvOjaJLz8PLNA8Qdn3G3Oqk3pHBozgNL8LezhWxYi45tQ06Wk6848Qnn/FotwdriXA
	s8qt80Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOU-00000004JST-1GKf;
	Tue, 18 Mar 2025 01:05:22 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOR-00000004JMt-3Prp
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 01:05:21 +0000
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id E567120DEACE;
	Mon, 17 Mar 2025 18:05:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E567120DEACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259919;
	bh=mI2ZxU7Sw/KQ7e8aWJaQUjOuf7ihC69n+BKL3G34WUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjG4CEZlBqfI2j+nkaayFYfsPydslFDDER9nSmJaE/qLKfnScC6BJyYppdt7187VB
	 xqaALSzDsIamP2X2nMUPpe4Ky6UUn0sAtgEviRYFsFhl0rv9yhQqs/JfG/SkGDZ5i1
	 8bJ1Wf6yDDdowocxJDLdDvSQpfTQxWExL196+ODI=
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
Subject: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to execute
Date: Mon, 17 Mar 2025 18:04:44 -0700
Message-ID: <20250318010448.954-7-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318010448.954-1-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_180519_912583_0CE37A99 
X-CRM114-Status: GOOD (  21.23  )
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
result in loss of IMA measurements during kexec soft reboot. Due to 
missed measurements that only occurred after kexec 'load', this function 
needs to be called during kexec 'execute'.

This patch includes the following changes:
 - Implement kimage_file_post_load() function to be invoked after the new
   kernel image has been loaded for kexec.
 - Call kimage_file_post_load() from kexec_file_load() syscall only for
   kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
   map the IMA segment, and register reboot notifier for the function
   ima_update_kexec_buffer() which would copy the IMA log at kexec soft
   reboot.
 - Make kexec_segment_size variable local static to the file so that it 
   becomes accessible both during kexec 'load' and 'execute'.
 - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
   to ima_update_kexec_buffer().
 - Copy the measurement list as much as possible.
 - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
   that the buffer is being copied at kexec 'execute', and resetting the
   file at kexec 'load' would corrupt the buffer.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 kernel/kexec_file.c                | 10 ++++++
 security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 606132253c79..ab449b43aaee 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static void kimage_file_post_load(struct kimage *image)
+{
+#ifdef CONFIG_IMA_KEXEC
+	ima_kexec_post_load(image);
+#endif
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9336c4f60650..c390c745f882 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
+static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
@@ -67,7 +68,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
  *    if the size of the allocated memory is not less than the size of IMA measurement list
  *        copy the measurement list to the allocated memory.
  *    else
- *        return error
+ *        copy the measurement list as much as possible.
  */
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
@@ -95,9 +96,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
@@ -117,7 +115,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
-out:
+
 	return ret;
 }
 
@@ -135,9 +133,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
+	size_t kexec_buffer_size = 0;
 	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -162,13 +159,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -186,12 +176,6 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -202,7 +186,32 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	size_t buf_size = 0;
+	int ret = NOTIFY_OK;
+	void *buf = NULL;
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
+	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
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
 
 static struct notifier_block update_buffer_nb = {
-- 
2.25.1


