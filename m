Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BBEC48260
	for <kexec@archiver.kernel.org>; Mon, 22 Jan 2024 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p2Qx59x3DZOhU7EH3tr3Z4+4zu/oFtSspDrBdbSZQ80=; b=4tl0PvXZSeyI1X
	RI8JswxKFEOBCNE9lhhS8S2Bs8YPkOAqE0Mc8IxL89hIWPLR4XF8NEOJUxSM6Hwdlr+/LkSovUDsP
	sD6E8uYZ0n5LXEAcKlYwgnrxG7ANm5kUQpmx7E0CR4jHbkanKyQUbdCPqZL97UhHiS2M3g6lUqmnU
	aFD8MGjrn3eKr2rWeauBHL+jYzDoFsuMLQi3qvFCV64j0AUFCqTew94ttsOQaBEvzVfAO57OgzU5q
	AHDiNflDQsGcCnGFFrdGfybdi12L2svLSCRRAjy9tKxIiyFU7mGcKeTZZNK4+t6XbJSVayIOdWdE3
	03hUj8JiFYU9WJCtAEOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBh-00DYe7-3C;
	Mon, 22 Jan 2024 18:38:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRzBd-00DYbk-2v
	for kexec@lists.infradead.org;
	Mon, 22 Jan 2024 18:38:23 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id E763B20E2C27;
	Mon, 22 Jan 2024 10:38:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E763B20E2C27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948697;
	bh=qWdS8NNgz0MGlGCMbGxri5f+7iqORqYYJwxxs6oaIek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7pEkKmywyPkVQDCSStuFKrnTzeK2SvA6C4NRv28+Fiyhp1DdB5EeAgvp/HKaC1rO
	 PHfMIVtmjKQ2YOq5SCZ22bpbjNCTUEfZNUunNpGa7k/MedP+iYrJ0CdHWF9Qm3RYue
	 NKEN4EwgVWfbr8kaG9RTLrlke8RutyqojgTtTIEA=
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
Subject: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Date: Mon, 22 Jan 2024 10:38:03 -0800
Message-Id: <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_103822_109139_1F3E18E0 
X-CRM114-Status: GOOD (  14.75  )
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

The extra memory allocated for carrying the IMA measurement list across
kexec is hardcoded as half a PAGE.  Make it configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added during
kexec soft reboot.  Ensure the default value of the option is set such
that extra half a page of memory for additional measurements is allocated
to maintain backwards compatibility.

Update ima_add_kexec_buffer() function to allocate memory based on the 
Kconfig option value, rather than the currently hardcoded one.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     | 11 +++++++++++
 security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..fc103288852b 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -338,3 +338,14 @@ config IMA_DISABLE_HTABLE
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int
+	depends on IMA && IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value, an extra half page of memory for
+	  additional measurements will be allocated to maintain backwards
+	  compatibility.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f26b5b342d84..c126aa6494e9 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
+	unsigned long extra_size;
 
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
@@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added during kexec.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
+		extra_size = PAGE_SIZE / 2;
+	else
+		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
+	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
