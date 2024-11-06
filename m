Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C56CD59F56
	for <kexec@archiver.kernel.org>; Wed,  6 Nov 2024 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mj/DHDYOEHrmXwfPAw77DtQ4JMIfjJ/G3szqs/QNO/Y=; b=xuc8EIgv2Rpb4g
	Sd8r6m8uF0GMKdYBcelZ6gBf0HpA9IAnup9s6EATKs6vTbs0NtAgC7BrO1VLclGQoUQSj7+uY+Kka
	nzHmupmXwP81Z5r0OTLmqdefX56ajen0PVUCB4l3XLfoYFmhN2qZsXo3IUIJBIGC+u0PEnWG2tHbE
	bqC6Hk9wcm8cB65sDOUuBYeQq3SYEHuGnmm8/vmgSM4YGfft0DibvFRdtXYt0FBOV26sjVtYYP0af
	OwQ2jtEZQ1N7e3iCZ67WKtNxlGZVlaY8fLxf1goagDxdHqGbFUm3Bsl9Ne+Nja8eWl0O9OazKPb/w
	PXDYJ4omGCen58CNw+gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8kIX-00000004GOC-11Ii;
	Wed, 06 Nov 2024 17:58:29 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8kIU-00000004GNj-0nDn
	for kexec@lists.infradead.org;
	Wed, 06 Nov 2024 17:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730915906; x=1762451906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uuiARcer2nxHt9TvLeaGYUWXJrZwhSYuzZc0XVN9HVc=;
  b=Peats95sCI3pfUSyNveE1ki32blFuhDkkiKUQ341xxKqUNoQ7GhYk0v6
   YPsMjoCMvuCKnnqbGyA4jocBI97H/s22GrhJPmO939FL+goGXQI4bvnpF
   lG/E9QNUZmk6dEeopIef5iHNNSXe6JgIBx7o3w1A0X9VHBCsRGQkOCd0q
   SWIrWdM3BIYlPAPWFwno8QjDs27DWKJxgupKHphlBnfo4iK1hvgOEI1+2
   cNdZiQEinKS/Ts1djxvPec/9K8yXcysrGpuEiwBr7Ilo/9aTq5QifRqzw
   i4Dp3uD3hPdqPwiIsEaDwCY6x0JMEP8gv1BFU4Wo0OKK81YA5JQCboQ7k
   g==;
X-CSE-ConnectionGUID: c7iTPFsHQhG+rDWGRmC4pA==
X-CSE-MsgGUID: ExYVZ2/TRmuN8da7SciQYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34428583"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34428583"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:58:24 -0800
X-CSE-ConnectionGUID: 1yOZz/x2StGZ3gHrt4297w==
X-CSE-MsgGUID: 9RJy+PmpRFKnH21EEQTcdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="85025919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2024 09:58:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ABAB9488; Wed, 06 Nov 2024 19:58:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kexec: x86: Use init_size in 32-bit case as well
Date: Wed,  6 Nov 2024 19:58:07 +0200
Message-ID: <20241106175807.1042574-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_095826_333814_954D77AC 
X-CRM114-Status: GOOD (  12.72  )
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

If the region of the memory is not enough for the decompressed
kernel, e.g., it follows by reserved memory, Bad Things may happen
as it's proven to be in practice on Intel Merrifield platform.

Include decompressed kernel size into the calculations for finding
the appropriate hole in memory to load kernel to.

Note, this has been already done for 64-bit case, this just
synchronises the approach for 32-bit case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kexec/arch/i386/kexec-bzImage.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 1b8f20c5b7d6..62260139862c 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -116,9 +116,9 @@ int do_bzImage_load(struct kexec_info *info,
 	struct entry32_regs regs32;
 	struct entry16_regs regs16;
 	unsigned int relocatable_kernel = 0;
-	unsigned long kernel32_load_addr;
 	char *modified_cmdline;
 	unsigned long cmdline_end;
+	unsigned long kernel32_load_addr, k_size;
 	unsigned long kern16_size_needed;
 	unsigned long heap_size = 0;
 
@@ -274,8 +274,10 @@ int do_bzImage_load(struct kexec_info *info,
 	}
 	
 	/* The main kernel segment */
-	size = kernel_len - kern16_size;
-
+	k_size = kernel_len - kern16_size;
+	/* need to use run-time size for buffer searching */
+	dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
+	size = _ALIGN(real_mode->init_size, 4096);
 	if (real_mode->protocol_version >=0x0205 && relocatable_kernel) {
 		/* Relocatable bzImage */
 		unsigned long kern_align = real_mode->kernel_alignment;
@@ -285,14 +287,13 @@ int do_bzImage_load(struct kexec_info *info,
 			kernel32_max_addr = real_mode->initrd_addr_max;
 
 		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
-						size, size, kern_align,
+						k_size, size, kern_align,
 						0x100000, kernel32_max_addr,
 						1);
-	}
-	else {
+	} else {
 		kernel32_load_addr = KERN32_BASE;
-		add_segment(info, kernel + kern16_size, size,
-				kernel32_load_addr, size);
+		add_segment(info, kernel + kern16_size, k_size,
+				kernel32_load_addr, k_size);
 	}
 		
 	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
