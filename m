Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F1606C562
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VJ3+rmMr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UU0i2ECF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U90YHHqYabJCzGCISBw16c6Orv5qCzpj8HcVqDO2HtM=; b=VJ3+rmMrgE+NGdLZBKKRD6nGO5
	42HYnNmqjIG/sYNFt5fMW+zbXQVyEUi6zmkJ/4ON+wKxhLoMZx/3nLLnljrdHWDYQFu3RcIrkML4w
	6w2NWQJwhduBQ75dB6Ti068ALkpIo7EMeemo2AnJ55uuzxDYSLIlXMOLbSHuya7AFc11z16mdQhC5
	db+I0awQqpEhSDca3VaUcwGe8heLWoAtg1p2929ZLPdX1Nfyc+68Y7R74gvw3YOplWkppw94JJv3f
	Sn/bYF0XUYXQ7c1PAithHz5/RfZ8kKx9IRjSBU1na5ghATpKmK+uakhclT14PY5yHC5LUsMP4MxRp
	qiIGzC7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBXp-00000001vb8-0qn3;
	Tue, 03 Nov 2026 10:15:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBXf-00000001vLV-3SNL;
	Tue, 03 Nov 2026 10:14:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 91C0941333;
	Tue,  3 Nov 2026 10:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32DB1F00919;
	Tue,  3 Nov 2026 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700899;
	bh=U90YHHqYabJCzGCISBw16c6Orv5qCzpj8HcVqDO2HtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UU0i2ECFurVjJyBCS6ZF6AH2Xktl7pInMJd7bazTQddWePDIEA5puQTogv9IC4gmj
	 vDXtNCxrzh7MDJ3y8rdI/oSSkl60s21Po9fm5r9bLuW6alBau2Jag4PshJqMPPNyXv
	 vbVWT40/nrXKwReI3HHsqnziuE7kypXnARDHkipEtL71XPpOzXK8B0PI/SHFk7Zuxi
	 8UnJMwBR0AXholRlH1Ulo9W1W0gkzlSzG/FngOBMmh3bYiTP4poFqmEban/zXNJXR/
	 ZqovUxW/zY9QWyRYIKWlJC3ZxoqmwoyCPoDjpLmBdOngc8Mj0IiybdzgtAYP84YlhL
	 u/1XA/JjrQJtg==
Date: Tue, 3 Nov 2026 12:14:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Yao Zi <me@ziyao.cc>,
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kexec@lists.infradead.org
Subject: Re: [PATCH 3/5] kexec_file: Honor the segment alignment for CMA
 allocations
Message-ID: <aum0GlBKTfZ6rvgL@kernel.org>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-3-825b90ea23c4@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-3-825b90ea23c4@iscas.ac.cn>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 03:33:16PM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
> 
> dma_alloc_from_contiguous() limits the requested alignment to
> CONFIG_CMA_ALIGNMENT without reporting it. kexec_alloc_contig() can
> therefore place a segment at a less aligned address than buf_align. On
> RISC-V with 4 KiB pages, the default 1 MiB limit is below the 2 MiB
> kernel alignment, and the new kernel stops at the setup_vm() BUG_ON for
> a misaligned physical address.
> 
> Release such a block and fall back to the regular memory hole search,
> which honors the alignment.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d8..6ce10e01414e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -690,6 +690,13 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
>  
>  	mem = page_to_boot_pfn(p) << PAGE_SHIFT;
>  
> +	/* dma_alloc_from_contiguous() caps the alignment at CONFIG_CMA_ALIGNMENT. */
> +	if (!IS_ALIGNED(mem, kbuf->buf_align)) {
> +		pr_debug("CMA block 0x%lx is not aligned to 0x%lx\n", mem, kbuf->buf_align);
> +		dma_release_from_contiguous(NULL, p, nr_pages);
> +		return -EINVAL;
> +	}
> +
>  	if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->memsz)) {
>  		/* Our region is already in use by a statically defined one. Bail out. */
>  		pr_debug("CMA overlaps existing mem: 0x%lx+0x%lx\n", mem, kbuf->memsz);
> 
> -- 
> 2.55.0
> 
> 

-- 
Sincerely yours,
Mike.

