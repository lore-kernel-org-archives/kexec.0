Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA88C00140
	for <kexec@archiver.kernel.org>; Sat, 13 Aug 2022 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rprSv9TimDAhRGrm3vIN8lTMDN7sWI5oMPaxb5Tnu8I=; b=R+YgnK7F7cwX3S
	dFjKuUuIALVdrFtJ24kIWAfKAjEwcrnVQsTi5+S+ZjLfxl6L7caVdQ1BAob+KRk7YUzvp4JGTSZdX
	5tyPiTYCNaXI1PMIXbStYRf2RjV9hWggxLh0i9yMSg+PHOpqSsH1z7Q9ukrJuc7QEUZ3EdR66ULyS
	huDHYtpHnmj5OUo6IDfrEUOMxXnGe98wkWosk79rDgRl/xk3fkslHEl0vTW6uYZ2CLaakjYWKedRd
	AXcG73VSJbnvvfNFbAeyQqYZHgxCLqHGiBcsmmFtOo5xur0XVtFH68nDzMO7zljd2ikSbIfWJk90s
	XHD4+Uhtj5Neyd38AgXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMf6f-001GXT-Eb; Sat, 13 Aug 2022 00:34:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMf6b-001GVP-Sy
	for kexec@lists.infradead.org; Sat, 13 Aug 2022 00:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660350860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=peRfAvWIP7FDZjD9LS6PUCSHBhipHIZbT/wujjdYk4M=;
	b=LGfcLRP1y+CMFasjtwP9bi9s69WB7D3+tDAghJJ7Y/80GTPynV4OPvJuE6H6qH9l09UQTi
	ZcTCQkkLPzSwVvdNj4z0Q+gtVkqKWTOYO4j0E/4cWOYsrcO3x1vLFmcZNO2/CcULk9R9Ib
	a9spHzUf/9stMW3txLyjME0XD9MUmEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-pusrxSxtNjmQQNpKUc6RaQ-1; Fri, 12 Aug 2022 20:34:15 -0400
X-MC-Unique: pusrxSxtNjmQQNpKUc6RaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7BAC85A581;
	Sat, 13 Aug 2022 00:34:14 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9C040CF8E5;
	Sat, 13 Aug 2022 00:34:13 +0000 (UTC)
Date: Sat, 13 Aug 2022 08:34:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 8/8] x86/crash: Add x86 crash hotplug support
Message-ID: <Yvbxgvk+5HqEl7J2@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-9-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-9-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_173422_034217_207566CD 
X-CRM114-Status: GOOD (  36.34  )
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

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
...snip.... 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e58798f636d4..bb59596c8bea 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2065,6 +2065,17 @@ config CRASH_DUMP
>  	  (CONFIG_RELOCATABLE=y).
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	int
> +	default 32768

Do we need to enforce the value with page align and minimal size? I
checked crash_load_segments() in arch/x86/kernel/crash.c, it does the
page size aligning in kexec_add_buffer(). And in
load_crashdump_segments() of
kexec-tools/kexec/arch/i386/crashdump-x86.c, it creates elfcorehdr at
below code, the align is 1024, and in generic add_buffer()
implementation, it enforces the memsz page aligned, and changes the
passed align as page alignment.


	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
                                                        max_addr, -1);

Maybe we should at least mention this in the help text to notice people.

> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> +	  size to determine the final buffer size.
> +
>  config KEXEC_JUMP
>  	bool "kexec jump"
>  	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
> index 8b6bd63530dc..96051d8e4b45 100644
> --- a/arch/x86/include/asm/crash.h
> +++ b/arch/x86/include/asm/crash.h
> @@ -9,4 +9,24 @@ int crash_setup_memmap_entries(struct kimage *image,
>  		struct boot_params *params);
>  void crash_smp_send_stop(void);
>  
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
> +#define arch_map_crash_pages arch_map_crash_pages
> +
> +void arch_unmap_crash_pages(void **ptr);
> +#define arch_unmap_crash_pages arch_unmap_crash_pages
> +
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action, unsigned int cpu);
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
>  #endif /* _ASM_X86_CRASH_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..55dda4fcde6e 100644
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
> @@ -397,7 +398,17 @@ int crash_load_segments(struct kimage *image)
>  	image->elf_headers = kbuf.buffer;
>  	image->elf_headers_sz = kbuf.bufsz;
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);

Do we need to break the line to 80 chars?

> +	/* For marking as usable to crash kernel */
> +	image->elf_headers_sz = kbuf.memsz;

Do we need this code comment?

> +	/* Record the index of the elfcorehdr segment */
> +	image->elfcorehdr_index = image->nr_segments;

And this place?

> +	image->elfcorehdr_index_valid = true;
> +#else
>  	kbuf.memsz = kbuf.bufsz;
> +#endif
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +423,107 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	/*
> +	 * NOTE: The addresses and sizes passed to this routine have
> +	 * already been fully aligned on page boundaries. There is no
> +	 * need for massaging the address or size.
> +	 */

Can we move the code comment above function interface?

> +	void *ptr = NULL;
> +
> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */

Do we need this code comment? On ARCH where proctionion is made, we
surely need to the protect/unprotect.

> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap_local_page(page);
> +	}
> +
> +	return ptr;
> +}
> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap_local(*ptr);
> +		*ptr = NULL;
> +	}
> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
> + *
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories. The new
> + * elfcorehdr is prepared in a kernel buffer, and then it is
> + * written on top of the existing/old elfcorehdr.
> + *
> + * For hotplug changes to elfcorehdr to work, two conditions are
> + * needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources. See the
> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).

Isn't this generic concept to crash hotplug? Should we move it out to
some generic place?

> + *
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +	unsigned int hp_action, unsigned int cpu)

The passed in 'cpu' is not used at all, what is it added for? I didn't
see explanation about it.

> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;
> +
> +	/*
> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
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
> +		goto out;
> +	}
> +	if (elfsz > memsz) {
> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * At this point, we are all but assured of success.
> +	 * Copy new elfcorehdr into destination.
> +	 */
> +	ptr = arch_map_crash_pages(mem, memsz);
> +	if (ptr) {
> +		/*
> +		 * Temporarily invalidate the crash image while the
> +		 * elfcorehdr is updated.
> +		 */
> +		xchg(&kexec_crash_image, NULL);
> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
> +		xchg(&kexec_crash_image, image);
> +	}
> +	arch_unmap_crash_pages((void **)&ptr);
> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
> +
> +out:
> +	if (elfbuf)
> +		vfree(elfbuf);
> +}
> +#endif
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
