Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E1ECA1009
	for <kexec@archiver.kernel.org>; Mon,  1 Sep 2025 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/ehgPorLwkznPzF2cjKS9QmtvHCNweSP/UH3tCDEq0=; b=LzmrqnGWwCck9riLAC6fOEP7ev
	YScFv0RxlffQxC83TM2pnws5Wh8Yde0uVvPbdG2+E4nIoa8+bqG0YX0Gsi3rzL7i81FJx0DO1T47h
	/Wr/AUAwjZ5Gtqpwk5OpN19TucihxIEfy+Gqy1jbCX9BclV290efW1Xx3+swEs+pHwn8tZYEYYole
	pGE/CkhhSbZ9W72js9rheIEWWx9+jlMTSFr6v4UeT4eKFqZUfljmoLJUXawX2ZpnS4TJtnqGBWvO/
	g6gwQUndXmWBNMXUZT3oZ9sFm6pj7/rxpq9hleNVxXnc6I8O6+QqKEHp00ctChuHGP6SANF0Gy8zK
	HwdpCGzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut8gB-0000000DUxN-05Yw;
	Mon, 01 Sep 2025 17:50:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5Yq-0000000CqQb-3kaM
	for kexec@bombadil.infradead.org;
	Mon, 01 Sep 2025 14:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=c/ehgPorLwkznPzF2cjKS9QmtvHCNweSP/UH3tCDEq0=; b=bSH5cUkOKHQEhFSFfQgs0E40Yy
	n6F1GCHr9J9Q03DIrmxEu6NTrJfYeiW7qBjqAr2SsHpyn1/pNcU9tQpCT+fkaIbQhiquggFu0FysA
	hI2FdLplopF+M6OoVE+4BsYuVHD9wSaU9D/C8VTVd4BJG9gr1y1u3AdSH8Tsp2UbihBa2PEbZw12l
	4WkgZ3XvOIR9xsjHMm53JgshxepRE0gH1pAz4AjnJTsXcD6w0KMpsZKt9PVvPATeUtqOb+7gXPPXx
	WTEpkhQqqvHT+T0YuaG+26Kp8tg6RqmFclP523oQn1SxYFlIiIFeXaYjR1l3WI98IbE+iAH9aEQbd
	Flgt8oBw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut5Yn-00000003lql-2ZiT
	for kexec@lists.infradead.org;
	Mon, 01 Sep 2025 14:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/ehgPorLwkznPzF2cjKS9QmtvHCNweSP/UH3tCDEq0=;
	b=iX0Pzj5g1sRSFzSDLO9AqKIwO4mYpl/7L8Mk7g0OXwl+29fbq5BT04HLKoV4RSro8BZ3gq
	6oZR60j8VnwPznKfNM9hwWpEgweuQB+n4T95waSckWFtTeIUzivZjP5PZQ0pgoZzM+e7Na
	QgVUCjaf5qZg0kR6tOOhKtQt8k779LU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/ehgPorLwkznPzF2cjKS9QmtvHCNweSP/UH3tCDEq0=;
	b=gjvG9voU5dydjMfNlduGDNeyVqbXuN9iD3gx/QQwobMRStv1dtx0Swp9VbjLEwVYZ5KGEE
	dMwT5EKToyWGZ8VxTAoUHrJPzc3Rv16ef9J3YGMXevmjme68u25vOEGmg/iCDocXp0Yxj8
	E7P0iSVIWYivv+xkUUiwSWu25py411g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-MgFctwObMyCS6zfbiIHLxw-1; Mon,
 01 Sep 2025 10:30:41 -0400
X-MC-Unique: MgFctwObMyCS6zfbiIHLxw-1
X-Mimecast-MFC-AGG-ID: MgFctwObMyCS6zfbiIHLxw_1756737035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21D44195E90B;
	Mon,  1 Sep 2025 14:30:34 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FE57180029C;
	Mon,  1 Sep 2025 14:30:23 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:30:20 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 05/12] kexec: Introduce kexec_pe_image to parse and
 load PE file
Message-ID: <20250901163020.30ce3c1e@rotkaeppchen>
In-Reply-To: <20250819012428.6217-6-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250819012428.6217-6-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_153106_005146_E3818510 
X-CRM114-Status: GOOD (  46.84  )
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

Hi Pingfan,

a few nits in addition to what is mentioned in the cover letter.

On Tue, 19 Aug 2025 09:24:21 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> As UEFI becomes popular, a few architectures support to boot a PE format
> kernel image directly. But the internal of PE format varies, which means
> each parser for each format.
> 
> This patch (with the rest in this series) introduces a common skeleton
> to all parsers, and leave the format parsing in
> bpf-prog, so the kernel code can keep relative stable.
> 
> A new kexec_file_ops is implementation, named pe_image_ops.
> 
> There are some place holder function in this patch. (They will take
> effect after the introduction of kexec bpf light skeleton and bpf
> helpers). Overall the parsing progress is a pipeline, the current
> bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
> end of the current stage 'disarm_bpf_prog()' the current parsed result
> by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
> , and deliver to the next stage.  For each stage, the bpf bytecode is
> extracted from the '.bpf' section in the PE file.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec@lists.infradead.org
> ---
>  include/linux/kexec.h   |   1 +
>  kernel/Kconfig.kexec    |   9 ++
>  kernel/Makefile         |   1 +
>  kernel/kexec_pe_image.c | 348 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 359 insertions(+)
>  create mode 100644 kernel/kexec_pe_image.c

[...]

> new file mode 100644
> index 0000000000000..b0cf9942e68d2
> --- /dev/null
> +++ b/kernel/kexec_pe_image.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec PE image loader
> +
> + * Copyright (C) 2025 Red Hat, Inc
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +#include <asm/memory.h>
> +
> +
> +#define KEXEC_RES_KERNEL_NAME "kexec:kernel"
> +#define KEXEC_RES_INITRD_NAME "kexec:initrd"
> +#define KEXEC_RES_CMDLINE_NAME "kexec:cmdline"
> +
> +struct kexec_res {
> +	char *name;
> +	/* The free of buffer is deferred to kimage_file_post_load_cleanup */
> +	struct mem_range_result *r;
> +};
> +
> +static struct kexec_res parsed_resource[3] = {
> +	{ KEXEC_RES_KERNEL_NAME, },
> +	{ KEXEC_RES_INITRD_NAME, },
> +	{ KEXEC_RES_CMDLINE_NAME, },
> +};
> +
> +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
> +
> +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	struct mz_hdr *mz;
> +	struct pe_hdr *pe;
> +
> +	if (!kernel_buf)
> +		return false;
> +	mz = (struct mz_hdr *)kernel_buf;
> +	if (mz->magic != IMAGE_DOS_SIGNATURE)
> +		return false;
> +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
> +	if (pe->magic != IMAGE_NT_SIGNATURE)
> +		return false;
> +	if (pe->opt_hdr_size == 0) {
> +		pr_err("optional header is missing\n");
> +		return false;
> +	}
> +
> +	return pe_has_bpf_section(kernel_buf, kernel_len);
> +}

Also check for 
pe32plus_opt_hdr->subsys == IMAGE_SUBSYSTEM_EFI_APPLICATION?

> +
> +static bool is_valid_format(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	return is_valid_pe(kernel_buf, kernel_len);
> +}
> +
> +/*
> + * The UEFI Terse Executable (TE) image has MZ header.
> + */
> +static int pe_image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;
> +}
> +
> +static int pe_get_section(const char *file_buf, const char *sect_name,
> +		char **sect_start, unsigned long *sect_sz)
> +{
> +	struct pe_hdr *pe_hdr;
> +	struct pe32plus_opt_hdr *opt_hdr;
> +	struct section_header *sect_hdr;
> +	int section_nr, i;
> +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> +
> +	*sect_start = NULL;
> +	*sect_sz = 0;
> +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> +	section_nr = pe_hdr->sections;
> +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + sizeof(struct pe_hdr));
> +	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
> +
> +	for (i = 0; i < section_nr; i++) {
> +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> +			*sect_start = (char *)file_buf + sect_hdr->data_addr;
> +			*sect_sz = sect_hdr->raw_data_size;
> +			return 0;
> +		}
> +		sect_hdr++;
> +	}
> +
> +	return -1;
> +}
> +
> +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
> +{
> +	char *sect_start = NULL;
> +	unsigned long sect_sz = 0;
> +	int ret;
> +
> +	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
> +	if (ret < 0)
> +		return false;
> +	return true;
> +}
> +
> +/* Load a ELF */
> +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> +{
> +	return 0;
> +}
> +
> +static void disarm_bpf_prog(void)
> +{
> +}
> +
> +struct kexec_context {
> +	bool kdump;
> +	char *image;
> +	int image_sz;
> +	char *initrd;
> +	int initrd_sz;
> +	char *cmdline;
> +	int cmdline_sz;
> +};
> +
> +void bpf_handle_pefile(struct kexec_context *context);
> +void bpf_post_handle_pefile(struct kexec_context *context);
> +
> +
> +/*
> + * optimize("O0") prevents inline, compiler constant propagation
> + */
> +__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struct kexec_context *context)
> +{
> +	/*
> +	 * To prevent linker from Identical Code Folding (ICF) with bpf_handle_pefile,
> +	 * making them have different code.
> +	 */
> +	volatile int dummy = 0;
> +
> +	dummy += 1;
> +}
> +
> +__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_context *context)
> +{
> +	volatile int dummy = 0;
> +
> +	dummy += 2;
> +}
> +
> +/*
> + * PE file may be nested and should be unfold one by one.
> + * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> + * next phase.
> + */
> +static int prepare_nested_pe(char **kernel, unsigned long *kernel_len, char **initrd,
> +		unsigned long *initrd_len, char **cmdline)
> +{
> +	struct kexec_res *res;
> +	int ret = -1;
> +
> +	*kernel = NULL;
> +	*kernel_len = 0;
> +
> +	res = &parsed_resource[0];
> +	if (!!res->r) {
> +		*kernel = res->r->buf;
> +		*kernel_len = res->r->data_sz;
> +		ret = 0;
> +	}
> +
> +	res = &parsed_resource[1];
> +	if (!!res->r) {
> +		*initrd = res->r->buf;
> +		*initrd_len = res->r->data_sz;
> +	}
> +
> +	res = &parsed_resource[2];
> +	if (!!res->r) {
> +		*cmdline = res->r->buf;
> +	}
> +
> +	return ret;
> +}
> +
> +static void *pe_image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
> +	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;

I don't see a point in defining all the
{linux,initrd,cmdline}_{start,sz} variables. Either you could reuse
the corresponding {kernel,initrd,cmdline} variables from the function
definition. Or better use a kexec_context that contains the same
information.

> +	struct kexec_res *res;
> +	struct mem_range_result *r;
> +	void *ldata;
> +	int ret;
> +
> +	linux_start = kernel;
> +	linux_sz = kernel_len;
> +	initrd_start = initrd;
> +	initrd_sz = initrd_len;
> +	cmdline_start = cmdline;
> +	cmdline_sz = cmdline_len;
> +
> +	while (is_valid_format(linux_start, linux_sz) &&
> +	       pe_has_bpf_section(linux_start, linux_sz)) {
> +		struct kexec_context context;
> +
> +		pe_get_section((const char *)linux_start, ".bpf", &bpf_start, &bpf_sz);
> +		if (!!bpf_sz) {
> +			/* load and attach bpf-prog */
> +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> +			if (ret) {
> +				pr_err("Fail to load .bpf section\n");
> +				ldata = ERR_PTR(ret);
> +				goto err;
> +			}
> +		}
> +		if (image->type != KEXEC_TYPE_CRASH)
> +			context.kdump = false;
> +		else
> +			context.kdump = true;

The bpf_prog cannot change whether kexec is used to load a kdump or
normal kernel. So this check can be moved outside the loop.

> +		context.image = linux_start;
> +		context.image_sz = linux_sz;
> +		context.initrd = initrd_start;
> +		context.initrd_sz = initrd_sz;
> +		context.cmdline = cmdline_start;
> +		context.cmdline_sz = strlen(cmdline_start);
> +		/* bpf-prog fentry, which handle above buffers. */
> +		bpf_handle_pefile(&context);
> +
> +		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
> +					&initrd_sz, &cmdline_start);
> +		/* bpf-prog fentry */
> +		bpf_post_handle_pefile(&context);
> +		/*
> +		 * detach the current bpf-prog from their attachment points.
> +		 */
> +		disarm_bpf_prog();
> +	}
> +
> +	/*
> +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> +	 * be updated to the new content.
> +	 */
> +
> +	res = &parsed_resource[0];
> +	/* Kernel part should always be parsed */
> +	if (!res->r) {
> +		pr_err("Can not parse kernel\n");
> +		ldata = ERR_PTR(-EINVAL);
> +		goto err;
> +	}
> +	kernel = res->r->buf;
> +	kernel_len = res->r->data_sz;
> +	vfree(image->kernel_buf);
> +	image->kernel_buf = kernel;
> +	image->kernel_buf_len = kernel_len;

Can't you assign the output to image->kernel_buf{_len} directly? Same
for initrd and cmdline.

> +
> +	res = &parsed_resource[1];
> +	if (!!res->r) {
> +		initrd = res->r->buf;
> +		initrd_len = res->r->data_sz;
> +		vfree(image->initrd_buf);
> +		image->initrd_buf = initrd;
> +		image->initrd_buf_len = initrd_len;
> +	}
> +	res = &parsed_resource[2];
> +	if (!!res->r) {
> +		cmdline = res->r->buf;
> +		cmdline_len = res->r->data_sz;
> +		kfree(image->cmdline_buf);
> +		image->cmdline_buf = cmdline;
> +		image->cmdline_buf_len = cmdline_len;
> +	}
> +
> +	if (kernel == NULL || initrd == NULL || cmdline == NULL) {
> +		char *c, buf[64];
> +
> +		c = buf;
> +		if (kernel == NULL) {
> +			strcpy(c, "kernel ");
> +			c += strlen("kernel ");
> +		}
> +		if (initrd == NULL) {
> +			strcpy(c, "initrd ");
> +			c += strlen("initrd ");
> +		}
> +		if (cmdline == NULL) {
> +			strcpy(c, "cmdline ");
> +			c += strlen("cmdline ");
> +		}
> +		c = '\0';
> +		pr_err("Can not extract data for %s", buf);
> +		ldata = ERR_PTR(-EINVAL);
> +		goto err;
> +	}

This check needs to go. Not having a initrd or cmdline is not an error
plus not having a kernel already throws an error above. In case you
want to keep the error message for debugging purpose you can add it to
the 'else' paths above.

> +
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret) {
> +		pr_err("Fail to find suitable image loader\n");
> +		ldata = ERR_PTR(ret);
> +		goto err;
> +	}
> +	ldata = kexec_image_load_default(image);
> +	if (IS_ERR(ldata)) {
> +		pr_err("architecture code fails to load image\n");
> +		goto err;
> +	}
> +	image->image_loader_data = ldata;
> +
> +err:
> +	for (int i = 0; i < 3; i++) {

Can you please get rid of the magic '3', e.g. by using ARRAY_SIZE.

Thanks
Philipp

> +		r = parsed_resource[i].r;
> +		if (!r)
> +			continue;
> +		parsed_resource[i].r = NULL;
> +		/*
> +		 * The release of buffer defers to
> +		 * kimage_file_post_load_cleanup()
> +		 */
> +		r->buf = NULL;
> +		r->buf_sz = 0;
> +		mem_range_result_put(r);
> +	}
> +
> +	return ldata;
> +}
> +
> +const struct kexec_file_ops kexec_pe_image_ops = {
> +	.probe = pe_image_probe,
> +	.load = pe_image_load,
> +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> +	.verify_sig = kexec_kernel_verify_pe_sig,
> +#endif
> +};


