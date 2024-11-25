Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10504D3B7FB
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=905CV9ftpKJ0HPQLcIxyrOfAp/IXY8cX6AqTnVswgHw=; b=brUL3nxb6KyJejfsNSHPE0iGZk
	hnLuD+uDlndTkC21KOEqlbCiDi+S4yjgZZ5a+2wmzFLvZXSc1lylz7teCuq8/2OHVgCoH8eNTLo7c
	hTWJ6Lxj/4CsjkBSH4bK7kNtgnPZEwfB9C8bCzPKbpFWjS76hfunm5+zk6T5aY4boMwokOqsDlgW/
	B3kWzDShk6pZXKv2Wv2goxX6CrKhPzEjcEW2+rLrftPvrEAl/uP6o9om9MsEGyasK8gS8Pf5DQ6PH
	IcEi5v7LPrO8NPN4XTuSPHbIquxU1lm+Jca3noCzLJ6lfLyshVn1U3f8m2GMWxC/APdN9lSEJTe3Q
	nem4Cm9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWB3-00000007jSI-2fhV;
	Mon, 25 Nov 2024 10:18:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW13-00000007gGN-3ZOF
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=905CV9ftpKJ0HPQLcIxyrOfAp/IXY8cX6AqTnVswgHw=; b=KFH3G9TH0TK2PRl18yYH2hameh
	nWg1EV1JfBaNIRnD42sGSmJGgQnz+JVkBjVkqoPRuhHvEMHTl3BeL1SDow+JE7I99qv2WbSQqks5b
	ozEwm5AfcCqGPVpLR26nLkltBgdd8334QZwxdt8BXcPLMtjBt71BnplqSllAl/q7O/xqxrSjIrOkT
	TgfR8N7AAKTvP+lrMS3SwUdYgXA1Bnka7RpoNQv3QbmG4dMqUq/APWXaZVtJUBzF/zRwXLU3MHd6H
	tPnUzfifEc7QTnOBNUtkYRxt2nuI0tAm+CKumkJk6FDVqeHxETwBCqW0TFhYBOAAa02EoXL88cm30
	ReEQUTgQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW11-000000014f4-04Ku;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000kq-17au;
	Mon, 25 Nov 2024 10:08:21 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v3 01/20] x86/kexec: Ensure control_code_page is mapped in kexec page tables
Date: Mon, 25 Nov 2024 09:54:31 +0000
Message-ID: <20241125100815.2512-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

The control_code_page should be explicitly mapped into the identity
mapped page tables for the relocate_kernel environment. This only seems
to have worked by luck before, because it tended to be within the same
2MiB or 1GiB large page already mapped for another reason.

A subsequent commit will reduce the control_code_page to a single 4KiB
page instead of a higher-order allocation, and seems to make it much
*less* likely that we get lucky with its placement. This leads to a
fault when relocate_kernel() first tries to access the page through its
identity-mapped virtual address.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/machine_kexec_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..b9b6243ee223 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -240,6 +240,12 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	if (direct_gbpages)
 		info.direct_gbpages = true;
 
+	/* Ensure the control code page itself is in the direct map */
+	result = kernel_ident_mapping_init(&info, level4p, start_pgtable + PAGE_SIZE,
+					   start_pgtable + KEXEC_CONTROL_CODE_MAX_SIZE);
+	if (result)
+		return result;
+
 	for (i = 0; i < nr_pfn_mapped; i++) {
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
-- 
2.47.0


