Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9FBCA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heJ7vs8qi7FCBhFgjivs3CstwBqPqnYF+4xZvvvUvMw=; b=oZWQMRQVUMHtlQUSIscfr8+/eO
	trjkDQ118UqPtvN8lV//7dQY1ynPtkeXq/vIVVW4ARJWHeP4/39s7aXg8qpQFNkbbKWq2s+tAmSmi
	rA2Y5oWkKZDdRgVYcgMGMYf1/uxpRcVUilpiwIEjY70jAHyr9CiCeD1woe4Ngvu1dYdShQ4c3QQsZ
	aW42s7Ii5m7wigrm+bLn6aD2zHgWdzX/ow5EPP5e1pZSk+V0kD9Awf6Cr0lt+KmINx+RwPPJ5aSVz
	fRwC7QExhO7LCJVHDmchpN1cbr5QX4lELxmXfDJ5cxSGf2ooNDeseyxZODUlQ2GJl60gf5aHG37Qp
	bdojXbFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uodnP-0000000CfgH-2aKb;
	Wed, 20 Aug 2025 08:03:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoceQ-0000000CXQf-2HID
	for kexec@bombadil.infradead.org;
	Wed, 20 Aug 2025 06:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=heJ7vs8qi7FCBhFgjivs3CstwBqPqnYF+4xZvvvUvMw=; b=Tr/EBbjMFyeL5qsDsRQitsWucs
	p6mxEJmOqScudRS5BUwISnV4rdzJ9z3g0c1Wlm0KbY4COqJsyt5QAEQ8IjlEBm3fS+ioiNJ5Hig73
	FJnnxMnxU1VFZfN5YNvPD2ZiysfdfFQ+WlrvHTSWKvMfot+4lj6eTzoVx2T0Ey3flvv/K7YQK0KKY
	bfXExcRiC6SJThi7EeH8qr5Oi07TLND6bgz90UoIu4GClDj9n/gIBgPj5Zw1ilmnZiH+zhUjCJnDu
	6Ey4fcno7iFY1Zj3XjhY8mYjcMXv6wZx6wR5mk05QxxndRIStA2ENeQL0xVSYT+H2P89M0JaxddaN
	vNT9JBlA==;
Received: from layka.disroot.org ([178.21.23.139])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoceN-00000000DKI-0cDV
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 06:50:25 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 941A125EFA;
	Wed, 20 Aug 2025 08:50:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fau3ZIC3Npm; Wed, 20 Aug 2025 08:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755672619; bh=wQ8qM95j2gviU1QGJ8rgqDjbocACb6XZzCLsLaODwvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtEHQMRlQ8rFrMqm+LHFQT49TgwWd3va36RPDXBR7xncfCUX10XX4FyWdzKwgt6Lb
	 18LHJZDgky6OaiFfnAxm1KsLWsuTLYCJMqN1Ka2i+xv/shW19/KB2f390u4GIJGm08
	 S77rKKia+72cEmXCIQZkGcrFoWlHBTUuOsqEnUuzaoSCIxwMZJe4e714jmv/SOZ6Ft
	 CRrDb7oKPNGVKhCnefHSoPsp2KvbmCz034WIhxcsZRQBKwu138knkFNElpCtGtkJA0
	 y5o7Ly4URMwyHxBOe9gDM4SraJtw3I2FDSFgZMEOfpCiYDQ5FnuiKYyLRC223Miyak
	 7qjAWxmVGmABw==
Date: Wed, 20 Aug 2025 06:50:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <aKVwHOM9KNEpUZF4@pie>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820055700.24344-3-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_075023_371778_81E494F5 
X-CRM114-Status: GOOD (  34.76  )
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

On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> This patch adds support for kexec_file on LoongArch.
> 
> The efi_kexec_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
> 
> This initrd will be passed to the second kernel via the command line
> 'initrd=start,size'.
> 
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> but ELF format is not supported.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   9 ++
>  arch/loongarch/include/asm/image.h         |  17 +++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
>  7 files changed, 289 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

...

> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
> index 1f090736e71d..655d5836c4e8 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,22 @@ struct loongarch_image_header {
>  	uint32_t pe_header;
>  };
>  
> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
> +
> +/**
> + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
> + *
> + * Returns non-zero if 'MZ' signature is found.
> + */
> +
> +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
> +{
> +	if (!h)
> +		return 0;
> +
> +	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
> +		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
> +}

This check is still too weak and doesn't improve comparing to v1.

> This could be simplified with a memcmp(). Also, this check isn't
> strict enough: PE files for any architectures, and even legacy MS-DOS
> COM executables all start with "MZ".

I've pointed this out in my previous reply[1].

>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IMAGE_H */

...

> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> new file mode 100644
> index 000000000000..7741f1139a12
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_efi.c

...

> +static void *efi_kexec_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct loongarch_image_header *h;
> +	struct kexec_buf kbuf;
> +	unsigned long text_offset, kernel_segment_number;
> +	struct kexec_segment *kernel_segment;
> +	int ret;
> +
> +	h = (struct loongarch_image_header *)kernel;
> +	if (!h->image_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Load the kernel */
> +	kbuf.image = image;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_min = text_offset;
> +	kbuf.buf_align = SZ_2M;
> +
> +	kernel_segment_number = image->nr_segments;
> +
> +	/*
> +	 * The location of the kernel segment may make it impossible to satisfy
> +	 * the other segment requirements, so we try repeatedly to find a
> +	 * location that will work.
> +	 */
> +	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> +		/* Try to load additional data */
> +		kernel_segment = &image->segment[kernel_segment_number];
> +		ret = load_other_segments(image, kernel_segment->mem,
> +					  kernel_segment->memsz, initrd,
> +					  initrd_len, cmdline, cmdline_len);
> +		if (!ret)
> +			break;
> +
> +		/*
> +		 * We couldn't find space for the other segments; erase the
> +		 * kernel segment and try the next available hole.
> +		 */
> +		image->nr_segments -= 1;
> +		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	}
> +
> +	if (ret) {
> +		pr_err("Could not find any suitable kernel location!");
> +		return ERR_PTR(ret);
> +	}
> +
> +	kernel_segment = &image->segment[kernel_segment_number];
> +
> +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
> +	image->start = kernel_segment->mem + h->kernel_entry - text_offset;

And this still assumes the loaded, secondary kernel is relocatable,
with neither extra check nor comment explaining its limitation.

Please see my previous reply[2] that explains why loading a
non-relocatble kernel with kexec_file API is reasonable.

> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		      kernel_segment->mem, kbuf.bufsz,
> +		      kernel_segment->memsz);
> +
> +	return NULL;
> +}
> +
> +const struct kexec_file_ops kexec_efi_ops = {
> +	.probe = efi_kexec_probe,
> +	.load = efi_kexec_load,
> +};

Thanks,
Yao Zi

[1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
[2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/

