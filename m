Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2C1E7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6933YuQD7v1gt6fKPbNUAtR2OjPbaq+uNa6Fn6QqyyI=; b=0D06GTZS1zDieWFJ2+VPr0O7DO
	DyDtcP5ihd53FzR0TeTUZ+7S7XtUpdgPTpc/SRMVFFxVsAgw/OVOsxTOXPtO5hyVxtzYT/lmfznzQ
	Ng1fijnL6x7D3ZroqhQ6ZmqNtU8M/JR99IYg1Qe2zU0wqZ9VAtDxBxb7zcyNNvdutV0jG4fAX/fCw
	rka3MbqswmgTt4iyepONIUQCGe/a5gdX/oRf7f1qtE4/q7iG0LWEesxsd1Gru2269euOazEXH/i33
	Uub9vptoLd00NtHemJEU4h6uBac50HKRLtIKoQplJUqY6IrLgAq18O0qOVKr/81VwbpOI+GEvvxzz
	3PaTMePg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tN3zN-000000098RI-1WLh;
	Mon, 16 Dec 2024 05:49:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tN3zJ-000000098QE-3e5V
	for kexec@lists.infradead.org;
	Mon, 16 Dec 2024 05:49:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C86C5C5ECD;
	Mon, 16 Dec 2024 05:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3501CC4CED0;
	Mon, 16 Dec 2024 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734328188;
	bh=g/eQnsT9d+ygJl/82h3fLUtDP8Njeoli4JMtLP8reOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iF94hWv+qjQgdzWrg7LqPH+9O3h2VbLE4gwcWpxEBiwW1tlztsiDpea8CymcviOp6
	 g5Rrt4RkaQCP0rJgqMzS2OgTV6sXL2HJoPP7m7+At7smMo2sfH+NBoNlVpd5GCcRC7
	 QuxkJgbvRqq7RLcNqivHMyaqyW45pg5Bb23aTiAlH90S9wK0Hz2JWSMgiKMuEtFAYa
	 y7k1hhOyhgSvq2zGgGqtAsYxCir9ZWPAW5G1Q/4BTbuOqKsbGuf5JoZoqyNr/VAt6/
	 rEebGMilh/9uPCFWDtfokAhhSIFG5OS0IaAyZ3b+03x7vPtnQD3cuTwhemts3KXHTL
	 BnbgTsFFp7L0Q==
Date: Sun, 15 Dec 2024 22:49:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v5 07/20] x86/kexec: Invoke copy of relocate_kernel()
 instead of the original
Message-ID: <20241216054942.GA25019@ax162>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-8-dwmw2@infradead.org>
 <20241214230818.GA677337@ax162>
 <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d843d2ceb09acdae494ee9a17ec94bf8bb4e4f.camel@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241215_214950_029834_73B75980 
X-CRM114-Status: GOOD (  30.73  )
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

On Sun, Dec 15, 2024 at 10:09:57AM +0000, David Woodhouse wrote:
> On Sat, 2024-12-14 at 16:08 -0700, Nathan Chancellor wrote:
> > 
> > I guess this seems somewhat unavoidable because control_page is just a
> > 'void *', perhaps machine_kexec() should just be marked as __nocfi? This
> > diff resolves that issue for me.
> 
> The patch below seems to work too. I already wanted to deal with the

Can confirm, thanks for the quick fix. With your fix for the first issue
I reported, the fix I sent for LTO, and this patch below, I can kexec on
a CFI and LTO enabled kernel without any issues.

> case where relocate_kernel isn't at the start of the page, so it forces
> me to do that.
> 
> For some reason it also started complaining
> vmlinux.o: warning: objtool: relocate_kernel+0x6a: return with modified stack frame
> ... which is easy to fix just by turning it into a jmp *%rsi; I have no
> idea why it was done with a ret like that in the first place.
> 
> I don't know why it puts 16 bytes of NOPs between __reloc_start and
> __cfi_relocate_kernel (in addition to the 16 before relocate_kernel
> itself), and space is *fairly* tight in the control page, but it's
> tolerable.

I think this is something to do with FineIBT IIRC? PeterZ might have
more details.

> To make the CFI check actually give useful output if it triggers, I'm
> tempted to do the IDT/GDT invalidation relocate_kernel itself, instead
> of before the call.
> 
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index ccb297765e08..e6befd11fee4 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -6,6 +6,7 @@
>  
>  #include <linux/linkage.h>
>  #include <linux/stringify.h>
> +#include <linux/cfi_types.h>
>  #include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
> @@ -61,7 +62,10 @@ SYM_DATA_END(kexec_debug_idt)
>  
>  	.section .text.relocate_kernel,"ax";
>  	.code64
> -SYM_CODE_START_NOALIGN(relocate_kernel)
> +__reloc_start:
> +	ANNOTATE_NOENDBR
> +
> +SYM_TYPED_FUNC_START(relocate_kernel)
>  	UNWIND_HINT_END_OF_STACK
>  	ANNOTATE_NOENDBR
>  	/*
> @@ -115,10 +119,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>  	lea	PAGE_SIZE(%rsi), %rsp
>  
>  	/* jump to identity mapped page */
> -	addq	$(identity_mapped - relocate_kernel), %rsi
> -	pushq	%rsi
> -	ANNOTATE_UNRET_SAFE
> -	ret
> +	addq	$(identity_mapped - __reloc_start), %rsi
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rsi
>  	int3
>  SYM_CODE_END(relocate_kernel)
>  
> @@ -263,7 +266,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  
>  	/* get the re-entry point of the peer system */
>  	popq	%rbp
> -	leaq	relocate_kernel(%rip), %r8
> +	leaq	__reloc_start(%rip), %r8
>  	movq	kexec_pa_swap_page(%rip), %r10
>  	movq	pa_backup_pages_map(%rip), %rdi
>  	movq	kexec_pa_table_page(%rip), %rax
> @@ -272,7 +275,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	movq	$1, %r11	/* Ensure preserve_context flag is set */
>  	call	swap_pages
>  	movq	kexec_va_control_page(%rip), %rax
> -	addq	$(virtual_mapped - relocate_kernel), %rax
> +	addq	$(virtual_mapped - __reloc_start), %rax
>  	pushq	%rax
>  	ANNOTATE_UNRET_SAFE
>  	ret
> 



