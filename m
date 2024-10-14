Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57326D1812B
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ElFAZTsD2R56N2sSat20p0QrBoQemenY8jJt3f+EYM=; b=VnGlQH+h+EqUF/
	Wk9hLE/q6TExqWHTUr9XhVlwA3yNWctGpLM7HZk7IGtBLKfdd0EsjaCWSlsEI66r2d7ALTUX8eVNz
	Bq59K33wGrqdBrjJXmsDnn8+qwxRoU2080w73jmuwdP8piu7sdvfhKcutmiPiKSHSbXyP38qbLRDD
	WSmBRUxMUR7u3RTW1mMQXu3bJUsQ/BpNw7hzBTvskLd7P0ucTLNCO6AiTwiQHBPzaogFnupD/lue8
	2XhGGLTDWeEdenz2jhdLO1BPgBLMQoo0ADwpA7wvj0kHdnZjRGhxEFPXb5QKRvAtFJeSImtDCdztt
	RLRzbdAkfo5LK7XJ78OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N94-00000005iNT-1emE;
	Mon, 14 Oct 2024 15:38:06 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N2n-00000005f8Q-0GCZ
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 15:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728919897; x=1760455897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Df3xeudgEV/ssagU0VoneJMHLM9Vq8ULa/82QHg6Qb8=;
  b=SBSPmUbAERKMnNGYKT3jhddUAKlwCW2mJMAzID92Vv1RDm5tCD12wbyn
   Ey8r7+jPM5NQcSJs30lHxqo7jbBZWKu0AC+ypSP4BcmT3icaO9hXcen/a
   voaEjs+PuC9CkfaTjwYkMGVFTphv9vIPr7yfC3XyubQXnUhnGzESV+YQ4
   zH06CK0VA6J4pQ+lfhZlfHCKdqZCAOc+wC5NtvgbAs9S5Z1Wo9auIihQ/
   YlCaZcLm0nSPXretNK4Rtt9VDRE/nYuiJ0FcSFB7PpEHkFYAv3iyt2JDE
   d5JpMe86MezqjcyRPqH/0+m+rBNXE3owgWbzU06ERJcfvycmw9yen87Ij
   A==;
X-CSE-ConnectionGUID: GnPgld49SZyrFoMFbuMzTQ==
X-CSE-MsgGUID: lnh5miodQgalMcUBl0YEPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39399309"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39399309"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:31:34 -0700
X-CSE-ConnectionGUID: xjuWzt7kQxOPcNV34kLTTw==
X-CSE-MsgGUID: pfIbiGYjR/C66JH/PTZSWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82168514"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 14 Oct 2024 08:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3AD8C2E6; Mon, 14 Oct 2024 18:31:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] util_lib/elf_info: Fix format specifiers for fprintf()
Date: Mon, 14 Oct 2024 18:31:28 +0300
Message-ID: <20241014153129.295176-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
References: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_083137_212659_B24034B0 
X-CRM114-Status: UNSURE (   9.05  )
X-CRM114-Notice: Please train this message.
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

Compiler is not happy when wrong specifier is being used.
Fix them all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 util_lib/elf_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 7ca9870bfca0..8f84f5254cc2 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -890,7 +890,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lx, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(68);
 			}
@@ -904,7 +904,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lx, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(69);
 			}
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
