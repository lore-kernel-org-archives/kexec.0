Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F4D109448C
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kl75N7LgXjXWe9D0eeIzRmXDj3LI1N7fDeUUiIu7CMw=; b=f+2W7JFunP5HY1thIpl11asfPa
	nchzAzWL+p9Bv6yaa2JpRrz8mna9xVSe5qJit1OOelILvRrX+4wci5+zcV6J5CKauy9m2QBfhFxF5
	X5jvVUSKlRTlSQii8ywoOfz6EMMG3kj4TcNh9y8P+anUIchnN1NRDXXVlT0AskWT9HzwzCP5ju5cj
	Ed5Gep0r4M1xTpQGOzcinSVbWH46sQscUnC1gFwnlIvGIKmRGHSHHpMgJ5HynrIV90aMquPXUUeaF
	mxGAqRDFh8NjebsYMb+k1zwLMVRAXv5hLBcTsDjeyp0nvLPZWvg5z820dJp8ll8PK/xZz2nU3SkE6
	0vXv8Etg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kk-0000000EyXt-27gB;
	Sun, 22 Mar 2026 02:14:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kh-0000000EyWJ-0PUA
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:14:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9138B446A8;
	Sun, 22 Mar 2026 02:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D354BC19421;
	Sun, 22 Mar 2026 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145666;
	bh=P5/QZdALceOOATbjA4yiwqZ9aFKguus/sia2zG/8cqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GPSzfeelF6hYSQ5+WCm7GMpOo+k7RWdYJOESMvhg6LWooNur6Lgo0QRrV/ez9pUNb
	 xyDDK8OM7wWtPyfKUhZJbGliyk8e10C9jE2z81zceZG0go2J9/asucjKVpEEvL2ooX
	 FqX6wlAzNbUuzcrPEl/+nEwWzfnARd/5dKJLZGiEFKQooaVNhErbUw+z9WkY7kU/Q0
	 kor4hf14Y6qhKFOVWZnJ9RGbGOK3AMQjVdljLYQw8Bylv/7s7IpkNukpB3yesxPJJ2
	 evv4zUAT7Bh+3q5CyGcVj4SXAxwMCDSx2YCHKCYrBI8Il+xTYfpdc69lnKm8iPdJpb
	 GxglQ/e+JaKwQ==
Content-Type: multipart/mixed; boundary="===============6815891717645210221=="
MIME-Version: 1.0
Message-Id: <08db54a539782f034e10f598cd46bd2ff7f7404922d78689c4628110164e77de@mail.kernel.org>
In-Reply-To: <20260322014402.8815-2-piliu@redhat.com>
References: <20260322014402.8815-2-piliu@redhat.com>
Subject: Re: [PATCHv7 01/13] bpf: Introduce kfuncs to parser buffer content
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,bpf@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:25 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_191427_181096_3B42DE0D 
X-CRM114-Status: GOOD (  13.51  )
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

--===============6815891717645210221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
> new file mode 100644
> index 000000000000..5d5c06833079
> --- /dev/null
> +++ b/kernel/bpf/bpf_buffer_parser.c

[ ... ]

> +static void release_bpf_parser_context(struct kref *kref)
> +{
> +	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
> +
> +	if (ctx->buf) {
> +		vfree(ctx->buf->buf);
> +		kfree(ctx->buf);
> +	}

If release_bpf_parser_context() runs while bpf_buffer_parser() has
stored the sentinel (void *)1 in ctx->buf via:

    old_val = cmpxchg(&context->buf, NULL, (void *)1);

then ctx->buf is non-NULL but not a valid struct bpf_parser_buf
pointer, and vfree(ctx->buf->buf) will dereference address 1.

The BPF verifier prevents this today by holding the acquired reference
across the kfunc call, but release_bpf_parser_context() has no
awareness of the sentinel value.  Would it be worth adding a check
here to handle the sentinel, or using a separate flag/mutex instead
of overloading ctx->buf?

[ ... ]

> +__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
> +		struct bpf_parser_context *context)
> +{

[ ... ]

> +	ret = copy_from_kernel_nofault(b, buf, buf_sz);
> +	if (!!ret) {

The !!ret is equivalent to just testing ret here.  Was the double
negation intentional?

> +		context->buf = NULL;
> +		vfree(b);
> +		return ret;
> +	}

[ ... ]

> +static const struct btf_kfunc_id_set buffer_parser_kfunc_set = {
> +        .owner = THIS_MODULE,
> +        .set   = &buffer_parser_ids,
> +};

These two lines use spaces for indentation instead of tabs.

> +
> +

There is a double blank line here.

> +BTF_ID_LIST(buffer_parser_dtor_ids)

[ ... ]

> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &buffer_parser_kfunc_set);
> +	return  ret ?: register_btf_id_dtor_kfuncs(buffer_parser_dtors,

There is a double space before ret.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============6815891717645210221==--

