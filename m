Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BEBD29C5F
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghQ4/MlS6QR/2l4DU4CYypjGattynpVfd3dWeOTY38k=; b=RmKAZiCZqbTbz1+qzJq8+SGmHC
	bMPs+2DRgXbXGtu841ko8Svqh0IPJo4Si+bwZZW4KJRSEuMCiS8lu3hf/i8V/AnXM37MrP/vF8cjD
	im1gWQmkSfsANEhurQ/KQhDh3M890mQjG4oy3MOrVrBX19Rdu9g7I58Q9jpGUdx4M7JuIBXa+39sY
	zzjbe4BZuwfdfT4wUkKDFO5Wmfoi2K6cHVWEnL9/MsCO5A0fnv9Zc2X4uJxjc9I7oNreSZTviZmXW
	X/jTKYrC/CgGPjmDkLMMnQ2teM0XcXOdJHe7Co9JRDfvbw2aNKVWH56T6oDhjKKL4XubXuZA8DmP/
	QMJJORfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFv-00000002jVj-3coC;
	Mon, 19 Jan 2026 18:45:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFq-00000002jUV-3viz
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4053D41AEA;
	Mon, 19 Jan 2026 18:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCFFC116C6;
	Mon, 19 Jan 2026 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848333;
	bh=eup11xvEgVwMgD+DiLklnJEQk5sM9viYzoAkrrjZKN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=b22nm1dlaQzLWyS8+pjhpoMfuJqNqiLM0EOUQA0mZ9gWRnr6ofyA7piQjQXp6Aj9+
	 8NrbvpXVzgGo6yNm292b0yZSpOW/lrsFyk9oHWGPQ/OKUPIERG4S8TtUO6oYbsiQL9
	 Wr9uOxWG1rY/iTRx+SUuErmJSNrnH309bS8VoEh+cDxxv5cSqLI7R83oJ7wEyjD4cF
	 W3rAv/6/7ELmMKLG4Rj6DfeSNPJddbvUeAlEK7fi4tEVYK3aSZQ+ubWVdOO6b+2glb
	 3yXZsze+qFM9wgixXg5AxH3LwmE6fCY1+KjqT2H3Mi/PsGL2ed4imPccvx3msIWMnZ
	 DcRaN3IF4nt3Q==
Content-Type: multipart/mixed; boundary="===============0317604263355170277=="
MIME-Version: 1.0
Message-Id: <028f71c299f5611605a71e8765c660e34ddd74900081d61e79c33f8f2599b8c1@mail.kernel.org>
In-Reply-To: <20260119032424.10781-4-piliu@redhat.com>
References: <20260119032424.10781-4-piliu@redhat.com>
Subject: Re: [PATCHv6 03/13] kexec_file: Introduce routines to parse PE file
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:32 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_104535_023593_AC035AC7 
X-CRM114-Status: GOOD (  18.55  )
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

--===============0317604263355170277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_uefi_app.c b/kernel/kexec_uefi_app.c
> new file mode 100644
> index 000000000000..dbe6d76d47ff
> --- /dev/null
> +++ b/kernel/kexec_uefi_app.c

[ ... ]

> +static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	struct mz_hdr *mz;
> +	struct pe_hdr *pe;
> +
> +	if (!kernel_buf)
> +		return false;
> +	mz = (struct mz_hdr *)kernel_buf;
> +	if (mz->magic != IMAGE_DOS_SIGNATURE)
> +		return false;
> +	pe = (struct pe_hdr *)(kernel_buf + mz->peaddr);

The kernel_len parameter is declared but never used in this function.
Should this validate that mz->peaddr is within bounds of kernel_len before
accessing pe->magic? If mz->peaddr is larger than the buffer size, this
would read out of bounds.

> +	if (pe->magic != IMAGE_NT_SIGNATURE)
> +		return false;
> +	if (pe->opt_hdr_size == 0) {
> +		pr_err("optional header is missing\n");
> +		return false;
> +	}
> +	return true;
> +}

[ ... ]

> +int pe_get_section(const char *file_buf, const char *sect_name,
> +		char **sect_start, unsigned long *sect_sz)
> +{
> +	struct pe_hdr *pe_hdr;
> +	struct pe32plus_opt_hdr *opt_hdr;
> +	struct section_header *sect_hdr;
> +	int section_nr, i;
> +	struct mz_hdr *mz = (struct mz_hdr *)file_buf;
> +
> +	*sect_start = NULL;
> +	*sect_sz = 0;
> +	pe_hdr = (struct pe_hdr *)(file_buf + mz->peaddr);
> +	section_nr = pe_hdr->sections;
> +	opt_hdr = (struct pe32plus_opt_hdr *)(file_buf + mz->peaddr +
> +				sizeof(struct pe_hdr));
> +	sect_hdr = (struct section_header *)((char *)opt_hdr +
> +				pe_hdr->opt_hdr_size);
> +
> +	for (i = 0; i < section_nr; i++) {

pe_get_section() has no buffer size parameter. The values of mz->peaddr,
pe_hdr->sections, and pe_hdr->opt_hdr_size are all read from the PE file
content. If the file is malformed or crafted, section_nr could be set to an
arbitrarily large value, causing sect_hdr to iterate past the end of
file_buf. Is there a way to validate these offsets against the actual
buffer size?

> +		if (strcmp(sect_hdr->name, sect_name) == 0) {
> +			*sect_start = (char *)file_buf + sect_hdr->data_addr;
> +			*sect_sz = sect_hdr->raw_data_size;
> +			return 0;
> +		}
> +		sect_hdr++;
> +	}
> +
> +	return -1;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============0317604263355170277==--

