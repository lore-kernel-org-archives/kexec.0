Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A682CA0EC4
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2PEviXU4VMU9vchhHOeuueMf4bEGGK7/S0g3kjTegg=; b=zEiEeb5q88NiMfEQ0WrIY7dlQT
	mPjldHqPsta+SZp/wc48RT9LBa1vP3Glt/+lVXtrzDaAuP3tJJpBblwI5GNvfnqxXid2gpsUbqv9D
	1r3cn5dL38pA71vI4ieKsGZitG+58JwexAz90+eKaGNegMyNmk93dwU9SAti9f+tkdPvlfRFGxlBf
	MVl/1ywJmJe8JUhcwPZUeLUgvw4IDkPZBBUCvYsSrCz1u4g6n1eyP58Z/a8Dinbcbo8WS0iahmeq7
	DfA0tzs/ABNKxLYxckiofdpRAIoO0PV7ApTDSkn7vJJEdEpVX+Cleeo5XdvCxJuJSbyQio3sdPYGC
	c4w9lx+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulabg-00000009B2P-2ouL;
	Mon, 11 Aug 2025 22:03:04 +0000
Received: from layka.disroot.org ([178.21.23.139])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulW1D-00000008VzG-2qRk
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 17:09:09 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1F6E425F79;
	Mon, 11 Aug 2025 19:09:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5y_AmtIzRja; Mon, 11 Aug 2025 19:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754932000; bh=fiqNW/iR9qCKHprF3oK6zQCfVI1mPKazrm5svXl7oM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxtL5WGrHK8P26FbuUNzQfeYUPcsZXpVZpbrmKoSvkz3QSd95+G19A/Gm9H3+v6tg
	 dRR0PdWp+datoqA+sIrcOAsIGTFJ9204Q+ghyCNcwOqnKnQHf4k55mnqpBHNcqBc4S
	 oX1gSCZedNDG9xCp1a+slHAjKDZXmAxLsdff2sCHpJ9ktWLKgQg9PQxJYFJJPItPzO
	 34a+eY6h1AS4YB4jpA6FL2V6EFQOuniTz/7hMs79p3NT7ijsr88KGO3L3iiwr6pAJD
	 2NCTpHiav6HqR1AYzgteHjFWNpaZj5Ke/tVTbQb+fVXGSLXEHSTC90KMXl0uWh789i
	 tRcnUmW7mOECA==
Date: Mon, 11 Aug 2025 17:06:22 +0000
From: Yao Zi <ziyao@disroot.org>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJojDiHWi8cgvA2W@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092659.14903-3-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_100907_990285_7E7AF0CF 
X-CRM114-Status: GOOD (  41.63  )
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

On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> This patch adds support for kexec_file on LoongArch.
> 
> The image_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
> 
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> but ELF format is not supported.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   8 ++
>  arch/loongarch/include/asm/image.h         |  18 ++++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>  7 files changed, 219 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_image.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

...

> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
> index 1f090736e71d..829e1ecb1f5d 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>  	uint32_t pe_header;
>  };
>  
> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
> +static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};

loongarch_pe_machtype isn't used at all.

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

This could be simplified with a memcmp(). Also, this check isn't strict
enough: PE files for any architectures, and even legacy MS-DOS COM
executables all start with "MZ".

> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IMAGE_H */

...

> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..fdd1845b4e2e
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_image.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image loader for LoongArch
> +
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +#include <asm/cpufeature.h>
> +#include <asm/image.h>
> +
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct loongarch_image_header *h =
> +		(const struct loongarch_image_header *)(kernel_buf);

Parentheses around "kernel_buf" are unnecessary.

> +	if (!h || (kernel_len < sizeof(*h))) {

Comparisons have higher priority than logic operations, so this pair of
parentheses is redundant, too.

> +		pr_err("No loongarch image header.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!loongarch_header_check_pe_sig(h)) {
> +		pr_err("Bad loongarch PE image header.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
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
> +	kbuf.buf_min = 0;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	text_offset = le64_to_cpu(h->text_offset);
> +	kbuf.buf_align = SZ_2M;

I think this aligment is unnecessary for relocatable LoongArch kernels:
it should be enough to align to the page size. See also my comments
below.

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

A non-relocatable loongarch kernel cannot be loaded to arbitrary
address. Thus this loading function seems to only work for relocatable
kernels, maybe it's better to leave a comment indicating the limitation.

For now, we don't seem to have a way to find out whether the kernel is
relocatable (for example, a flag in kernel image header), so it's
impossible to point out whether the loaded kernel boots fine with
arbitrary loading address...

> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +		      kernel_segment->mem, kbuf.bufsz,
> +		      kernel_segment->memsz);
> +
> +	return NULL;
> +}
> +
> +const struct kexec_file_ops kexec_image_ops = {
> +	.probe = image_probe,
> +	.load = image_load,
> +};
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> index f9381800e291..008f43e26120 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)

...

> -	if (!kimage->arch.cmdline_ptr) {
> -		pr_err("Command line not included in the provided image\n");
> -		return -EINVAL;
> +		if (!kimage->arch.cmdline_ptr) {
> +			pr_err("Command line not included in the provided image\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	/* kexec/kdump need a safe page to save reboot_code_buffer */
> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>  	local_irq_disable();
>  
>  	pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> -	pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> +	pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> +	pr_notice("Command line at %s\n", (char *)cmdline_ptr);

The printed message doesn't match meaning of the pointer: you're
printing the content of cmdline_ptr, instead of its address, thus
"Command line at" sounds confusing to me.

Furthermore, this chunk isn't related to "support for kexec_file", I
think it's better to separate it into another patch (or even another
series).

>  	pr_notice("System table at 0x%lx\n", systable_ptr);
>  	pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>  	pr_notice("Bye ...\n");

Best regards,
Yao Zi

