Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D984108B8FF
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WduMs0oCDjoZc9tykXLPvvqUKcYoPT8r3holeFOEj5U=; b=K2cTgKcQXhUP/x3jLRNXTyeNrP
	zcp6xDVQI6Qb81YTy3gdRVBNEDZWzRZQS2yaEqtuiaxTlO0kxfGeKPMqNDdYM2hmY8BhBMpXfEYJP
	kIW0OKYCRCHT1sWpxBzmdUBaisW4ovc56tEY2bOoujanunkXYKBMgiDa9xV1ql5zGeYaBd6S+DIDH
	NxuJdH2WoEQVaSPNrDeN3kz32gBo/cRIzuDyoiFwF1Gm+IBAjt+XherYL+o6Ue9ks0/gVhTv4PqNs
	ftHO8FXwD5ot4iX05OIIQlu/oU2Sgvte8q+vUQhFDcu3ypCmWt9uwxWAp79n9QDLEvWBEKhHNh7vS
	bbFcHRag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kk-0000000EyXQ-0z4Z;
	Sun, 22 Mar 2026 02:14:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kg-0000000EyVo-0F1j
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:14:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E6A03441C4;
	Sun, 22 Mar 2026 02:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF3C19421;
	Sun, 22 Mar 2026 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145664;
	bh=15LtSrMbO+4zppNOiphuTaqoBsJ8Br+hPF1Xrky7JBo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LL2s7ggscFg5V1sRZTGntO4Wl4g2rEbg76J5JTmPLTdMKL6aPEnBh6VphatMFCWXL
	 ocEdB77wCcv9qji8J6fxcOWHAzdU9JEYrjEY5qsPzcck9zaCuCU5vdUXxcebMRlS46
	 wbKZVhh/WKQeSH1i7rOxP/v3bSAYKlfOFSD+iYOVguuQlCkAp+NtTUH+yje5jTs0nk
	 Yg+y/jKj2OK5qK6K8B/crNc81HDy6lBEqiZH2uNawhQJ9YKaO2cp0kJaYZJ09uzaMm
	 H3hXU3BvkZ9SsGyqx/kWZFv+pZ7XmQcBMCtVgg0kdufzxF3685qMUcLthQSngQ3A7p
	 9INLlgI2gyLsg==
Content-Type: multipart/mixed; boundary="===============6203560646426951199=="
MIME-Version: 1.0
Message-Id: <1857be3473d584037af17e3026d9b1e1d16a78486c9be63174ea4553aa9db9f8@mail.kernel.org>
In-Reply-To: <20260322014402.8815-7-piliu@redhat.com>
References: <20260322014402.8815-7-piliu@redhat.com>
Subject: Re: [PATCHv7 06/13] kexec_file: Chain the stages into a pipeline
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:24 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_191426_135518_2A0857FE 
X-CRM114-Status: GOOD (  15.65  )
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

--===============6203560646426951199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index af16f7b685d9..7f7884411e2c 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> @@ -301,6 +305,23 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
>  				vfree(ctx->kernel);
>  				ctx->kernel = decompressed_buf;
>  				ctx->kernel_sz = decompressed_sz;
> +				if (fill_pipeline) {
> +					int i;
> +
> +					for (i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +						if (ctx->next_parsing_buf[i])
> +							continue;
> +						ctx->next_parsing_buf[i] = decompressed_buf;
> +						ctx->next_parsing_buf_sz[i] = decompressed_sz;
> +						break;
> +					}

After this, both ctx->kernel and ctx->next_parsing_buf[i] point to
the same decompressed_buf allocation. When next_parsing_buf is later
promoted to parsing_buf in process_bpf_parsers_container(), there
are two independent references to the same memory.

If the next BPF stage issues another KEXEC_BPF_CMD_DECOMPRESS for
KEXEC_BPF_SUBCMD_KERNEL, vfree(ctx->kernel) frees the buffer while
parsing_buf[i] still references it.

The KEXEC_BPF_CMD_COPY path avoids this by allocating a separate
copy with __vmalloc(). Should the DECOMPRESS path do the same to
prevent aliased ownership?

> +					/* No enough parsing slot */
> +					if (i == MAX_PARSING_BUF_NUM) {
> +						ctx->kernel = NULL;
> +						vfree(decompressed_buf);
> +						return -ENOMEM;
> +					}
> +				}
>  				break;

[ ... ]

> @@ -313,6 +334,22 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
>  		if (!p)
>  			return -ENOMEM;
>  		memcpy(p, buf, cmd->payload_len);
> +		if (fill_pipeline) {
> +			pn = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
> +			if (!pn) {
> +				vfree(p);
> +				return -ENOMEM;
> +			}
> +			memcpy(pn, buf, cmd->payload_len);
> +			for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
> +				if (!ctx->next_parsing_buf[i]) {
> +					ctx->next_parsing_buf[i] = pn;
> +					ctx->next_parsing_buf_sz[i] = cmd->payload_len;
> +					break;
> +				}
> +			}
> +		}

If all MAX_PARSING_BUF_NUM slots are already occupied, the loop
completes without storing pn anywhere, and the allocation is leaked.

The DECOMPRESS path handles this case with an explicit check:

    if (i == MAX_PARSING_BUF_NUM) {
        ctx->kernel = NULL;
        vfree(decompressed_buf);
        return -ENOMEM;
    }

Is a similar overflow check missing here for the COPY path?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============6203560646426951199==--

