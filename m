Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC965C47074
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pgNBfL7rEYP9Ylwt4goQqb3svijfF2NxnhQMUZeObZA=; b=o3QV2ZtnKQyjSx
	QpvsMu5qMwP/aglW3KbF1/r/T5DRBbhhhrEEog8IbXIJfzI8OS+aB8mZQls+cAS5YL+LTlhouSq8t
	lFwILWWbYKE3GmmR2j407RuASrcj2C+oN4JU4ggnqTqcrnPpNCg4RexcCqg9XJPT09RUbLCO7hYPI
	l1ABMcY8yvQ7eF6+bLMx2n/K1VMjjtEpNKcdqTCfOce3QQwT5VSqa0hApVxX5HCBpSVgwBwzuzQty
	Gu0N5WKAuj6zpfi+u3TJmb1bmVv8ziE3VyZzdmTxwHqpbxo03yUjyiuZjiqEUW7H46kJr4YWvOsHh
	hwcsFao2DWkx692ZSiXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3EaH-000jQI-0P;
	Wed, 15 Nov 2023 12:01:29 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3EaD-000jLy-2P
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 12:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049685; x=1731585685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EufwntLcxHa17lX7vkyRAITUbajJMYhr8ams+J+dhGY=;
  b=lMzG4Zbm3y94ets4a4RAtnwoU66X4f/3PsjBqJyZjyn+twVODAXEfcmj
   m7WvRu9fJUiEE1rF1t8p+3CQaq4p6jHRcyBDsdRgcpEAKyRXinr+aCwFu
   xid6A9xXfrnthJ31qhwmlUIMdgN32TTZvQRl7Nin2RbGBMq9eTCmyDzM3
   VAWno9HTLTAE/r48vOg5xrEiwafpYb+9OkXsJToDi7HDwwaLcQQMJrIZv
   6zam/XHJXUDqvBbIswX0nGTHYeyFqTm12xrMNEH9gNOwvA12ATGVYpoP/
   xAf/zucWeLy1K48y78j3fGv6oBsqg8kn6eRp9VPKqDex8cB8EZcPZ6zIW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394780422"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="394780422"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="13160242"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:20 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6F3B710A22F; Wed, 15 Nov 2023 15:01:12 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 06/14] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Wed, 15 Nov 2023 15:00:36 +0300
Message-ID: <20231115120044.8034-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_040125_844557_4247A215 
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

TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..bea89814b48e 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -145,11 +145,16 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
+	 *    in TDX guests.
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
+1:
+	ALTERNATIVE "jmp 1f", "", X86_FEATURE_TDX_GUEST
+	orl	$X86_CR4_MCE, %eax
 1:
 	movq	%rax, %cr4
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
