Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F7BC48BC3
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/SXgeTq7VTEh/S3Wuiy6xldCNfSI5VHrhjGcpAkYZvg=; b=I+N2YbvPu37nL+
	xRGQOjvj08MmiVsILxRlDTpwq93Uo2C2Z6ZeBLA+bZ7S8S9N+JHaGdp6X3Akd9vZzuploZhyE3IuC
	CVvDQn9LpOfH1GsSaY/sDf1knyT5x98NEt/pMnoBN1afATdwW80ecKdlhwgDhJMVGAcLc63a6NJwj
	nmDEQU5mWF3uGzst1stnEH2OiW5L/o1vdL+E69v8kvsG36CtwUu1Lal71oca6sS3qRSi9ZFqu4NPJ
	ApnF9R14XxGeeZIFxH2aQ+K1wkzmKnjzN4VqYtcHr8aTr3K4hKMSvDZFjOdjiT8SYv1H2W7r1yV4X
	+p2JJjqS9qH2N23htWPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLN-0000000DLsk-1Upi;
	Wed, 14 Feb 2024 15:38:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raHLJ-0000000DLps-23AV
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 15:38:38 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D8A620B2003;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D8A620B2003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=7AfuizgJ5ElWTHZgEiEhqrG4GwZkXPqkkrHChqJjnRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJ9JAEojMDPIpCYEicWI2Hvf0bgAdnLVRsk0Jo3mrdAf52Wi8BCW/dWl9YKie8pUK
	 8dbavId1j6BOTH15o/t+X7gfydphHDfI4qTuTBJK9GQ+cc0wY1+/nn6zlwzMwv1TWf
	 iuctBCpIy27AhGJWW34NKDsC7pQDBGQn0dX+Y2ZQ=
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
Subject: [PATCH v5 3/8] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Wed, 14 Feb 2024 07:38:22 -0800
Message-Id: <20240214153827.1087657-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_073837_738598_41558F77 
X-CRM114-Status: GOOD (  13.73  )
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
new Kernel.  Therefore, the digest calculation, storage, and
verification of the IMA segment needs to be skipped.

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
index 3145447eb77a..73f0dd0e1787 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -358,6 +358,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bef2f6f2571b..0e3689bfb0bb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -750,6 +750,14 @@ static int kexec_calculate_store_digests(struct kimage *image)
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
index a9cb5e882e2e..ccb072617c2d 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -161,6 +161,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -171,6 +172,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
