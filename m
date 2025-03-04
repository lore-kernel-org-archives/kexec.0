Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151C6C28B22
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4fpkfAT2qDRSew80giIKdwwL8+StIhxSDKSC7I42as=; b=Dw/qpJNFV9w1KeSDPGRDms7g2A
	vEHkjCZJFv2X4e30dkupIywzwTIxYMsNb0IsrPIDjnq38S15h44f44bhhheBCRHwQXYLubc9lfbX4
	PISc+LWWEFrwhMYXHcl/WCbp02ccstMyNRjKScn7IqeHTVhpqtfUZxngbZPEH9u19ubL9yiqLRks3
	GKt8BXsLYK9yuueh3Vg2FN5CLmDOjOmowTDJhlW8IBDyxI7vYLrl/XveJ2Mq61vGwChrxUQBpeze6
	FFtwgYm+DMdu2KdQxex8bt/qHk0UvkrvPe3w7ZXcyFttH4igf08jkZfiJPoC3+9Pkci9n2bTZHjDL
	ck61Qw6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYH2-000000066E8-3PQP;
	Tue, 04 Mar 2025 19:49:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpXYe-00000005wwV-2KEU
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 19:04:02 +0000
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA1D6210EAF9;
	Tue,  4 Mar 2025 11:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA1D6210EAF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741115038;
	bh=C4fpkfAT2qDRSew80giIKdwwL8+StIhxSDKSC7I42as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=casVGVZgDDZlGFiWiV3hWdWKoyYHaSIQEDZ5oX9eeeCgtOONN/0UQNhCVXntbS03g
	 9voUHFotE22DmYfcw1/1AfbYJMDF6VmMfarkqJaM1XQw9YLb3C+JWR6o+MSdMBxBEy
	 Ys6JO5etPNGex+zEulwetmCLvpMK80fd+leFg760=
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
Subject: [PATCH v9 6/7] ima: make the kexec extra memory configurable
Date: Tue,  4 Mar 2025 11:03:50 -0800
Message-Id: <20250304190351.96975-7-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304190351.96975-1-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_110400_694955_46B8B8A2 
X-CRM114-Status: GOOD (  15.43  )
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

The extra memory allocated for carrying the IMA measurement list across
kexec is hard-coded as half a PAGE.  Make it configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added during
kexec soft reboot.  Ensure the default value of the option is set such
that extra half a page of memory for additional measurements is allocated
for the additional measurements.

Update ima_add_kexec_buffer() function to allocate memory based on the
Kconfig option value, rather than the currently hard-coded one.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/Kconfig     | 10 ++++++++++
 security/integrity/ima/ima_kexec.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..d73c96c3c1c9 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int "Extra memory for IMA measurements added during kexec soft reboot"
+	depends on IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value of 0, an extra half page of memory for those
+	  additional measurements will be allocated.
+
 endif
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index dd49658153ca..9fb1bf5a592a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -133,22 +133,26 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
-
+	unsigned long extra_memory;
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added during kexec.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
+		extra_memory = PAGE_SIZE / 2;
+	else
+		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
+	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
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
-- 
2.25.1


