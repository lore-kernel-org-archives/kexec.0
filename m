Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F82EC636CC
	for <kexec@archiver.kernel.org>; Mon, 13 Feb 2023 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GaEoMfs9jyZAaC8vTPQMzsMIJL4w0idmc64l2troO4w=; b=kmbvKJvLOslVNe
	KmM7GX6HemYgmWln1Jma2h5Jxuv40TdUEQmaNqNBfJgFG2oTk8XUwrdwTJH3hqpBo5hShmzxek3Wt
	KnBTevZ6VRypFeXn7z1Zgg2CbZUVvS3KmEaxdHS3sVvlswB+HRilybFerUirDjxIlPSNZTUb7qKzU
	9xtSP76mfkSfG+A+iJup/zNMeudos9r0vCb3J4t75DPDYoLd6uzteqwhGddHvkMpPHkB7N89S6dPw
	ggG4B3H35EgEY5oY4wrtZc2Ujta7WMBueIEHj35JzwXCiK8dVn6C42PKlzkoQLEXuoZk3csELM21T
	sFM0jxebywKLILTmgRzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRiZf-00GoIC-6D; Mon, 13 Feb 2023 23:49:31 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRiZD-00Go8Q-Rs
	for kexec@lists.infradead.org; Mon, 13 Feb 2023 23:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676332143; x=1707868143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0x8prcfOkEmACeYEiOgHUm+WyjDXkIRz6t1uNF7BUGU=;
  b=DEU4gkRe/LLVPz4mbmoDkRzEjfxFbx3I8SLNirxLNL96qdWaDD15dR26
   lkOcvo9DsLQEL09c7WQdokTlK3piGVyHkYW8iQreseYHUnBrjt85LtUCS
   fQDksFjPUHK5tEtSPPMRj42RwY3I/Fb5BdFmopd2plqZ/bKHuOt+Pcu3Z
   9WmOx09Em9RfwgCtJHM33EyyvQWtQcaK4r5DrGUru1h6WCMDLyPpKcrz7
   Q0585VAobnBCGTTm/xwZrgn9gwVHC5fvRxUEwjMosn+HwK2Z6pyZimU0M
   1fFa63JS+f3I/qrdhd/F/3HFpfpYpGVFMGMUaQEcmAPVaq3IAc7QDAr1c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="395645605"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="395645605"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732672802"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732672802"
Received: from iannetti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 62E0010CA34; Tue, 14 Feb 2023 02:48:43 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Date: Tue, 14 Feb 2023 02:48:35 +0300
Message-Id: <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_154903_987115_529A5202 
X-CRM114-Status: UNSURE (   8.15  )
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

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Preserve the flag during kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4a73351f87f8..18f19dcc40e9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -145,8 +145,12 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Preserve MCE, if it was set. Clearing MCE may fault in some
+	 *    environments.
 	 */
-	movl	$X86_CR4_PAE, %eax
+	movq	%cr4, %rax
+	andl	$X86_CR4_MCE, %eax
+	orl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
