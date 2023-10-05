Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459DDE9272D
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zvMrgxT1lF9n0KhSRGFqPMdU3JJMl1n+X/f9jfO+lTA=; b=kZ8CYxMFCBngXt
	ByoyFsDZ6kejNeZOlQBBnhojhAK5HGTg71QzjOly8SyewCwBOZ9/f6YpJiPDwDusNbUqnIY98wYe7
	k+Vhv38SGk4lmvE+7DjXPMYkPtMef6C9DpVZcwOyeY9fH3QOTcHvKqpwp5Cuane/k1fne737Jq90A
	YcOD3wSQVKAJ93lBxd5Eo7jzJ28bD7+Er1KSaxCRsZ4hCtZ3bVpauu1gcChEf9WLLBKAG871/18Zi
	b0+pbojHjWSXhaEXLTi47UAxqBARF9RwSAdUU1wRZBeouAOU5yqlAwXYd+DwrM5KAXG2TPSpzzE52
	fejvq53JxyJFGwIz5ETg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3D-004HSs-0f;
	Thu, 05 Oct 2023 18:26:19 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT37-004HPt-2U
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:17 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDEC620B74C2;
	Thu,  5 Oct 2023 11:26:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDEC620B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530371;
	bh=JzbNPfP8rsA3zKDRhrHM4A1C1P+3asNcarWREnGnRqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAWgvyqCkGSAPglJFh8N+rB6X3OLX3+25r6mswkyyU3LlPgeqMJULubtEi+XYH080
	 76C1abZgZuKZACBOL7bLU3RYW7+3pPGptw0qBhAnISnh0XYPzSxQ2U697FoxWQgJ3e
	 LwVe5SpHqYjwZh1BOKApY6djAo8sMhnNbRmRR90k=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move memory allocation to a separate function
Date: Thu,  5 Oct 2023 11:25:56 -0700
Message-Id: <20231005182602.634615-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112613_895047_BD45E40E 
X-CRM114-Status: GOOD (  22.02  )
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

IMA allocates memory and dumps the measurement during kexec soft reboot
as a single function call ima_dump_measurement_list().  It gets called
during kexec 'load' operation.  It results in the IMA measurements
between the window of kexec 'load' and 'execute' getting dropped when the
system boots into the new Kernel.  One of the kexec requirements is the
segment size cannot change between the 'load' and the 'execute'.
Therefore, to address this problem, ima_dump_measurement_list() needs
to be refactored to allocate the memory at kexec 'load', and dump the
measurements at kexec 'execute'.  The function that allocates the memory
should handle the scenario where the kexec load is called multiple times.

Refactor ima_dump_measurement_list() to move the memory allocation part
to a separate function ima_alloc_kexec_buf() to allocate buffer of size
'kexec_segment_size' at kexec 'load'.  Make the local variables in
function ima_dump_measurement_list() global, so that they can be accessed
from ima_alloc_kexec_buf().  Make necessary changes to the function
ima_add_kexec_buffer() to call the above two functions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 33 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..307e07991865 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,61 +15,114 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+struct seq_file ima_kexec_file;
+struct ima_kexec_hdr ima_khdr;
+
+void ima_clear_kexec_file(void)
+{
+	vfree(ima_kexec_file.buf);
+	ima_kexec_file.buf = NULL;
+	ima_kexec_file.size = 0;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = 0;
+}
+
+static int ima_alloc_kexec_buf(size_t kexec_segment_size)
+{
+	if ((kexec_segment_size == 0) ||
+	    (kexec_segment_size == ULONG_MAX) ||
+	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+		pr_err("%s: Invalid segment size for kexec: %zu\n",
+			__func__, kexec_segment_size);
+		return -EINVAL;
+	}
+
+	/*
+	 * If kexec load was called before, clear the existing buffer
+	 * before allocating a new one
+	 */
+	if (ima_kexec_file.buf)
+		ima_clear_kexec_file();
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(kexec_segment_size);
+	if (!ima_kexec_file.buf) {
+		pr_err("%s: No memory for ima kexec measurement buffer\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ima_kexec_file.size = kexec_segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(ima_khdr);	/* reserved space */
+
+	memset(&ima_khdr, 0, sizeof(ima_khdr));
+	ima_khdr.version = 1;
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-	struct seq_file file;
-	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		pr_err("%s: Kexec file buf not allocated\n",
+			__func__);
+		return -EINVAL;
 	}
 
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
+	/*
+	 * Ensure the kexec buffer is large enough to hold ima_khdr
+	 */
+	if (ima_kexec_file.size < sizeof(ima_khdr)) {
+		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
+			__func__);
+		ima_clear_kexec_file();
+		return -ENOMEM;
+	}
 
-	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
+	/*
+	 * If we reach here, then there is enough memory
+	 * of size kexec_segment_size in ima_kexec_file.buf
+	 * to copy at least partial IMA log.
+	 * Make best effort to copy as many IMA measurements
+	 * as possible.
+	 */
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
-			khdr.count++;
-			ima_measurements_show(&file, qe);
+		if (ima_kexec_file.count < ima_kexec_file.size) {
+			ima_khdr.count++;
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
-			ret = -EINVAL;
+			ret = EFBIG;
+			pr_err("%s: IMA log file is too big for Kexec buf\n",
+				__func__);
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
+	ima_khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
-		khdr.version = cpu_to_le16(khdr.version);
-		khdr.count = cpu_to_le64(khdr.count);
-		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
+		ima_khdr.version = cpu_to_le16(ima_khdr.version);
+		ima_khdr.count = cpu_to_le64(ima_khdr.count);
+		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
 
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
 
@@ -108,13 +161,20 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
+	ret = ima_alloc_kexec_buf(kexec_segment_size);
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
