Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7261C48BEE
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gXdsXuk+0sQDmX2kAoyb/HaeYpMipW7CGAYO4j6crdc=; b=MHkLNlDa4v8aEx
	H/i4cXgslNjXqv6R6CnJgJH6DoA99iDaKa/RVlv0+Js8+6QuZNMBOc8sCDDb8TV+vJpy2I41uMLrz
	Cj7n52CBOBFtda/isGTaQitzvGboyBl8frhDxRmLbyE7UnhSbSiBz7WPiJ7DSi68Uh+e7WPpwCeop
	KOK57SaDFhA/wyDmY9KU2+rWa31juObzmmxCJ2TqLGbFe4tVo3fgTegOCiFpE16dI4N3AEAWi3d/x
	+BfwYhJE3IQ72H6I8A2JzeuoumkOalsyE4E2OxeT5L4OM/v0SsWBBxmQJcFWbjmNWOMP4lmXkMJIX
	uMHt0G42VgjoVwq5kHag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLR-0000000DLut-2Nvv;
	Wed, 14 Feb 2024 15:38:45 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLL-0000000DLrN-3lVJ
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 15:38:41 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF2F120B2005;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF2F120B2005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=ZlIccf7Ox9/YKL2es1yXhbAiKARAN1cP73a//eRxN5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X36gxMzUPc70JtXNRuKZiHxPx50rW99EylvQtZD3RWl+bRX+tsTbjn+LjZ7HUbx0G
	 xhBnsOojVkxrp3OgqaL9nXPxm8cK1wvt4lqGA6+q02kR3zucWoOOn8sUqW+cHQQ+Ji
	 2yji3N+cGifW/1Y+syvRgjjsR1pm7SpdSbdZiKZU=
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
Subject: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to execute
Date: Wed, 14 Feb 2024 07:38:24 -0800
Message-Id: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_073840_183423_93D857A1 
X-CRM114-Status: GOOD (  15.40  )
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

This patch includes the following changes:
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

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima_kexec.c | 45 +++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fe59cb7c179d..2d5df320c34f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 1d4d6c122d82..98fc9b9782a2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
 static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
@@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -154,14 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -179,12 +171,6 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -195,7 +181,34 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
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
 }
 
 struct notifier_block update_buffer_nb = {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
