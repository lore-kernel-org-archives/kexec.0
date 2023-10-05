Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D23E92727
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fPbEfR2IUeMabd1ZXjP2jqtvhFWoCYSpRIxfUlnLgTs=; b=nVVhVMOu9xPPlY
	s8voP6cg90FPhXln0EsW2USDFWBbptt2nkor7AYj0pRD243cZFNQtN80naP3HHN+SFD073bfRYAN3
	qP1jm6/MJa/QdzAkOFTpmOC8hEJKPeHdWTcK4zIm7fQUopZJjcj1aZOwG4UeCiwpNyMbvzcKKxHl4
	lxJI7fNUZYa8ngf2VvmVzRsebtiMLDk9DWlsPMFmU0mwd0O5JO7inkBscGj9JGexSdLCR2XUvIPcB
	z4z85Wnz5PNrPUXwBVta+3p53TOMoR2LCLLfMhafyb+5eH7an+3dAIFgcyrmmMzWlhZOUzl7reaXM
	Lsk4nU5Dlt7Cap/B8fvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3F-004HTg-17;
	Thu, 05 Oct 2023 18:26:21 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3A-004HRG-0K
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:18 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 261C320B74C7;
	Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 261C320B74C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530374;
	bh=8DnZqCRLNl2kH912XJt+JUclDDYq4fKWT4+5FgK5Duw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2PI4GCwKQxYpriwcXUCTi9/ezNh0cgu0fXOh1iGEhpLBtzp1+sGIc/XItOPZMIPa
	 JscSayHolG3wD/1ah2wKfuhJegtnChjdXsHkk8a81PNU1rjDbCGNCkGQtMHb0522mG
	 gFyoRjBookAHHwQPwok5P3wOrm73/P+dT1G8Xx8s=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 6/7] ima: make the memory for events between kexec load and exec configurable
Date: Thu,  5 Oct 2023 11:26:01 -0700
Message-Id: <20231005182602.634615-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112616_178533_B1ECDAA6 
X-CRM114-Status: GOOD (  13.86  )
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

Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
of extra pages to be allocated for IMA measurements added in the window
from kexec 'load' to kexec 'execute'.

Update ima_add_kexec_buffer() function to allocate memory based on the 
Kconfig option value, rather than the currently hardcoded one.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     |  9 +++++++++
 security/integrity/ima/ima_kexec.c | 13 ++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..1b55cd2bcb36 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+config IMA_KEXEC_EXTRA_PAGES
+	int
+	depends on IMA && IMA_KEXEC
+	default 16
+	help
+	  IMA_KEXEC_EXTRA_PAGES determines the number of extra
+	  pages to be allocated for IMA measurements added in the
+	  window from kexec 'load' to kexec 'execute'.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13fbbb90319b..6cd5f46a7208 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+			      (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
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
