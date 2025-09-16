Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5275DCAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hIAAMaDpQ4ucb+HGc+pD8RUm6Z1ve88qfRHrnH4BVGo=; b=kxm62Mb9zn0cpI3l46ExbU1g+U
	v6lob5k1ADCQptCiM+OJ9YszG3DObCmQ7kABV+YXTQ+9bAGAq4kCf4xOKsMjZ45Z6iX948F9xt8m3
	7hzyVlSuvvb0VFPh6/0dbhszmdQvotLfpYQ9McCOT635jhXBAamGnoZrFHxx8MnCk5PmGbjYN0Nhu
	F6AhzuS4+HR/8mSoaCdERg8J8toE8msK/CVtPVHVwRCnBv2Jpo3DKXaw46mYQSFd8LOBC1ThDZGD2
	ivI7LxrWx6zI0AGr+GXbHrzN8VX819xaJus1MdzDTR+Uj+Wz12zGT7Y82h6wHcQUvwE3ahEpo58TH
	1Lc6DjCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyVA1-00000007pdw-01sn;
	Tue, 16 Sep 2025 12:51:53 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyV9y-00000007pdQ-2tid
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 12:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758027110; x=1789563110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=67qe2cHRWzRfMUP3ME91QmZPRdAfH2+ZYKLVwC5M8ik=;
  b=G0s43wq2fx5vBJQPO/izvFo5LfT0tnPFlnYkPue58oQRDs2RKgBK4b4c
   +4am4AokCeqADDBrG24x3vD/IYvC0pT2Y0SoIsmvUDdVN+BVArFsepGDj
   89fQAn5RHMv1D1PHjP741V4dmp0QLFt0aLsXUCHX3TFEujeW1F6uEQkgn
   VwCVPqmhGDDuP77yaQGc5w9Zh+Of5kL9w4iBjcufQVFJRSBW2i0E++NN4
   erxTTcFBw0zcUjDrJinpLLvMGQp5uGL9gHH/3X1neYBuIaLAzDuuhFfw3
   q2gbZcjlKZHErFkqQYTJIj63XaHT/0kxxKlE7PLyWqICaqKsE1QZ8cBZ4
   Q==;
X-CSE-ConnectionGUID: 8412e1yiRamB84HVo9MiwA==
X-CSE-MsgGUID: crh+5p5ySUaS0ZlU/Mcj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60364097"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60364097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:51:49 -0700
X-CSE-ConnectionGUID: h8Lkt1NbTRqMIpPbxHGW6Q==
X-CSE-MsgGUID: 7PQfZTs0R2W/sucx0zx+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174537453"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 16 Sep 2025 05:51:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 83F2895; Tue, 16 Sep 2025 14:51:45 +0200 (CEST)
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
Subject: [resend, PATCH v2 1/1] kexec: Remove unused code in kimage_load_cma_segment()
Date: Tue, 16 Sep 2025 14:51:09 +0200
Message-ID: <20250916125124.3094021-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_055150_787044_D40D042D 
X-CRM114-Status: GOOD (  10.95  )
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


