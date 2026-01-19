Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC3D489BF
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOnhmnZMuP3iYw6uKhrLV+jhB+C3iBzAgMKn6nhSPUY=; b=4RikeUyPT3M9ADYY3MhbvUWdj+
	zhxuTu0hFS4SYooGpIKtV7iRe3XwCNGuo7Am8t9jFSyM8/uHCJWLy3Ntvq1zEw5U+V09naA9P9XQg
	WywivxcQPH1CM13PV7l9WbNa39k/vARj1G6tRn8o35I5om+kmnhHL9C8Od/vkU7vVOV4yNqmAiIUF
	1NcAkf8pwTQGVU09nmz6/Iw69U2vBLmkMk1fWk0FEkSXBu87RPPlSg4oEWr2J2NmExBMqqDXZ4kue
	K5Vqp0J8TUQE09jR9LkkkxmxIzOVoi5yR9lIzLdRVtMtDzm1dadGADM+VCoaH3T7Ct51zLBu3fd7k
	NA7w9Qwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG8-00000002jeb-27tP;
	Mon, 19 Jan 2026 18:45:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG5-00000002jZq-1RMD
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6D0D60153;
	Mon, 19 Jan 2026 18:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007C2C116C6;
	Mon, 19 Jan 2026 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848348;
	bh=h9M3VYBtxAEa2EwrH2dHTAkKbQKY8m0mIdf4uUg6zyQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kble2M3tdeCBi+Rhj7syEirvqAi5NWfPqufd0haTd1xVG3FTj4DD8XevNRGHMS+C/
	 sV4cytjEi7fhbZ2yclLbDeF4UvE6j6UNpmApoFEGX9RjTIN9srnHvggjY3KawObHrc
	 +H+HiWBBsvnc2On8phPYg5rNxG96TgReeBORM/jPgWp12icFgbtIBVXfbLGFLmyVcb
	 IC26AS2eYzFV5Jccleq0ejFHQ51tOsmIxkdpUP5jgr5AG+nsMQ4wIbCpKw6Aa3AEoX
	 mlZkYbQ+1sy5UVyBOCrUnk8vSXMkDgbU+QOKddlsLA6jHmQfDCwXc+tiAtQoiLHLBr
	 odXeAD/Lbtsjw==
Content-Type: multipart/mixed; boundary="===============0962507557268174505=="
MIME-Version: 1.0
Message-Id: <e0424b46ffd815f666093af468a0961c6f9a4966a5d67d5cbc3b232422426328@mail.kernel.org>
In-Reply-To: <20260119032424.10781-7-piliu@redhat.com>
References: <20260119032424.10781-7-piliu@redhat.com>
Subject: Re: [PATCHv6 06/13] kexec_file: Implement decompress method for parser
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:47 +0000 (UTC)
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

--===============0962507557268174505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index dc59e1389da9..bd6a47fc53ed 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +static void decompress_mem_allocator_fini(struct decompress_mem_allocator *a)
> +{
> +	vfree(a->chunk_base_addr);
> +}

Should decompress_mem_allocator_fini() also free the individual chunks stored
in chunk_base_addr[0..next_idx-1]? On the success path, merge_decompressed_data()
frees them, but on error paths (decompressor failure or merge failure), the
chunks appear to be leaked since only the array pointer is freed here.

[ ... ]

> +static int parser_cmd_decompress(char *compressed_data, int image_gz_sz,
> +		char **out_buf, int *out_sz, struct kexec_context *ctx)
> +{
> +	struct decompress_mem_allocator *a = &dcmpr_allocator;
> +	decompress_fn decompressor;
> +	const char *name;
> +	int ret;
> +
> +	decompress_mem_allocator_init(a, CHUNK_SIZE);

Is the return value from decompress_mem_allocator_init() intentionally
ignored? If vmalloc fails inside that function, chunk_base_addr and the
other fields remain uninitialized, and subsequent code will use garbage
values when accessing the allocator.

> +	decompressor = decompress_method(compressed_data, image_gz_sz, &name);
> +	if (!decompressor) {
> +		pr_err("Can not find decompress method\n");
> +		return -1;
> +	}

When decompress_method() returns NULL, should decompress_mem_allocator_fini()
be called before returning? The allocator was initialized above and allocated
both chunk_base_addr and the first chunk, which appear to leak on this path.

> +	pr_debug("Find decompressing method: %s, compressed sz:0x%x\n",
> +			name, image_gz_sz);
> +	ret = decompressor(compressed_data, image_gz_sz, NULL, flush,
> +				NULL, NULL, NULL);
> +	if (!!ret)
> +		goto err;
> +	ret = merge_decompressed_data(a, out_buf, out_sz);
> +
> +err:
> +	decompress_mem_allocator_fini(a);
> +
> +	return ret;
> +}

[ ... ]

> +	switch (cmd->cmd) {
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
> +				break;

When decompression succeeds but subcmd is not KEXEC_BPF_SUBCMD_KERNEL (for
example INITRD or CMDLINE), decompressed_buf is allocated by
merge_decompressed_data() but not stored or freed. Is this intentional, or
should decompressed_buf be freed in the default case?

> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============0962507557268174505==--

