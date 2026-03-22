Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA38109449E
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNChu3lDCXMnbWvkkdI7QrS3SOxVdPCfDZeDEe/5ubI=; b=aecyvvjhbUiey2/3VJYortmC02
	IYbZ/oJtp3yVywVbUeEax7oSlqKTCYqhOZmI5Xtn4wm8qc3SwMAjlcm5EzICXQktr1Z0kasyVdaoK
	Q9WTpBiNSWaavZZdfRHDTDlzXrpMLJ3l93EuEQXXYl9p0Ss3qbPBcoTVnwWSnKGFs4hk9fg9JqmX0
	uxcIdugq7w8b6r1OUs4G0sR00YAMqR8iRhinkNxTSEcBVEN2H6A2GhbFQPqZR+eQ08p9G00P0Jp2h
	ZP4xb4RlP1z8/0mtD27NNO01lf3BrbEbG2lSeTHgkoLlx4sA2S4j6ksbRpxxiDslIWJHqkXsNwJO+
	+5umTtqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kk-0000000EyYL-3N2y;
	Sun, 22 Mar 2026 02:14:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w48Kj-0000000EyWx-3LEv
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 02:14:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 51A7260120;
	Sun, 22 Mar 2026 02:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CCBC2BCAF;
	Sun, 22 Mar 2026 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145668;
	bh=JFi23hDPzBAJJbr+GBVnnI+oU8bt2iNkSB+GWSbbTmI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=V2FXJrS6V2Xv2NrLnWV0ierikbDUejhRcYKkiM3QUauGUMhYVIOqhJSXSPWk+nPfG
	 gOfoIWMZPpHVxR9QU4roFa5m3EGdnU7VbQKjC1pSaSg/066c326Hz+mdXAFcSm7Wh4
	 UbU08zQ1JRmFth8QuZ5CjSY8EEnnHPOpzDXRGpc+FLy0jAa5Ynn7TKdjOJzRR/mYw5
	 b9Xnbra7T8FrYXmQZLYu+/d0RWKw0pa/tv5mgNxy6BzL49/hIV6jOlg+CcNkIdM2Mr
	 c1P+bu4IzSDVjGaEQ4BYgRcjx6Jvbidl7vqrVKpXjfDe4VSpRpb01a5vWyXLgvdFnI
	 3eAFIu/txDrVA==
Content-Type: multipart/mixed; boundary="===============6720247887629249689=="
MIME-Version: 1.0
Message-Id: <e6a5b9f1a0eb1f4874d1a426dc17ccaad603065e8e6cebd8e0cc4ac8d014a2f9@mail.kernel.org>
In-Reply-To: <20260322014402.8815-10-piliu@redhat.com>
References: <20260322014402.8815-10-piliu@redhat.com>
Subject: Re: [PATCHv7 09/13] kexec_file: Integrate bpf light skeleton to load image with bpf-prog
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:27 +0000 (UTC)
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

--===============6720247887629249689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index 7f7884411e2c..430f6c3970b6 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
> +				 const char *symbol_name,
> +				 unsigned int *symbol_size)
> +{

[ ... ]

> +	/* Check section data bounds */
> +	if (dst_shdr->sh_offset > elf_size ||
> +	    dst_shdr->sh_offset + dst_shdr->sh_size > elf_size ||
> +	    sym->st_value > dst_shdr->sh_size) {
> +		pr_err("Symbol data out of bounds\n");
> +		return NULL;
> +	}
> +
> +	symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
> +
> +	if (symbol_size)
> +		*symbol_size = sym->st_size;
> +
> +	return symbol_data;
> +}

The bounds check validates that sym->st_value falls within the section,
but it does not validate that sym->st_value + sym->st_size also fits
within the section (or the ELF buffer).

The caller arm_bpf_prog() passes the returned sym->st_size through to
bpf_load_and_run() as opts.data_sz / opts.insns_sz, which controls how
many bytes are copied from the pointer:

    arm_bpf_prog()
      opts_data = get_symbol_from_elf(..., &opts_data_sz);
        -> *symbol_size = sym->st_size;
      ...
      kexec_pe_parser_bpf__open_and_load()
        kexec_pe_parser_bpf__load()
          opts.data_sz = opts_data_sz;
          bpf_load_and_run(&opts);
            skel_map_update_elem(map_fd, &key, opts->data, 0);

Since the ELF comes from userspace via the PE .bpf section, could a
crafted ELF with a valid st_value but an oversized st_size cause a
read beyond the buffer here? Something like:

    if (sym->st_value + sym->st_size > dst_shdr->sh_size) ...

might be needed alongside the existing st_value check.

> + /* Load a ELF */
>  static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
>  {

[ ... ]

> +	pe_parser = kexec_pe_parser_bpf__open_and_load();
> +	if (!pe_parser) {
> +		pr_info("Can not open and load bpf parser\n");
> +		return -1;
> +	}
> +	kexec_pe_parser_bpf__attach(pe_parser);
> +
> +	return 0;
>  }

kexec_pe_parser_bpf__attach() returns an error code, but its return
value is not checked here. If attach fails (e.g.
skel_raw_tracepoint_open() returns an error), arm_bpf_prog() still
returns 0.

The caller process_bpf_parsers_container() then proceeds to call
kexec_image_parser_anchor(), which is a no-op without the fentry
hook. context->parsed stays false, and every section appears to fail
with "no BPF section succeeded" -- hiding the real cause.

Should the return value of kexec_pe_parser_bpf__attach() be checked,
with the parser destroyed and an error returned on failure?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============6720247887629249689==--

