Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AABC001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ym12gxX02sQgtizb9s+ZMYYyr1iMhhsP57kMJvUyuqY=; b=EXfQakWl9b5GFp
	eu20Wb+BRBRBXXcZC4EKE7TtdBWwTrFTEy/2Rs1I4IJ/4eXOhf87A43fSEXarIzuaeXbXtVMdwAZp
	UuWlbjY98BoAgF3xSDjiYhG4N75hhSikcV75auxr5qWupcJVdWtxckE7PlV2e9om8ZFXjF28GP9CC
	HumZITWBMo9YiAvv0NLVvpeLmedbtr+MmzjOQsjETFzDeneTMu4yTfvb9tnI5bb4D3qdCdllzr7TK
	TffVt0YGLysi4pYgA1i1R05d4fqqFlpgvvuFE47/wMgeOnYdNSEiaIIZBZrm00e6iGjmdwXzkoB1D
	zMTEqqYJCDKaVi9A+ccg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR8Kk-004VBH-1a;
	Wed, 02 Aug 2023 09:39:58 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR8Kg-004VAV-2U
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 09:39:56 +0000
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76EDC1EC053F;
	Wed,  2 Aug 2023 11:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1690969191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=qbAb28o3tTJyuj6zBqT3c/7EC27OCaTirnTJ24B68rw=;
	b=pK8OgvPZqyU9mXrjGzYXOw9QEn3Aj1nEqDDoqeblSnSLCEvWCTlwVEiRsbK8Pdp0RZ2ruK
	r+AbPuI6yw35R/PFgVV5WUo2u67IW4TgwqsSVedZP+ky9z4uqSCj1ukjS5kN77skeKdK2A
	VmEEKPwL8YucrcdNaT//X7zjqdthLKo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DaNgISScVH2s; Wed,  2 Aug 2023 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1690969187; bh=qbAb28o3tTJyuj6zBqT3c/7EC27OCaTirnTJ24B68rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZnA2RbIkt7bvkrXIOReyMu35jT96kZDma2DdSGBU+hlhgYu/pibRZRUyM9cEM1TW
	 L/+lZx1iq64wBrHRYczsmgQnsRWfu1b/a6H2MwkwEOrlBFuDFe8hbE3x+aCc1aY4gy
	 k7Ono3a6ah6RhD8JkqtbyjOnGQWLi7/f1FHf94B/4y96VLhLcDZ0uAQLd7dfsB6Tkv
	 1LTM7ua/0gw3mTuKQSyTkA2wT9IRt1uAdtmmW39rAb82paPyRiq99F/P9x9p6pvNDS
	 HirU49kbd1D0EoRFTcgxMm5BZfdRiCoeBKCCqr9WI2BEB3dtNEXdIVpoq+AtzCuJFC
	 hoKgZO9hohbmFn6AXL3xLCYja+yDNQLf9I5yfvuweD171STA6jLsVVZGlfaLDdkyeg
	 UnQyCT0YdyT3SHaJyHKLVtkxZq73jvFeNFQFeTz+4DOKgl1hr/1kYNg4zh73Y2Zncj
	 dltGgtqQhSvJTtYuxCVAdBKPr9QZ96AQKV1dFolZ04igWYV+L3sTVwOCLAeh8bt941
	 7ZGLdf7BwjwVxvDflBQumvo8/CVE3fkILzS1tNKik4G+OZElDEn5B2clpdycsb/5QW
	 8rnnnL8Y1NZAMipx+gPMtSkgoE1wzYkg2Z6RqikTn+oLX1lToWSyzg7/GsHMEkV6HW
	 P5PQ4ku3T69a0hkRub4ITCj0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AFF040E0190;
	Wed,  2 Aug 2023 09:39:33 +0000 (UTC)
Date: Wed, 2 Aug 2023 11:39:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_023954_962552_F71E3184 
X-CRM114-Status: GOOD (  24.34  )
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

On Wed, Aug 02, 2023 at 04:22:54PM +0800, Tao Liu wrote:
> Thanks for the patch! I have tested it on the lenovo machine in the
> past few days, no issue found, so the patch tests OK.

Thanks for testing!

Mike, Tom, the below ok this way?

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sun, 16 Jul 2023 20:22:20 +0200
Subject: [PATCH] x86/sev: Do not try to parse for the CC blob on non-AMD
 hardware

Tao Liu reported a boot hang on an Intel Atom machine due to an unmapped
EFI config table. The reason being that the CC blob which contains the
CPUID page for AMD SNP guests is parsed for before even checking
whether the machine runs on AMD hardware.

Usually that's not a problem on !AMD hw - it simply won't find the CC
blob's GUID and return. However, if any parts of the config table
pointers array is not mapped, the kernel will #PF very early in the
decompressor stage without any opportunity to recover.

Therefore, do a superficial CPUID check before poking for the CC blob.
This will fix the current issue on real hardware. It would also work as
a guest on a non-lying hypervisor.

For the lying hypervisor, the check is done again, *after* parsing the
CC blob as the real CPUID page will be present then.

Clear the #VC handler in case SEV-{ES,SNP} hasn't been detected, as
a precaution.

Fixes: c01fce9cef84 ("x86/compressed: Add SEV-SNP feature detection/setup")
Reported-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tao Liu <ltao@redhat.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230601072043.24439-1-ltao@redhat.com
---
 arch/x86/boot/compressed/idt_64.c |  9 +++++++-
 arch/x86/boot/compressed/sev.c    | 37 +++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 6debb816e83d..3cdf94b41456 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -63,7 +63,14 @@ void load_stage2_idt(void)
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	/*
+	 * Clear the second stage #VC handler in case guest types
+	 * needing #VC have not been detected.
+	 */
+	if (sev_status & BIT(1))
+		set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
+	else
+		set_idt_entry(X86_TRAP_VC, NULL);
 #endif
 
 	load_boot_idt(&boot_idt_desc);
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 09dc8c187b3c..c3e343bd4760 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -404,13 +404,46 @@ void sev_enable(struct boot_params *bp)
 	if (bp)
 		bp->cc_blob_address = 0;
 
+	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return;
+
+	/*
+	 * Check for the SME/SEV feature:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* Check whether SEV is supported */
+	if (!(eax & BIT(1)))
+		return;
+
 	/*
 	 * Setup/preliminary detection of SNP. This will be sanity-checked
 	 * against CPUID/MSR values later.
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
+	/* Now repeat the checks with the SNP CPUID table. */
+
+	/* Recheck the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -418,7 +451,7 @@ void sev_enable(struct boot_params *bp)
 		return;
 
 	/*
-	 * Check for the SME/SEV feature:
+	 * Recheck for the SME/SEV feature:
 	 *   CPUID Fn8000_001F[EAX]
 	 *   - Bit 0 - Secure Memory Encryption support
 	 *   - Bit 1 - Secure Encrypted Virtualization support
-- 
2.41.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
