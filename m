Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0763FC5B572
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49GLJIYRy4vZ3cG5rYKQJNFQilEnE70SWvjy9to5mKY=; b=mSfsoJO0QJDj+UJFSbklnwXb+0
	GTWCqxPc8GNKGla+pAJyXSRpvcqpXQpvzkG2Mn4T1/45BSnYENBirFk997IhNo/qtOfXI8DKkRXAO
	4miBFcHhrrxyiMM8lPHL2S5OEKmdBHrPjXm6ePa4EbPSMsd2zxXHrW1kJ5iATfUGIafvRq5Dry7dc
	2jYB/BR2xunj6KS6LBTjJPB1qxfuNxevdMnRWtAn+/myDeP4zt6KqB46o7mV9TzMfA7jS1a+FMJyq
	KTaFFP4W2VLrrG67BvqSl5ZNHOQAWEDXa9HuaNcshIylCAzW2PfwZuZHkEojSccoNzuIt9tgWhEbq
	ge5n/rCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqG7-00000005Ruw-1cI2;
	Mon, 17 Aug 2026 05:51:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvqG6-00000005Ruq-31oo
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 05:51:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C47F943990;
	Mon, 17 Aug 2026 05:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9EC1F000E9;
	Mon, 17 Aug 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786945901;
	bh=49GLJIYRy4vZ3cG5rYKQJNFQilEnE70SWvjy9to5mKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2gKdWFh05E+WTUIOy6fVlmJoZ3AvzL3kKF6IpS67NmfM0FfdNGCl0v01yMKbnGC5
	 gdYwLQP5f3+qFGLh37gfG4MPQtnrkZ/Ly5TzzUuhdbxJEpKQzEOewIjVencSyP5sWg
	 qePR8aIdDUEXfbYtP2RFGB7IRpDpKJR3GnykUJ5p1yZFfcoxDTNJNy80cVP7Zr10ZY
	 o6S9F93N96hliFB9V0GwS0CS0qP5agd9pNj/qum8Hcal7Syo8NGbz0OdNbKfOqpKWA
	 zjROHDvoZF+n5TBVvlruFBx7pLDYILQsS0OoalotCdVlBLjku764siAifLFJzQ/S6M
	 X8q/9FNobYH5A==
Date: Mon, 17 Aug 2026 08:51:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kiarash Azarnia <kiarash.azarnia@gmail.com>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix signed shift UB in
 kho_preserved_memory_reserve()
Message-ID: <aoKhZqkTNUJGpOEf@kernel.org>
References: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
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

On Sun, Aug 16, 2026 at 12:30:37PM +0330, Kiarash Azarnia wrote:
> kho_preserved_memory_reserve() computes the size of a preserved
> reservation as:
> 
> 	sz = 1 << (order + PAGE_SHIFT);
> 
> `1` is a signed int, so the shift is signed-int arithmetic. For order
> 19 (a 2 GiB region) it produces 1 << 31, which is unrepresentable in
> int and is undefined behavior; in practice it yields 0x80000000,
> sign-extended on the assignment to the u64 sz. For order >= 20 the
> shift count exceeds the width of int, which is also undefined. The
> return value of memblock_reserve() is ignored and memblock_cap_size()
> clamps the bogus size, so the kernel silently reserves the wrong
> amount of memory for the preserved region.
> 
> kho_alloc_preserve() caps order at MAX_PAGE_ORDER and cannot reach
> order 19, but a boot-time reserve_mem= region of at least 2 GiB drives
> kho_preserve_pages() to compute order 19, and kho_preserve_pages() is
> EXPORT_SYMBOL_GPL(), so the path is reachable.

This looks like LLM generated, please make sure to add Assisted-by tag next
time.
 
> Cast the shift operand to u64 so the arithmetic is done in 64 bits:
> 
> 	sz = (u64)1 << (order + PAGE_SHIFT);
> 
> Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiarash Azarnia <kiarash.azarnia@gmail.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 175c08a6e41e..c79f48bd64ac 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -501,7 +501,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
>  	struct page *page;
>  	u64 sz;
>  
> -	sz = 1 << (order + PAGE_SHIFT);
> +	sz = (u64)1 << (order + PAGE_SHIFT);
>  	page = kho_get_preserved_page(phys, order);

This is already fixed:
https://patch.msgid.link/20260727150240.889555-1-pratyush@kernel.org
  
>  	/* Reserve the memory preserved in KHO in memblock */
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.

