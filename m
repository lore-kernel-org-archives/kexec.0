Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06ECC19F53
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=epF08Q9r7/aIhgV9/pbxFc2CK0ZUoca7u5lpFJjCaTQ=; b=PEwhLzBA/CmeAW
	aKuRJCO9sEXF0DM2jPp/qPutWAcON88BNpNx2IG6v1Zq54ueb76wwQ4chhrXgJMS74Qst2T3QGbBC
	wJ8aQenhBaWM6GUPCEMJgaTi09CusOQbLbm1aTH/Ku6a01NEQ1NZIlaHARqB1CACYBH3/DaHt8z7x
	xP8fjZ/OHTHVPdwEV3Is0hIfuku8COdIoHrWD/y3Ya6tZD8SwsFIrFZEpYsZUKvR50c4wedvwn1g+
	GYoRnjJrVL5oDkKSfaynKAIssSwTt5zZxuCwGNVcDbHEFga1Yv2BVhy8Cw4tZ9XJqEMIJk0t4CrHI
	zpm5prXbpPjuXbuMoiHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1n9F-00000006Qnt-2ZmS;
	Tue, 30 Apr 2024 13:03:53 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1n9C-00000006Qms-21Lz
	for kexec@lists.infradead.org;
	Tue, 30 Apr 2024 13:03:52 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E19840E00B2;
	Tue, 30 Apr 2024 13:03:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4pOHEVBUvPZw; Tue, 30 Apr 2024 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714482224; bh=yH6Cwq5/6RGkXtt5HQxlFR8k88T6Ia2YT89+Wjt1MZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juNMt5sml1hzAQw8ms2D04JBZUNnRjMdVKJ8nvf2Z0jYIs50oI2ezS4569ejqpPT7
	 J3PDH5Ml4s4Utu+2BhLRka0NKCurSbPKHWPcklEssmWhuiXTcR/DXdKqAWQe3rko1o
	 MLaEgIdd06Pqyt9CVBv3WrHPBzgnVvy8NLzlcIorNXOuyqMFOMWGS3YHCaEUEdDSvr
	 l9UZK4wH5Vg9p9s4liriyMZ2wNtczIq8hSeNoTmket0pNKiQEkAT9Yb7D/osJnF9mB
	 yxIWpgTKpCVNLSSk9j3RMZeHx7SBM/lNQD9yWHr6e+yjk4piyJHJD47jB7vcMsFq8D
	 LhVNjBdOTGboN8l7nZi+DziNaF921K0LsanmK3XpzWFtWTI3a8S8BPf9kiFLse6oY9
	 ioqmSAQMvaZQwbJrxdf1UZ/hl9M7vY0xDj6pScAygVRA7JUJhOdys+KGKn9BgUpCNG
	 x8x3+r7zF50fPMKJ5GLRnVeT6LKos0PkChpiuLNxUw5fOI9OUY4zmDwYKzx7YGAX5G
	 NFbuSKxS+3N6oACe+Js9/PkTwZ+A8Go0w9OAa93debmZDYvuw8n3RpcQP6HNoGBTHb
	 CmUTw2K0MvgCnI04isvWw/cNjukt+2KZT4noNKeNID09Ycus/JPSN4wPhc+oiwmVIU
	 YC3lblHRoDgiwrqxN0qAN2wk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51C6D40E016B;
	Tue, 30 Apr 2024 13:03:24 +0000 (UTC)
Date: Tue, 30 Apr 2024 15:03:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_060350_722308_D37A6A5E 
X-CRM114-Status: GOOD (  11.48  )
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

On Tue, Apr 09, 2024 at 02:29:57PM +0300, Kirill A. Shutemov wrote:
> +1:
> +	testq	$X86_CR4_MCE, %r13
> +	jz	1f
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>  1:

Please add the below patch to your set. Those same-number labels are
just abominable.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 30 Apr 2024 15:00:16 +0200
Subject: [PATCH] x86/relocate_kernel: Use named labels for less confusion

That identity_mapped() function was loving that "1" label to the point
of completely confusing its readers.

Use named labels in each place for clarity.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8e2037d78a1f..0077c9e562a7 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -152,13 +152,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 	movl	$X86_CR4_PAE, %eax
 	testq	$X86_CR4_LA57, %r13
-	jz	1f
+	jz	no_la57
 	orl	$X86_CR4_LA57, %eax
-1:
+no_la57:
+
 	testq	$X86_CR4_MCE, %r13
-	jz	1f
+	jz	mca_off
 	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
-1:
+mca_off:
+
 	movq	%rax, %cr4
 
 	jmp 1f
@@ -173,9 +175,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
 	testq	%r12, %r12
-	jz 1f
+	jz sme_off
 	wbinvd
-1:
+sme_off:
 
 	movq	%rcx, %r11
 	call	swap_pages
@@ -195,7 +197,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 */
 
 	testq	%r11, %r11
-	jnz 1f
+	jnz relocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
@@ -216,7 +218,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	ret
 	int3
 
-1:
+relocate:
 	popq	%rdx
 	leaq	PAGE_SIZE(%r10), %rsp
 	ANNOTATE_RETPOLINE_SAFE
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
