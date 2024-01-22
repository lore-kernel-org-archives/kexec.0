Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA50FC47DAF
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MdAdnUUwRcupq7Cksvv/8u06QiYWA2lRH/NTyUKDj5w=; b=H7jdzvl2P3qEhK
	RNYQd2vzNE+9Nge5lbk055kM9DfoCM+pc3MLtMlx0TUw4p02gfARFvV1+f+6JNNOI2kGod/v1JFXo
	ed3rzEgvjEn8oJVOKP2utoySBnakGox4lGtOKTzLGKXbn5xLyzCICdQ0hJ5re5HsTR4UcAWB8ynuf
	R3fXZwpwaq9V+56S21xoEU7w13EJIjg+WMcULpyArNMik00VQVxErgiNjLECoNbDtLfVHUnhwDInb
	4TqQWhl7CoV6gyrN1dHNI3RfDrxCtnfWeihk1raBhLBlWiHZ0Oae7VoDShX/vT3uVRc0ELBYPAFFz
	4B0MWYQW1T4T7+ZAvIrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBh-00DYe0-1k;
	Mon, 22 Jan 2024 18:38:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBb-00DYYy-39
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:23 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D11820E2C0A;
	Mon, 22 Jan 2024 10:38:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D11820E2C0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948695;
	bh=qJHN560TUZe/5m2Gya0jv8CgnkhIqfBUCJMwNbKONAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe8BZj6hMBvY5o1xChVYXTZ58hlM5FZ1WkPHd6CmU76c37WMkBJMuHaS6r1AlLa4E
	 cFLEsSo4gkeJGI0Ozgo0IyGtqNMFy1xpsxKaTchsKKnFdZsYkusfDzyDrS6LrJ+tT+
	 AdBEZhp5IZCpFMI3NL4G6AYEiwc9FlQgxHENtYtA=
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
Subject: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Date: Mon, 22 Jan 2024 10:37:58 -0800
Message-Id: <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103820_185906_FFCAD322 
X-CRM114-Status: GOOD (  19.36  )
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

Refactor ima_dump_measurement_list() to move the memory allocation part
to a separate function ima_alloc_kexec_file_buf() which allocates buffer
of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
ima_kexec_file in function ima_dump_measurement_list() as local static to
the file, so that it can be accessed from ima_alloc_kexec_file_buf().
Make necessary changes to the function ima_add_kexec_buffer() to call the
above two functions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..99daac355c70 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,62 +15,93 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static struct seq_file ima_kexec_file;
+
+static void ima_free_kexec_file_buf(struct seq_file *sf)
+{
+	vfree(sf->buf);
+	sf->buf = NULL;
+	sf->size = 0;
+	sf->read_pos = 0;
+	sf->count = 0;
+}
+
+static int ima_alloc_kexec_file_buf(size_t segment_size)
+{
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf &&
+	    ima_kexec_file.size == segment_size &&
+	    ima_kexec_file.read_pos == 0 &&
+	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
+		return 0;
+
+	ima_free_kexec_file_buf(&ima_kexec_file);
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf)
+		return -ENOMEM;
+
+	ima_kexec_file.size = segment_size;
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
-	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		*buffer_size = 0;
+		*buffer = NULL;
+		pr_err("%s: Kexec file buf not allocated\n", __func__);
+		return -EINVAL;
 	}
 
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
+
+	/* Copy as many IMA measurements list records as possible */
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
+		if (ima_kexec_file.count < ima_kexec_file.size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
-			ret = -EINVAL;
+			pr_err("%s: IMA log file is too big for Kexec buf\n",
+			       __func__);
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
-	return ret;
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
+	return 0;
 }
 
 /*
@@ -108,13 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
+		       __func__, ret);
+		return;
+	}
+
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
