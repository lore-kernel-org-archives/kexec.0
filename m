Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13FEC001B1
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UsH/lk67pFEW5zX+/yO4UL9YXozW/SX1dXIe8VOXSWQ=; b=rgwZRN09DbAVNi
	SqDKuieBBxvJE+iYfBn5GM3E6kYjsdt6AKMdCs+pzK0RgM5ZHaKxEUCbXepHyFpTbv5SGJjHVgpwP
	y8hR7bNL4Ika6YqFeBCIBddr/OcAIwy2JqHIyojNIDOSdaLFmvg+s3w6JJFn94B/U1jW2AXDY1Xv9
	4j4JsPxe9tkoVZQlecBKIcLXphW93DllE92nAN/PJH9f+esdOUK5FAP4EDlh8hSBPzB5rj9n/U0/E
	ASbd8I3Uht6LMy141FZVXlNykVbFg57NyiCblSK45t1D0wqkLfaORMcVrZL6c2qeIcUtVNGhp0u2Q
	4mj0WrUo78bBUp/ODltg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXx-00BVwr-3A;
	Mon, 03 Jul 2023 21:57:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGRXs-00BVsW-0I
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 21:57:22 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79AE720C08E7;
	Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79AE720C08E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1688421438;
	bh=0H385rr4xvv2DCWeqKIKQV5s1y2DVPMF7eZDISj7L0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSVf05PhU8/5t+iU4STAK+h9lawJ/Oq58BG3TG2kS6zP2adxu0b6vPS9OXmdKU0Qi
	 +dmZnQiLTWeTwaYoj4eujuKJIyZjuVFooBOnyXgrCirfaye7sM6tINN5nX/yZbO0QA
	 wppF1MNyGYUPQZHZT6gJYp94PHDEJaFPMMU9vEdI=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima measurements
Date: Mon,  3 Jul 2023 14:57:02 -0700
Message-Id: <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_145720_223322_06239C39 
X-CRM114-Status: GOOD (  13.59  )
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

The IMA subsystem needs a dedicated mechanism to reserve extra memory for
measurements added between the kexec 'load' and kexec 'execute'.

Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
taking ima binary runtime measurements size, size of ima_kexec_hdr, and
IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to align
to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
buffer.

This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
sufficient to handle the additional measurements.  This should be as per
the system requirements and based on the number of additional measurements
expected during the window from kexec 'load' to kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..2ffda9449b9b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 858b67689701..7deb8df31485 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added in the window from
+	 * kexec 'load' to kexec 'execute'.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	binary_runtime_size = ima_get_binary_runtime_size() +
+			      sizeof(struct ima_kexec_hdr) +
+			      IMA_KEXEC_EXTRA_SIZE;
+
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
-					   PAGE_SIZE / 2, PAGE_SIZE);
+		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
 		pr_err("Binary measurement list too large.\n");
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
+	ret = ima_allocate_buf_at_kexec_load();
+	if (ret < 0)
 		return;
-	}
 
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
