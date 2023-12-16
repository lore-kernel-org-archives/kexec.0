Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D8AC46CCD
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 01:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bTCH0H0D44+MmJ9y1sAt+sJrjgPxcKJog5kV6GYnkLQ=; b=QYQjKbBPplzOvM
	+yNgHsJVxNUcLSajKLa8kla+z+/Mrop0m+owH77KvZOxpEsWpUBek82BULCIAyCh+aDbXnMXeSBfz
	0qoj/RaLlY2tTUppbVVgTjcNF2N0QFr9fvF+KSxC216XNCfKl3U50AoDUSEcFukUjgQu7oqGmDfjF
	kjarn70pQGvXzuo8WTd5nunNK0iBtAYHu1D9biv6nqNeHgKkqZY2jyPXffbccwFEm4Vaapeb1+MzX
	n+mmH6BgOEqCYVyirY7NVDI7Cpccb7CGnrx35mtecfxOiDLt4Rzy04BGc0xpcVX8J/bzhNOfk0Mbg
	6SbMwbaXMhVy1omKoNCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9h-00546O-2V;
	Sat, 16 Dec 2023 01:07:49 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9d-00544S-36
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 01:07:47 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B37520B3CC4;
	Fri, 15 Dec 2023 17:07:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B37520B3CC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688860;
	bh=Kuh7HHtW0surZQmmoh5+OnSpf7Wv3yhg4QwvyIeBjLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNPb2AIur58OR3dj8b86eQdW3bzbIccak3QFeUC8oydKG1wbr6xpxeuGYUhoGr+Jw
	 8J6BpxZDw68QpOohLkDytm/j6cRBoX9+Jm++2hXVUG24qEHdcHd1Lbreb2NOBiei/O
	 V6lYA183wfPY//gDdsrR1M5r8XJivJDPr301UZMg=
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
Subject: [PATCH v3 6/7] ima: configure memory to log events between kexec load and execute
Date: Fri, 15 Dec 2023 17:07:28 -0800
Message-Id: <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_170746_047373_E6BF1284 
X-CRM114-Status: GOOD (  12.92  )
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

IMA currently allocates half a PAGE_SIZE for the extra events that would
be measured between kexec 'load' and 'execute'.  Depending on the IMA
policy and the system state, that memory may not be sufficient to hold
the extra IMA events measured after kexec 'load'.  The memory
requirements vary from system to system and they should be configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added in the
window from kexec 'load' to kexec 'execute'.

Update ima_add_kexec_buffer() function to allocate memory based on the 
Kconfig option value, rather than the currently hardcoded one.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     |  9 +++++++++
 security/integrity/ima/ima_kexec.c | 13 ++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..8792b7aab768 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int
+	depends on IMA && IMA_KEXEC
+	default 64
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added in the window
+	  from kexec 'load' to kexec 'execute'.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 55bd5362262e..063da9c834a0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -128,15 +128,18 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+			      (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024);
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
