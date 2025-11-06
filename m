Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3674CCFA03
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AR8zCu9He0hr0Ps1/Yt7ZPdaD105dTYO/pQr3EZq3BI=; b=g4xRTJlet2RZADWJtBTteXDbxg
	523QJ1CndWScg/52krhV011jebCtD9K+eJV/ks56Rt1EZNMmt+BPz9Xqip4ikhvYSJ3C3ZcjpsPao
	Rgqb72zvcZYLvCaiyWoHFnVbD59SWbxJurCag+0QEPSmBZEAvH6fqTVy9HI/OgspxTW0IBMJOxt3i
	4rtp8UGr1+6JW9nlyMMczRHiUV4x/EfKyHiPeB3wetZy/dhLoGMyf6umE9gsPlaKvuNtbhrlMiyb+
	U8gF5s3LxkJAgM5G5CcKIqDt1TCdDraJQdlAV3hkgu6MuIhZCChCM0b8aYGpo6A/Cc8LZoLhwd/m4
	qwXk8LBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGtxx-0000000EyMp-2BpP;
	Thu, 06 Nov 2025 06:59:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGtxu-0000000EyM5-3gkK
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 06:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762412365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR8zCu9He0hr0Ps1/Yt7ZPdaD105dTYO/pQr3EZq3BI=;
	b=emnJMgSYM8Eoy+Y3zxG2/gV0ZO8krDITL8X2BaX1He8Rgk589gn4QMJu00rY5InwB0NNqb
	U+d+l/n7ulqdNqFAHORDgLJborL1E3+S5s5W85t/IY2vWkSkRvVje9eC8SpPGR/XrJZ/FF
	icpLglsEvSNtaG+R2XX4ttjN3FlnWTM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-iYaUPKAfPv6_RvXWSa6UDQ-1; Thu,
 06 Nov 2025 01:59:23 -0500
X-MC-Unique: iYaUPKAfPv6_RvXWSa6UDQ-1
X-Mimecast-MFC-AGG-ID: iYaUPKAfPv6_RvXWSa6UDQ_1762412361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B35E81800358;
	Thu,  6 Nov 2025 06:59:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D92196B8F6;
	Thu,  6 Nov 2025 06:59:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
Date: Thu,  6 Nov 2025 14:59:03 +0800
Message-ID: <20251106065904.10772-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_225927_012361_6897E241 
X-CRM114-Status: GOOD (  14.29  )
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

The kexec segment index will be required to extract the corresponding
information for that segment in kimage_map_segment(). Additionally,
kexec_segment already holds the kexec relocation destination address and
size. Therefore, the prototype of kimage_map_segment() can be changed.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: <stable@vger.kernel.org>
To: kexec@lists.infradead.org
To: linux-integrity@vger.kernel.org
---
 include/linux/kexec.h              | 4 ++--
 kernel/kexec_core.c                | 9 ++++++---
 security/integrity/ima/ima_kexec.c | 4 +---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..8a22bc9b8c6c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
-extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
+extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
@@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
-static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
+static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..9a1966207041 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
 	return result;
 }
 
-void *kimage_map_segment(struct kimage *image,
-			 unsigned long addr, unsigned long size)
+void *kimage_map_segment(struct kimage *image, int idx)
 {
+	unsigned long addr, size, eaddr;
 	unsigned long src_page_addr, dest_page_addr = 0;
-	unsigned long eaddr = addr + size;
 	kimage_entry_t *ptr, entry;
 	struct page **src_pages;
 	unsigned int npages;
 	void *vaddr = NULL;
 	int i;
 
+	addr = image->segment[idx].mem;
+	size = image->segment[idx].memsz;
+	eaddr = addr + size;
+
 	/*
 	 * Collect the source pages and map them in a contiguous VA range.
 	 */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7362f68f2d8b..5beb69edd12f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
 	if (!image->ima_buffer_addr)
 		return;
 
-	ima_kexec_buffer = kimage_map_segment(image,
-					      image->ima_buffer_addr,
-					      image->ima_buffer_size);
+	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
 	if (!ima_kexec_buffer) {
 		pr_err("Could not map measurements buffer.\n");
 		return;
-- 
2.49.0


