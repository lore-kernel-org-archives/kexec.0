Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2361FCAC592
	for <kexec@archiver.kernel.org>; Mon, 15 Sep 2025 15:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rxRsqgoSu2vtlIsj1vPAvCfHkjp1aGbbRRG2HSMJhDs=; b=WZ14qzL4us/Ga+FOKQbqpeXNtS
	OMN2wVLwmHp7tdSq8p4MWMcWdjjrU5iHAaaWvG2pcBf+tZqfzgqp+5RO7k6DWv70PoYzb2phwKpmF
	3Ys70l1KWmiKlzavUTi0Yz4Yo660aj1PM0xpx9FCk3b18Fe5Y81oDGzMKEb3EH+T8NGyx8IFSX2s8
	fdL2sR1CD00AN1sb+MWKVFnTPfNrsaYr25y6DXqnY8ur6OYr8tM1C+opG45NAOCJBqp9uzPwN81BJ
	kLBzPmdRWUj0VCk0r8jdzOboRTYu3U2qM6xEp9mwZSRGr1FxlI6RFCAY9Lsg46JSEhbgk2aaUa3dX
	5uIGx9ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBYW-000000051j8-1W32;
	Mon, 15 Sep 2025 15:55:52 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBYU-000000051iZ-2OnO
	for kexec@lists.infradead.org;
	Mon, 15 Sep 2025 15:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757951750; x=1789487750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XSaTVE69Y82izKbCX7lEZ0n9v5yXDvhPB5ubZ5Z3Ya8=;
  b=aO5IbuE+HeCi+hYWeiIJSq0wz9fSukwBgABAMNLHE8JRaeJ8cHV3/qU0
   3sWtCyxILNMp+PpYpSACKZn4PGyq2cayAUKgv/7KVV+zWd0zLLK39qxJ7
   dUFUhnOzH1KSHPCcEdpi9Vluu73MDG/7W071NlBFG/WueYG/9dg+Mmcuj
   JpeY8dO1VLv+CQyi6JJLUwfnOfU5bBCzrSS/oDxhqpmzuyvZry/jF01u3
   k/X/yR9C7t58i3+st4o5Rxj5FTeCvxBr8VOguaj4Wdy4XwONPiy2vYw2Y
   oQlDKEyogGn4SAlQAlIdKzx383KHJYFCOzu1Kb7rPa3ghBvwVP6tX6pdx
   g==;
X-CSE-ConnectionGUID: q7aarZxFTea6pmmKxvEr2w==
X-CSE-MsgGUID: jdgnU3beQYi6hURQa8OknQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="62846007"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="62846007"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:55:47 -0700
X-CSE-ConnectionGUID: aDkoebD3TCmck7IT51wYUg==
X-CSE-MsgGUID: Xf2A40I4R7K9ggmEzCL6WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="175095835"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2025 08:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5E6C694; Mon, 15 Sep 2025 17:55:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kexec: Remove unused code in kimage_load_cma_segment()
Date: Mon, 15 Sep 2025 17:55:43 +0200
Message-ID: <20250915155543.2912469-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_085550_621012_0F0221BB 
X-CRM114-Status: GOOD (  10.63  )
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

clang is not happy about set but unused variable:

kernel/kexec_core.c:745:16: error: variable 'maddr' set but not used [-Werror,-Wunused-but-set-variable]
  745 |         unsigned long maddr;
      |                       ^
1 error generated.

Fix the compilation breakage (`make W=1` build) by removing unused variable.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/kexec_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5357ed39e9d1..32722926bc7e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -742,7 +742,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 	struct kexec_segment *segment = &image->segment[idx];
 	struct page *cma = image->segment_cma[idx];
 	char *ptr = page_address(cma);
-	unsigned long maddr;
 	size_t ubytes, mbytes;
 	int result = 0;
 	unsigned char __user *buf = NULL;
@@ -754,7 +753,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		buf = segment->buf;
 	ubytes = segment->bufsz;
 	mbytes = segment->memsz;
-	maddr = segment->mem;
 
 	/* Then copy from source buffer to the CMA one */
 	while (mbytes) {
@@ -782,7 +780,6 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 		}
 
 		ptr    += mchunk;
-		maddr  += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.50.1


