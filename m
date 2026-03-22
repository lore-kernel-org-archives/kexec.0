Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBA9109448C
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUKH6tk7e0QXLFYS2hPEcOStsd5qhu6cQrD7NLLmGzY=; b=asZHykJ5IIm0ImWSc9XjPNIis0
	mPdWZ7OjtzkUeK9qDHncayYgpUfmCXqEMRIv+iFfpHE/MQwsFoHsHR6i2RgRT1FYcaZkwCnsbIA6K
	bdXcNwNx0tzFLKtKesP08QHsKzmWLfBLJg5n/PAR5deVWlXmF2itgd0lgzukNfiNJvdThLE1+SJjK
	WjbGSeHoQO5GD6GWOr4MQh9vXxqCHPemcdTOjs5lB8cQvsTO9YnTHZPYqrjbPXRddJ89Jd87KKvDd
	KI3zIiKMoRdsI575anW7SuUW9Zuq3Ld8x/3O6gcxYEJfafw9kq/r4fUda7IIypti5ySWvbS+e44qm
	B67BwKew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WS-0000000Ez9n-45US;
	Sun, 22 Mar 2026 02:26:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48WR-0000000Ez8p-3dy3
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:26:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 400186187F;
	Sun, 22 Mar 2026 02:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68215C19421;
	Sun, 22 Mar 2026 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774146394;
	bh=e28PPferGzosCU+i58JNVBT0CDCpiwBcPUUhQVfPpa4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lrfLxNMmIAVERtQCvrBbbT2rJgEZ3n+ml/bVFya/R7T8MXMVnpb0VEZnlh4xoUuJN
	 uYVt6vk+SfjkrKgD48TaBD7o0kCfyoEHDiH3l1CAmOuMY/rXJGjqy2CqpmXtZ+Vzah
	 JjCuFhkoHYsP4t0/ct05fLANvhSuqxjIsaiC2NPu6vOs1iUsrKFi1hSFklRO38UEH9
	 a9uuj1FhstylH3gPXcOmA72EoOeaFdBjwj/7PJi3hDMc7H/CpY1B1eKyf2qxu+p690
	 IYX/zs4PIjJCPVWRT+sSezoPRFv0LfKQa0RmmRglBMrlL91u/CMyvZykXs+BL7v7f6
	 YxvKwiBqGCZug==
Content-Type: multipart/mixed; boundary="===============7741034310972575734=="
MIME-Version: 1.0
Message-Id: <9fc6a101fc0aff669aab2270d9287b55e63b44993778536303843b6155af1283@mail.kernel.org>
In-Reply-To: <20260322014402.8815-5-piliu@redhat.com>
References: <20260322014402.8815-5-piliu@redhat.com>
Subject: Re: [PATCHv7 04/13] kexec_file: Implement decompress method for parser
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:26:34 +0000 (UTC)
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

--===============7741034310972575734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index bd1800a76782..c79fb777d51b 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> @@ -73,8 +74,243 @@ static int __init kexec_bpf_prog_run_init(void)
>  }
>  late_initcall(kexec_bpf_prog_run_init);

[ ... ]

>  static int kexec_buff_parser(struct bpf_parser_context *parser)
>  {
> +	struct bpf_parser_buf *pbuf = parser->buf;
> +	struct kexec_context *ctx = (struct kexec_context *)parser->data;
> +	struct cmd_hdr *cmd = (struct cmd_hdr *)pbuf->buf;
> +	char *decompressed_buf, *buf, *p;
> +	unsigned long decompressed_sz;
> +	int ret = 0;

[ ... ]

> +	case KEXEC_BPF_CMD_DECOMPRESS:
> +		ret = parser_cmd_decompress(buf, cmd->payload_len, &decompressed_buf,
> +					&decompressed_sz, ctx);
> +		if (!ret) {
> +			switch (cmd->subcmd) {
> +			case KEXEC_BPF_SUBCMD_KERNEL:
> +				vfree(ctx->kernel);
> +				ctx->kernel = decompressed_buf;
> +				ctx->kernel_sz = decompressed_sz;
> +				break;
> +			default:
> +				vfree(decompressed_buf);
> +				break;
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }

Should this return ret instead of 0?  When parser_cmd_decompress()
fails, ret holds the error code, but the function discards it and
returns success.

bpf_buffer_parser() in bpf_buffer_parser.c propagates this return
value back to the calling BPF program:

    ret = context->func(context);
    ...
    return ret;

Returning 0 here means the BPF program sees success even when
decompression failed.  It would then proceed to send
KEXEC_BPF_CMD_DONE, setting ctx->parsed = true, causing kexec
to complete loading with a missing or undecompressed kernel image.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============7741034310972575734==--

