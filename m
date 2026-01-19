Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2B6EEE26E
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQ1bnlblhz5Hj/ONZdHkmaHrHUuHe1i6PuMmieccQOA=; b=O5nuku5kmWCDKAvFXkw/r5KgzM
	rPVHS6PA53k2hQK4V5Fb6wpHxOxpbXO63MhDoLs3mViAbp0AWrFPB3bKXPNqHgF+6xCmt7uo3O3rO
	/sbeQg/GcKC02PK0T9pYlE0CRNuD8G98uj4zEUOOOxFHUDZEGmJ0WYwI/E6LzD0gIFQM+pa5WAK80
	MaNbrmV6psdqyUcfC92JAslJSezuF+Yi/MsMpYdQBa+vARVDpsp9kZF2lcgFIf59rvl3WIEuQzMvo
	3hwjC3PGiP6bTaIfPi9rxieruZRpPI2dTgYtJTI14iYwT1fv1BCXYd3B9Uu+y9mnhm0AacvYYLs13
	720tVLnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG8-00000002jdq-0u6F;
	Mon, 19 Jan 2026 18:45:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG1-00000002jYj-08nu
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7672060140;
	Mon, 19 Jan 2026 18:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9347C19424;
	Mon, 19 Jan 2026 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848344;
	bh=M79Vmns/Avz7hIWo4vceBKReeeeMlgF1ADBYBVpfZ5U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tOEf7mctB/OB4YSV1G1w6GWJEIOYeaDQLk7gmK7o+1BTw68evq2hIzDx/9qUTys8J
	 6XWXzT7TwTfAhWIpt0yDcSudYX9G3TsvPSPXe3CVDIBtfcumXhssQJ7aSUTLTCQmbp
	 vl9RLb1MWiX/Ot6ogICswk1dYqN/IAMFMDDIamFYxm6SqqSDLFIY0hI7rvvFXDlcg7
	 Ac3YCRU/flPUXuNld6iKAzE4/WQywc5gOiGtVslXKlqhgAdUpvxV0TAohTSeXpL6a6
	 bP8H5XGjuo8Jdluz+xyLSN9KSajYIA3z8gbXUOq6dGJHjzdqgXjSXJlBLuOP4woVU3
	 FVxqzy5Es4Lcg==
Content-Type: multipart/mixed; boundary="===============5395468137030447417=="
MIME-Version: 1.0
Message-Id: <ac79262dc46cbfcc238dfb3bfbb5feaa804a2b3b3e8ce2ab1e4b096b6985bdec@mail.kernel.org>
In-Reply-To: <20260119032424.10781-2-piliu@redhat.com>
References: <20260119032424.10781-2-piliu@redhat.com>
Subject: Re: [PATCHv6 01/13] bpf: Introduce kfuncs to parser buffer content
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,bpf@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:43 +0000 (UTC)
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

--===============5395468137030447417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
> new file mode 100644
> index 000000000000..6acb4b5da71b
> --- /dev/null
> +++ b/kernel/bpf/bpf_buffer_parser.c

[ ... ]

> +static void release_bpf_parser_context(struct kref *kref)
> +{
> +	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
> +
> +	if (!!ctx->buf) {
> +		vfree(ctx->buf->buf);
> +		kfree(ctx->buf);
> +	}

[ ... ]

> +struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
> +		void *data)
> +{
> +	struct bpf_parser_context *ctx;
> +	unsigned int key;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

ctx->buf is NULL here from kzalloc.

[ ... ]

> +__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
> +		struct bpf_parser_context *context)
> +{
> +	struct bpf_parser_buf *parser_buf;
> +	int ret;
> +	char *b;
> +
> +	if (unlikely(context->func == NULL))
> +		return -EINVAL;
> +
> +	b = __vmalloc(buf_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (!b)
> +		return -ENOMEM;
> +	ret = copy_from_kernel_nofault(b, buf, buf_sz);
> +	if (!!ret) {
> +		vfree(b);
> +		return ret;
> +	}
> +
> +	parser_buf = kmalloc(sizeof(struct bpf_parser_buf), GFP_KERNEL);
> +	if (!parser_buf) {
> +		vfree(b);
> +		return -ENOMEM;
> +	}
> +	parser_buf->buf = b;
> +	parser_buf->size = buf_sz;
> +	context->buf = parser_buf;

If bpf_buffer_parser() is called multiple times on the same context, does
this leak the previous parser_buf and its backing vmalloc buffer? The
assignment to context->buf overwrites any existing pointer without first
freeing it.

release_bpf_parser_context() will only free the final context->buf value
when the context is destroyed, so any intermediate buffers from prior
calls would be lost.

Should there be a check here to either return an error if context->buf is
already set, or free the old buffer before assigning the new one?

> +	ret = context->func(context);
> +
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============5395468137030447417==--

