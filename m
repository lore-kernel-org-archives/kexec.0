Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B52CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wOd4ROZwm7BeDiBuMReM/u+siX5soAh1GCkzxj14EIk=; b=DrNIDeKzk65Hn0mZ/dOFZ4VYyu
	MkYZOlNW9DAxxvG/jcHsgNC8re//Xer++UIJn1b08FIVivezuA8P+4br97SpftpRYiG7WJMZ6U8TU
	xyJ48UZh4650OjFqWOGFrE+YiRY2ym8or81L+3hKi7w7tUwP35vyNiN+hS3j92RSyv0vnRiXQ7qe8
	2cGIQJkjJ2eX5akF3vF/tcq3CRTCueD7n/1S/lksO5+CareNr8APcDQQVCQ3S5SGMCJ7kCfuOapKP
	BxUN5yAMwPAhz9tJ+9SzIbxjZ3BwhOYAzalROSPnp7qHJFopZSrQl9i0oAqrHy9nzql4SQVpAiukW
	Kk3uJ/4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uohEo-0000000DSIi-0VP7;
	Wed, 20 Aug 2025 11:44:18 +0000
Received: from layka.disroot.org ([178.21.23.139])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoglg-0000000DL9z-2J1G
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 11:14:14 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5130625F01;
	Wed, 20 Aug 2025 13:14:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CawIejir6Qjv; Wed, 20 Aug 2025 13:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755688446; bh=fAE4LeP4gRVZJ56ceko6LYfRClFNY4XpOfAEuCT1suI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1Dbi2/MVbcei9TDGKMu5fu9PDUvQafoXB7k54QMkJ/zvH9kRf2TsqC1qG4gAyWtd
	 5EUM+/JXs3pMX8m4c/OX2xsBGcowxoRVsNYiwSo5MyuUkP3J7Fcs4AtGVqDMto1VLu
	 SQNvXcq2mPLHG8OhoXtIS/Le6lQUnBaieokE3avFJQ+zBbifnwBrAmCSoKZz36Gyj6
	 4TLzipuHQ601yyTOJoPXdomvO/lmblFiFJ43zP/DAmCwV6rtVQWspTXiuAuhQGSHia
	 gf6DTfWlo3c8/fmedJV4490xTVIUet9zGAkoEBbB6pbVFxcOuiXvxF8AAA8HWQd8EY
	 6FuuF7vNL+aEg==
Date: Wed, 20 Aug 2025 11:13:47 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <aKWt63S_wD3zeMYU@pie>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev>
 <aKVwHOM9KNEpUZF4@pie>
 <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_041413_147195_4C3B0EAB 
X-CRM114-Status: GOOD (  50.71  )
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

On Wed, Aug 20, 2025 at 05:13:27PM +0800, Youling Tang wrote:
> Hi, Yao
> 
> On 2025/8/20 14:50, Yao Zi wrote:
> 
> > On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > This patch adds support for kexec_file on LoongArch.
> > > 
> > > The efi_kexec_load() as two parts:
> > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > - the second part loads other segments (eg: initrd, cmdline)
> > > 
> > > This initrd will be passed to the second kernel via the command line
> > > 'initrd=start,size'.
> > > 
> > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> > > but ELF format is not supported.
> > > 
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > ---
> > >   arch/loongarch/Kconfig                     |   9 ++
> > >   arch/loongarch/include/asm/image.h         |  17 +++
> > >   arch/loongarch/include/asm/kexec.h         |  12 +++
> > >   arch/loongarch/kernel/Makefile             |   1 +
> > >   arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
> > >   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > >   arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
> > >   7 files changed, 289 insertions(+), 11 deletions(-)
> > >   create mode 100644 arch/loongarch/kernel/kexec_efi.c
> > >   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> > ...
> > 
> > > diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
> > > index 1f090736e71d..655d5836c4e8 100644
> > > --- a/arch/loongarch/include/asm/image.h
> > > +++ b/arch/loongarch/include/asm/image.h
> > > @@ -36,5 +36,22 @@ struct loongarch_image_header {
> > >   	uint32_t pe_header;
> > >   };
> > > +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
> > > +
> > > +/**
> > > + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
> > > + *
> > > + * Returns non-zero if 'MZ' signature is found.
> > > + */
> > > +
> > > +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
> > > +{
> > > +	if (!h)
> > > +		return 0;
> > > +
> > > +	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
> > > +		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
> > > +}
> > This check is still too weak and doesn't improve comparing to v1.
> > 
> > > This could be simplified with a memcmp(). Also, this check isn't
> > > strict enough: PE files for any architectures, and even legacy MS-DOS
> > > COM executables all start with "MZ".
> > I've pointed this out in my previous reply[1].
> Previously, I had considered adding a specific LoongArch magic
> number (such as "Loongson") in the loongarch_image_header, but
> this is incompatible with older versions of the kernel, so it
> remains the same without further checks.

All PE images ship a PE signature with offset 0x3c[1] and you could
locate the PE header[2] by the offset provided by
loongarch_image_header.pe_header and check its machine field[3], which
should be 0x6264 for 64-bit LoongArch executables and 0x6232 for 32-bit
ones. At least this ensures it's a LoongArch kernel image.

> > >   #endif /* __ASSEMBLY__ */
> > >   #endif /* __ASM_IMAGE_H */
> > ...
> > 
> > > diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
> > > new file mode 100644
> > > index 000000000000..7741f1139a12
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/kexec_efi.c
> > ...
> > 
> > > +static void *efi_kexec_load(struct kimage *image,
> > > +				char *kernel, unsigned long kernel_len,
> > > +				char *initrd, unsigned long initrd_len,
> > > +				char *cmdline, unsigned long cmdline_len)
> > > +{
> > > +	struct loongarch_image_header *h;
> > > +	struct kexec_buf kbuf;
> > > +	unsigned long text_offset, kernel_segment_number;
> > > +	struct kexec_segment *kernel_segment;
> > > +	int ret;
> > > +
> > > +	h = (struct loongarch_image_header *)kernel;
> > > +	if (!h->image_size)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	/* Load the kernel */
> > > +	kbuf.image = image;
> > > +	kbuf.buf_max = ULONG_MAX;
> > > +	kbuf.top_down = false;
> > > +
> > > +	kbuf.buffer = kernel;
> > > +	kbuf.bufsz = kernel_len;
> > > +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > +	kbuf.memsz = le64_to_cpu(h->image_size);
> > > +	text_offset = le64_to_cpu(h->text_offset);
> > > +	kbuf.buf_min = text_offset;
> > > +	kbuf.buf_align = SZ_2M;
> > > +
> > > +	kernel_segment_number = image->nr_segments;
> > > +
> > > +	/*
> > > +	 * The location of the kernel segment may make it impossible to satisfy
> > > +	 * the other segment requirements, so we try repeatedly to find a
> > > +	 * location that will work.
> > > +	 */
> > > +	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
> > > +		/* Try to load additional data */
> > > +		kernel_segment = &image->segment[kernel_segment_number];
> > > +		ret = load_other_segments(image, kernel_segment->mem,
> > > +					  kernel_segment->memsz, initrd,
> > > +					  initrd_len, cmdline, cmdline_len);
> > > +		if (!ret)
> > > +			break;
> > > +
> > > +		/*
> > > +		 * We couldn't find space for the other segments; erase the
> > > +		 * kernel segment and try the next available hole.
> > > +		 */
> > > +		image->nr_segments -= 1;
> > > +		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
> > > +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> > > +	}
> > > +
> > > +	if (ret) {
> > > +		pr_err("Could not find any suitable kernel location!");
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	kernel_segment = &image->segment[kernel_segment_number];
> > > +
> > > +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
> > > +	image->start = kernel_segment->mem + h->kernel_entry - text_offset;
> > And this still assumes the loaded, secondary kernel is relocatable,
> > with neither extra check nor comment explaining its limitation.
> > 
> > Please see my previous reply[2] that explains why loading a
> > non-relocatble kernel with kexec_file API is reasonable.
> LoongArch is a non-position independent (non-PIE) kernel when
> the RELOCATABLE option is not enabled, the kernel contains certain
> instructions such as la.abs, which prevent it from being relocated to
> arbitrary memory addresses for execution. As a result, limitations
> exist that make features like kdump or kexec_file dependent on
> the RELOCATABLE option.
> 
> Strictly speaking, we need to add additional checks: if the kernel is
> non-relocatable, the loading operation should fail directly.

Agree.

> For a
> running kernel, we can easily determine this by calling
> kallsyms_lookup_name("relocate_kernel"). However, for a kernel
> that is being loaded but has not yet started execution, it is difficult
> to easily determine whether the currently loaded kernel has the
> RELOCATABLE configuration option enabled.

I understand the difficulty, thus IMHO a comment is helpful here to
remind the reader of lack of relocatability checks.

Best regards,
Yao Zi

> For ELF format images, we can determine whether the loaded image
> contains the ".la_abs" section in the following way:
> static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
> {
>         struct mem_shdr *shdr, *shdr_end;
>         unsigned char *strtab;
> 
>         strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
>         shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
>         for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
>                 if (shdr->sh_size &&
>                         strcmp((char *)&strtab[shdr->sh_name], ".la_abs") ==
> 0) {
>                         return shdr;
>                 }
>         }
> 
>         return NULL;
> }
> 
> Thanks,
> Youling.
> > 
> > > +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > > +		      kernel_segment->mem, kbuf.bufsz,
> > > +		      kernel_segment->memsz);
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +const struct kexec_file_ops kexec_efi_ops = {
> > > +	.probe = efi_kexec_probe,
> > > +	.load = efi_kexec_load,
> > > +};
> > Thanks,
> > Yao Zi
> > 
> > [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
> > [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/
> 

[1]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#signature-image-only
[2]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#coff-file-header-object-and-image
[3]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#machine-types

