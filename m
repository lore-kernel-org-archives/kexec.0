Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF7AC4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xohOZA5zepyqLo/iHqG6q+eqG5kFfMuW5OqfpskvaY4=; b=PojxxThqqLSiTl
	cYA80Buu+R+hF4UYtCO9DJNOq3tsdPtR+SWFxZku4bm2HxsbpARZNHFvKmkDzBD9Lr3a03drupmjl
	RdpuUrmnX1EwYVgg9IeNn0gO9tV0h9sVA+ScJko7uZVcPK+uqQaL43xM9udd76GfIpNdGAzpxSw9E
	4xM1/3BuCtE8lRKdVHtyO8qL/yQk1FFQ+KuvijxuHBvBBYQUaBmWgYmDLktuVL+uvpZuDhHOFKwNf
	TOn1VIng1UavmkmtjUV6YDxwKkbNhzyQEQOpDWhgCFxWHxtuIVJBvxEzQcD/r/EzttKkssXt+MGoF
	ExUd0VmT8zv3bp/57LzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Wkm-0000000Cped-1GRW;
	Thu, 02 May 2024 13:45:40 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2Wki-0000000CpbV-3Nrl
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 13:45:38 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 057F340E01F6;
	Thu,  2 May 2024 13:45:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CAz-p8QlU9Cc; Thu,  2 May 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714657530; bh=zji4T/QOtMf3/iGCx7QJQsPxQclDFcQuEmKgqQq8AF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V84SIw7BNHOpaaG9srJty4nxAGa7z6IwwnF1aYgwWBno4+HM1G0Ibaf+WlhT3cux3
	 7HjhIqCzCa7iNZ8xeKtlu74butBVoVNviPqTfcaHroMl9pOgZEF63s9R9p61FZ9Di3
	 bY5oM6P0PQyicVh+ZOT0hQek9ATNtnOfrbWwB+OG/qgecjtY7wVilcaStYpby8gnVM
	 X9PB4q1J6+ysjYZsSvIjqJHBN4YymhUrqXLMqyaBCZZY9t2oyccXEUAg6vhobnspPF
	 YRTTLldxlsLSdEJoR/CHNSe2G62NDENeL8SEykkftszQc3dyVt9wrnTJZKtRJRhkFs
	 8zUPmWrldXD3Wwl1RBXsQcEy65LZvb+iy0rM/BJsOctVNbkcb98z9lCKm8YXsHz87q
	 iSL4Yjy8OL8NalVsFhgarLEXcdHGazqOvndvgMMOD8NKXH3D0JrH2QgQRZhviRg+OA
	 06h+TD5pND2cyOmma6JT3I+JuMA7Qz69XI3LReUu2e+04N1IjED+dyuqa/ON4q7RY0
	 aCsLR46rK4vBGuWzkDWJvBoBGiWcagr/boxQk+kR5CbMTghAt+OLO3b8jYXqCwHMxs
	 K7xzgJYWvgYw3LZ3tzJrwa5rRKshkCTdOR6HAGKWVM5soMCL/uECUSCDWczLf+x8Gm
	 RNyPyBcef/WZbC18oW/fJMEA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F11ED40E01E8;
	Thu,  2 May 2024 13:45:07 +0000 (UTC)
Date: Thu, 2 May 2024 15:45:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com,
	nik.borisov@suse.com, peterz@infradead.org, rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
 <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_064537_037236_EF3499ED 
X-CRM114-Status: GOOD (  26.31  )
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

On Sat, Apr 27, 2024 at 08:06:34PM +0300, Kirill A. Shutemov wrote:

> Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted memory for kexec

s/Adding/Add/

> AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
> This is done by allocating pages normally from the buddy allocator and
> then converting them to shared using set_memory_decrypted().
> 
> On kexec, the second kernel is unaware of which memory has been
> converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
> memory as private is fatal.
> 
> Therefore, the memory state must be reset to its original state before
> starting the new kernel with kexec.
> 
> The process of converting shared memory back to private occurs in two
> steps:
> 
> - enc_kexec_stop_conversion() stops new conversions.
> 
> - enc_kexec_unshare_mem() unshares all existing shared memory, reverting
>   it back to private.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>x
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/include/asm/x86_init.h |  2 ++
>  arch/x86/kernel/crash.c         |  4 ++++
>  arch/x86/kernel/reboot.c        | 12 ++++++++++++
>  arch/x86/kernel/x86_init.c      |  4 ++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 28ac3cb9b987..c731e6bc4343 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -155,6 +155,8 @@ struct x86_guest {
>  	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_tlb_flush_required)(bool enc);
>  	bool (*enc_cache_flush_required)(void);
> +	void (*enc_kexec_stop_conversion)(bool crash);
> +	void (*enc_kexec_unshare_mem)(void);

This is all fine and dandy but those functions need documentation in the
kernel doc above it.

And if there's a "stop_conversion" function, then I'd expect there to be
a "start conversion" one.

I think you need to give those two better names to denote that they're
related, the order in which they should be called and why they're
separate.

>  };
>  
>  /**
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e74d0c4286c1..f1b261be78b4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -128,6 +128,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	x86_platform.guest.enc_kexec_stop_conversion(true);
> +	x86_platform.guest.enc_kexec_unshare_mem();
> +

You call them here back-to-back...

>  	crash_save_cpu(regs, safe_smp_processor_id());
>  }
>  
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index f3130f762784..c1920ec34f0c 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/objtool.h>
>  #include <linux/pgtable.h>
> +#include <linux/kexec.h>
>  #include <acpi/reboot.h>
>  #include <asm/io.h>
>  #include <asm/apic.h>
> @@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
>  
>  void native_machine_shutdown(void)
>  {
> +	/*
> +	 * Call enc_kexec_stop_conversion() while all CPUs are still active and
> +	 * interrupts are enabled. This will allow all in-flight memory
> +	 * conversions to finish cleanly.
> +	 */
> +	if (kexec_in_progress)
> +		x86_platform.guest.enc_kexec_stop_conversion(false);
> +
>  	/* Stop the cpus and apics */
>  #ifdef CONFIG_X86_IO_APIC
>  	/*
> @@ -752,6 +761,9 @@ void native_machine_shutdown(void)
>  #ifdef CONFIG_X86_64
>  	x86_platform.iommu_shutdown();
>  #endif
> +
> +	if (kexec_in_progress)
> +		x86_platform.guest.enc_kexec_unshare_mem();

... but they're split here.

And I don't know why and nothing tells me...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
