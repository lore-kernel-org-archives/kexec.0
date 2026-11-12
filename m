Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA52606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=35m75Wx2;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Sc0PhQT9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tF49+JupgZE9xGK8EKohysErvg0QsCmNr2anu3IocEM=; b=35m75Wx23yCe+o
	4EDPfbnv3PwQgFL89KfhzBC32l3+XTPqEyzdFLCealnQyZ7x39hrD28CIt7ucmOKvHd6aI/jHB67s
	oBwRPZjOvgur9ESvowGaQ02jpetnJ1ZCXJ48bEmgQUJWBNpfUHEB6L2yH+uY73mk7OMJba2x3NTuY
	/t5u1yhLaAQ4qSrctJnTSQ0AsQ07anZmbpDz3/lC2E4rn9Y/hcmej2r02HBSri1pWWMMHU+13pMvx
	M3/CfNEZoBKEOx3x7Ez3vZfpzaJZtJNQ3QNP7t/mmuSoAFQACxHdz4WTzXuMu3dYbY/hBqnuS4rla
	1Wi4lGIi57nSaz13tLNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJI-00000009w26-3H7G;
	Thu, 12 Nov 2026 12:53:48 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJF-00000009vun-3k0P
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 12:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tF49+JupgZE9xGK8EKohysErvg0QsCmNr2anu3IocEM=; b=Sc0PhQT9Su7h7qxLJdtbnFU0Jq
	m7sPeEM20P9y8mnSG++XUGfE5cfs9sjhxGm0w5nBnWGCA5Bbh5guO6jTW8ymF2Xu6pd5nOpPPNQlm
	ZkKAlN2hLgh5E0eh+IQm2MzWO7NwRyBFhL2w0RtAt8DJ2nfPsTM7/vvWBogNLtV0OTRUyZEZmiQfV
	9Y1xsKqdqaQHGLHd9NAlF4WCC/icJQd4wzP/1OIc2k+av3JJTKXxM4NZs7KtHsyV0Rrq9JoIbgWDR
	7ytgv8rEJDbdHit6sOPt8J/ZPJ4P5jc3fe35MDUc0e6wRac3pjjUNw0drrSWNG0MFjf2tDk4BIzgT
	HI1TJyDg==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIa-00000003H1G-0duP;
	Thu, 12 Nov 2026 13:53:02 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] ima: keep kexec dump state tied to installed image
Date: Thu, 12 Nov 2026 12:52:46 +0000
Message-ID: <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_045346_116674_AF7F748A 
X-CRM114-Status: GOOD (  15.57  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ima_add_kexec_buffer() updates the global measurement scratch buffer
and segment size for the new image. If kexec_file_load() fails, the
new image is freed but the scratch buffer and segment size remain. When
kexec starts the installed image, ima_update_kexec_buffer() dumps the
measurement list into the IMA segment. A larger failed segment causes an
OOB write, while a smaller one truncates the log and reports the wrong
size in the kexec_execute event. KASAN for instsance reports the OOB
writes as:

  BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
  Write of size 868426 at addr ffffc9000004e000 by task init/1
  ...
  __asan_memcpy+0x3b/0x60
  ima_update_kexec_buffer+0x265/0x280

Leave installed scratch state unchanged until all later load steps pass.
Store new buffers in the candidate and reuse only equal-size installed
buffers. Emit kexec_load before those steps with the local size.
Allocation failure still omits the optional segment.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 security/integrity/ima/ima_kexec.c | 74 ++++++++++++++++--------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 0d845693a1f7..3aa8b1096f81 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -35,7 +35,8 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	sf->count = 0;
 }
 
-void ima_measure_kexec_event(const char *event_name)
+static void ima_measure_kexec_event_size(const char *event_name,
+					 size_t segment_size)
 {
 	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	size_t buf_size = 0;
@@ -48,35 +49,26 @@ void ima_measure_kexec_event(const char *event_name)
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
 		      "ima_runtime_measurements_count=%ld;",
-		      kexec_segment_size, buf_size, len);
+		      segment_size, buf_size, len);
 
 	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
 }
 
-static int ima_alloc_kexec_file_buf(size_t segment_size)
+void ima_measure_kexec_event(const char *event_name)
 {
-	/*
-	 * kexec 'load' may be called multiple times.
-	 * Free and realloc the buffer only if the segment_size is
-	 * changed from the previous kexec 'load' call.
-	 */
-	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
-		goto out;
+	ima_measure_kexec_event_size(event_name, kexec_segment_size);
+}
 
-	ima_free_kexec_file_buf(&ima_kexec_file);
+static int ima_alloc_kexec_file_buf(struct kimage *image, size_t segment_size)
+{
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		return 0;
 
 	/* segment size can't change between kexec load and execute */
-	ima_kexec_file.buf = vmalloc(segment_size);
-	if (!ima_kexec_file.buf)
+	image->ima_buffer = vmalloc(segment_size);
+	if (!image->ima_buffer)
 		return -ENOMEM;
 
-	ima_kexec_file.size = segment_size;
-
-out:
-	ima_kexec_file.read_pos = 0;
-	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
-	ima_measure_kexec_event("kexec_load");
-
 	return 0;
 }
 
@@ -160,10 +152,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .top_down = true };
 	unsigned long binary_runtime_size;
 	unsigned long extra_memory;
+	size_t segment_size;
 
-	/* use more understandable variable names than defined in kbuf */
-	size_t kexec_buffer_size = 0;
-	void *kexec_buffer = NULL;
 	int ret;
 
 	if (image->type == KEXEC_TYPE_CRASH)
@@ -182,36 +172,36 @@ void ima_add_kexec_buffer(struct kimage *image)
 			      extra_memory;
 
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
-		kexec_segment_size = ULONG_MAX;
+		segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+		segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
 
-	if ((kexec_segment_size == ULONG_MAX) ||
-	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
+	if (segment_size == ULONG_MAX ||
+	    (segment_size >> PAGE_SHIFT) > totalram_pages() / 2) {
 		pr_err("Binary measurement list too large.\n");
 		return;
 	}
 
-	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	ret = ima_alloc_kexec_file_buf(image, segment_size);
 	if (ret < 0) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
 		return;
 	}
 
-	kbuf.buffer = kexec_buffer;
-	kbuf.bufsz = kexec_buffer_size;
-	kbuf.memsz = kexec_segment_size;
+	ima_measure_kexec_event_size("kexec_load", segment_size);
+
+	kbuf.memsz = segment_size;
 	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
-		vfree(kexec_buffer);
+		vfree(image->ima_buffer);
+		image->ima_buffer = NULL;
 		return;
 	}
 
 	image->ima_buffer_addr = kbuf.mem;
-	image->ima_buffer_size = kexec_segment_size;
-	image->ima_buffer = kexec_buffer;
+	image->ima_buffer_size = segment_size;
 	image->ima_segment_index = image->nr_segments - 1;
 	image->is_ima_segment_index_set = true;
 
@@ -269,8 +259,22 @@ void ima_kexec_post_load(struct kimage *image)
 		ima_kexec_buffer = NULL;
 	}
 
-	if (!image->ima_buffer_addr)
+	if (!image->ima_buffer_addr) {
+		kexec_segment_size = 0;
+		ima_free_kexec_file_buf(&ima_kexec_file);
 		return;
+	}
+
+	if (image->ima_buffer) {
+		ima_free_kexec_file_buf(&ima_kexec_file);
+		ima_kexec_file.buf = image->ima_buffer;
+		image->ima_buffer = NULL;
+	}
+
+	kexec_segment_size = image->ima_buffer_size;
+	ima_kexec_file.size = image->ima_buffer_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
 	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
 	if (!ima_kexec_buffer) {

