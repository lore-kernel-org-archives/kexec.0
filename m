Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C773C0015E
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dsQtsVsm5XKsqDpUE3Uc9tHNfZEmsjwisvADcE4pT6M=; b=gw3izq+GkSBicI
	1yrcKnR4T8HQMOkZh8eUAnH8qBNI1t/YcFqe2yzwjo72TnqjKYC+8vvIO/hBhWdtNdq8uGdrp9EBi
	ZfE2bzg6SohLSg7GVdmRTMNSyz9aes9a/tCwE4ph15a5Rb2sdCaxkhWHu8F4MMIlHAKBMT5iclyHc
	XXDUS3Ri+47NpeKU5qa/hwOtS9tdd2DrCmvm8C39vZbySwj3WJB2vAtJ5vdr872PjFMa1sKe3bYuV
	D3/U4OnUGMkaKMlNx0icLWlRq1OZnFu1h3m5GNvUOYRrUegKvIDufnNhFhTxBqJqM8jVsgYUFpEuH
	2+8e1R2Mv27f0agcfAQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQty0-0030n9-0x;
	Tue, 01 Aug 2023 18:19:32 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxw-0030lD-1l
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 18:19:31 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4CF7238AEA2;
	Tue,  1 Aug 2023 11:19:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4CF7238AEA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690913968;
	bh=XSu/u8+vyhoyKdaPC5jr7V2GlLG5uFfsCE+21U5Fofs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvgYNT7GmYF5rOZ0k6+hig3x2xbFWxcTxTpYi21DHDFieGhqLlltEKw8FAEJpZLrH
	 6QxtNqqZU/uXBPLiSHeM2QJZfwNMVRuHhALQR8rUYFT6b4d4QNP8CjPN8j5XFAWJw8
	 +qurG3UrKDaIX/7Ix/i4zVpJXAStZ2gAtQYp1znI=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 3/6] ima: get TPM update counter
Date: Tue,  1 Aug 2023 11:19:14 -0700
Message-Id: <20230801181917.8535-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_111928_611839_A22C4037 
X-CRM114-Status: GOOD (  11.87  )
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

Measuring the TPM PCR update counter will help the remote attestation
service to validate if there are any missing entries in the IMA log, when
the system goes through certain important state changes (e.g. kexec soft
boot, IMA log snapshotting etc.).  Detecting such missing entries would
help the remote attestation service functionality to be more robust.
It should also help the system administrators with manual investigations
when TPM PCR quotes go out of sync with IMA measurements.

Implement a new function, 'ima_tpm_get_update_counter()', which uses
the 'tpm_pcr_get_update_counter()' function from the TPM driver interface
to retrieve the PCR update counter of the TPM chip in use.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_queue.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..4acd0e5a830f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -167,6 +167,7 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+int ima_tpm_get_update_counter(u32 *cpu_update_counter);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..38f5c35b23b2 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -135,6 +135,22 @@ unsigned long ima_get_binary_runtime_size(void)
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
+int ima_tpm_get_update_counter(u32 *update_counter)
+{
+	int result;
+
+	if (!update_counter)
+		return -EINVAL;
+
+	result = tpm_pcr_get_update_counter(ima_tpm_chip,
+				CONFIG_IMA_MEASURE_PCR_IDX, TPM_ALG_SHA1, update_counter);
+
+	if (result != 0)
+		pr_err("Failed to get TPM PCR update counter, result: %d\n", result);
+
+	return result;
+}
+
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
