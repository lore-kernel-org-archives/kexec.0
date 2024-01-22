Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA40C47DD3
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QQe83LUGDx2A0nNDQk/DFjVTu81O84UeZ0FIuB57Xxg=; b=Pt8NNJkdFMm2HV
	dCG/bCcnzfaVvcvUNFbAc8fNA/qLDfvTquFRgVGLQsuxmb9s9d6QTnafExh8UCGD/LrjDf7c1vzeA
	aTi1/0HW9HsmnXzckwkLsiPPS/XzC9CBNspQpDhDO37HhE6apYRHy3l1glKXeW/6Rvcw3RNstt4OD
	ymZ5zAUkboiLPweDVBheLIZNgr9Vjibq7X8n958oO64LbcMTekn+V3ifwOFi/+mxAUJ8VeUokgRev
	XHmcPn3B2mFKMFKO9hFmu6TTPFUaOMCi2cVVo7Z9aKgp4J6vjKuQAq5ixyJDGNawnmGjrfjAUYbmB
	MfOMhUCK440tQDznThFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBg-00DYcR-0Q;
	Mon, 22 Jan 2024 18:38:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBb-00DYZ0-2S
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:21 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCCAA20E2C18;
	Mon, 22 Jan 2024 10:38:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCCAA20E2C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948696;
	bh=06l468Ace46pgsOl3SC3DbsNNCIbYOZvyp2JfoJ3taA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImRy9VmSeKD77UDZBXPJNgXD15itjsj9Lzk/8QXKlBQgXnD1twCCOBqWHvVA91oR3
	 Rlh6Pf2cCyWzP/qi1XwRc9GfQ1QGIUeVqGAurtLwfbfSbi13HWkpc49yuqpRgJscBB
	 PnZCmP0sM190ITL46Cf/dEKgYkNuoNMNy9lDEVEk=
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
Subject: [PATCH v4 3/7] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Mon, 22 Jan 2024 10:38:00 -0800
Message-Id: <20240122183804.3293904-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103820_000146_0577B160 
X-CRM114-Status: GOOD (  14.07  )
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

kexec_calculate_store_digests() calculates and stores the digest of the
segment at kexec_file_load syscall where the IMA segment is also
allocated.  With this series, the IMA segment will be updated with the
measurement log at kexec soft reboot.  Therefore, it may fail digest
verification in verify_sha256_digest() after kexec soft reboot into the
new Kernel.

Skip IMA segment from calculating and storing digest in function
kexec_calculate_store_digests() so that it is not added to the
'purgatory_sha_regions'.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/kexec.h              | 3 +++
 kernel/kexec_file.c                | 8 ++++++++
 security/integrity/ima/ima_kexec.c | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e00b8101b53b..eb98aca7f4c7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -366,6 +366,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..bf758fd5062c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -734,6 +734,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (image->is_ima_segment_index_set &&
+		    i == image->ima_segment_index)
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 4f944c9b4168..d92a48284cc4 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -156,6 +156,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -166,6 +167,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
