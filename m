Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A265ED5E150
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D/zg2ZYzEK13kkoFHcQ4gzvdTPLgtWQkyOACdltopNM=; b=rsH3/6NLsanxHxwL+WVR7vcmGy
	Cr/APt1rWXgLdBclEodU3ls1IRpLXKNrB7MlJJyzEm/tlpGN08kKzKZTkyBjRlfumwYsi6YYSAUAs
	DVUbZJWD9YTSkQwVYjrMrfQE50lpgE74h5j1HqGMXe3b2XA5b+WT5Gu9WOLqamS5MeFpJ193nmTEO
	aAtvgRzG6+aeecZE2tLaQFRqlu2I6HrSbTrpOGwQwRQrN4ySS1oLogD/L8RwwX1gm4qllKtDKpw+7
	ugSNJ0Iq3I9/R4CqRIRGJciWCgKMP8dzCzd69V7XKwsOs+wn4c7u0iHRbgAZnwMSRyV3lXZ0bx6gH
	20GZDGCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6d-00000005FrA-1t2R;
	Tue, 16 Dec 2025 13:28:47 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVV6Y-00000005FnF-1Rk2
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 13:28:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1765891722; x=1797427722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=37oVug3GO/FYqPPdADlSo+znYXlYx9qasQSWVCIyI2I=;
  b=KmMzRq0X2tqjuPOLkzY4flBQMnrlxjIuENmVk6WWXLVgcxB39XU66XU6
   o2SL7hPXdL7m3QqEyPkyN0qwSyXkJ/ehIXBo8lDuZ6XorlLl48DZods93
   GrEosyf8A6ri7w9N1Gaw2unow0NlKxniXBSFDlr9N1D1Pgx40/pvUZ/P/
   BXjW3K1LJyjGFA29gjaHWzyREb3ZZ71Czvt1MZK5FrmzDehSO8rR7uHt1
   sWPCQQLrtPsBHpjljl+oFX7LyebiXWgUC28BqXdcLtvojEmkvA/qDJAQl
   CRa7HcG3n2mf27ezeLJImqlnKEBbqTF1rRii+RK0rts7PBNOv3Q6hVWWk
   Q==;
X-CSE-ConnectionGUID: X2uXvakgRayHQ2nCT+irRw==
X-CSE-MsgGUID: UY9PPWy3TN2o3+5mXIA0VA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:28:40 +0200
X-CSE-ConnectionGUID: bQ8p51OVQ16U5mOwjNrmLg==
X-CSE-MsgGUID: YTsECUlBR7eWu6f4MATFbw==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.6])
  by ces02_data.me-corp.lan with SMTP; 16 Dec 2025 15:29:53 +0200
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 16 Dec 2025 15:28:39 +0200
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 2/2] kernel/crash: handle multi-page vmcoreinfo in crash kernel copy
Date: Tue, 16 Dec 2025 15:28:01 +0200
Message-ID: <20251216132801.807260-3-pnina.feder@mobileye.com>
In-Reply-To: <20251216132801.807260-1-pnina.feder@mobileye.com>
References: <20251216132801.807260-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_052842_648142_145B3518 
X-CRM114-Status: GOOD (  13.99  )
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

kimage_crash_copy_vmcoreinfo() currently assumes vmcoreinfo fits
in a single page. This breaks if VMCOREINFO_BYTES exceeds PAGE_SIZE.

Allocate the required order of control pages and vmap all pages
needed to safely copy vmcoreinfo into the crash kernel image.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 kernel/crash_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 99dac1aa972a..3952b3e102e0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -44,9 +44,15 @@ note_buf_t __percpu *crash_notes;
 
 int kimage_crash_copy_vmcoreinfo(struct kimage *image)
 {
-	struct page *vmcoreinfo_page;
+	struct page *vmcoreinfo_base;
+	struct page *vmcoreinfo_pages[DIV_ROUND_UP(VMCOREINFO_BYTES, PAGE_SIZE)];
+	unsigned int order, nr_pages;
+	int i;
 	void *safecopy;
 
+	nr_pages = DIV_ROUND_UP(VMCOREINFO_BYTES, PAGE_SIZE);
+	order = get_order(VMCOREINFO_BYTES);
+
 	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
 		return 0;
 	if (image->type != KEXEC_TYPE_CRASH)
@@ -61,12 +67,15 @@ int kimage_crash_copy_vmcoreinfo(struct kimage *image)
 	 * happens to generate vmcoreinfo note, hereby we rely on
 	 * vmap for this purpose.
 	 */
-	vmcoreinfo_page = kimage_alloc_control_pages(image, 0);
-	if (!vmcoreinfo_page) {
+	vmcoreinfo_base = kimage_alloc_control_pages(image, order);
+	if (!vmcoreinfo_base) {
 		pr_warn("Could not allocate vmcoreinfo buffer\n");
 		return -ENOMEM;
 	}
-	safecopy = vmap(&vmcoreinfo_page, 1, VM_MAP, PAGE_KERNEL);
+	for (i = 0; i < nr_pages; i++)
+		vmcoreinfo_pages[i] = vmcoreinfo_base + i;
+
+	safecopy = vmap(vmcoreinfo_pages, nr_pages, VM_MAP, PAGE_KERNEL);
 	if (!safecopy) {
 		pr_warn("Could not vmap vmcoreinfo buffer\n");
 		return -ENOMEM;
-- 
2.43.0


