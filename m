Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C532EB104A
	for <kexec@archiver.kernel.org>; Tue, 10 Mar 2026 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MSL+w0v7oyItZmGWWs64QhONDOI35vXCXF222iDqVM=; b=QQqSnxP+DrWpKbg+UtkgKoQIwm
	Wb3GzqgKcFvurUHCrY13rzQmz8vMTWk/yVNAwGHiSBGPbbyAqb1rV41ftYZxwOdjWY9SqyHvstSx3
	sHVo4uCcjVQiApH1AfNmXIVdMrn1w0+xDqODb93vESDDTs5vQJdx0Oqq2GI7uaZmITwDY6ekqKRZK
	Fh9ODhCFP6u/DAudHi+7sNRi7md+E+AiuVQO2RfD7otKABNf82WSseShhyrwqwc16myQNkDUwnCjp
	aX0LCozf++aB+lUZzxu4B6SdgwWuJxAFyle8Qxo9HR1TWMSuS4stTnc3SvVP4b9ssT2sHf9awaFM6
	LcLqGXrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuSI-00000009DGN-0rZT;
	Tue, 10 Mar 2026 10:36:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzuSF-00000009DG2-30qs
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 10:36:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 50C8244393;
	Tue, 10 Mar 2026 10:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FB4C19423;
	Tue, 10 Mar 2026 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139007;
	bh=W9mAwkbLlYnKfeePBjebcYRdBnJ6E2MpSEq54ioYRzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4P/dioTx1zil8ozOzqhL6X/9iGKpOVhuU526quBqtwWSPwFQSEZoIJMVmJJUsOF5
	 nwKORBgb0pGbSD59iNFGvajMzeEB+l90b66z07ro+54oDBh7pDJRwjyM2jjW4fM4pO
	 xcrbr14WA961xY1LpW+mTGorEMhcXxAR0O15Tg8HHIiCiRG8dLKVGWu/HHvBcZENzO
	 hXNLQnxrOmRnWvmMOMFR0ufoj3F6tuAXdD9kMzpfuGtqhlfmHXyrwOwBlv9FFYu/7d
	 +22JF3UWxgN3RP3N9VaBWLPofEMoo6/DvR+oB87o/Sqvkiy5/LNe5KvzyURJyMqiFq
	 a8o+ZkcX6YwPg==
Date: Tue, 10 Mar 2026 12:36:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v8 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
Message-ID: <aa_0OESNkyp8V2eF@kernel.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-4-c3abcf4ac750@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-kho-v8-4-c3abcf4ac750@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_033647_803866_20E7B163 
X-CRM114-Status: GOOD (  20.50  )
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

On Mon, Mar 09, 2026 at 06:41:47AM -0700, Breno Leitao wrote:
> kho_in_debugfs_init() has two problems when displaying incoming
> sub-blobs in debugfs:
> 
> 1. It uses the hardcoded property name "fdt" instead of
>    KHO_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
>    subtrees stored by the current kho_add_subtree().
> 
> 2. It calls fdt_totalsize() to determine blob sizes, which assumes
>    all blobs are FDTs. This breaks for non-FDT blobs like struct
>    kho_kexec_metadata.
> 
> Fix both issues by using KHO_SUB_TREE_PROP_NAME to find subtrees
> and reading the "blob-size" property from the FDT (persisted by
> kho_add_subtree()) instead of calling fdt_totalsize().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover_debugfs.c | 34 ++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index 7a100f2bf3947..257ee8a52be66 100644
> --- a/kernel/liveupdate/kexec_handover_debugfs.c
> +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/libfdt.h>
>  #include <linux/mm.h>
> +#include <linux/kho/abi/kexec_handover.h>
>  #include "kexec_handover_internal.h"
>  
>  static struct dentry *debugfs_root;
> @@ -121,23 +122,34 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>  	fdt_for_each_subnode(child, fdt, 0) {
>  		int len = 0;
>  		const char *name = fdt_get_name(fdt, child, NULL);
> -		const u64 *fdt_phys;
> -		void *sub_fdt;
> +		const u64 *blob_phys;
> +		const u64 *blob_size;
> +		void *blob;
>  
> -		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
> -		if (!fdt_phys)
> +		blob_phys = fdt_getprop(fdt, child,
> +					KHO_SUB_TREE_PROP_NAME, &len);
> +		if (!blob_phys)
>  			continue;
> -		if (len != sizeof(*fdt_phys)) {
> -			pr_warn("node %s prop fdt has invalid length: %d\n",
> -				name, len);
> +		if (len != sizeof(*blob_phys)) {
> +			pr_warn("node %s prop %s has invalid length: %d\n",
> +				name, KHO_SUB_TREE_PROP_NAME, len);
>  			continue;
>  		}
> -		sub_fdt = phys_to_virt(*fdt_phys);
> +
> +		blob_size = fdt_getprop(fdt, child,
> +					KHO_SUB_TREE_SIZE_PROP_NAME, &len);
> +		if (!blob_size || len != sizeof(*blob_size)) {
> +			pr_warn("node %s missing or invalid %s property\n",
> +				name, KHO_SUB_TREE_SIZE_PROP_NAME);
> +			continue;
> +		}
> +
> +		blob = phys_to_virt(*blob_phys);
>  		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
> -					     sub_fdt, fdt_totalsize(sub_fdt));
> +					     blob, *blob_size);
>  		if (err) {
> -			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
> -				ERR_PTR(err));
> +			pr_warn("failed to add blob %s to debugfs: %pe\n",
> +				name, ERR_PTR(err));
>  			continue;
>  		}
>  	}
> 
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

