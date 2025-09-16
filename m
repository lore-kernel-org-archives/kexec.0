Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5501CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hIAAMaDpQ4ucb+HGc+pD8RUm6Z1ve88qfRHrnH4BVGo=; b=QJXZzK66P/PLFmADHJZRLIhRDl
	Ph7GO2q3/20P2PwHiPmWxKSzRis8tYDwBH8bqIO2YCM1KEhzkMuiuIZZ2CkHEoIYh5jwifEVLG5GD
	/Ml7jQ7Fa8UnGESHjK4kQyVdTqOtzqI7qEO34SD0k8SSy+dS0EvKolY9ftzQjUfVsMWapXyA3NzM9
	4TV9kXN6leUXjIJfxRuPiCpB+92Xqj9/Uqnby9xX+gy3NinYDNM5ZTS8St4O91/mCWQSQnRQccAax
	DLt+RPG69PVokh1HOkTPL6szJZFu+z2F034slQM7K9Z8GfYCc6sVzMSoOh/7bgssgnghFVS3BYDNo
	TFZpDInQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyUpk-00000007miN-3biq;
	Tue, 16 Sep 2025 12:30:56 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyUpi-00000007mhz-3A2K
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 12:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758025855; x=1789561855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
  b=P4m1y2joOFmWEZQmxx/w4evrmc/LbRbq3Zp4hkPh1jVMyJi9o8FEB3mX
   OOY9ZiNS712ELaqjuWDz4RXx/KJF1AwtDYax+WNGdpxgtF5VWMeIfk82S
   b+7ujB9q0kDw0cjxV7jw1dCLQIDBL7tMFGch3/Nt7w+dz1cTIGxVw80HV
   InybQxreCxZbjc3K/gnsFLFJEysgaREVw9FdoCcw+nzBQTtin1L9VidqX
   +jW0girl4EeyP6Y9LUBbAojJtxODu4nRxEptRr9FPB1FMW3f7dOmAaWQd
   Nu8i+cd37zdJkS2wO+dqIrXiUn9GqGk9WC+n3m6KpCe8sTqyxq29DOArJ
   A==;
X-CSE-ConnectionGUID: lM3ZXrBRTxK8i8fALuK+NA==
X-CSE-MsgGUID: SV6x1iw7RAusHGXubKjKpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60446950"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60446950"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:30:53 -0700
X-CSE-ConnectionGUID: 3aecjGYMT6O9Rv3FBnxrSw==
X-CSE-MsgGUID: nlm4VC3sQE+RrHtiECjVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175354079"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 16 Sep 2025 05:30:50 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 62F4194; Tue, 16 Sep 2025 14:30:49 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, grom@black.igk.intel.com,
	07110bfd5785d3bff71cebd710db42d6f5c4a643@black.igk.intel.com,
	Mon@black.igk.intel.com, Sep@black.igk.intel.com,
	17@black.igk.intel.com, "00:00:00"@black.igk.intel.com,
	2001@black.igk.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 16 Sep 2025 14:29:49 +0200
Message-ID: <20250916123048.3058824-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_053054_829261_0B4EF19F 
X-CRM114-Status: GOOD (  10.39  )
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

As Nathan noted, GCC 16 produces the similar warning;

Fixes: f4fecb50d6e1 ("kexec_core: remove superfluous page offset handling in segment loading")
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed Fixes (Nathan), added a note about GCC (Nathan), added tag (Nathan)

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


