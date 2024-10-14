Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696EDD18129
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NWTSz8BLfN7X0/KAQfoEfFt8ILcxoEB3MSSLc4djKl4=; b=vnUgMU1/zCrtkM
	N9Niol29GLs7EcG2jGycEC2E88BdVLvNRi+Os1MNUJt3qIf9DmaEcid5QLcI+wAqnF+kFQ1N9/3WY
	uUukB5jYD3jf9JPfMEOWhphGnS8ig1KYvJBBR79pfGJtSEIv6grUsiFnZmmvegkiohQZB644CDtr0
	GukUlWEuc3zIi3NtJURQUfOZAXNusnn4gtVdFjCgROwpEIVbrUZEJZZGmEevRnJUISn8SGc0HDqgU
	OajMpmF+KzuZD3KMiIppKrayTOSV039asRlafCMjk/lIeOu/6Y5UyqoiH04XDUh5+fYLjgUR4jn9/
	EXmkIAgiNlEWitErQgLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N96-00000005iPq-2N7d;
	Mon, 14 Oct 2024 15:38:08 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N2n-00000005f8B-0PHO
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 15:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728919897; x=1760455897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gs0dWyen0Qw+KQEK5UDZy9fFs2ABNcFFxHPqb6w+Xgg=;
  b=CNNXskyNf5GXJ81waaZiUycq9J4eHH/esaKEFEplIjJweB+SltpHgj9v
   yg0GDjlsh1ZVTaP6vNaoQE1v6BG08upjI6FmIH9A+h3fLN0M2o8sk2BH2
   GtPCc7rEliL/GIJuZ6kb9wofnTqSm89L8w7hJlCUPnvwZgVWnWnf1tF58
   1MXh8eSLMrmgsRuQAkPDqNCTu7GtPo1yjvb0a4F5cO4p8oCB/eZ9OzyEQ
   vx0hkXcE8VBuLD9geZRpUldxUaLw9997BC3VaJFc1qNChB2JbC+z3xzUj
   Dn4l85XhpJZ9dvYEPyRBtIqZ32nO71MURwjdJ33RYI4tlMS9+dJdt4V7K
   w==;
X-CSE-ConnectionGUID: eBj8ZH4UQTm6x0hLCRC0Gg==
X-CSE-MsgGUID: FLXj8h4xShuOF1DskP+35g==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38852303"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="38852303"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:31:33 -0700
X-CSE-ConnectionGUID: nvo64rB1SJuyfVR1RAYdxA==
X-CSE-MsgGUID: oAw2YNaFTJK+QG3j8ouGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108352259"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2024 08:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 21F8328E; Mon, 14 Oct 2024 18:31:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] kexec: i386: Fix 32-bit right shifts on 32-bit architectures
Date: Mon, 14 Oct 2024 18:31:26 +0300
Message-ID: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_083137_231204_CDC08647 
X-CRM114-Status: GOOD (  10.41  )
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

32-bit compilation makes compiler unhappy about too big right shifts.
Use a similar trick to Linux kernel project by replacing foo >> 32 by
(foo >> 16) >> 16.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kexec/arch/i386/x86-linux-setup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 73251b93397b..efb6e2cba508 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -99,11 +99,11 @@ void setup_linux_bootloader_parameters_high(
 
 	if (real_mode->protocol_version >= 0x020c &&
 	    (initrd_base & 0xffffffffUL) != initrd_base)
-		real_mode->ext_ramdisk_image = initrd_base >> 32;
+		real_mode->ext_ramdisk_image = (initrd_base >> 16) >> 16;
 
 	if (real_mode->protocol_version >= 0x020c &&
 	    (initrd_size & 0xffffffffUL) != initrd_size)
-		real_mode->ext_ramdisk_size = initrd_size >> 32;
+		real_mode->ext_ramdisk_size = (initrd_size >> 16) >> 16;
 
 	/* The location of the command line */
 	/* if (real_mode_base == 0x90000) { */
@@ -117,7 +117,7 @@ void setup_linux_bootloader_parameters_high(
 		real_mode->cmd_line_ptr = cmd_line_ptr & 0xffffffffUL;
 		if ((real_mode->protocol_version >= 0x020c) &&
 		    ((cmd_line_ptr & 0xffffffffUL) != cmd_line_ptr))
-			real_mode->ext_cmd_line_ptr = cmd_line_ptr >> 32;
+			real_mode->ext_cmd_line_ptr = (cmd_line_ptr >> 16) >> 16;
 	}
 
 	/* Fill in the command line */
@@ -172,7 +172,7 @@ static int setup_linux_vesafb(struct x86_linux_param_header *real_mode)
 	real_mode->vesapm_seg     = 0;
 
 	if (fix.smem_start > 0xffffffffUL) {
-		real_mode->ext_lfb_base = fix.smem_start >> 32;
+		real_mode->ext_lfb_base = (fix.smem_start >> 16) >> 16;
 		real_mode->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
