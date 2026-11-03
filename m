Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D7606C563
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F5JKcxYP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4M9873z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5o98qwlKEQyOrCRjq2RUqHe7Txdo2HfIj4qXGPwficc=; b=F5JKcxYPeLK1WHu9A3G3OZz3OM
	qkM37622K/hglsTs44ooVWDvXzjxTXF9wU7iSKxMFat4ctCbmqWwqevTPfkgjNclcTQKq78xoBVxk
	N8q3zUyH7Mb4/StacVxs5VdvxjT0csud7Z/IeHb32SOJ1s7VfwI2Qw+BvQ807kZ7DmUPZR7OxnQOM
	CLIiteHM2RKwC0pTIWei9A9uF3xHiaA+z1V5iHR0jD9YQEdEAgmasSsVPGYbrpo726srH3OsgaIn0
	nsDMYrfVItPon32NYQEtCDVTNnzfXf3C/qFLinBI3eGPcWTkugtK3NWTZAxVvDkJzCayBYGJxIEgD
	TWeRl/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBY9-00000001w8l-2CP1;
	Tue, 03 Nov 2026 10:15:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBY7-00000001w3h-034m;
	Tue, 03 Nov 2026 10:15:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0008C601FF;
	Tue,  3 Nov 2026 10:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53311F000C1;
	Tue,  3 Nov 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700925;
	bh=5o98qwlKEQyOrCRjq2RUqHe7Txdo2HfIj4qXGPwficc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l4M9873zeOp+nuSn9vGGPWM/5zR54YN8iGYC/B8Y18HQJOpFdwDfuPsn2vNUNk+NP
	 Uhf2M+Btkoiph3PQBpwJsFhic896iAqepE0h9dLCpKlAT/9gUjbY5mhQLzGQ3/fL1f
	 ZsQ1uSDCfX8u5/3T+tY4zOt7H2ihasdNaaoxKbI2NBQYIYbtZO9nG9bwX8dcZbYdyO
	 0BQUezOpFtIVi/H+vhLMA7bUtpqmWfcSpK93Xv8oCzQ+t22pDSLZjSIfg3hXfKDps3
	 DdRnHbHugGUkSbZpCF5hrPiL7KiLQeeff3o/ayxbyjmYJq+PIMS+HKqulLooeXACS4
	 r4f891vSExf1A==
Date: Tue, 3 Nov 2026 12:15:16 +0200
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
Subject: Re: [PATCH 4/5] kexec_core: Clear the unused part of CMA segments
Message-ID: <aum0NFfSezGOiR0K@kernel.org>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-4-825b90ea23c4@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-4-825b90ea23c4@iscas.ac.cn>
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

On Fri, Oct 23, 2026 at 03:33:17PM +0800, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
> 
> kimage_load_cma_segment() copies the source data into pages that are not
> cleared, but zeroes nothing after it: the final memset() runs once the
> loop has consumed all of memsz. The tail of the last source page and
> every page beyond bufsz keep stale data, while the purgatory digest
> covers them as zeroes.
> 
> A kexec_file reboot then stops in purgatory on a digest mismatch, for
> instance when the DTB lands in a reused CMA page.
> 
> Zero the remainder of each page instead.
> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/kexec_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d05..0d6e10bea4e4 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -780,15 +780,15 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
>  			goto out;
>  		}
>  
> +		/* CMA pages are not cleared: zero the part without source data */
> +		memset(ptr + uchunk, 0, mchunk - uchunk);
> +
>  		ptr    += mchunk;
>  		mbytes -= mchunk;
>  
>  		cond_resched();
>  	}
>  
> -	/* Clear any remainder */
> -	memset(ptr, 0, mbytes);
> -
>  out:
>  	return result;
>  }
> 
> -- 
> 2.55.0
> 
> 

-- 
Sincerely yours,
Mike.

