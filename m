Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D71CAC5B0
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=; b=UlkG3X/siNF+iyQKNsGF5ykNYq
	ZntXVmucu7pLosO+bzOgBRpOOYyoHicAGOb841ouYqJVGW28Zkw0Sgrk6PMZH94m4jmtRSQ9idi5Z
	Nna8XzOMGpk/gJKKMS+Ca0LiVS1t2tGfY8g2BzneHml938pz6vMBtGO0x8QFpy7MPcoSop6kaPwkc
	1ummeFPX9ydFzhbrIOu03GnALmwQjDr6kIoOHpZS626+TtInTBBpjlH9+T8/bOFg8bc2mkwg0T/CE
	56wQ91MMjh20Xx3sXX+jAt2wdUlrVTNuCqWAc2v+4JWfy2dQpZHGXB9m8KdRbHx9ol2mUpLdR+d4j
	fnocd4RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3GKf-00000002t20-1LtM;
	Mon, 29 Sep 2025 16:02:33 +0000
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com ([34.218.115.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3GKd-00000002t06-05I6
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 16:02:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759161751; x=1790697751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+HGVWrxAkg8mWbnk47FbeDyfZnbZtnHncdoKf7Bqyo8=;
  b=Geq1z+dZgsUCc0rMufXeKX5NX5dPc+RQMZFZB4eUZCLlfbsV0kUMMSiH
   pMfTsqjGDGtgMDOUjZtOF9Z+DD8Crgslhawmrwy3uL6RMWtCvGZ9fPPeT
   WkANyJOonpreLN4dzq7Ne95rc90SOfE6hCn02a5/bxDLQ1Rl5nNZYLfl8
   gh3z30e1c0sVmDlRB57Sxo+azrdTy9roC3O7Glkt1w+xgE95+MORDgqoK
   Qt7YoBjwxEhOm7TQGSA3ekEJIuAK53T650i37jQresSAd/GyiJ1TmgO7R
   sD92AqM3t2XqwdoqmXrr90SiAD1LVM3Ivz7FT6lqu+/qofcInZ8PB5quM
   g==;
X-CSE-ConnectionGUID: wht2y+cZTZ6YFWGEG+eDNg==
X-CSE-MsgGUID: ZdV6+l7yTYCL+RXgXoKoxw==
X-IronPort-AV: E=Sophos;i="6.18,301,1751241600"; 
   d="scan'208";a="3752301"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:02:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:32049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.1:2525] with esmtp (Farcaster)
 id de35df7c-9f59-4666-a8ad-e44850f84128; Mon, 29 Sep 2025 16:02:28 +0000 (UTC)
X-Farcaster-Flow-ID: de35df7c-9f59-4666-a8ad-e44850f84128
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 16:02:27 +0000
Received: from 80a9970eed1e.amazon.com (10.187.171.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 16:02:26 +0000
From: Justinien Bouron <jbouron@amazon.com>
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek
	<pmladek@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, "Marcos
 Paulo de Souza" <mpdesouza@suse.com>, Yan Zhao <yan.y.zhao@intel.com>,
	Justinien Bouron <jbouron@amazon.com>, Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: [PATCH v2] kexec_core: Remove superfluous page offset handling in segment loading
Date: Mon, 29 Sep 2025 09:02:20 -0700
Message-ID: <20250929160220.47616-1-jbouron@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.30]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_090231_123158_0AD7D76D 
X-CRM114-Status: GOOD (  14.68  )
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

During kexec_segment loading, when copying the content of the segment
(i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
pages, kimage_load_{cma,normal,crash}_segment handle the case where the
physical address of the segment is not page aligned, e.g. in
kimage_load_normal_segment:
```
	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
	// ...
	ptr = kmap_local_page(page);
	// ...
	ptr += maddr & ~PAGE_MASK;
	mchunk = min_t(size_t, mbytes,
		PAGE_SIZE - (maddr & ~PAGE_MASK));
	// ^^^^ Non page-aligned segments handled here ^^^
	// ...
	if (image->file_mode)
		memcpy(ptr, kbuf, uchunk);
	else
		result = copy_from_user(ptr, buf, uchunk);
```
(similar logic is present in kimage_load_{cma,crash}_segment).

This is actually not needed because, prior to their loading, all
kexec_segments first go through a vetting step in
`sanity_check_segment_list`, which rejects any segment that is not
page-aligned:
```
	for (i = 0; i < nr_segments; i++) {
		unsigned long mstart, mend;
		mstart = image->segment[i].mem;
		mend   = mstart + image->segment[i].memsz;
		// ...
		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
			return -EADDRNOTAVAIL;
		// ...
	}
```
In case `sanity_check_segment_list` finds a non-page aligned the whole
kexec load is aborted and no segment is loaded.

This means that `kimage_load_{cma,normal,crash}_segment` never actually
have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
is always true no matter if the segment is coming from a file (i.e.
`kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
syscall) or created by the kernel through `kexec_add_buffer`. In the
latter case, `kexec_add_buffer` actually enforces the page alignment:
```
	/* Ensure minimum alignment needed for segments. */
	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
```

Signed-off-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
Changes since v1:
	- Reworked commit message as requested by Baoquan He
	  <bhe@redhat.com>
	- Removed accidental whitespace change
	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
---
 kernel/kexec_core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..3b279d9e0d01 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -761,9 +761,7 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	while (mbytes) {
 		size_t uchunk, mchunk;
 
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -840,9 +838,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 
 		if (uchunk) {
@@ -905,9 +901,7 @@ static int kimage_load_crash_segment(struct kimage *image, int idx)
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
 		ptr = kmap_local_page(page);
-		ptr += maddr & ~PAGE_MASK;
-		mchunk = min_t(size_t, mbytes,
-				PAGE_SIZE - (maddr & ~PAGE_MASK));
+		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
 		uchunk = min(ubytes, mchunk);
 		if (mchunk > uchunk) {
 			/* Zero the trailing part of the page */
-- 
2.43.0


