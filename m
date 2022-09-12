Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1E9ECAAA1
	for <kexec@archiver.kernel.org>; Mon, 12 Sep 2022 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u89NDw8sSl4mznLxEXMm8ooFafC3F1nhwtX7wrGEA9I=; b=zH4nkWOJKTcmmN
	LLjlvKzVsOdSsZ21AEOsqRKQxXWdx4u1ECU9JRveb6xs/gT4rXKPh23C5Ym/Tc9SRhjQ6qb0ChfpR
	kWWsP5wcRbSACP/2GolAtcI5WOzV9/xllU/tB2DZLlxDWmxaO+YZZTqNCjE9j2FQ1JjiT5pevGZ1Z
	g21P0OBAOmf51TVufsHclz6nAk6L1pHd7XG8dCnUr//ywLl0GOnZ1Xn6+navv2uAAhzX0XJZ3ez+f
	Whi+EfgPe1z48WW3N9VufepjbPxc92DoTKY9M3pOOsB2mCVfOwNjFS6A5Rz+Hcv5Nref6A9YCUW21
	CCZf8aS/3Dol/nI2iuVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXdIn-007KVU-Kn; Mon, 12 Sep 2022 06:52:17 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXdIi-007KP5-Um
	for kexec@lists.infradead.org; Mon, 12 Sep 2022 06:52:15 +0000
Received: from nazgul.tnic (unknown [185.122.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D4F41EC01B7;
	Mon, 12 Sep 2022 08:51:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1662965517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=zQU+ilUE6KZTkKm6TJWEBwShCmN8B0rfcvXt/Sb2Jis=;
	b=SraL03CSsWt4N6QLSQ/pz5PtLMR4Sh1zaQvs94Z+x/JzWLYmRjlcovyVMCSlOdMfx967yQ
	4oLc0b6xXFKgdPp31JC3UisIa9qLoemX4OklU430LfS5B8dkrerq8qFraw8i93kT2g10cg
	KdCkBKZEmgzPIs1cLlwj5T0Mu/HuTfM=
Date: Mon, 12 Sep 2022 08:52:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Yx7XEcXZ8PwwQW95@nazgul.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909210509.6286-8-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220911_235213_211100_A28A458E 
X-CRM114-Status: GOOD (  41.82  )
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

On Fri, Sep 09, 2022 at 05:05:09PM -0400, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> When loading the crash kernel via kexec_load or kexec_file_load,

Please end function names with parentheses. Check the whole patch pls.

> the elfcorehdr is identified at run time in
> crash_core:handle_hotplug_event().
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and then installed over the top of
> the existing elfcorehdr.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
> 
> With this change, crash hotplug for kexec_file_load syscall
> is supported.

Redundant sentence.

> The kexec_load is also supported, but also
> requires a corresponding change to userspace kexec-tools.

Ditto.

> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/Kconfig             |  11 ++++
>  arch/x86/include/asm/kexec.h |  20 +++++++
>  arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..cdfc9b2fdf98 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	int
> +	default 32768
> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> +	  size to determine the final buffer size.

If I'm purely a user, I'm left wondering how to determine what to
specify. Do you have a guidance text somewhere you can point to from
here?

> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index a3760ca796aa..432073385b2d 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>  extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>  extern void kdump_nmi_shootdown_cpus(void);
>  
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
> +#define arch_map_crash_pages arch_map_crash_pages
> +
> +void arch_unmap_crash_pages(void **ptr);
> +#define arch_unmap_crash_pages arch_unmap_crash_pages
> +
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action);
> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static inline int crash_hotplug_cpu_support(void) { return 1; }
> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static inline int crash_hotplug_memory_support(void) { return 1; }
> +#define crash_hotplug_memory_support crash_hotplug_memory_support
> +#endif
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_KEXEC_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..8fc7d678ac72 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers = kbuf.buffer;
>  	image->elf_headers_sz = kbuf.bufsz;
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz =
> +		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
> +			sizeof(Elf64_Phdr);


	kbuf.memsz  = CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
	kbuf.memsz *= sizeof(Elf64_Phdr);

looks more readable to me.


> +	/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +	image->elf_headers_sz = kbuf.memsz;
> +	image->elfcorehdr_index = image->nr_segments;
> +	image->elfcorehdr_index_valid = true;
> +#else
>  	kbuf.memsz = kbuf.bufsz;

Do that initialization at the top where you declare kbuf and get rid of
the #else branch.

> +#endif
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

This ugly ifdeffery is still here. Why don't you have stubs for the
!defined() cases in the header so that you can drop those here?

> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	void *ptr = NULL;
> +
> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap_local_page(page);
> +	}
> +
> +	return ptr;
> +}

	if (size > 0)
		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
	else
		return NULL;

That's it.

> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap_local(*ptr);
> +		*ptr = NULL;
> +	}

Oh wow, this is just nuts. Why does it have to pass in a pointer to
pointer which you have to carefully check twice? And why is it a void
**?

And why are those called arch_ if all I see is the x86 variants? Are
there gonna be other arches? And even if, why can't the other arches do
kmap_local_page() too?

> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + *
> + * To accurately reflect hot un/plug changes, the new elfcorehdr
> + * is prepared in a kernel buffer, and then it is written on top
> + * of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +	unsigned int hp_action)

Align arguments on the opening brace.

> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	/*
> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()

Elfcorehdr_index_valid??

> +	 */
> +	ksegment = &image->segment[image->elfcorehdr_index];
> +	mem = ksegment->mem;
> +	memsz = ksegment->memsz;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("crash hp: unable to prepare elfcore headers");
			^^^^^^^^

this thing is done with pr_fmt(). Grep the tree for examples.

> +		goto out;
> +	}

The three lines above reading ksegment need to be here, where the test
is done.

> +	if (elfsz > memsz) {
> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * At this point, we are all but assured of success.

Who is "we"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
