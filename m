Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248FEC77B73
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oqo9Z0knJU14ACLwgom9gToDjkeB06w77fRcuJSzKck=; b=tM0STyE7s35jI6
	YeYkhiogPTl0mLaMT+ggW+rFRkCqbmY+D4etlDNP+lDVdKBmMtyoDLnmPsEz+yiKESbYUIkmy1rnJ
	fJHUEKv9kHTADNZL2DoGhiwjlnv5lVfbgXw8CTLhAsVG77XIi/r6JKZ5Gn521ZACSDOQ1d6V0Cw/Z
	KkEThiRdzGC/CCbft4NsT/MCAsaKkmbbK+Gn5i7su0sjyBytVdLZKa/HBRP+3gUm1XKFY2v2E2miF
	uFOzHeUfeNIF5eA8tWM5x4Qq/MzaviJO1C1f6yOitxs8ZLzQz8fyZQE159aBLORo2PnBP1kTnLNfw
	AS9/3rTwbvMnFGX6b0sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps6ZF-007Enx-26;
	Thu, 27 Apr 2023 18:42:09 +0000
Received: from [2607:7c80:54:3::138] (helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps6ZC-007EnW-2L
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 18:42:07 +0000
Received: from [127.0.0.1] ([73.231.166.163])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 33RIe6OM375051
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Apr 2023 11:40:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 33RIe6OM375051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023040901; t=1682620809;
	bh=rYnD7pkCIgEpxgiuVJ8/9sz/T5OnJ8VmHi4qScJQMRM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hLU1Quyo2y9woh85OWcLX8Y/ZVhLXw4dueIS4kqyVT30n8nzyx1IKtBn7jwXm5r3I
	 XUWRP6aYpXFqfvGQMRKTEAbBhA5Qi1/7mCCDb2szn7zgtptYBAnfRQXhL1DKcPTLHR
	 7zHOgSLAlgb2O98UAbW4nlormZuVB7635Fas/Z2syNr9o3PjZF/78Jxx8D+BgjNEMw
	 dslA/BA+otZkgWTX2jOcxIzqCqL2/bRPVPdallrO793WSbEIUjJOaXTTpOQTfYFco+
	 BDtaQHdsXG/ITIJQRuU2eLtNYfxOhHfSTcQzBl2Gukm0hG53cpUNAQYyeLqJ9bphGC
	 bZLkYMH75b7fg==
Date: Thu, 27 Apr 2023 11:40:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: Re: [RFC v3 21/21] x86/boot/compressed/64: use 1GB pages for mappings
User-Agent: K-9 Mail for Android
In-Reply-To: <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com> <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
Message-ID: <70EB1774-A782-47FB-A8EA-534E66A551F6@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_114206_784471_F386DC6C 
X-CRM114-Status: GOOD (  11.54  )
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

On April 26, 2023 5:08:57 PM PDT, Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>pkram kaslr code can incur multiple page faults when it walks its
>preserved ranges list called via mem_avoid_overlap().  The multiple
>faults can easily end up using up the small number of pages available
>to be allocated for page table pages.
>
>This patch hacks things so that mappings are 1GB which results in the need
>for far fewer page table pages.  As is this breaks AMD SEV-ES which expects
>the mappings to be 2M.  This could possibly be fixed by updating split
>code to split 1GB page if the aren't any other issues with using 1GB
>mappings.
>
>Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>---
> arch/x86/boot/compressed/ident_map_64.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
>index 321a5011042d..1e02cf6dda3c 100644
>--- a/arch/x86/boot/compressed/ident_map_64.c
>+++ b/arch/x86/boot/compressed/ident_map_64.c
>@@ -95,8 +95,8 @@ void kernel_add_identity_map(unsigned long start, unsigned long end)
> 	int ret;
> 
> 	/* Align boundary to 2M. */
>-	start = round_down(start, PMD_SIZE);
>-	end = round_up(end, PMD_SIZE);
>+	start = round_down(start, PUD_SIZE);
>+	end = round_up(end, PUD_SIZE);
> 	if (start >= end)
> 		return;
> 
>@@ -120,6 +120,7 @@ void initialize_identity_maps(void *rmode)
> 	mapping_info.context = &pgt_data;
> 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> 	mapping_info.kernpg_flag = _KERNPG_TABLE;
>+	mapping_info.direct_gbpages = true;
> 
> 	/*
> 	 * It should be impossible for this not to already be true,
>@@ -365,8 +366,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
> 
> 	ghcb_fault = sev_es_check_ghcb_fault(address);
> 
>-	address   &= PMD_MASK;
>-	end        = address + PMD_SIZE;
>+	address   &= PUD_MASK;
>+	end        = address + PUD_SIZE;
> 
> 	/*
> 	 * Check for unexpected error codes. Unexpected are:

Strong NAK: 1G pages are not supported by all 64-bit CPUs, *and* by your own admission breaks things ...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
