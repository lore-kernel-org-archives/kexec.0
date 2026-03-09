Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244F7EF3716
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1lIZx7jxksyX/dRkyXna8WJ9zLTRrgGdsrdZAvKcRI=; b=hOzC/PHyTI2e8GwFnEUUYvC/Jk
	oxqf5fy/Hc3WIeJ7V43+rCHq97SNgUGYfhqEstv2NvNsnmwqsX+N56tiem1iORgDc+RAn5r9yMgqK
	O2EyrV3lHKyeQQ98SnTdjZXl2lcXEuj4rAPOjgTeyijjg7ADx/F8tJOycBN9sJ6/cBV9GpM/vn+Vf
	u6xljKKFruwnZlEsZfJJC3OSLbp+mJFygU961NMTLDxw2BvP+mRagi72/ZQDeYJ2CsM8CtDm+83mN
	umB+YGwqhzUXJAEa3RF4Y/DCBHLa01jlAJveFNg2hQayjSVWgrph4VkRl5aurdpVG24IFZkv+4dY6
	yN3RVy1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVtE-00000006sqG-2s5J;
	Mon, 09 Mar 2026 08:23:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzVtD-00000006sqA-1120
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 08:22:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18637600CB;
	Mon,  9 Mar 2026 08:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B623C4CEF7;
	Mon,  9 Mar 2026 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773044577;
	bh=V/B5tPmLCgAxbN8UIEDAM4TeuWOKraxmkgH51tGu4uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3b92q7bgFaOMmV3eGLdzebrY0/Sr+0bh6qjjVKefF860DvD1c1diA+xcCEQSmiek
	 bmvIjE53jg20sq2gBg+7p/LuokK09L0Giolq0uT/UOHHgc9MJtjIB3cMCqwPMGxlQ1
	 kX5mGd8TNaqCBYpqvuDW+pBSdtOiCO3aIlJ3gRxeTVW4PIsDnAMKzsytp0APqz3sWu
	 EKAYn6dGohnRiYx5K+hJUOYxUnxrL/rrDEhMnaLcIh50LQNGcc5aAZAKeUifPAWf5F
	 3ShdhuDfGkK99AG/vwbd1ulwOU2eX/UHbTTTevAfbcR3baUHGm7hpB+EXgW4vYHawr
	 pRWS78C/KKv8w==
Date: Mon, 9 Mar 2026 10:22:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v7 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
Message-ID: <aa6DWto0xY5EPyxK@kernel.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
 <20260306-kho-v7-4-404d14c188bb@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-kho-v7-4-404d14c188bb@debian.org>
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

On Fri, Mar 06, 2026 at 04:39:23AM -0800, Breno Leitao wrote:
> kho_in_debugfs_init() has two problems when displaying incoming
> sub-blobs in debugfs:
> 
> 1. It uses the hardcoded property name "fdt" instead of
>    KHO_FDT_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
>    subtrees stored by the current kho_add_subtree().
> 
> 2. It calls fdt_totalsize() to determine blob sizes, which assumes
>    all blobs are FDTs. This breaks for non-FDT blobs like struct
>    kho_kexec_metadata.
> 
> Fix both issues by using KHO_FDT_SUB_TREE_PROP_NAME to find subtrees
> and reading the "blob-size" property from the FDT (persisted by
> kho_add_subtree()) instead of calling fdt_totalsize().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/liveupdate/kexec_handover_debugfs.c | 38 ++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> index 7a100f2bf3947..fc2baa8b104fd 100644
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
> @@ -121,23 +122,36 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
>  	fdt_for_each_subnode(child, fdt, 0) {
>  		int len = 0;
>  		const char *name = fdt_get_name(fdt, child, NULL);
> -		const u64 *fdt_phys;
> -		void *sub_fdt;
> -
> -		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
> -		if (!fdt_phys)
> +		const u64 *blob_phys;
> +		const u64 *blob_size;
> +		void *blob;
> +		size_t size;

Do we really need two size variables? Can't we just have u64 *size and pass
*size to __kho_debugfs_blob_add()?

> +
> +		blob_phys = fdt_getprop(fdt, child,
> +					KHO_FDT_SUB_TREE_PROP_NAME, &len);
> +		if (!blob_phys)
>  			continue;
> -		if (len != sizeof(*fdt_phys)) {
> -			pr_warn("node %s prop fdt has invalid length: %d\n",
> -				name, len);
> +		if (len != sizeof(*blob_phys)) {
> +			pr_warn("node %s prop %s has invalid length: %d\n",
> +				name, KHO_FDT_SUB_TREE_PROP_NAME, len);
>  			continue;
>  		}
> -		sub_fdt = phys_to_virt(*fdt_phys);
> +
> +		blob_size = fdt_getprop(fdt, child,
> +					KHO_FDT_SUB_TREE_SIZE_PROP_NAME, &len);
> +		if (!blob_size || len != sizeof(*blob_size)) {
> +			pr_warn("node %s missing or invalid %s property\n",
> +				name, KHO_FDT_SUB_TREE_SIZE_PROP_NAME);
> +			continue;
> +		}
> +		size = (size_t)*blob_size;
> +
> +		blob = phys_to_virt(*blob_phys);
>  		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
> -					     sub_fdt, fdt_totalsize(sub_fdt));
> +					     blob, size);
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
> 

-- 
Sincerely yours,
Mike.

