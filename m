Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76268109448C
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xERLiFunLRNb8lbLEdTuH1ic+4aHz0LjEa5KLiwdylQ=; b=u0RYrZDWegkvD58jUveCEJ9XKU
	Bsd1q3r53QDEuKwPfMnesfHJ1G9rxwAKLKcd9dws38fDzLpP2S2YujOCVBcSUpd1k7DysCi9+fz6R
	Oh/cnEIUdxXLwKZhdi9yxypkxj+VJKaSy2rV5MpEbuv5M/aRIp+C+8MiJyxKiKfcncSP4UPbBkMhn
	ho/6mGFxdF8Ot8iJKMFQm5vzXcPPnqQmNHV319DntIm1TMa/YN2jSUTw34JJV9CHswYEGCqiND3JL
	geI8RebsjLzVm2P8wSit9nPUaCo/KeCF/LsihCBN1VbZ/iINg6mLj2JyS7Mhrl2sk2PBi7JqN2WbI
	FL1uvyfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kn-0000000EyZq-0Jim;
	Sun, 22 Mar 2026 02:14:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kj-0000000EyX3-4AuY
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:14:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADDEA44545;
	Sun, 22 Mar 2026 02:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06289C19421;
	Sun, 22 Mar 2026 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145669;
	bh=KM27ZStv54d4ev0F7eUGi5mKasxRcuFt8w61iI2z5fg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oxUq1vhpeCZwtX+7Kq7V3QSY/lojQ+xfQP0pcoqot5QvXw7dV/4rDeQc4Fmrmz261
	 bTZRS/mvj5oQHnT1L/FgCE9DX2A6ylnaoFZyYsiDjfmbgFI++GWJJSx0li5dtrXa5X
	 f0jRGsbVhjksG7iR8ZJ5iQ/zXJFt54xyL9EPHQ8vBKj0YCKmycjTCIHilcxZgai7+2
	 lPD9Ojg6dtgDhgW+9MiZnpR8YqmnhoYSyM12LtNBNchwxx9hOLrbge4ALx9VWZnKrZ
	 pCfOGXtBQiPGyUYRLbuTQsK2Fs44b/oZRUcxkKk0JdHwZhVoK8nqoF68AHgYNQj68b
	 rrPtttxnisexQ==
Content-Type: multipart/mixed; boundary="===============8611594194516260872=="
MIME-Version: 1.0
Message-Id: <08c0a3bb712e08a8889996a1e4e8c4539eb02a393e237d67e3179364c054fddc@mail.kernel.org>
In-Reply-To: <20260322014402.8815-3-piliu@redhat.com>
References: <20260322014402.8815-3-piliu@redhat.com>
Subject: Re: [PATCHv7 02/13] kexec_file: Use bpf-prog to decompose image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:29 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_191430_086390_D64D52F8 
X-CRM114-Status: GOOD (  18.99  )
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

--===============8611594194516260872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> new file mode 100644
> index 000000000000..bd1800a76782
> --- /dev/null
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +#include <asm/memory.h>
> +#include "kexec_internal.h"

Are asm/image.h and asm/memory.h needed here?  I could not find any
symbols from either header used in this file.  asm/image.h only exists
for arm64, loongarch, and riscv, and asm/memory.h only for arm, arm64,
and csky.

Since CONFIG_KEXEC_BPF has no architecture dependency, enabling it on
x86 would cause a build failure from these missing headers.

[ ... ]

> +static int process_bpf_parsers_container(const char *elf_buf, size_t elf_sz,
> +				   struct kexec_context *context, int depth)
> +{

[ ... ]

> +		/*
> +		 * Give the BPF prog a clean slate so context->parsed reliably
> +		 * reflects whether *this* invocation succeeded.
> +		 */
> +		context->parsed = false;
> +		/* This is the hook point for bpf-prog */
> +		kexec_image_parser_anchor(context, (unsigned long)bpf);
> +		disarm_bpf_prog();
> +
> +		/* Free the old parsing context, and reload the new */
> +		for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +			if (!!context->parsing_buf[i])
> +				break;
> +			vfree(context->parsing_buf[i]);
> +			context->parsing_buf[i] = NULL;
> +			context->parsing_buf_sz[i] = 0;
> +		}

The comment says "free the old parsing context" but the condition
appears inverted.  !!context->parsing_buf[i] is true when the pointer
is non-NULL, so the loop breaks at the first populated entry and only
calls vfree() on NULL pointers (which is a no-op).

Should this be if (!context->parsing_buf[i]) instead?

[ ... ]

> +int decompose_kexec_image(struct kimage *image, int extended_fd)
> +{
> +	struct kexec_context ctx = { 0 };
> +	unsigned long parser_sz;
> +	char *parser_start;
> +	int ret = -EINVAL;

[ ... ]

> +	if (!validate_elf_bpf_sections(parser_start, parser_sz)) {
> +
> +		ret = kernel_read_file_from_fd(extended_fd,
> +						0,
> +						(void **)&ctx.parsing_buf[0],
> +						KEXEC_FILE_SIZE_MAX,
> +						NULL,
> +						0);
> +		if (ret < 0) {
> +			pr_err("Fail to read image container\n");
> +			return -EINVAL;
> +		}
> +		ctx.parsing_buf_sz[0] = ret;
> +		ret = process_bpf_parsers_container(parser_start, parser_sz, &ctx, 0);
> +		if (!ret) {
> +			char *p;
> +
> +			/* Envelop should hold valid kernel, initrd, cmdline sections */
> +			if (!ctx.kernel || !ctx.initrd || !ctx.cmdline) {
> +				vfree(ctx.kernel);
> +				vfree(ctx.initrd);
> +				vfree(ctx.cmdline);
> +				return -EINVAL;
> +			}

[ ... ]

> +		}
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}

When process_bpf_parsers_container() fails, or when the
!ctx.kernel || !ctx.initrd || !ctx.cmdline check triggers,
ctx.parsing_buf[0] was allocated by kernel_read_file_from_fd() but
is never freed before returning.  Does this leak the buffer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============8611594194516260872==--

