Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B5CE8D55
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z116tVXEe9/MkljJcWwj3SfWixMbIZ/hduWK0XTrkIs=; b=U99GVxjEszkqFTwt229nqdI6j7
	HcuHjkeud+I/sC8JYM6GoAzHZ5XUpWdcfpNOVhZcp8LgpqJ4ArMIa25SmnVf1BnAXvg0uf1LkpvOn
	EuhCkxa2wWQn5mgEJd3o8z/4XqKHvk7RlQ1PdO7wX4/pI9AGGAH6YpoRo1X0jgorucr5cUpyNouuW
	Gq1z8Uj4Dk7E1u07n2mGfozniOEHigBM/EQW2rILNnJuWC7eJexr2Zo4AeDYrm0H4Go8+ELVtJih9
	iSA7iV9qJ1aTFbASwoeH15RO7KKMZ8CECXiYbHu8fxDforc+YZSoZ18DdbHbuRIkSvzlO5UT5fzZC
	eQi74uOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJx99-0000000CnXw-062y;
	Fri, 14 Nov 2025 16:59:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJx96-0000000CnXS-4C5p
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:59:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BF4E43DBD;
	Fri, 14 Nov 2025 16:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4000C4CEF1;
	Fri, 14 Nov 2025 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763139576;
	bh=7cmvOMMRkq7ABj9bLQADRb0yWVUhjMz3dsMaV2GWWsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kBi+hiwo08/9mOe6EG2q1yq84Ff8LNY2+8836aE5rlJv1D7bXe9pmypkSuifU3fh3
	 euRqZaH2A3RgYi3jrloTypTJDJhUPQeUGuHW82BCUf2KyIzhyYeeb658jkRzdPQltK
	 BoOJ1jIdNh+OuaIDgwTIapMLlHt2quM88bE7z6cU25Q0yZjj0ckknCg4fYq3Sf62Yp
	 JwGmvLddaxWMIQextoL4nvDn5pBlZ3oVE+kUdvU0PafBTjXvBXo5Jt8f6KtG2hRHlk
	 dfH3RoNx5t9DgwYtIVGi0xW0bHL/YKRb+rCXX7J5BvokHxLQWzvi15ewRV65ck05tr
	 6IgfkYlkHBIWw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 05/13] kho: Always expose output FDT in debugfs
In-Reply-To: <20251114155358.2884014-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:50 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-6-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:59:32 +0100
Message-ID: <mafs0pl9k7dor.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_085937_059934_9BC4B8C1 
X-CRM114-Status: GOOD (  18.71  )
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, the output FDT is added to debugfs only when KHO is
> finalized and removed when aborted.
>
> There is no need to hide the FDT based on the state. Always expose it
> starting from initialization. This aids the transition toward removing
> the explicit abort functionality and converting KHO to be fully
> stateless.
>
> Also, pre-zero the FDT tree so we do not expose random bits to the
> user and to the next kernel.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 83aca3b4af15..cd8641725343 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1147,8 +1147,6 @@ int kho_abort(void)
>  	__kho_abort();
>  	kho_out.finalized = false;
>  
> -	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
> -
>  	return 0;
>  }
>  
> @@ -1219,9 +1217,6 @@ int kho_finalize(void)
>  
>  	kho_out.finalized = true;
>  
> -	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
> -					 kho_out.fdt, true));
> -
>  	return 0;
>  }
>  
> @@ -1310,7 +1305,7 @@ static __init int kho_init(void)
>  	if (!kho_enable)
>  		return 0;
>  
> -	fdt_page = alloc_page(GFP_KERNEL);
> +	fdt_page = alloc_page(GFP_KERNEL | __GFP_ZERO);

If I read the series right, patch 9 will make this a full FDT with no
subnodes. That makes a lot more sense than a zero page. Thinking out
loud.

For this patch,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  	if (!fdt_page) {
>  		err = -ENOMEM;
>  		goto err_free_scratch;
> @@ -1344,6 +1339,9 @@ static __init int kho_init(void)
>  			init_cma_reserved_pageblock(pfn_to_page(pfn));
>  	}
>  
> +	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
> +					 kho_out.fdt, true));
> +
>  	return 0;
>  
>  err_free_fdt:

-- 
Regards,
Pratyush Yadav

