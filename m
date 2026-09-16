Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D272C88E5C
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kryuK3liGiOsrOQQb3JdRd/XrDBXKZJdf0bb5gTtXVA=; b=ghikPYz5Svp4+36L7XzEXOpP0z
	jknpaprsPHQY4LtbGqrTGi/GDy97bNcF5WdwnEM3prlryED4syvP+9zcDiZk0YVxk4JNlgMJg7GwU
	g2ra5FcRr2eHkto7MQ3Oi0bVj+NBTD7uCYyQtRmh9zd6qhmxCsiX9L0vqawDfIGgjTWSN5M6Efm47
	pVVNeZRVNDhwnfi6wLvLkTqroN21eyl+qCB3wR1FLJh/mdLk67ln3i5BzQYY54nvDooqtVmLlkXVr
	v9mQ7JYguv6BLP/6IzsYW0tAuyzIcSRZpujRfBPr3HR9rZBbeswASnYrohL/cMC5RNWImVKuyKPZ2
	AI4ud1qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6l4K-00000008inW-3R9Y;
	Wed, 16 Sep 2026 08:32:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6l4J-00000008inN-2yHN
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 08:32:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A8414131C;
	Wed, 16 Sep 2026 08:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211411F000FF;
	Wed, 16 Sep 2026 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789547559;
	bh=kryuK3liGiOsrOQQb3JdRd/XrDBXKZJdf0bb5gTtXVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OE0zVRHywwZPRGzw7YjRr13x+B5BhcawMFrUjOnZ6UYVh2xMHPClEH7eMMRLHg1Ta
	 7383xDBAZx8aiTXPifqvkjz/Mzlzyu/vPr1sVy0IqIqgj914UgaLVVLse6c+FvxiOe
	 q/DsaHka4dg6nsJp1DoaOSMXlppy3fKbwLJsq+dhGQvACllR4eeE0uahd5SMJtHU/D
	 Ip7/c+4nt3hgP6HiJhggCs8ScgA8TgUCedPyHUKgHP4POlPRNovh9CZHMb1C2g+Tk7
	 tb0CIBNryPjpn7Njm5gW8fRbYiNZx1lPnJSzJsR/pj6WuKcX4F2sttv1kZw9KwyVEr
	 1XcJsl3KPxL0w==
Message-ID: <3c663c66-70ab-4c9b-a490-67deac9a572d@kernel.org>
Date: Wed, 16 Sep 2026 10:32:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] mm/memory-failure: keep inherited poisoned frames
 out of the buddy allocator
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 kas@kernel.org, kexec@lists.infradead.org,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 hannes@cmpxchg.or, shakeel.butt@linux.dev
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-9-3bc7a57bd503@debian.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260915-hwpoison-kho-v5-9-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/15/26 14:53, Breno Leitao wrote:
> When the pages are being given to the allocator, check if they are
> poisoned, and mark them as such.
> 
> Similar to unaccepted memory, hook it in __free_pages_core(), and thus
> the frames never enter the allocator, rather than being taken back out
> of it.
> 
> A block runs up to MAX_PAGE_ORDER and a unit is 2MB, so hold back only
> the frames the table covers and free the rest one at a time. The
> allocator merges them back up, so a unit costs the frames it names, not
> the whole block.
> 
> The frames that are freed go back through accept_and_free_block(), so a
> clean frame in a block that is still unaccepted is accepted first.
> 
> A frame is flagged before its memory block exists, so the per block
> counter is seeded from the page flag when the block is created rather
> than incremented here.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b07b5f4751cb95..cca67a2702a421 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1597,6 +1597,25 @@ static void __meminit accept_and_free_block(struct page *page,
>  	__free_pages_ok(page, order, FPI_TO_TAIL);
>  }
>  
> +static void __meminit free_poisoned_block(struct page *page, unsigned int order,
> +					  enum meminit_context context)
> +{
> +	unsigned long i, nr_pages = 1UL << order;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		struct page *p = page + i;
> +		phys_addr_t phys = page_to_phys(p);
> +
> +		if (range_contains_poisoned_memory(phys, PAGE_SIZE)) {
> +			hwpoison_boot_page(p, context);
> +			continue;
> +		}
> +
> +		/* this part of the block is not poisoned */
> +		accept_and_free_block(p, 0);
> +	}
> +}
> +
>  void __meminit __free_pages_core(struct page *page, unsigned int order,
>  		enum meminit_context context)
>  {
> @@ -1631,6 +1650,13 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
>  		atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  	}
>  
> +	/* First: a block parked by __free_unaccepted() never returns here. */
> +	if (range_contains_poisoned_memory(page_to_phys(page),
> +					   PAGE_SIZE << order)) {
> +		free_poisoned_block(page, order, context);
> +		return;
> +	}
> +
>  	accept_and_free_block(page, order);
>  }
>  
> 


