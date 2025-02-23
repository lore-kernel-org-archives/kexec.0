Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B91C021B2
	for <kexec@archiver.kernel.org>; Sun, 23 Feb 2025 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkOwpvyn5ZXwqceHj9vbT7VPfFI3uFx17BjfOibXqw4=; b=bKXREO6A9twQ0Jmx9MI5zkTFaE
	MlMKiIPW5nePl/grdi2WJP1FmmicjULMCwmMGKppLZmP/sola0lWIgVGMFXOTmiglkG97VIIuw1j2
	CvngKLplqabRo7KTNjn5qRW50gcDbLsQdzMnTqlkkPx2RI3vdSiyVy6e/Ea6XCCzKWAhTvmKlDCvj
	knEFkImVdqbfeGpNkTv2dNzhIh2z30ObBtI8c5fMUu6nLcu/EBCWByZ7GQylqzR9mu67maUUgZahe
	RawIZscUDDaAC3Qr5DpllZudNw3vidaWY8S5ajAArjy6KMQdAdhK+lGnUv4hZGy49v1DpzKJA74fZ
	Y7LbuIbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tm8fs-0000000AoRb-1TDn;
	Sun, 23 Feb 2025 09:53:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tm8fn-0000000AoQ0-1sdq
	for kexec@lists.infradead.org;
	Sun, 23 Feb 2025 09:53:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A01C25C6691;
	Sun, 23 Feb 2025 09:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E7C4CEDD;
	Sun, 23 Feb 2025 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740304398;
	bh=K7CO8Lrs4keAG8R3V4xMDGh7oNAIoEsVthwZm0p0UA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot35b3B9o74y0ZW1yh9Xu17CwBgDZtTIRFy5wUdBX2QLt/goPhUli1fT0/nJTthvW
	 sKwCwWph3guEFEim3dXjdupAMUVxVTJg1v36mgWmiZvcN7+vnUsYGKMu1TJyTkc8nC
	 RFH+mGB0RClDnEONs7RrccKyLTuyj36Ft21hdmP5wOG5LkJgmQwT5vzC4K+yoyy+xB
	 dhBM7JtlDEQ2FzOocYA+zmY7BcTM5r8Fj8qdpmX3y0SNtd2K9TASYlUP/7OxT+xI+/
	 +DrLTruIU1VrBlfhtMMWtl1xzv09vrgEw7uFnhFN2SMMzGv4KgRuD+TUM5TW+Z4Owi
	 DvVqMVhZTHF3Q==
Date: Sun, 23 Feb 2025 10:53:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
	bsz@amazon.de
Subject: Re: [PATCH v6 2/7] x86/kexec: Debugging support: load a GDT
Message-ID: <Z7rwA-qVauX7lY8G@gmail.com>
References: <20250115191423.587774-1-dwmw2@infradead.org>
 <20250115191423.587774-3-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115191423.587774-3-dwmw2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_015319_533787_FA12C8A3 
X-CRM114-Status: GOOD (  19.31  )
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


* David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There are some failure modes which lead to triple-faults in the
> relocate_kernel function, which is fairly much undebuggable for normal
> mortals.
> 
> Adding a GDT in the relocate_kernel environment is step 1 towards being
> able to catch faults and do something more useful.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index af2cd06ff318..c62f03808f18 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
>  SYM_DATA(kexec_pa_swap_page, .quad 0)
>  SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
>  
> +#ifdef CONFIG_KEXEC_DEBUG
> +	.balign 16
> +SYM_DATA_START_LOCAL(kexec_debug_gdt)
> +	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
> +	.long   0
> +	.word   0
> +	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
> +	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
> +	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
> +SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
> +#endif /* CONFIG_KEXEC_DEBUG */

Yeah, so is there any reason (other than paranoia) why the early-early 
GDT and IDT shouldn't be unconditional? There's many ways for such an 
approach to bitrot, it's much better to not hide it behind a 
default-disabled debug option...

Some of the other bits, like the hard-coded serial debugging 
assumptions, probably need to be behind the debug option - but much of 
the new debug mechanism looks safe and generic and can be always-on, 
IMHO.

This would also throw regressions back into the face of whoever manages 
to introduce them, ideally. ;-)

Thanks,

	Ingo

