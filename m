Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5895FD462C5
	for <kexec@archiver.kernel.org>; Wed, 13 Nov 2024 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=d0ZtBsYmVgfCUFkZffIWnzt+VU6Eo9KXQ1RkHpH+4Fw=; b=Xk2/LVesV/n1x3
	gRgvzF/HKZMvmb9dyW3CsJQDbmxhbbvzPTtsY6CcJt79x0TiIkhWLkHxGWnl97f0kX1KvzoJ39NJf
	5/UPl54/JD+Pyyufn8MuF/FcNXwDC+96+n8zgpFOU2Qx5m077hgK2anozSFeanIJa+ifxHdpqodjI
	b+sasbl44LNmf8/otWsCK+UHfsWYv+spjgjOxWEYN65bkoLgsJHfqeyX1Qe7KD7ALf8k2d4G9ShLM
	nIOcimbBk3SodHPAGaCZun7aFFyfycebHm3Bd8BLL06A0hwolR3BaElnwsFN44u7UO6PWi4kq3sVF
	8mVYQKLqzmBM8pYeEZLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFY1-00000007Lcn-0JvF;
	Wed, 13 Nov 2024 15:44:49 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFXx-00000007LcC-1hgr
	for kexec@lists.infradead.org;
	Wed, 13 Nov 2024 15:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731512686; x=1763048686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qp0DWzorgLJZU2NQzt+yo8do3jksjplfkvC9JHRJc38=;
  b=mWjzf3hYiny5i7jTLh9M1vpOm40kTCMlucz3urJY50yHXyhOKLLYYwJu
   yoz0rcjccXrxJ6+shzMBa0eWGiSx46nJ56Ha1lpp/SIkn2N+s90jjmV4+
   lyuNF4XKu3c7+jkTfTj4rbj279JAHwyCV3xLloKsO8nfDZ9Ki01+TjXyx
   RQHrQ1hHRqA77qEEAZubSrHpraYZJHd4WvjZmeJiuHzB1m94IaUgJRGFA
   Di0Yo4H3fQWEDzdgZMWm7aaT1HHIvtnFW+O0EsoMM3W+2mHfDAro0dC21
   jSC0uvVJjZ3ww0NOSKD10E4jzIpbYVXznP15+ojvQPafOfzFNJVU7TGB+
   g==;
X-CSE-ConnectionGUID: EKAuXJ3KTduFHF2hcG7VLA==
X-CSE-MsgGUID: n1SC+baeQTu9CHHfMwI+Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48918643"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="48918643"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:44:42 -0800
X-CSE-ConnectionGUID: GXjrvfj2R6qNRXVmnlRm8A==
X-CSE-MsgGUID: vBedD5ayRXeuy6KhvdDxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92868196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2024 07:44:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EF18E1CF; Wed, 13 Nov 2024 17:44:39 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kexec: x86: Include pref_address when looking for a memory hole
Date: Wed, 13 Nov 2024 17:44:37 +0200
Message-ID: <20241113154437.2860694-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_074445_479900_D8C5177B 
X-CRM114-Status: GOOD (  16.52  )
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

When the kernel is built relocatable, the starting address can be
anything above 1Mb on x86. However, the startup_*() entries consider
that the minumum address for the kernel for the decompression has to
be at least LOAD_PHYSICAL_ADDR which is turn the value that is provided
as pref_address in boot protocol. The boot protocol itself says:

  This field, if nonzero, represents a preferred load address for the
  kernel.  A relocating bootloader should attempt to load at this
  address if possible.

Besides that the code in the kernel (arch/x86/kernel/kexec-bzimage64.c)
has these lines (in bzImage64_load() function):

    if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
        kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
    else
        kbuf.buf_min = header->pref_address;

All that said, do the same in kexec tools. Without this patch
the relocatable kernel may end up in the memory hole that is
not enough for in-place decompression and Bad Things will happen
as it's proven on Intel Merrifield, that has a reserved memory
block starting at 64Mb.

Note, it doesn't mean that kernel has no issues itself in this particular
stage, but at least we may work around some corner cases for kexec.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kexec/arch/i386/kexec-bzImage.c     |  6 +++++-
 kexec/arch/x86_64/kexec-bzImage64.c | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 3232cf54c1d9..fcf4254c71c9 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -281,14 +281,18 @@ int do_bzImage_load(struct kexec_info *info,
 	if (real_mode->protocol_version >=0x0205 && relocatable_kernel) {
 		/* Relocatable bzImage */
 		unsigned long kern_align = real_mode->kernel_alignment;
+		unsigned long kernel32_min_addr = KERN32_BASE;
 		unsigned long kernel32_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
 
+		if (kernel32_min_addr < real_mode->pref_address)
+			kernel32_min_addr = real_mode->pref_address;
+
 		if (kernel32_max_addr > real_mode->initrd_addr_max)
 			kernel32_max_addr = real_mode->initrd_addr_max;
 
 		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
 						k_size, size, kern_align,
-						0x100000, kernel32_max_addr,
+						kernel32_min_addr, kernel32_max_addr,
 						1);
 	} else {
 		kernel32_load_addr = KERN32_BASE;
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 210bc0af2643..29ed8c98619a 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -120,6 +120,8 @@ static int do_bzImage64_load(struct kexec_info *info,
 	char *modified_cmdline;
 	unsigned long cmdline_end;
 	unsigned long align, addr, k_size;
+	unsigned long kernel64_min_addr = KERN32_BASE;
+	unsigned long kernel64_max_addr = -1;
 	unsigned kern16_size_needed;
 
 	/*
@@ -204,8 +206,14 @@ static int do_bzImage64_load(struct kexec_info *info,
 	dbgprintf("kernel init_size 0x%x\n", real_mode->init_size);
 	size = _ALIGN(real_mode->init_size, 4096);
 	align = real_mode->kernel_alignment;
+
+	if (kernel64_min_addr < real_mode->pref_address)
+		kernel64_min_addr = real_mode->pref_address;
+
 	addr = add_buffer(info, kernel + kern16_size, k_size,
-			  size, align, 0x100000, -1, -1);
+			  size, align,
+			  kernel64_min_addr, kernel64_max_addr,
+			  -1);
 	if (addr == ULONG_MAX)
 		die("can not load bzImage64");
 	dbgprintf("Loaded 64bit kernel at 0x%lx\n", addr);
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
