Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE98FC35FF3
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 01:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ChPJc5DONIaBIynmnXN9T7sDKpkYPTV76HK61XuJeLY=; b=z0Ku8nLq3/p43KZJZ5Id4z8sWD
	fk6oyUcQUc2K1wNJ6z5NBneZ92aPlBhxP1mJLQqCCGV0FyBelo1F1PzReWjUPxx4yb8gRUp5V+UwB
	1H2Zhjjud/haHf+//+SJ4wNi1e5menI3YhiQo3kX1Ds65VtijMSvzh9m/Aokkr0N3vk/uBtNdJNWU
	91LKu1SFjfxRYQuriEh54UJZ5W3Ot4kDeczEzrdFIUJtIbl98MLJ+sRkeowV3px6ahBoDBUtfMox6
	3acNjEX69wjItUPzEX/XPzhd3Bqb8arEYxQon80uJ6tVo9hpzeBK+nsGQq3rTJlDWM+PJOsu72pMS
	MmOmHGeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOS-00000004JPs-2XLv;
	Tue, 18 Mar 2025 01:05:20 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuLOP-00000004JMI-12n3
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 01:05:18 +0000
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3EDB220DEAC8;
	Mon, 17 Mar 2025 18:05:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3EDB220DEAC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259916;
	bh=ChPJc5DONIaBIynmnXN9T7sDKpkYPTV76HK61XuJeLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJHzzqSszRZ4adMZNCUevuB1bEuRkGJl5Zowh35kpLSiVk7TFGjXHO81cb4SFrT6e
	 9w3Z+gQdMuEKRDUkLiqISP7wJNS9JLy87AdECpJhW7m98w1FBAFKHjE3GXYhLSg69U
	 Sm0xl45PXu5pzzj7enIT5LRiSW+ioqQNRU1Skeio=
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
Subject: [PATCH v10 4/8] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Mon, 17 Mar 2025 18:04:42 -0700
Message-ID: <20250318010448.954-5-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318010448.954-1-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_180517_345195_13760BEC 
X-CRM114-Status: GOOD (  18.69  )
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

With this series, the IMA segment will be updated with the measurement 
log at the kexec execute stage when a soft reboot is initiated. 
Therefore, the digests should be updated for the IMA segment in the 
normal case.

The content of memory segments carried over to the new kernel during the
kexec systemcall can be changed at kexec 'execute' stage, but the size
and the location of the memory segments cannot be changed at kexec
'execute' stage.

However, during the kexec execute stage, if kexec_calculate_store_digests()
API is called to update the digest, it does not reuse the same memory
segment allocated during the kexec 'load' stage and the new memory segment
required cannot be transferred/mapped to the new kernel.

As a result, digest verification will fail in verify_sha256_digest() 
after a kexec soft reboot into the new kernel. Therefore, the digest
calculation/verification of the IMA segment needs to be skipped.

To address this, skip the calculation and storage of the digest for the
IMA segment in kexec_calculate_store_digests() so that it is not added 
to the purgatory_sha_regions.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7d6b12f8b8d0..107e726f2ef3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..606132253c79 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
+		return true;
+	else
+		return false;
+}
+#else
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	return false;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (check_ima_segment_index(image, i))
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 45170e283272..34020b1513b0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -168,6 +168,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -178,6 +179,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


