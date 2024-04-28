Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D19CC4345F
	for <kexec@archiver.kernel.org>; Sun, 28 Apr 2024 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u5+GzWrzZVrTJWHVHUE2RzmJSJLLyVwyyVM97RO5CZk=; b=GJWs5fOSWowNr9
	1esPyt3iP1z6itLt3RMd9om2ndv7A+9iObIZ6pcPFN/JlSdhnDHYY1aQxIlTj6F1DIc7Fxq68cwTE
	/+dngijX+lQ5j9r8KooNngL8fx2WnDZC4VIUZzoR9weqyn34yOaR9elvcB/o9xKdPL0GqTrLxYAji
	rLY33AOeM5A2aktHJs0aQ9Fb8GtvvX64j71/YLnVYZZGne//L9aPe1Kt4HbsIt2qY7U9EfiYzqnxr
	zuds7PZ35YcT082z8QcAT2fRWaeEdXP5QshbN/XG7bEhBB7Bnloyb6Yw99OpzfbpQNBNbRqVrPcJd
	IDPsBcVYoXB8s3GaFOPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s184L-00000000NAm-25bA;
	Sun, 28 Apr 2024 17:12:05 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s184E-00000000N8W-2P3S
	for kexec@lists.infradead.org;
	Sun, 28 Apr 2024 17:12:02 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C013740E0249;
	Sun, 28 Apr 2024 17:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yIWMf0eQpAjz; Sun, 28 Apr 2024 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714324298; bh=n8m7VXqiGZAmEpF7qkKdr35cuC1UAhOwozx/1g8c2jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEd67HJ5UVpQXs5da0WESrtXPALlwXqhQUZVrGi/DN2KQPq2S4s0rzWAcMxM6tvwh
	 aDIrwaJgOlRGte14D1XMVisCGkRcKu+qX6y8tLPvbrDrArXnX1vuZj0eZBeS3M5ie7
	 72J7Ap+1GwM+7cXqDSl5/6qYqGsopbzneEJxb0YjmjwdySkz4NsXLzSV3NkjCQYR2q
	 1+rUxb7c2dJrc9EP55qviYpGBeHQ0QEL5fu4Pb0uZi4paMuPjEgWsvSS/RL8gXvFH8
	 qseBvfEGKaXeJZ2DCDWQ8+rM3tWOG9vYnb/Af70Wx/BtN1VUxB/jd0tucRfH+ka62A
	 PifqcmfludHTau0He03VHNKdVNxeNnvv2zH6GdL42FhZmW34stYowBvA4w3vn4Xfhh
	 xxWgAAv0L6rvZhWK7J0Y7B+g7QYCQbwkrQ9MwaO+9NU0TfaAADAkuyD8A6E3FHmRy6
	 PmkS3+EQskYjoyB1GXcQ3KwYQMaxEWeSnkYsZvmGWHznhg/rSaU3hqAATxt6R0+v0r
	 s650kgJTqWduNcZP3XbzBnAfqqeMbq7J/hrjagXD8BmYLUG9r3KhLCu+5Yz/BXRv+T
	 VHwTyr0McN1lwd/vO8BaHa0+J2AdJf9FknPSidkXCUJp2Dn8FY9gb8iyDRxNhK4xft
	 mzfV13P/ErHlTuZN6kcbGw8A=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A991240E016B;
	Sun, 28 Apr 2024 17:11:17 +0000 (UTC)
Date: Sun, 28 Apr 2024 19:11:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_101200_008884_1B448DFF 
X-CRM114-Status: GOOD (  18.49  )
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

On Tue, Apr 09, 2024 at 06:26:05PM +0300, Kirill A. Shutemov wrote:
> From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Fri, 10 Feb 2023 12:53:11 +0300
> Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> 
> Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> Attempt to clear it leads to #VE.
> 
> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.

This is all fine and dandy but nothing explains *why* TDX needs this
special dance.

Why can't TDX do the usual CR4.MCE diddling like the normal kernel
during init and needs to do that here immediately?

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..90246d544eb1 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
>  #include <asm/processor-flags.h>
> @@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  
>  	/*
>  	 * Set cr4 to a known state:
> -	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.

			 ... might not be allowed ...

> +	 *  - physical address extension enabled
>  	 */
> -	movl	$X86_CR4_PAE, %eax
> -	testq	$X86_CR4_LA57, %r13
> -	jz	1f
> -	orl	$X86_CR4_LA57, %eax
> -1:
> +	movl	$X86_CR4_LA57, %eax
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> +	andl	%r13d, %eax

%r13 needs a comment here that it contains %cr4 read above in
relocate_kernel()

> +	orl	$X86_CR4_PAE, %eax
>  	movq	%rax, %cr4
>  
>  	jmp 1f
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
