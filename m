Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8875C1093190
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgcAZNZhW6hoKemEt1fgC5r6U169uUhLD+jpaJXLEoM=; b=DFzLeCWY3CaKczx8n4ymwukoVm
	qe1eRughVVGB4RBJxh3WFDpmzHL4PRrX+A5dKQ8TG8IMRC7HT1pbJQoJbR5urCJxymdim3MzViekw
	ZoUugD58XUyWHSKHBiajO7w5aTawDdvrXa4De0IvxfqWwtjiKgg8xdZh6ZNdLHT8w5EFEV+CaKqKF
	p7myqPyJNNPNYRfHCGQ/6Spg6tpJKJD2pZAYOwZ8xb4umhOq0vooQtX52ySf5aXGRqG2rAR4R3+xb
	NY11kMxJpDvrHPj08Xk/ffmy9M7G9W3wj9NlYBUSR426dciDkIZw1CuLWcC8mtxGoQ0hawwu5MVwo
	Nv6g1/jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ver-0000000CQ3I-0KhW;
	Fri, 20 Mar 2026 08:56:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Vep-0000000CQ3C-2wQW
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 08:56:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C384560127;
	Fri, 20 Mar 2026 08:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6F9C4CEF7;
	Fri, 20 Mar 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996998;
	bh=ZJNfT3lPJxzaGdT6bGFu3WgbabeykkSDcAaOFE+CTEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IwWduJK3Q0ps7Q3T+6/cPljz9bzlzMD7YqehSZQMUvmFFsKNNaEaT95LdBmvO9GZ+
	 lfFcqCjV8DbrRsRL9Ejn3CjOPulO8Hz7jBmzM6QLuIdqFibLx3wFc/nlIqvK8ftg5i
	 m/tEnf74BYEjDiRWWfvBLfYs2Qa/MhZdCaz++kKi75vnjLKGmYep338ZfTx5cAa3dk
	 VHR21V/T9FAgHlP3jIcO9L7mmeBt9rTSotZmIfD7CN+FQH0+tEG8pVuIivy2p6BrB/
	 EmW9cbnzzY4hTZCmlQhlrmLpYqdTu6BZ9aEzMIyAl0fxpaL6QV1Wd2lyyDxPBmUQVG
	 jVPTvbJrZeGBA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] kho: use checked arithmetic in deserialize_bitmap()
In-Reply-To: <20260319210528.1694513-2-elver@google.com> (Marco Elver's
	message of "Thu, 19 Mar 2026 22:03:53 +0100")
References: <20260319210528.1694513-2-elver@google.com>
Date: Fri, 20 Mar 2026 08:56:34 +0000
Message-ID: <2vxzzf42c20t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marco,

On Thu, Mar 19 2026, Marco Elver wrote:

> The function deserialize_bitmap() calculates the reservation size using:
>
>     int sz = 1 << (order + PAGE_SHIFT);
>
> If a corrupted KHO image provides an order >= 20 (on systems with 4KB
> pages), the shift amount becomes >= 32, which overflows the 32-bit
> integer. This results in a zero-size memory reservation.
>
> Furthermore, the physical address calculation:
>
>     phys_addr_t phys = elm->phys_start + (bit << (order + PAGE_SHIFT));
>
> can also overflow and wrap around if the order is large. This allows a
> corrupt KHO image to cause out-of-bounds updates to page->private of
> arbitrary physical pages during early boot.
>
> Fix this by changing 'sz' to 'unsigned long' and using checked add and
> shift to safely calculate the shift amount, size, and physical address,
> skipping malformed chunks. This allows preserving memory with an order
> larger than MAX_PAGE_ORDER.
>
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Marco Elver <elver@google.com>

deserialize_bitmap() is replaced with the radix tree with this series
[0]. Can you please redo these changes on top of that?

Also, a couple comments below.

[0] https://lore.kernel.org/linux-mm/20260206021428.3386442-1-jasonmiu@google.com/

> ---
> v2:
> * Switch to unsigned long and use checked shift and add (Mike).
>
> v1: https://lore.kernel.org/all/20260214010013.3027519-1-elver@google.com/
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index cc68a3692905..0d8417dcd3ff 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -19,6 +19,7 @@
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
>  #include <linux/memblock.h>
> +#include <linux/overflow.h>
>  #include <linux/page-isolation.h>
>  #include <linux/unaligned.h>
>  #include <linux/vmalloc.h>
> @@ -461,15 +462,29 @@ static void __init deserialize_bitmap(unsigned int order,
>  				      struct khoser_mem_bitmap_ptr *elm)
>  {
>  	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
> +	unsigned int shift;
>  	unsigned long bit;
> +	unsigned long sz;
> +
> +	if (check_add_overflow(order, PAGE_SHIFT, &shift) ||
> +	    check_shl_overflow(1UL, shift, &sz)) {
> +		pr_warn("invalid order %u for preserved bitmap\n", order);
> +		return;
> +	}

Isn't it simpler to just check if (order + PAGE_SHIFT) > 63? KHO is only
designed to work on 64-bit platforms so we know the max possible shift
already. Is there any reason to call the proper overflow functions? The
only reason I ask is because I find the open-coded check easier to read.

>  
>  	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
> -		int sz = 1 << (order + PAGE_SHIFT);
> -		phys_addr_t phys =
> -			elm->phys_start + (bit << (order + PAGE_SHIFT));
> -		struct page *page = phys_to_page(phys);
> +		phys_addr_t offset, phys;
> +		struct page *page;
>  		union kho_page_info info;
>  
> +		if (check_shl_overflow((phys_addr_t)bit, shift, &offset) ||
> +		    check_add_overflow(elm->phys_start, offset, &phys)) {
> +			pr_warn("invalid phys layout for preserved bitmap\n");
> +			return;
> +		}
> +
> +		page = phys_to_page(phys);
> +
>  		memblock_reserve(phys, sz);
>  		memblock_reserved_mark_noinit(phys, sz);
>  		info.magic = KHO_PAGE_MAGIC;

-- 
Regards,
Pratyush Yadav

