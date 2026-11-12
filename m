Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D553606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4aiTdUZ2;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=FHXMsZjK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ho9lfVmh032DRkxc1lN+upULBMkzPGfKHmpBixAPo84=; b=4aiTdUZ2oJaY0G
	avfs5mk5khr30XB6j6rPr+gmNNZdiH9mfZkvVwsbZC3rz32C8eYpZPiB1Yc4k3RJogLPa+FjQhVf7
	w4L+EEEgoTWTFeU96qyxCYTf4gBLZOV2lcuVUoo//dz8UdayrTnYlZQgBnpoVjfjktKh0tywMhkXv
	iCu7MX3K9E7a29ZeIcpqOIb/AeugcsXsjUNQWI6haFerjXJzg8hhDNLnG2TFHnY5SYOK1g+uMRyM1
	qN0NMa+e3igPwKsAK6eyNa2psOnOCB2aXhH21Qv2u8SSLKGksvwP+5SuCRKqmKXQ/7Dmsya94HyWc
	68D44Z8mrT/bt75fB+PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJS-00000009w82-3ycF;
	Thu, 12 Nov 2026 12:53:58 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJL-00000009vv4-3Tl4
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 12:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ho9lfVmh032DRkxc1lN+upULBMkzPGfKHmpBixAPo84=; b=FHXMsZjK+wefAnn50JdCcok8mn
	TRuHEMnf5i23qBfyHGbHtXnvmXH2Q/9cdqKnFoQ1Jlz+A2ZArjg68bTapmRe5mzC1tuFwSISJSZv2
	a3mSrAcXMEySMoYz372FwbRIS5WWhTDUmRhdIjEprKJAcDqeQ+5CSSJLV9j5Oln5n71+E6Q7Zzr1z
	AlNb1wIakd49DInoZAZIyLJmRm2zmluiqo7pivBxiiDJkFU8Pc9p2Pm1HqjjKW2eJ7PJB8XWIaWKU
	UmX1h04az5ovUpqAY69EBE8cSzzrk0F5a0rW2p1kotj7Dv1YEkGT6hEoO3Amf4gkRw/yUn+RZbfuu
	XDK3+haA==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIa-00000003H1G-2QwN;
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
Subject: [PATCH v2 3/3] ima: clear kexec state when replacing file image
Date: Thu, 12 Nov 2026 12:52:47 +0000
Message-ID: <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
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
X-CRM114-CacheID: sfid-20261112_045352_097310_1443C9CB 
X-CRM114-Status: GOOD (  16.51  )
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

ima_kexec_buffer remains mapped to the IMA segment of the installed
kexec_file_load image. KEXEC_FILE_UNLOAD and a successful normal
kexec_load can replace and free that image without clearing the mapping.
Executing a later kexec_load image can then write the measurement list
into the freed pages. The new image has an IMA segment size of zero, but
size does not establish ownership of the mapping.

Record the image whose segment is mapped and verify it before the
execute-time update. Clear the mapping and scratch state under kexec_lock
when a normal image is removed without another file image taking its
place.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/linux/ima.h                |  1 +
 kernel/kexec.c                     | 11 +++++++++++
 kernel/kexec_file.c                |  7 ++++++-
 security/integrity/ima/ima_kexec.c | 24 ++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e08baf16c2f..d61b7b7756b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -34,6 +34,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 extern void ima_kexec_post_load(struct kimage *image);
+void ima_kexec_cleanup(void);
 #else
 static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 90756dc6339b..297f4657869b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/ima.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/syscalls.h>
@@ -114,6 +115,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	if (nr_segments == 0) {
 		/* Uninstall image */
+#ifdef CONFIG_IMA_KEXEC
+		if (!(flags & KEXEC_ON_CRASH))
+			ima_kexec_cleanup();
+#endif
 		kimage_free(xchg(dest_image, NULL));
 		ret = 0;
 		goto out_unlock;
@@ -163,6 +168,12 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	/* A kexec_load image has no IMA measurement segment. */
+#ifdef CONFIG_IMA_KEXEC
+	if (!(flags & KEXEC_ON_CRASH))
+		ima_kexec_cleanup();
+#endif
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59f9ba1b0cd7..95b3a9ab1e3b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -401,8 +401,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 #endif
 		dest_image = &kexec_image;
 
-	if (flags & KEXEC_FILE_UNLOAD)
+	if (flags & KEXEC_FILE_UNLOAD) {
+#ifdef CONFIG_IMA_KEXEC
+		if (image_type == KEXEC_TYPE_DEFAULT)
+			ima_kexec_cleanup();
+#endif
 		goto exchange;
+	}
 
 	/*
 	 * In case of crash, new kernel gets loaded in reserved region. It is
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 3aa8b1096f81..cc15aed8df48 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -25,6 +25,7 @@ static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
 static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
+static struct kimage *ima_kexec_image;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -229,6 +230,11 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	if (ima_kexec_image != kexec_image) {
+		pr_err("Kexec buffer does not match current image.\n");
+		return ret;
+	}
+
 	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
 
 	if (ret)
@@ -239,6 +245,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 
 	kimage_unmap_segment(ima_kexec_buffer);
 	ima_kexec_buffer = NULL;
+	ima_kexec_image = NULL;
 
 	return ret;
 }
@@ -258,6 +265,7 @@ void ima_kexec_post_load(struct kimage *image)
 		kimage_unmap_segment(ima_kexec_buffer);
 		ima_kexec_buffer = NULL;
 	}
+	ima_kexec_image = image;
 
 	if (!image->ima_buffer_addr) {
 		kexec_segment_size = 0;
@@ -288,6 +296,22 @@ void ima_kexec_post_load(struct kimage *image)
 	}
 }
 
+/*
+ * Drop the dump state before its kexec image is replaced.
+ *
+ * This function assumes that kexec_lock is held.
+ */
+void ima_kexec_cleanup(void)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+	ima_kexec_image = NULL;
+	kexec_segment_size = 0;
+	ima_free_kexec_file_buf(&ima_kexec_file);
+}
+
 #endif /* IMA_KEXEC */
 
 /*

