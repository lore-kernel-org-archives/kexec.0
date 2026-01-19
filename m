Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401B1CCF2F7
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=daRjYPvktAUimNvs8q3hMxnSVH4fnHMajUr2DzuSVtw=; b=uY/pSqOKVMq1QYG/P73L+sQkU/
	ayBsZsbfltOmIIphQSw14KNPWrmxlVLd4swc0501LuEAhNZEOeMaIamVsfZL2QbIR26mf2ZGUIGh3
	trqpD4kYERTxSY+5klz3QJuHH8UT3fsn5fLSbrodVb1rCNqnQV/OjTt7crjYfQv0OO7D5IGmfUsLT
	jwJuithSWj1UZxoAXRj9hE3DpdfhHViP3bRFQV9pl+vItu/4FdpZ2fgJSvrrsqEI89pzrhy4pa3M7
	Cm+lTRpcQL8m7ZC/eTbCXMPKH/S8+AxZHiqQYNFRNbRDdQRlxqyaYLaJzmziIbd4tpgpRUhBG7g1A
	F8NT2nuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG6-00000002jc9-2guU;
	Mon, 19 Jan 2026 18:45:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFy-00000002jX3-3wuZ
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6143F6014E;
	Mon, 19 Jan 2026 18:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDA0C19422;
	Mon, 19 Jan 2026 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848342;
	bh=ZTIje7WATkqMH4x3QflgRA4cjG+o9UVX2c4ymxmpl3U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ih+ATkmj3i3VhCFeNiT4Y2CJPVXo70WyKD6Vin9NZlO8KqGVvlHTWAycM7p8YysDR
	 656miIoTVZ3EMb2QYzDhcvWF5381V6SYBjoSLG3dRzfv0Hq+0zOIbbGdyEBlKUwhSO
	 lngsH3Yg7FAnghAWusJXGuEKuX0+mkMy/AE7ifP+SyYkjIbjb6chaXUdAWMHVjRhSp
	 j3LXgX6EYJ6KnKfD5LiRNwgQHK04xFbkXsvNtJ4uugZtDXHwDSPBa7Hg0BlfmhaO3W
	 3VWhLfWqqjNKW0naKnOB0XUuR8Lr1rptN/XADkcaqJNEN2nMbXXYovJ/54M1OkpWbJ
	 j/YOvAav+3vVg==
Content-Type: multipart/mixed; boundary="===============2133534859589085953=="
MIME-Version: 1.0
Message-Id: <7509e4d1cd0a1a8a0f2b1a33c8a1f503e7275c826f9fc138e8cb2f12c4add8ec@mail.kernel.org>
In-Reply-To: <20260119032424.10781-5-piliu@redhat.com>
References: <20260119032424.10781-5-piliu@redhat.com>
Subject: Re: [PATCHv6 04/13] kexec_file: Use bpf-prog to decompose image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:41 +0000 (UTC)
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

--===============2133534859589085953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> new file mode 100644
> index 000000000000..dc59e1389da9
> --- /dev/null
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +struct kexec_context {
> +	bool kdump;
> +	char *kernel;
> +	int kernel_sz;
> +	char *initrd;
> +	int initrd_sz;
> +	char *cmdline;
> +	int cmdline_sz;
> +};

The *_sz fields here are int, but image->kernel_buf_len and related fields
are unsigned long. Could this cause truncation issues for buffers larger
than INT_MAX?

[ ... ]

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

With the placeholder arm_bpf_prog/disarm_bpf_prog functions that do nothing,
if an image has a .bpf section, won't this loop iterate forever? The BPF
program is supposed to modify context.kernel to point to the inner content,
but without a real implementation, context.kernel stays unchanged after
kexec_image_parser_anchor() returns.

Note: commit 59dbdff4e55b ("kexec_file: Integrate bpf light skeleton to load
image with bpf-prog") later in the series fills in these placeholders.

> +		bpf = alloc_bpf_parser_context(kexec_buff_parser, &context);
> +		if (!bpf)
> +			return -ENOMEM;

[ ... ]

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

When the kernel image has no .bpf section, the while loop never executes.
In that case, context.kernel remains NULL (from the zero initializer), and
these lines set image->kernel_buf = NULL, image->kernel_buf_len = 0.

This appears to leak the original image->kernel_buf that was allocated by
kernel_read_file_from_fd() in kimage_file_prepare_segments(). The subsequent
arch_kexec_kernel_image_probe() call then receives NULL instead of the valid
kernel buffer.

Should there be a check to preserve the original buffers when no
decomposition occurred?

> +
> +	return 0;

[ ... ]

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0222d17072d4..f9674bb5bd8d 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -238,7 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		goto out;
>  #endif
>
> +	if (IS_ENABLED(CONFIG_KEXEC_BPF))
> +		decompose_kexec_image(image, initrd_fd);

The return value of decompose_kexec_image() is ignored here. If it returns
an error (e.g., -ENOMEM from alloc_bpf_parser_context()), the function
continues with potentially corrupted state instead of propagating the error.

Should this check the return value and goto out on failure?

> +
> +	/*
> +	 * From this point, the kexec subsystem handle the kernel boot protocol.
> +	 *
> +	 * Call arch image probe handlers
> +	 */
>  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>  					    image->kernel_buf_len);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============2133534859589085953==--

