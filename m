Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648D4C4332F
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+/yVmR8kZuNMnRsMIBfTCgeuhqS4dcIsDK3oWEExBoo=; b=iP1CfKzCxayJnq
	EXj+d1xQ75sPZBrvCbLutmzxd39pjlkI2+bmWc0gkSuRJOsJV6Rxp1ZhqdzHmSY1AMH1YiIHVgBm/
	Wj8xMlnlJ9CkxLxJq9fx7GabtSXrmop1vZKRO8A7Oj+a31jIEeEtYn9j7+OZI2Nf+3D+EBvBPqzlf
	rtD3O6e/pkbUJrbh5QYEA3fY9iTJZ7tWy87BzGVPVuUC4OJAJmjkynHvNYthN48mg63QekJ9ZTtr7
	WxpDFbgEF7+WamOSCytmXjU9VupwOLIH2FyaYLyF9SrSx7SicfRAyi+76hVVtDDbljidl2ZxrJr8d
	UDI9DIPCOQDmenwFrSbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD0p0-008LKr-2M; Wed, 04 Jan 2023 10:16:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCzln-007udx-Fm
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 09:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672823350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WN89MJjCwknaqCXAnQNz+cH4SbGTgMKetTVEG8R1/tI=;
	b=R6meCJfDTmqsecxWC0lqLUxadtvdqrCygT6xHw7IbTOz4K+xYo3GFdx1V61jBbIxbJ6Ysa
	tM/pIMQPeN6PlslzLhzyRTXj19a/yYi0ptIFnMNgveF0sHQzBNoBFbQN/hc5wC8AtvX/3h
	8Bd2UGiUnCVNlNq08uxTPv7hXpQvMls=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-6Jg9EXBaO52_gmnY01AXbQ-1; Wed, 04 Jan 2023 04:09:06 -0500
X-MC-Unique: 6Jg9EXBaO52_gmnY01AXbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F5283C0E441;
	Wed,  4 Jan 2023 09:09:06 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3B31121314;
	Wed,  4 Jan 2023 09:09:04 +0000 (UTC)
Date: Wed, 4 Jan 2023 17:08:55 +0800
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
Subject: Re: [PATCH v15 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7VCJ4QvBIYNnF0b@MiWiFi-R3L-srv>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221209153656.3284-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_010911_865226_2A755F42 
X-CRM114-Status: GOOD (  27.51  )
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

On 12/09/22 at 10:36am, Eric DeVolder wrote:
...... snip out
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..5186df48ce6c 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -42,6 +42,21 @@
>  #include <asm/crash.h>
>  #include <asm/cmdline.h>
>  
> +/*
> + * For the kexec_file_load() syscall path, specify the maximum number of
> + * memory regions that the elfcorehdr buffer/segment can accommodate.
> + * These regions are obtained via walk_system_ram_res(); eg. the
> + * 'System RAM' entries in /proc/iomem.
> + * This value is combined with NR_CPUS_DEFAULT and multiplied by
> + * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
> + * segment size.
> + * The value 8192, for example, covers a (sparsely populated) 1TiB system
> + * consisting of 128MiB memblocks, while resulting in an elfcorehdr
> + * memory buffer/segment size under 1MiB. This represents a sane choice
> + * to accommodate both baremetal and virtual machine configurations.
> + */
> +#define CRASH_MAX_MEMORY_RANGES 8192
> +
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
>  	struct boot_params *params;
> @@ -394,10 +409,39 @@ int crash_load_segments(struct kimage *image)
>  	if (ret)
>  		return ret;
>  
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {

Do I miss anything important during reviewing? I can't see why memory
hotplug is also relying on HOTPLUG_CPU.

> +		/*
> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +		 * Start with VMCOREINFO and kernel_map.
> +		 */
> +		unsigned long pnum = 2;
> +
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +			pnum += CONFIG_NR_CPUS_DEFAULT;
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +			pnum += CRASH_MAX_MEMORY_RANGES;
> +
> +		if (pnum < (unsigned long)PN_XNUM) {
> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> +			kbuf.memsz += sizeof(Elf64_Ehdr);
> +
> +			image->elfcorehdr_index = image->nr_segments;
> +			image->elfcorehdr_index_valid = true;
> +
> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +			image->elf_headers_sz = kbuf.memsz;
> +		} else {
> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +		}
> +	}
> +#endif
>  
> -	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +456,67 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + *
> + * To accurately reflect hot un/plug changes, the new elfcorehdr
> + * is prepared in a kernel buffer, and then it is written on top
> + * of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image)
> +{
> +	void *elfbuf = NULL, *old_elfcorehdr;
> +	unsigned long mem, memsz;
> +	unsigned long elfsz = 0;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("unable to prepare elfcore headers");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Obtain address and size of the elfcorehdr segment, and
> +	 * check it against the new elfcorehdr buffer.
> +	 */
> +	mem = image->segment[image->elfcorehdr_index].mem;
> +	memsz = image->segment[image->elfcorehdr_index].memsz;
> +	if (elfsz > memsz) {
> +		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> +	 */
> +	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +	if (old_elfcorehdr) {
> +		pr_err("updating elfcorehdr failed\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Temporarily invalidate the crash image while the
> +	 * elfcorehdr is updated.
> +	 */
> +	xchg(&kexec_crash_image, NULL);
> +	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
> +	xchg(&kexec_crash_image, image);
> +	kunmap_local(old_elfcorehdr);
> +	pr_debug("updated elfcorehdr\n");
> +
> +out:
> +	vfree(elfbuf);
> +}
> +#endif
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
