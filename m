Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80086CA0EEB
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hAJlHDvRqPXZP6gjpMtCItfPezDjP3bZ9+iZXylcguQ=; b=OCQefbHGd2l/M52nxfz1DnhIAl
	yluq8Pcvo5THpMnXa4UUwSnNUQixL59XTB1UoNDyC06y+q5x2/q9f/YeUy9u3hfdwf50C+UhsNZcI
	C6POBDjAsttqhTSAlQduizbgAULS/DynrFRfKAspyPD8+W+mEcFZqtTiFC0+YELRcbhWUimt/QB9h
	OCzl8aaKd2AgHvuzJ5h6hsl7bqgcM0cFjs1GNbyr7XIkR4ZLzSj50wujptbzMU7/FmnlTPxMOIpvM
	YhIgIml734OwXMnAshPsDM2AGKZ19xhAPIHxsSBXUX9HBjhXdCuCyu4nGISda8Key/pSlngrNzGBP
	RZAyKufw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up1ln-0000000GQCj-11Mo;
	Thu, 21 Aug 2025 09:39:43 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uozWG-0000000G4ZA-2oWI
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 07:15:35 +0000
Message-ID: <284a663f-3bdd-4dcc-b017-b1b3fe6d9eb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755760526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAJlHDvRqPXZP6gjpMtCItfPezDjP3bZ9+iZXylcguQ=;
	b=knxq+tVimd9IbWYeagAu12XA+IPT9X5xTur4GrkRgf067Tk/mT3o5S0OPrDr0B1l9PKhga
	52EcIZ52FIgtIwgx/QZTcynLtOlcpA+PLTsRbTdL4qA9kjrvZFC9x1RW5a3riqeJWzp5Qz
	OKJI161XwmCJRjhiLChhKQj4WusaqA4=
Date: Thu, 21 Aug 2025 15:14:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] LoongArch/kexec_file: Support loading ELF binary
 file
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 Yao Zi <ziyao@disroot.org>, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-4-youling.tang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-4-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_001533_450145_C706CEF2 
X-CRM114-Status: GOOD (  33.45  )
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

On 2025/8/20 13:56, Youling Tang wrote:

> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patch creates kexec_elf_ops to load ELF binary file
> for kexec_file_load() syscall.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   arch/loongarch/Kconfig                     |   1 +
>   arch/loongarch/include/asm/kexec.h         |   1 +
>   arch/loongarch/kernel/Makefile             |   2 +-
>   arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++++++++++++++
>   arch/loongarch/kernel/machine_kexec_file.c |   1 +
>   5 files changed, 109 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/kernel/kexec_elf.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 490dc6eed749..bf2664ed7ce3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -632,6 +632,7 @@ config ARCH_SELECTS_KEXEC_FILE
>   	def_bool y
>   	depends on KEXEC_FILE
>   	select HAVE_IMA_KEXEC if IMA
> +	select KEXEC_ELF
>   	select RELOCATABLE
>   
>   config ARCH_SUPPORTS_CRASH_DUMP
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
> index 34799db933fb..fecfb3015abc 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -43,6 +43,7 @@ struct kimage_arch {
>   
>   #ifdef CONFIG_KEXEC_FILE
>   extern const struct kexec_file_ops kexec_efi_ops;
> +extern const struct kexec_file_ops kexec_elf_ops;
>   
>   int arch_kimage_file_post_load_cleanup(struct kimage *image);
>   #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index dd6183f353e6..001924877772 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -62,7 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
>   obj-$(CONFIG_RELOCATABLE)	+= relocate.o
>   
>   obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
> -obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o
> +obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o kexec_elf.o
>   obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>   
>   obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
> diff --git a/arch/loongarch/kernel/kexec_elf.c b/arch/loongarch/kernel/kexec_elf.c
> new file mode 100644
> index 000000000000..d41ee5fd7cef
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_elf.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Load ELF vmlinux file for the kexec_file_load syscall.
> + *
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(ELF): " fmt
> +
> +#include <linux/elf.h>
> +#include <linux/kexec.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/memblock.h>
> +#include <asm/image.h>
> +#include <asm/setup.h>
> +
> +static int loongarch_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
> +			 struct kexec_elf_info *elf_info,
> +			 struct kexec_buf *kbuf,
> +			 unsigned long *text_offset)
> +{
> +	int ret = -1;
> +	size_t i;
> +
> +	/* Read in the PT_LOAD segments. */
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		size_t size;
> +		const struct elf_phdr *phdr;
> +		struct loongarch_image_header *header;
> +
> +		phdr = &elf_info->proghdrs[i];
> +		if (phdr->p_type != PT_LOAD)
> +			continue;
> +
> +		size = phdr->p_filesz;
> +		if (size > phdr->p_memsz)
> +			size = phdr->p_memsz;
> +
> +		kbuf->buffer = (void *)elf_info->buffer + phdr->p_offset;
> +		kbuf->bufsz = size;
> +		kbuf->buf_align = phdr->p_align;
> +		header = (struct loongarch_image_header *)kbuf->buffer;
> +		*text_offset = le64_to_cpu(header->text_offset);
> +		kbuf->buf_min = *text_offset;
> +		kbuf->memsz = le64_to_cpu(header->image_size);
Elf kernel resolution should not be used to struct loongarch_image_header,
members of the content contained in the inner world of CONFIG_EFI_STUB in
the arch/loongarch/kernel/head.S, should use the content inside the elf
header information, The kexec-tools tool should also be fixed.

However, there is certain content in the elf header information, and the
general kexec_elf_load() function cannot be used. Special processing of
kbuf->memsz and kbuf->memsz is required.

$ readelf -l vmlinux
...
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags Align
   LOAD           0x0000000000010000 0x9000000000200000 0x9000000000200000
                  0x0000000002747a00 0x000000000287a0d8  RWE 0x10000
   NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                  0x0000000000000000 0x0000000000000000  R      0x8

phdr->p_paddr should have been a physical address, but it is a virtual
address on the current LoongArch. This will cause kexec_file to fail
when loading the kernel and need to be converted to a physical address.
Another patch is working to fix this issue[1].

 From the above MemSiz, it can be seen that 0x287a0d8 has not been aligned.
Although kexec_add_buffer() will perform PAGE_SIZE alignment on kbuf->memsz,
there is still a stampeding in the loaded kernel space and initrd space.
The initrd resolution failed when starting the second kernel.

It can be known from the link script vmlinux.lds.S that,
    BSS_SECTION(0, SZ_64K, 8)
    . = ALIGN(PECOFF_SEGMENT_ALIGN);

It needs to be aligned according to the SZ_64K size, so that after 
alignment,
its size is consistent with _kernel_asize 
(loongarch_image_header->image_size).

The following modifications will be used in the next version to fix it，

--- a/arch/loongarch/kernel/kexec_elf.c
+++ b/arch/loongarch/kernel/kexec_elf.c
@@ -28,7 +28,6 @@ static int loongarch_kexec_elf_load(struct kimage 
*image, struct elfhdr *ehdr,
         for (i = 0; i < ehdr->e_phnum; i++) {
                 size_t size;
                 const struct elf_phdr *phdr;
-               struct loongarch_image_header *header;

                 phdr = &elf_info->proghdrs[i];
                 if (phdr->p_type != PT_LOAD)
@@ -41,10 +40,9 @@ static int loongarch_kexec_elf_load(struct kimage 
*image, struct elfhdr *ehdr,
                 kbuf->buffer = (void *)elf_info->buffer + phdr->p_offset;
                 kbuf->bufsz = size;
                 kbuf->buf_align = phdr->p_align;
-               header = (struct loongarch_image_header *)kbuf->buffer;
-               *text_offset = le64_to_cpu(header->text_offset);
-               kbuf->buf_min = *text_offset;
-               kbuf->memsz = le64_to_cpu(header->image_size);
+               *text_offset = __pa(phdr->p_paddr);
+               kbuf->buf_min = _*text_offset;
+               kbuf->memsz = ALIGN(phdr->p_memsz, SZ_64K);
                 kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;

[1]: 
https://lore.kernel.org/loongarch/00651F3A-6649-4C69-B365-352C8D323902@flygoat.com/T/#t

Thanks,
Youling.
> +		kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
> +		ret = kexec_add_buffer(kbuf);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> +			    unsigned long kernel_len, char *initrd,
> +			    unsigned long initrd_len, char *cmdline,
> +			    unsigned long cmdline_len)
> +{
> +	int ret;
> +	unsigned long text_offset = 0, kernel_segment_number;
> +	struct elfhdr ehdr;
> +	struct kexec_elf_info elf_info;
> +	struct kexec_segment *kernel_segment;
> +	struct kexec_buf kbuf;
> +
> +	ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Load the kernel */
> +	kbuf.image = image;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kernel_segment_number = image->nr_segments;
> +
> +	ret = loongarch_kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &text_offset);
> +	if (ret)
> +		goto out;
> +
> +	/* Load additional data */
> +	kernel_segment = &image->segment[kernel_segment_number];
> +	ret = load_other_segments(image, kernel_segment->mem, kernel_segment->memsz,
> +				  initrd, initrd_len, cmdline, cmdline_len);
> +	if (ret)
> +		goto out;
> +
> +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
> +	image->start = kernel_segment->mem + __pa(ehdr.e_entry) - text_offset;
> +
> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		      kernel_segment->mem, kbuf.bufsz, kernel_segment->memsz);
> +
> +out:
> +	kexec_free_elf_info(&elf_info);
> +	return ret ? ERR_PTR(ret) : NULL;
> +}
> +
> +const struct kexec_file_ops kexec_elf_ops = {
> +	.probe = kexec_elf_probe,
> +	.load  = elf_kexec_load,
> +};
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index a713acf32db8..dc6e37457559 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -22,6 +22,7 @@
>   
>   const struct kexec_file_ops * const kexec_file_loaders[] = {
>   	&kexec_efi_ops,
> +	&kexec_elf_ops,
>   	NULL
>   };
>   

