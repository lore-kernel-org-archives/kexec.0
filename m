Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C1ACAC599
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9M0HY5vU9dfbX9REnWEbhEbNzjrF7Jv8rQDTMuCSe3Q=; b=mT0yZRDRmgpHs78qPW1LACPv45
	b0a/1dyh9ziO6hekguV6cmn0/IVpxoKG7GWRPe7LzMEnLdsrTDpgvKJRsdRxtc9AjcYA9lvlTcKxJ
	h28V0fwrmoggU/hvdeM8GjMIUh1XCnm0fuhnfLumu+nyVS7a/Pul2UBRfJIf6iQjTam8x2Hr2gIV6
	7WBWhia8IgbdpuuVqI2HJDbGv1hlDVQb8mZkZ4VewNDfwsjuz/JWtMJIGlIM+vbcbNkhgUbHZteMi
	WpFT8HsapnUGsp6/rs8i8XExTOEly6iE6WiJv4gGS7Fat33Jp+W2aq8BhlqMav4Od/459ahboFRf0
	iQ5ckgaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrq3-0000000BWc3-3mvC;
	Wed, 17 Sep 2025 13:04:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyrq1-0000000BWZR-2r0I
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 13:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9M0HY5vU9dfbX9REnWEbhEbNzjrF7Jv8rQDTMuCSe3Q=;
	b=KuDl0oXF0FBUkKEzWDM34ipC/LdQSks6RPqza7HPm6WgQ4GT3/GMPrCZL9OJY3w4k5aHAe
	W44kFXZ+27Y+kqcjho8oetuY6GnfDEoGV1aVrUO0owtK20oMB43kJkTjt4aeCMbrjhke01
	9vHbDMBQ1CWf3iargcZZG3QPeeCt0Tg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-_SJLiuuaMxmEsmTOKRCDtg-1; Wed,
 17 Sep 2025 09:04:38 -0400
X-MC-Unique: _SJLiuuaMxmEsmTOKRCDtg-1
X-Mimecast-MFC-AGG-ID: _SJLiuuaMxmEsmTOKRCDtg_1758114276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73886180057F;
	Wed, 17 Sep 2025 13:04:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC4001955F19;
	Wed, 17 Sep 2025 13:04:31 +0000 (UTC)
Date: Wed, 17 Sep 2025 21:04:28 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 05/12] kexec: Introduce kexec_pe_image to parse and
 load PE file
Message-ID: <aMqx3PLkYLp3FLOD@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-6-piliu@redhat.com>
 <20250901163020.30ce3c1e@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901163020.30ce3c1e@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_060445_865458_60A2D5DE 
X-CRM114-Status: GOOD (  57.97  )
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

On Mon, Sep 01, 2025 at 04:30:20PM +0200, Philipp Rudo wrote:
> Hi Pingfan,
> 
> a few nits in addition to what is mentioned in the cover letter.
> 

Besides the following comment, as we agree on your suggestion, many of
the logic in this file will be moved to kimage_file_prepare_segments().

> On Tue, 19 Aug 2025 09:24:21 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > As UEFI becomes popular, a few architectures support to boot a PE format
> > kernel image directly. But the internal of PE format varies, which means
> > each parser for each format.
> > 
> > This patch (with the rest in this series) introduces a common skeleton
> > to all parsers, and leave the format parsing in
> > bpf-prog, so the kernel code can keep relative stable.
> > 
> > A new kexec_file_ops is implementation, named pe_image_ops.
> > 
> > There are some place holder function in this patch. (They will take
> > effect after the introduction of kexec bpf light skeleton and bpf
> > helpers). Overall the parsing progress is a pipeline, the current
> > bpf-prog parser is attached to bpf_handle_pefile(), and detatched at the
> > end of the current stage 'disarm_bpf_prog()' the current parsed result
> > by the current bpf-prog will be buffered in kernel 'prepare_nested_pe()'
> > , and deliver to the next stage.  For each stage, the bpf bytecode is
> > extracted from the '.bpf' section in the PE file.
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  include/linux/kexec.h   |   1 +
> >  kernel/Kconfig.kexec    |   9 ++
> >  kernel/Makefile         |   1 +
> >  kernel/kexec_pe_image.c | 348 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 359 insertions(+)
> >  create mode 100644 kernel/kexec_pe_image.c
> 
> [...]
> 
> > new file mode 100644
> > index 0000000000000..b0cf9942e68d2
> > --- /dev/null
> > +++ b/kernel/kexec_pe_image.c
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Kexec PE image loader
> > +
> > + * Copyright (C) 2025 Red Hat, Inc
> > + */
> > +
> > +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/kexec.h>
> > +#include <linux/pe.h>
> > +#include <linux/string.h>
> > +#include <linux/bpf.h>
> > +#include <linux/filter.h>
> > +#include <asm/byteorder.h>
> > +#include <asm/image.h>
> > +#include <asm/memory.h>
> > +
> > +
> > +#define KEXEC_RES_KERNEL_NAME "kexec:kernel"
> > +#define KEXEC_RES_INITRD_NAME "kexec:initrd"
> > +#define KEXEC_RES_CMDLINE_NAME "kexec:cmdline"
> > +
> > +struct kexec_res {
> > +	char *name;
> > +	/* The free of buffer is deferred to kimage_file_post_load_cleanup */
> > +	struct mem_range_result *r;
> > +};
> > +
> > +static struct kexec_res parsed_resource[3] = {
> > +	{ KEXEC_RES_KERNEL_NAME, },
> > +	{ KEXEC_RES_INITRD_NAME, },
> > +	{ KEXEC_RES_CMDLINE_NAME, },
> > +};
> > +
> > +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
> > +
> > +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	struct mz_hdr *mz;
> > +	struct pe_hdr *pe;
> > +
> > +	if (!kernel_buf)
> > +		return false;
> > +	mz = (struct mz_hdr *)kernel_buf;
> > +	if (mz->magic != IMAGE_DOS_SIGNATURE)
> > +		return false;
> > +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);
> > +	if (pe->magic != IMAGE_NT_SIGNATURE)
> > +		return false;
> > +	if (pe->opt_hdr_size == 0) {
> > +		pr_err("optional header is missing\n");
> > +		return false;
> > +	}
> > +
> > +	return pe_has_bpf_section(kernel_buf, kernel_len);
> > +}
> 
> Also check for 
> pe32plus_opt_hdr->subsys == IMAGE_SUBSYSTEM_EFI_APPLICATION?
> 

Yes, it would be better.

> > +
> > +static bool is_valid_format(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	return is_valid_pe(kernel_buf, kernel_len);
> > +}
> > +
> > +/*
> > + * The UEFI Terse Executable (TE) image has MZ header.
> > + */
> > +static int pe_image_probe(const char *kernel_buf, unsigned long kernel_len)
> > +{
> > +	return is_valid_pe(kernel_buf, kernel_len) ? 0 : -1;
> > +}
> > +
> > +static int pe_get_section(const char *file_buf, const char *sect_name,
> > +		char **sect_start, unsigned long *sect_sz)
> > +{
> > +	struct pe_hdr *pe_hdr;
> > +	struct pe32plus_opt_hdr *opt_hdr;
> > +	struct section_header *sect_hdr;
> > +	int section_nr, i;
> > +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> > +
> > +	*sect_start = NULL;
> > +	*sect_sz = 0;
> > +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> > +	section_nr = pe_hdr->sections;
> > +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr + sizeof(struct pe_hdr));
> > +	sect_hdr = (struct section_header *)((char *)opt_hdr + pe_hdr->opt_hdr_size);
> > +
> > +	for (i = 0; i < section_nr; i++) {
> > +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> > +			*sect_start = (char *)file_buf + sect_hdr->data_addr;
> > +			*sect_sz = sect_hdr->raw_data_size;
> > +			return 0;
> > +		}
> > +		sect_hdr++;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz)
> > +{
> > +	char *sect_start = NULL;
> > +	unsigned long sect_sz = 0;
> > +	int ret;
> > +
> > +	ret = pe_get_section(file_buf, ".bpf", &sect_start, &sect_sz);
> > +	if (ret < 0)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +/* Load a ELF */
> > +static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void disarm_bpf_prog(void)
> > +{
> > +}
> > +
> > +struct kexec_context {
> > +	bool kdump;
> > +	char *image;
> > +	int image_sz;
> > +	char *initrd;
> > +	int initrd_sz;
> > +	char *cmdline;
> > +	int cmdline_sz;
> > +};
> > +
> > +void bpf_handle_pefile(struct kexec_context *context);
> > +void bpf_post_handle_pefile(struct kexec_context *context);
> > +
> > +
> > +/*
> > + * optimize("O0") prevents inline, compiler constant propagation
> > + */
> > +__attribute__((used, optimize("O0"))) void bpf_handle_pefile(struct kexec_context *context)
> > +{
> > +	/*
> > +	 * To prevent linker from Identical Code Folding (ICF) with bpf_handle_pefile,
> > +	 * making them have different code.
> > +	 */
> > +	volatile int dummy = 0;
> > +
> > +	dummy += 1;
> > +}
> > +
> > +__attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_context *context)
> > +{
> > +	volatile int dummy = 0;
> > +
> > +	dummy += 2;
> > +}
> > +
> > +/*
> > + * PE file may be nested and should be unfold one by one.
> > + * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> > + * next phase.
> > + */
> > +static int prepare_nested_pe(char **kernel, unsigned long *kernel_len, char **initrd,
> > +		unsigned long *initrd_len, char **cmdline)
> > +{
> > +	struct kexec_res *res;
> > +	int ret = -1;
> > +
> > +	*kernel = NULL;
> > +	*kernel_len = 0;
> > +
> > +	res = &parsed_resource[0];
> > +	if (!!res->r) {
> > +		*kernel = res->r->buf;
> > +		*kernel_len = res->r->data_sz;
> > +		ret = 0;
> > +	}
> > +
> > +	res = &parsed_resource[1];
> > +	if (!!res->r) {
> > +		*initrd = res->r->buf;
> > +		*initrd_len = res->r->data_sz;
> > +	}
> > +
> > +	res = &parsed_resource[2];
> > +	if (!!res->r) {
> > +		*cmdline = res->r->buf;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void *pe_image_load(struct kimage *image,
> > +				char *kernel, unsigned long kernel_len,
> > +				char *initrd, unsigned long initrd_len,
> > +				char *cmdline, unsigned long cmdline_len)
> > +{
> > +	char *linux_start, *initrd_start, *cmdline_start, *bpf_start;
> > +	unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
> 
> I don't see a point in defining all the
> {linux,initrd,cmdline}_{start,sz} variables. Either you could reuse
> the corresponding {kernel,initrd,cmdline} variables from the function
> definition. Or better use a kexec_context that contains the same
> information.
> 

OK, I will remove them.

> > +	struct kexec_res *res;
> > +	struct mem_range_result *r;
> > +	void *ldata;
> > +	int ret;
> > +
> > +	linux_start = kernel;
> > +	linux_sz = kernel_len;
> > +	initrd_start = initrd;
> > +	initrd_sz = initrd_len;
> > +	cmdline_start = cmdline;
> > +	cmdline_sz = cmdline_len;
> > +
> > +	while (is_valid_format(linux_start, linux_sz) &&
> > +	       pe_has_bpf_section(linux_start, linux_sz)) {
> > +		struct kexec_context context;
> > +
> > +		pe_get_section((const char *)linux_start, ".bpf", &bpf_start, &bpf_sz);
> > +		if (!!bpf_sz) {
> > +			/* load and attach bpf-prog */
> > +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> > +			if (ret) {
> > +				pr_err("Fail to load .bpf section\n");
> > +				ldata = ERR_PTR(ret);
> > +				goto err;
> > +			}
> > +		}
> > +		if (image->type != KEXEC_TYPE_CRASH)
> > +			context.kdump = false;
> > +		else
> > +			context.kdump = true;
> 
> The bpf_prog cannot change whether kexec is used to load a kdump or
> normal kernel. So this check can be moved outside the loop.
> 

Original, this assignment happens only if the file has valid bpf-prog,
which is the loop body. But I have no strong opinion about it. I can
declare context outside the loop as __maybe_unused.

> > +		context.image = linux_start;
> > +		context.image_sz = linux_sz;
> > +		context.initrd = initrd_start;
> > +		context.initrd_sz = initrd_sz;
> > +		context.cmdline = cmdline_start;
> > +		context.cmdline_sz = strlen(cmdline_start);
> > +		/* bpf-prog fentry, which handle above buffers. */
> > +		bpf_handle_pefile(&context);
> > +
> > +		prepare_nested_pe(&linux_start, &linux_sz, &initrd_start,
> > +					&initrd_sz, &cmdline_start);
> > +		/* bpf-prog fentry */
> > +		bpf_post_handle_pefile(&context);
> > +		/*
> > +		 * detach the current bpf-prog from their attachment points.
> > +		 */
> > +		disarm_bpf_prog();
> > +	}
> > +
> > +	/*
> > +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> > +	 * be updated to the new content.
> > +	 */
> > +
> > +	res = &parsed_resource[0];
> > +	/* Kernel part should always be parsed */
> > +	if (!res->r) {
> > +		pr_err("Can not parse kernel\n");
> > +		ldata = ERR_PTR(-EINVAL);
> > +		goto err;
> > +	}
> > +	kernel = res->r->buf;
> > +	kernel_len = res->r->data_sz;
> > +	vfree(image->kernel_buf);
> > +	image->kernel_buf = kernel;
> > +	image->kernel_buf_len = kernel_len;
> 
> Can't you assign the output to image->kernel_buf{_len} directly? Same
> for initrd and cmdline.
> 

OK.

> > +
> > +	res = &parsed_resource[1];
> > +	if (!!res->r) {
> > +		initrd = res->r->buf;
> > +		initrd_len = res->r->data_sz;
> > +		vfree(image->initrd_buf);
> > +		image->initrd_buf = initrd;
> > +		image->initrd_buf_len = initrd_len;
> > +	}
> > +	res = &parsed_resource[2];
> > +	if (!!res->r) {
> > +		cmdline = res->r->buf;
> > +		cmdline_len = res->r->data_sz;
> > +		kfree(image->cmdline_buf);
> > +		image->cmdline_buf = cmdline;
> > +		image->cmdline_buf_len = cmdline_len;
> > +	}
> > +
> > +	if (kernel == NULL || initrd == NULL || cmdline == NULL) {
> > +		char *c, buf[64];
> > +
> > +		c = buf;
> > +		if (kernel == NULL) {
> > +			strcpy(c, "kernel ");
> > +			c += strlen("kernel ");
> > +		}
> > +		if (initrd == NULL) {
> > +			strcpy(c, "initrd ");
> > +			c += strlen("initrd ");
> > +		}
> > +		if (cmdline == NULL) {
> > +			strcpy(c, "cmdline ");
> > +			c += strlen("cmdline ");
> > +		}
> > +		c = '\0';
> > +		pr_err("Can not extract data for %s", buf);
> > +		ldata = ERR_PTR(-EINVAL);
> > +		goto err;
> > +	}
> 
> This check needs to go. Not having a initrd or cmdline is not an error
> plus not having a kernel already throws an error above. In case you
> want to keep the error message for debugging purpose you can add it to
> the 'else' paths above.
> 

Ah, it is valid to have either initrd or cmdline as NULL in
kexec_file_load. I will remove this chunk regarding to the check on
kernel done.

> > +
> > +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > +					    image->kernel_buf_len);
> > +	if (ret) {
> > +		pr_err("Fail to find suitable image loader\n");
> > +		ldata = ERR_PTR(ret);
> > +		goto err;
> > +	}
> > +	ldata = kexec_image_load_default(image);
> > +	if (IS_ERR(ldata)) {
> > +		pr_err("architecture code fails to load image\n");
> > +		goto err;
> > +	}
> > +	image->image_loader_data = ldata;
> > +
> > +err:
> > +	for (int i = 0; i < 3; i++) {
> 
> Can you please get rid of the magic '3', e.g. by using ARRAY_SIZE.
> 

Yes.


Thank you for careful review.

Best Regards,

Pingfan

> Thanks
> Philipp
> 
> > +		r = parsed_resource[i].r;
> > +		if (!r)
> > +			continue;
> > +		parsed_resource[i].r = NULL;
> > +		/*
> > +		 * The release of buffer defers to
> > +		 * kimage_file_post_load_cleanup()
> > +		 */
> > +		r->buf = NULL;
> > +		r->buf_sz = 0;
> > +		mem_range_result_put(r);
> > +	}
> > +
> > +	return ldata;
> > +}
> > +
> > +const struct kexec_file_ops kexec_pe_image_ops = {
> > +	.probe = pe_image_probe,
> > +	.load = pe_image_load,
> > +#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> > +	.verify_sig = kexec_kernel_verify_pe_sig,
> > +#endif
> > +};
> 


