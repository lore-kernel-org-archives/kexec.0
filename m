Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F80C021B2
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYVHNkbt845qc4At8T+7xSFjWVvWbhRzCIpl+tl8a1U=; b=s//Dt3gARR+oWJu2xn8IlLs6dF
	XWy+aFpKUjaYvbsaE6Pu24M1UxOUG69XE+4K3EQNVYwM912lSeR2ZZqy0udxP52oBgJXqaggBn5iW
	SuVpC3qIhDlbPRZeXYujHi5nh1PvXs6x1sO2/cVnAXVfwIbdYrSDAUY4ESW20Ns3BF5aVIRwtK7qI
	yXr/i9uW/w2T1sTjTJPuOyBl+xQVHu1NSDxZ2ft9xbFxnuhwPpjodB9exK9hegGcd4skcn9IESkSu
	paOeVL7eqWPuC4YbcAT5Tx7xa99YNYKWIEo5okQ33OgNIiuyCwtnv72VD9lQLpmUNaEReIpcdr7HX
	SgzothZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkWW6-0000000ACZm-1SA7;
	Tue, 18 Feb 2025 22:56:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkWUp-0000000ACHX-0SHX
	for kexec@bombadil.infradead.org;
	Tue, 18 Feb 2025 22:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oYVHNkbt845qc4At8T+7xSFjWVvWbhRzCIpl+tl8a1U=; b=D2eTAMjm6wzDvxi7jQ7PQ+mP6R
	NLSnltvsUS8o3bde+spf2cMt6IKdlbVibtVSl/bkg6/sVi18vMTomgTYPL7evCtbl4iCGOLoY3Po/
	AIE+LxNdMZY9JUS/C84AWffrVO0rJWyLKLodCHU+uOFLDxxBqL5pv+IYVwFJPVzOjG3o2t6NCI67O
	CEc0IjNp81mlMeCXUSJA6uwZfbmesxTzMVYvN+rTuXHfhBXFxeQ6eQ1vR7H0qzxtiS0qUA+5KJ/o/
	ZkId/bj4/j20j8tnqyYc0xYioPJLI+OFsyqyt7+4LHmibG3MjT4JsaYV4P+JvBlFPig4R5uMS7oac
	JW27Tmgg==;
Received: from linux.microsoft.com ([13.77.154.182])
	by desiato.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkWUk-000000024J7-2ovG
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 22:55:17 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id A916120376ED;
	Tue, 18 Feb 2025 14:55:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A916120376ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739919309;
	bh=oYVHNkbt845qc4At8T+7xSFjWVvWbhRzCIpl+tl8a1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBJ2dLw1tKOONGiEFEBXMm5dj1FUIrRcwAEhC+pHxvNApgwI3HZXJ+PoceHTsPM8K
	 LiAAJXvHtfx4vEXAlfoo7M5WpHYwaJmmDfU9ziODkKqtNLjPX8J0VjcoY9u2dorW7P
	 8fJ8tcscWC5pVeyhqDeUcO8TvK+deOGIiw/ht8x4=
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
Subject: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
Date: Tue, 18 Feb 2025 14:54:56 -0800
Message-Id: <20250218225502.747963-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218225502.747963-1-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_225515_393702_22F76442 
X-CRM114-Status: GOOD (  26.62  )
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

Carrying the IMA measurement list across kexec requires allocating a
buffer and copying the measurement records.  Separate allocating the
buffer and copying the measurement records into separate functions in
order to allocate the buffer at kexec 'load' and copy the measurements
at kexec 'execute'.

This patch includes the following changes:
 - Refactor ima_dump_measurement_list() to move the memory allocation
   to a separate function ima_alloc_kexec_file_buf() which allocates
   buffer of size 'kexec_segment_size' at kexec 'load'.
 - Make the local variable ima_kexec_file in ima_dump_measurement_list()
   a local static to the file, so that it can be accessed from 
   ima_alloc_kexec_file_buf(). Compare actual memory required to ensure 
   there is enough memory for the entire measurement record.
 - Copy as many measurement events as possible.
 - Make necessary changes to the function ima_add_kexec_buffer() to call
   the above two functions.
 - Compared the memory size allocated with memory size of the entire 
   measurement record. If there is not enough memory, it will copy as many
   IMA measurement records as possible, and this situation will result
   in a failure of remote attestation.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |   1 +
 security/integrity/ima/ima_kexec.c | 102 +++++++++++++++++++++--------
 security/integrity/ima/ima_queue.c |   4 +-
 3 files changed, 77 insertions(+), 30 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 24d09ea91b87..4428fcf42167 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9d45f4d26f73..89088f1fa989 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,63 +15,97 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static struct seq_file ima_kexec_file;
+
+static void ima_reset_kexec_file(struct seq_file *sf)
+{
+	sf->buf = NULL;
+	sf->size = 0;
+	sf->read_pos = 0;
+	sf->count = 0;
+}
+
+static void ima_free_kexec_file_buf(struct seq_file *sf)
+{
+	vfree(sf->buf);
+	ima_reset_kexec_file(sf);
+}
+
+static int ima_alloc_kexec_file_buf(size_t segment_size)
+{
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		goto out;
+
+	ima_free_kexec_file_buf(&ima_kexec_file);
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf)
+		return -ENOMEM;
+
+	ima_kexec_file.size = segment_size;
+
+out:
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-	struct seq_file file;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
+	size_t entry_size = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		pr_err("Kexec file buf not allocated\n");
+		return -EINVAL;
 	}
 
-	file.file = NULL;
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
+	/* Copy as many IMA measurements list records as possible */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (file.count < file.size) {
+		entry_size += ima_get_binary_runtime_entry_size(qe->entry);
+		if (entry_size <= segment_size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
 			ret = -EINVAL;
+			pr_err("IMA log file is too big for Kexec buf\n");
 			break;
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
 	 */
-	khdr.buffer_size = file.count;
+	khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
 		khdr.version = cpu_to_le16(khdr.version);
 		khdr.count = cpu_to_le64(khdr.count);
 		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
+			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
+			     ima_kexec_file.count : 100,
 			     true);
 
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
 	return ret;
 }
 
@@ -90,7 +124,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
+	size_t kexec_buffer_size = 0;
 	size_t kexec_segment_size;
 	int ret;
 
@@ -110,13 +144,19 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
+	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	if (ret < 0) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
 		return;
 	}
 
+	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+					kexec_segment_size);
+	if (ret < 0) {
+		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
+		return;
+	}
+
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -131,6 +171,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
 
+	/*
+	 * kexec owns kexec_buffer after kexec_add_buffer() is called
+	 * and it will vfree() that buffer.
+	 */
+	ima_reset_kexec_file(&ima_kexec_file);
+
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 83d53824aa98..3dfd178d4292 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -78,7 +78,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
  * binary_runtime_measurement list entry, which contains a
  * couple of variable length fields (e.g template name and data).
  */
-static int get_binary_runtime_size(struct ima_template_entry *entry)
+int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry)
 {
 	int size = 0;
 
@@ -122,7 +122,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	if (binary_runtime_size != ULONG_MAX) {
 		int size;
 
-		size = get_binary_runtime_size(entry);
+		size = ima_get_binary_runtime_entry_size(entry);
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
-- 
2.25.1


