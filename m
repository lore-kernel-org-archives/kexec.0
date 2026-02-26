Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDF3FCE07F
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xa0ZfxYyv4zHUToxsERixm69ne0BA2dtlNERxeC8jao=; b=CJxRp0kUUWPWrfrmr3oZ73AkWl
	LK/jW3WuRoyR42PF9zzyNQll2duSjTIiPDsQ88uQgBDmRKpKldBqLOcJxUNvTDDIChEHoGK0X9CuF
	zlSlExfn3tUq/cjGxhJYS7WOd28UoYCfeqUJVDhdlU47gS87vpx5Bg92PzL7tj0TWDdTcQLp09Y/F
	mLCIx94i0YEHlK3HtK9tbL3yuHxDYFarRNL5xZFAhJPhbLGWaJOeeVojPwbNLpHfhyR4MAoIEVL/c
	6riXbt1bXXputuM1KKJ7RNFVdrONdnEFGzRVrVl+/ei/3ebFXxWtWhgG665T2Aiu6TAcws5gUDOpm
	MZGjXmSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbZC-00000006EVI-2mpw;
	Thu, 26 Feb 2026 13:38:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbZ9-00000006EUn-2m37
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 13:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772113085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xa0ZfxYyv4zHUToxsERixm69ne0BA2dtlNERxeC8jao=;
	b=FKu/5Gm0EyoV7goVpe4iOv1mOSSQsxJdh/SL83oGH5vZZF8I7w21wT6k9f6EL+gn0h1t1B
	YpyjEGaeKH8DoPc7BlVdXSQzEgjVlv0GzgR4R5nasAnmM1sSmKvh1Aq3eeVtf/F68sQ1uc
	lD24nPqGGY1HsRK2tw2RubrU00fgVJI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-oW_UghdSNl6lrqpHzPoquA-1; Thu,
 26 Feb 2026 08:38:01 -0500
X-MC-Unique: oW_UghdSNl6lrqpHzPoquA-1
X-Mimecast-MFC-AGG-ID: oW_UghdSNl6lrqpHzPoquA_1772113077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8206619560AD;
	Thu, 26 Feb 2026 13:37:56 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.44.32.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB86D3000218;
	Thu, 26 Feb 2026 13:37:47 +0000 (UTC)
Date: Thu, 26 Feb 2026 14:37:43 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
Message-ID: <20260226143743.7e963ba9@rotkaeppchen>
In-Reply-To: <20260119032424.10781-5-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
	<20260119032424.10781-5-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: DeI8zg1gRRo5hrAzHpdqdAw4pbzQ5VFONYqe0Jmlp9s_1772113077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_053807_776557_51D8706C 
X-CRM114-Status: GOOD (  30.53  )
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

On Mon, 19 Jan 2026 11:24:15 +0800
Pingfan Liu <piliu@redhat.com> wrote:

[...]

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> new file mode 100644
> index 0000000000000..dc59e1389da94
> --- /dev/null
> +++ b/kernel/kexec_bpf_loader.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image bpf section helpers
> + *
> + * Copyright (C) 2025, 2026 Red Hat, Inc
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
> +#include <linux/elf.h>
> +#include <linux/string.h>
> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +#include <asm/memory.h>
> +#include "kexec_internal.h"
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
> +	char *kernel;
> +	int kernel_sz;
> +	char *initrd;
> +	int initrd_sz;
> +	char *cmdline;
> +	int cmdline_sz;
> +};
> +
> +void kexec_image_parser_anchor(struct kexec_context *context,
> +		unsigned long parser_id);
> +
> +/*
> + * optimize("O0") prevents inline, compiler constant propagation
> + *
> + * Let bpf be the program context pointer so that it will not be spilled into
> + * stack.
> + */
> +__attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
> +		struct kexec_context *context,
> +		unsigned long parser_id)
> +{
> +	/*
> +	 * To prevent linker from Identical Code Folding (ICF) with kexec_image_parser_anchor,
> +	 * making them have different code.
> +	 */
> +	volatile int dummy = 0;
> +
> +	dummy += 1;
> +}
> +
> +
> +BTF_KFUNCS_START(kexec_modify_return_ids)
> +BTF_ID_FLAGS(func, kexec_image_parser_anchor, KF_SLEEPABLE)
> +BTF_KFUNCS_END(kexec_modify_return_ids)
> +
> +static const struct btf_kfunc_id_set kexec_modify_return_set = {
> +	.owner = THIS_MODULE,
> +	.set = &kexec_modify_return_ids,
> +};
> +
> +static int __init kexec_bpf_prog_run_init(void)
> +{
> +	return register_btf_fmodret_id_set(&kexec_modify_return_set);
> +}
> +late_initcall(kexec_bpf_prog_run_init);
> +
> +static int kexec_buff_parser(struct bpf_parser_context *parser)
> +{
> +	return 0;
> +}
> +
> +/* At present, only PE format file with .bpf section is supported */
> +#define file_has_bpf_section	pe_has_bpf_section
> +#define file_get_section	pe_get_section
> +
> +int decompose_kexec_image(struct kimage *image, int extended_fd)
> +{
> +	struct kexec_context context = { 0 };
> +	struct bpf_parser_context *bpf;
> +	unsigned long kernel_sz, bpf_sz;
> +	char *kernel_start, *bpf_start;
> +	int ret = 0;
> +
> +	if (image->type != KEXEC_TYPE_CRASH)
> +	        context.kdump = false;
> +	else
> +	        context.kdump = true;
> +
> +	kernel_start = image->kernel_buf;
> +	kernel_sz = image->kernel_buf_len;
> +
> +	while (file_has_bpf_section(kernel_start, kernel_sz)) {
> +
> +		bpf = alloc_bpf_parser_context(kexec_buff_parser, &context);
> +		if (!bpf)
> +			return -ENOMEM;
> +		file_get_section((const char *)kernel_start, ".bpf", &bpf_start, &bpf_sz);
> +		if (!!bpf_sz) {
> +			/* load and attach bpf-prog */
> +			ret = arm_bpf_prog(bpf_start, bpf_sz);
> +			if (ret) {
> +				put_bpf_parser_context(bpf);
> +				pr_err("Fail to load .bpf section\n");
> +				goto err;
> +			}
> +		}

I'm not sure this works as intended. In case a .bpf section exists but
bpf_sz is 0, the function will skip arming the bpf-prog but still
continue. That doesn't look right to me. IIUC a zero size bpf-prog
should be an error. Or am I missing something?

Thanks
Philipp

> +		context.kernel = kernel_start;
> +		context.kernel_sz = kernel_sz;
> +		/* bpf-prog fentry, which handle above buffers. */
> +		kexec_image_parser_anchor(&context, (unsigned long)bpf);
> +
> +		/*
> +		 * Container may be nested and should be unfold one by one.
> +		 * The former bpf-prog should prepare 'kernel', 'initrd',
> +		 * 'cmdline' for the next phase by calling kexec_buff_parser()
> +		 */
> +		kernel_start = context.kernel;
> +		kernel_sz = context.kernel_sz;
> +
> +		/*
> +		 * detach the current bpf-prog from their attachment points.
> +		 */
> +		disarm_bpf_prog();
> +		put_bpf_parser_context(bpf);
> +	}
> +
> +	/*
> +	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
> +	 * be updated to the new content.
> +	 */
> +	image->kernel_buf = context.kernel;
> +	image->kernel_buf_len = context.kernel_sz;
> +	image->initrd_buf = context.initrd;
> +	image->initrd_buf_len = context.initrd_sz;
> +	image->cmdline_buf = context.cmdline;
> +	image->cmdline_buf_len = context.cmdline_sz;
> +
> +	return 0;
> +err:
> +	vfree(context.kernel);
> +	vfree(context.initrd);
> +	vfree(context.cmdline);
> +	return ret;
> +}
> +
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0222d17072d40..f9674bb5bd8db 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -238,7 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		goto out;
>  #endif
>  
> -	/* Call arch image probe handlers */
> +	if (IS_ENABLED(CONFIG_KEXEC_BPF))
> +		decompose_kexec_image(image, initrd_fd);
> +
> +	/*
> +	 * From this point, the kexec subsystem handle the kernel boot protocol.
> +	 *
> +	 * Call arch image probe handlers
> +	 */
>  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>  					    image->kernel_buf_len);
>  	if (ret)
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 8e5e5c1237732..ee01d0c8bb377 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -39,6 +39,7 @@ extern size_t kexec_purgatory_size;
>  extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
>  extern int pe_get_section(const char *file_buf, const char *sect_name,
>  		char **sect_start, unsigned long *sect_sz);
> +extern int decompose_kexec_image(struct kimage *image, int extended_fd);
>  #else /* CONFIG_KEXEC_FILE */
>  static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
>  #endif /* CONFIG_KEXEC_FILE */


