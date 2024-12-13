Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E033E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 06:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylDikDn93YqfQdqF75+mqVrF/ASihsVtwerJZKQeb1w=; b=kwucX0q/3C/laHtjmKri5Hm4Of
	a2YutcNNdjvECuRJOaEMS334nMV0+p+fViDIdTLdNXz30tGJTbEV9EApP4c37tQD6NT5azXnWry+J
	1K+GJrwALEJCgbOphL/PpuJfq00dgV9Mfwn+DTiySFYMk3VNdjIE/1IUmoc7oJVLjeDaRWmXtZRnR
	+Q0qeOES+8IYwYnTW3NXstM7VuWWJXQORIHsxc/7jiTRgoTApbVKm630dlQmFkV6b+WbNv0hUsrS+
	O0fkn9mUaiu5YsifSIub+wgh+1l6K1ZRgPpY+eykbKeFWhpwbmxrJnBhOHDwFBQP+6vBNjgmDh7Aj
	xUUbbh7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzSt-00000002ti1-0GAI;
	Fri, 13 Dec 2024 06:47:55 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzSr-00000002thJ-09V7
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 06:47:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734072473; x=1765608473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxlMeg8yLvyobF5BZCphZMShNNgJBFWKM/5XKIOYuOs=;
  b=F9hSCOiJodsaQgN70ZapLGiTQxZTNNmvjkP4b1mQSx4imSjbgw8Akp8v
   I6eAGmI+Ui/Y0/HqtG1vdoGI/dKGKhcxlPrJ5yBQ04xAKYmuhYbGXgR64
   BfWLj2KtIThAXlO0wOzQ0Txds9oVv49REuNC6twv8IjgcqaWSeCFV0tF1
   jKHO5rGjTe46E6OB5YmuMrzBfbY27wzUywkMee/0Nq9mdWyCn3IFeMG2i
   UogmOEo7TYZ3fyAhIqFTzdD7VPbs6pV4ec5+3KsJN4huA/0HyZJVl0MFj
   r9e7fBBG8W9EXlPt0x5aK8kd+Qrn926SdV5YEZUa3+5pz3qzZ61R31/GX
   w==;
X-CSE-ConnectionGUID: HFZ08nocQ1q8YUxUZrCdAQ==
X-CSE-MsgGUID: oPkqDtmvTiWUVFi/NdL0TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45206657"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="45206657"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:47:53 -0800
X-CSE-ConnectionGUID: UIg6JalIS36H2HNE5PapfQ==
X-CSE-MsgGUID: 3BLv8ClPSyWs4NAL/sPCDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96687135"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:47:48 -0800
Message-ID: <a0e4a3e6-254b-468b-9e59-accc35b4a606@linux.intel.com>
Date: Fri, 13 Dec 2024 14:47:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Only write through identity mapping of control
 page
To: David Woodhouse <dwmw2@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_224753_091241_CCB2E3C9 
X-CRM114-Status: GOOD (  22.92  )
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



On 2024/12/13 4:11, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The virtual mapping of the control page may have been _PAGE_GLOBAL and
> thus its PTE might not have been flushed on the %cr3 switch and it might
> effectively still be read-only. Move the writes to it down into the
> identity_mapped() function where the same %rip-relative addressing will
> get the new mapping.
> 
> The stack is fine, as that's using the identity mapped address anyway.
> 
> Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of RWX")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219592
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>

> ---
>   arch/x86/kernel/relocate_kernel_64.S | 32 +++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 553d67845b84..b9c80b3091c8 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -90,22 +90,17 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>   	movq	kexec_pa_table_page(%rip), %r9
>   	movq	%r9, %cr3
>   
> -	/* Save %rsp and CRs. */
> -	movq    %rsp, saved_rsp(%rip)
> -	movq	%rax, saved_cr3(%rip)
> -	movq	%cr0, %rax
> -	movq	%rax, saved_cr0(%rip)
> -	/* Leave CR4 in %r13 to enable the right paging mode later. */
> -	movq	%cr4, %r13
> -	movq	%r13, saved_cr4(%rip)
> -
> -	/* save indirection list for jumping back */
> -	movq	%rdi, pa_backup_pages_map(%rip)
> +	/*
> +	 * The control page still might not be writable because the original
> +	 * kernel PTE may have had the _PAGE_GLOBAL bit set. Don't write to
> +	 * it except through the *identmap* address.
> +	 */
>   
>   	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
>   	movq	%rcx, %r11
>   
>   	/* setup a new stack at the end of the physical control page */
> +	movq	%rsp, %rbp
>   	lea	PAGE_SIZE(%rsi), %rsp
>   
>   	/* jump to identity mapped page */
> @@ -118,6 +113,19 @@ SYM_CODE_END(relocate_kernel)
>   
>   SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	UNWIND_HINT_END_OF_STACK
> +
> +	/* Save original %rsp and CRs. */
> +	movq    %rbp, saved_rsp(%rip)
> +	movq	%rax, saved_cr3(%rip)
> +	movq	%cr0, %rax
> +	movq	%rax, saved_cr0(%rip)
> +	/* Leave CR4 in %r13 to enable the right paging mode later. */
> +	movq	%cr4, %r13
> +	movq	%r13, saved_cr4(%rip)
> +
> +	/* save indirection list for jumping back */
> +	movq	%rdi, pa_backup_pages_map(%rip)
> +
>   	/*
>   	 * %rdi	indirection page
>   	 * %rdx start address
> @@ -185,7 +193,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 *  - Machine check exception on TDX guest, if it was enabled before.
>   	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
>   	 *
> -	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
> +	 * Use R13 that contains the original CR4 value
>   	 * PAE is always set in the original CR4.
>   	 */
>   	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d


