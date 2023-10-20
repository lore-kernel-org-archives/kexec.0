Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF69CDB474
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pgNBfL7rEYP9Ylwt4goQqb3svijfF2NxnhQMUZeObZA=; b=GKGArDLrzsPRbA
	3VmPzPrcbbhvyRXrv04dGBca/e23ZaFYOIU+62Bz+/9WtMKoSACk/ZRbmXnCzmW1KUlgdGIYXQJ/t
	eT/clxNLLuEVGXkqv/hnPqBMMYsDlTdN00v8k8Lr5LlBAJwcWIIh/Y/Vc5jHZ+ORVwAO4dvuRXmYA
	eMcB7+/p1qjxqvcgVsxchTBdG1vAD/EHATAUOV598i07YhTM/yGVFXC69IjLMi34CPVFjV2SYfy0t
	WogG8DimR0kxXlvzShn4GUiV1CpMS/bdfhNy3c82o3LJK8fvMrhOVnRVSpQv1n8MFnt1y8CsoZ02k
	bVCuCdM3SR0EwhumgjgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBo-002Zyh-1X;
	Fri, 20 Oct 2023 15:13:28 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtrBk-002Zud-3C
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 15:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697814804; x=1729350804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EufwntLcxHa17lX7vkyRAITUbajJMYhr8ams+J+dhGY=;
  b=VzmNRa0LR2Ki07ZSrSHGzAEPkUHG25J0v3Ro+3WP5ni/MFatYeuZ8Jb1
   pI+xZxa2YrJybgDeYkWlpY6GPHWwE/uo2lb1+AFfmPcZRaKaI0HHfgYtf
   dY223lfKQJUUvfIFrEe8CnVCmMnry7L0/lc8Nl2tM8WSPECTLnenbtVh6
   Llx5qDfJSyHbRCLwdfkzTdQtQ6K/5heMzvhA4LrMnCtUr9LngcYfQ8iGe
   yDSj/Czt1YLy+2QyjW2vck0c0BK9pAWjSzSyqA8wYlfPhjg5LheaeM+d2
   637zrrqNVSCVAk/BZgB4VoISLU+zUcBpGYmqnjPskxpfjuvTlARdXeNB5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366742893"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366742893"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1004634219"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1004634219"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 1C68810A297; Fri, 20 Oct 2023 18:12:45 +0300 (+03)
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
Subject: [PATCHv2 05/13] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Date: Fri, 20 Oct 2023 18:12:34 +0300
Message-ID: <20231020151242.1814-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_081325_085895_18CB0326 
X-CRM114-Status: UNSURE (   8.78  )
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
