Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8922BEDE9BB
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 12:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fn1udlheJA9BFWjwEoeXHxMT8+zj2sbroTUc/WHNVlc=; b=klOdvWfJ5rrsL2
	5Q8AtLlu0t3VLj1aKVK+nLGa9qUIi6H3mBKXOXfNXgS53hcQQguWxISpXauMHGKeqKp72S/ednHGm
	7FeselNdrCn8H3Nv4bXHygik5gz+sgx2qm0U3oEQpA0SZFvXGWAhhsqWTfDIWgw+KWBpKQeDprZvl
	PgSlR/NElHZpaZvaImJ1eXEruWmcbYrYttyGa6uY2a6kBucbwXSpIRbqcmJn8gHbpBCoIzGZXiNxP
	K+m6BtTNZcc9gisytJtt37YGTe5g+U43iZzzX7FxoiR3wfhW5Azb1OZplgSgf40zClI/h8VSYZfZv
	xDl420pAsShab0pNKdAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qglU9-008Kem-1m;
	Thu, 14 Sep 2023 12:30:17 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qglU6-008Kdr-35
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 12:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694694614; x=1726230614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sR+zT73wsMXErBcopbNqQMDJkeQDLlNb2UdQEZ/50wo=;
  b=lMk3VF2KstfTpOOmA7aKxNZIgVC8sObX2ZsrKHAU83Q0jFF9KwgZP134
   +2hbuzEkiXvkG2XScWY5ZVnxiGmbjxRZDBGb5rVNlmJnupI4W8R4g2UfX
   6I6YLMIbOKyhmKRSDcEsiXbBOplK2Qy7DQMrdDW6spGbb9NFBaMT59g0Q
   fJqd4+gbQ/gw/9Sxbw10zQq3I2CfkIPXcJaTmu2WFvpihcj5cGN50wRTh
   TwY9JsXi8V5SJj6YTJcjGASheeuLRgDFgt7ILjFzWWNqsLA27AfpDETRE
   523dvp1wZB27coYZ3pB8qq1iqkvMH545BeLp/Pg9JnkdL4SIkKpr+C87a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363972236"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="363972236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 05:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747708268"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="747708268"
Received: from njayagop-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 05:30:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E3769109D89; Thu, 14 Sep 2023 15:30:07 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@google.com>,
	Kees Cook <keescook@chromium.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.de,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed: Reserve more memory for page tables
Date: Thu, 14 Sep 2023 15:30:01 +0300
Message-ID: <20230914123001.27659-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_053015_070258_114535FF 
X-CRM114-Status: GOOD (  14.67  )
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

The decompressor has a hard limit on the number of page tables it can
allocate. This limit is defined at compile-time and will cause boot
failure if it is reached.

The kernel is very strict and calculates the limit precisely for the
worst-case scenario based on the current configuration. However, it is
easy to forget to adjust the limit when a new use-case arises. The
worst-case scenario is rarely encountered during sanity checks.

In the case of enabling 5-level paging, a use-case was overlooked. The
limit needs to be increased by one to accommodate the additional level.
This oversight went unnoticed until Aaron attempted to run the kernel
via kexec with 5-level paging and unaccepted memory enabled.

To address this issue, let's allocate some extra space for page tables.
128K should be sufficient for any use-case. The logic can be simplified
by using a single value for all kernel configurations.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Aaron Lu <aaron.lu@intel.com>
Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
---
 arch/x86/include/asm/boot.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..aaf1b2fc6ede 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,20 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
-# define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode.
+ *
+ * The additional page table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_INIT_PGT_SIZE	(6*4096)
+
+/*
+ * Total number of page table kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ */
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
