Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229AECCF2DE
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLLvAvVEgrgEULuSA5TryrUac3bkP1P7W/1KsSrmJnk=; b=bIOG6vrg0OGS3ca/KE3VujEDYe
	lDB2aWvufL5OaWAiRz3ulweiCUiAA14hqvAXF4hALYkdSquCFzJSc4wBWPqGvgiFS8EkAmO2jJDuL
	JNifLIJ2rfmSmgDImGyTXfSoFWrN741x4Z5rizfExZQ/ZQHgCmVK821tcmB2MlCoUil0MwOSE9w56
	IPMvN2e6paYq5c9Ole+0scSHrmW+93zeBilx5ZtUShQAnuUzCvHKSwAKUpe6YxlSchuhkbJYLPkca
	tn2gR/hqmAmrEvUykTP3PajqNvQT0I/b2Ap9NU7MwgrdRvmAqSgGlknU7YRxN8cY1oxLygj7JR+JQ
	ueTtDm+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG0-00000002jXo-0Gtc;
	Mon, 19 Jan 2026 18:45:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFu-00000002jUr-1DVM
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6733C43F54;
	Mon, 19 Jan 2026 18:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE7C116C6;
	Mon, 19 Jan 2026 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848337;
	bh=wRNvAJXnVuu1QOy742TWlD5Dl2Dtpm3GKw4CrofTVeQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KWsObhltzs8wffjQlpFHA2xQ8ghIWpEpMTrT3XyVPstHjmlxKMZVeY22ethWSfnk8
	 NR8eG1F7CYM4yB2jxE1hR53i/9sB0lxSI7/zqEx1M+ZRJ8WAIPFsqnhDKBeYQHNcXH
	 3owN7yRqHNtboD2DIo89VlOHQyUfk7PbVuWpXIutBUYUc38RJM5X0xLRnr9Rxq+axA
	 QRAYBbR6kymyKYFZCXzN6JywgIOsoU1W1AwcapnGkklTX0DzfBgQFXTSo9qIUX9KBO
	 wKkyU0pg2Qup8njwIlFr8ZTOLxA2nFw5ULUXu02s88DFgVhWVCNZK5zJdySjSiH/QI
	 xZlOcUm4Ex0QA==
Content-Type: multipart/mixed; boundary="===============3056990786630533314=="
MIME-Version: 1.0
Message-Id: <468c97464c9b7d16dcbcd192ab8616cb9d55fc0f3948c4df57dd7504a277889e@mail.kernel.org>
In-Reply-To: <20260119032424.10781-11-piliu@redhat.com>
References: <20260119032424.10781-11-piliu@redhat.com>
Subject: Re: [PATCHv6 10/13] kexec_file: Integrate bpf light skeleton to load image with bpf-prog
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:36 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_104538_365937_4964770A 
X-CRM114-Status: GOOD (  16.89  )
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

--===============3056990786630533314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index 5ad67672dead..9f1c5aede42e 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c

[ ... ]

> +static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
> +		const char *symbol_name, unsigned int *symbol_size)
> +{
> +	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
> +	Elf_Shdr *shdr, *dst_shdr;
> +	const Elf_Sym *sym;
> +	void *symbol_data;
> +
> +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
> +		pr_err("Not a valid ELF file\n");
> +		return NULL;
> +	}
> +
> +	sym = elf_find_symbol(ehdr, symbol_name);
> +	if (!sym)
> +		return NULL;
> +	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
> +	dst_shdr = &shdr[sym->st_shndx];
> +	symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The elf_size parameter is declared but never used in this function. The
pointer calculations at ehdr->e_shoff, shdr[sym->st_shndx], and
dst_shdr->sh_offset + sym->st_value could all access memory beyond the
ELF buffer if the ELF data is malformed. Should there be bounds checking
against elf_size to prevent out-of-bounds reads?

> +	*symbol_size = sym->st_size;
> +
> +	return symbol_data;
> +}
> +
>  /* Load a ELF */
>  static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
>  {
> +	opts_data = get_symbol_from_elf(bpf_elf, sz, "opts_data", &opts_data_sz);
> +	opts_insn = get_symbol_from_elf(bpf_elf, sz, "opts_insn", &opts_insn_sz);
> +	if (!opts_data || !opts_insn)
> +		return -1;
> +	/*
> +	 * When light skeleton generates opts_data[] and opts_insn[], it appends a
> +	 * NULL terminator at the end of string
> +	 */
> +	opts_data_sz = opts_data_sz - 1;
> +	opts_insn_sz = opts_insn_sz - 1;
                      ^^^^^^^^^^^^^^^^^^

If sym->st_size is 0 for either opts_data or opts_insn symbols in the ELF,
then opts_data_sz or opts_insn_sz would be 0 after get_symbol_from_elf()
returns. Subtracting 1 from an unsigned int with value 0 would cause an
integer underflow to UINT_MAX. This large value would then be passed to
bpf_load_and_run() via the opts structure. Would it make sense to check
that opts_data_sz and opts_insn_sz are non-zero before the subtraction?

> +
> +	pe_parser = kexec_pe_parser_bpf__open_and_load();
> +	if (!pe_parser)
> +		return -1;
> +	kexec_pe_parser_bpf__attach(pe_parser);
> +
> +	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============3056990786630533314==--

