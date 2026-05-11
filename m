Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75AECD37B9
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2zffpQEMSxbFE0uJA4SQFtegz0TpogLtn+Le+lt3tk=; b=amtEtQJDXdSTvVuApUFG5H+nZz
	KohkRnqAePARaEGwk6+TZXgGJIiSCcAWq68wXoZl21+MCEEjtD8NDAg/DcRQB5PKwopuMcUVZmjy/
	86A8FcnLdnKGKh/J2Eug5Apu48jRPeKXIWGSqqwxYFGu71rg9aMznDa9h+xlGDhE5m5J+UIcgNHdf
	7zZdZXQA9EeWUZj3rMnMM4OQzk+ewwnpYCaY8xJvMbNlLZVoKAAJzSylCVx1+XTrEx+5JhrzVKZJJ
	BF/QmUhUxlCJyWLbg4Uu0hS+WT3pnbGc1FJ/J5FZVNMAFy84FljPRc7oYN8od66ZU16J8Ub/nUHgd
	PtKDCPOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOs0-0000000DKnl-31b0;
	Mon, 11 May 2026 11:32:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOrz-0000000DKnL-1Aop
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:32:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 61BCA6001A;
	Mon, 11 May 2026 11:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFE1C2BCB0;
	Mon, 11 May 2026 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778499138;
	bh=qNNqg0dnTiPNdw7XCSPl1o8PJe8uHezO/mLjClsBB+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUh8viXlk8oQo393EqkU4YkTeVj3ZpVUXp0PN/Ad7bPd9Ezgc8lq3+2nL/ZRxppyj
	 aEPVqg4XfaJvMtLRm6IZp8dvIui5iGZrZGlejvS6S4Vn6r3o0IdiZH5TCM+UNfE2z/
	 8vAYGoqba9jYzfa2W2u0sHconpFBsvfBSazyCAGr+uCR3kkRvguHqk/ovbgjQ7bpxC
	 9VBtGVVzL7XT3bwGB+vg7UIdqAYT5stR/fsd4Tg9tTTSpVU7bgnLKVGXnR/rGdM1Nn
	 CqK0vF8ya8wli7tvt066pA3NbJBe+MdFm3jHEo9YcPJCFXcPTLi+LFgfszgc0j2KY3
	 xw7LdbQKbr47g==
Date: Mon, 11 May 2026 14:32:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
Message-ID: <agG-OuOTAg5YD-CV@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-2-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-2-pratyush@kernel.org>
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

On Wed, Apr 29, 2026 at 03:39:03PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO radix tree is a data structure that can track the presence or
> absence of an arbitrary key, with nothing inherently tied to KHO memory
> preservation tracking. This was one of the design goals of the radix
> tree. This was done to enable it to be re-used by other users of KHO.
> 
> Despite that, the radix tree APIs are very closely tied to KHO memory
> preservation tracking. Adding a key is done by kho_radix_add_page(),
> which encodes it as a page tracking operation and takes in PFN and
> order. kho_radix_del_page() does the same. These functions encode the
> key internally that goes into the radix tree. kho_radix_walk_tree() does
> the same by baking the PFN and order into the callback arguments.
> 
> Generalize the APIs by taking the key directly and doing the encoding at
> the callers. Rename the functions to kho_radix_add_key() and
> kho_radix_del_key(). In practice, this removes a line each from the
> functions and moves the encoding function call to the callers.
> Similarly, update kho_radix_tree_walk_callback_t to take the key
> directly.
> 
> To keep the naming convention clearer, rename
> kho_radix_{encode,decode}_key() to kho_{encode,decode}_radix_key().
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kho_radix_tree.h     | 18 +++----
>  kernel/liveupdate/kexec_handover.c | 76 ++++++++++++++----------------
>  2 files changed, 42 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> index 84e918b96e53..f368f3b9f923 100644
> --- a/include/linux/kho_radix_tree.h
> +++ b/include/linux/kho_radix_tree.h
> @@ -85,7 +85,7 @@ static struct kho_out kho_out = {
>  };
>  
>  /**
> - * kho_radix_encode_key - Encodes a physical address and order into a radix key.
> + * kho_encode_radix_key - Encodes a physical address and order into a radix key.

Let's keep kho_radix_ prefix for namespasing please.
This is the common practice these days.

>   * @phys: The physical address of the page.
>   * @order: The order of the page.
>   *

...

> @@ -144,24 +144,21 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
>  }
>  
>  /**
> - * kho_radix_add_page - Marks a page as preserved in the radix tree.
> + * kho_radix_add_key - Add a key to the radix tree.
>   * @tree: The KHO radix tree.
> - * @pfn: The page frame number of the page to preserve.
> - * @order: The order of the page.
> + * @key: The key to add.
>   *
> - * This function traverses the radix tree based on the key derived from @pfn
> - * and @order. It sets the corresponding bit in the leaf bitmap to mark the
> - * page for preservation. If intermediate nodes do not exist along the path,
> - * they are allocated and added to the tree.
> + * This function traverses the radix tree based on the key provided. It sets the

Nit:                                                     @key here and in
the comments below.

> + * corresponding bit in the leaf bitmap to mark the key as present. If
> + * intermediate nodes do not exist along the path, they are allocated and added
> + * to the tree.
>   *
>   * Return: 0 on success, or a negative error code on failure.
>   */

-- 
Sincerely yours,
Mike.

