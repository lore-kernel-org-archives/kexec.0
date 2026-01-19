Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0759CCCF2EE
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMf1a4Jp3uDSsCDSI5RZOgxUZ6pYZcT4DgC6vDelTcU=; b=G7xKVu5iIcWpzogr3aLDfRrS7R
	kS6lfm2JInCRnxYjTU4ry8BZmnQn1fm2VKMK3EtwlH557uF2l1f334uUctGJ08WZPo2gm/ylxnmKB
	9ytP7nebYpL5gM+NaY2NE3KGAiU7u7Ows3HfaIcYvWjUA2sUt2QFzYdMfzzmEX7GqD7KWzI2E6C68
	ZVu8HrTphQIYLgxkQ2XfPh70cONlRu5zBrjIlTKQTH5PhUL+3WpJfNObTwk+paMI6xu88cXG5hOq6
	xpXytn4SGx1jSEh6BO99WJGPrWqCbCdVWEQefZs40IpNyw9R5DaeW5BQoPSRaSdsJ601N09mlnCxe
	Ukpnw8/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG6-00000002jYw-0Qjo;
	Mon, 19 Jan 2026 18:45:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFw-00000002jW6-3kcb
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 965BC44521;
	Mon, 19 Jan 2026 18:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D19C116C6;
	Mon, 19 Jan 2026 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848340;
	bh=Ikfg5KIMUlTIopIK07Reje08ixZv+AmRD+SrzZ7gCdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CQCXYOQP/u2K0fH7yCGd+dJFJcgI6wYCxxAHMylFusY3Rovv9qnmMv4V3BVoslePE
	 7B2uK6HqUcLhYMtvy+AZZ2zXsgEW5UT+sKH0H9mdpXDN17lEqDxVynqjGMJb7jSHU8
	 WR9OVAOgyBgGIZLvOxXpng1ZB66evVmKfhBufNspeAVRMWQZJAfy33/xaGIMLAP75c
	 O13v00SnSF0Wa5JEBCKaNUGHfKkLHLMsuRdlFonOR+SYVfkXYe+wdS1cg0OA4hY3yZ
	 hEG+tN9Azf9W9kMdbgnuypOCVa9AaFAJgC0mQhJ73h3woocL5SAoXEqSuyF6n71cLM
	 kDb+UMFtfr+Mw==
Content-Type: multipart/mixed; boundary="===============8972815748039503686=="
MIME-Version: 1.0
Message-Id: <f7a838c389c0356a7a52dc2fa09b5db8f24a6eed1d7dbc346250e4f3db233855@mail.kernel.org>
In-Reply-To: <20260119032424.10781-13-piliu@redhat.com>
References: <20260119032424.10781-13-piliu@redhat.com>
Subject: Re: [PATCHv6 12/13] tools/kexec: Introduce a bpf-prog to parse zboot image format
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:40 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_104540_983273_EC91B8C0 
X-CRM114-Status: GOOD (  15.39  )
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

--===============8972815748039503686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/kexec/zboot_parser_bpf.c b/tools/kexec/zboot_parser_bpf.c
> new file mode 100644
> index 000000000000..54c4b762b332
> --- /dev/null
> +++ b/tools/kexec/zboot_parser_bpf.c

[ ... ]

> +/* see drivers/firmware/efi/libstub/zboot-header.S */
> +struct linux_pe_zboot_header {
> +	unsigned int mz_magic;
> +	char image_type[4];
> +	unsigned int payload_offset;
> +	unsigned int payload_size;
> +	unsigned int reserved[2];
> +	char comp_type[4];
> +	unsigned int linux_pe_magic;
> +	unsigned int pe_header_offset;
> +} __attribute__((packed));

[ ... ]

> +	unsigned int payload_offset = zboot_header->payload_offset;
> +	unsigned int payload_size = zboot_header->payload_size;
> +	bpf_printk("zboot image payload offset=0x%x, size=0x%x\n", payload_offset, payload_size);
> +	/* sane check */
> +	if (payload_size > image_sz) {
> +		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
> +		bpf_printk("Invalid zboot image payload offset and size\n");
> +		return 0;
> +	}

Should this bounds check also verify that payload_offset + payload_size
does not exceed image_sz? The current check only validates that payload_size
fits, but if payload_offset is large (e.g., near image_sz), the read below
could extend past the end of the kernel buffer.

For example, with payload_offset = image_sz - 10 and payload_size = 100,
the check "payload_size > image_sz" passes, but the bpf_probe_read below
would read 90 bytes past the valid buffer boundary.

> +	unsigned int max_payload = MAX_RECORD_SIZE - sizeof(struct cmd_hdr);
> +	if (payload_size >= max_payload) {
> +		bpf_ringbuf_discard(buf, BPF_RB_NO_WAKEUP);
> +		bpf_printk("Err: payload_size > MAX_RECORD_SIZE\n");
> +		return 0;
> +	}
> +	void *dst = (void *)buf + sizeof(struct cmd_hdr);
> +	/* Overwrite buf */
> +	struct cmd_hdr *cmd = (struct cmd_hdr *)buf;
> +	cmd->cmd = KEXEC_BPF_CMD_DECOMPRESS;
> +	cmd->subcmd = KEXEC_BPF_SUBCMD_KERNEL;
> +	/* 4 bytes original size is appended after vmlinuz.bin */
> +	cmd->payload_len = payload_size - 4;
> +	bpf_probe_read(dst, payload_size, context->kernel + payload_offset);
                                                           ^^^^^^^^^^^^^^^

This is where the out-of-bounds read could occur if payload_offset +
payload_size > image_sz. While bpf_probe_read is safe and will not crash
(it uses copy_from_kernel_nofault internally), it could read from adjacent
kernel memory if the zboot header contains invalid offset/size values.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============8972815748039503686==--

