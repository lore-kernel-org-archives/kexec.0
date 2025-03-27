Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB001C36011
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AYkt3UZmdT/puNZc9A2b9Jl693S9yxUDwwUM5aOO5U=; b=b2KAXrcEb7OS20vpqgcdL2UH7S
	1YyXGLETThlhQ7IoecIRZhpQCb01ZT6/gO16SwLe14gCPcyjKBrln2sMzFFMLmLIeJZDNuag/huLI
	ar58jdxj7ufmSliO/fF7cjFT7mvEqS6iMx9O1TL1j22ACYx2Ol7gfKFbs8ch48lJVbPMumqfJSK08
	UaRY6jvZrGRSpBXO0/MPJG8oqNQVsJNsP/LoPCrE9tngsHeZnXSojbYXsFJhv23WvE8VJYa0ncdWq
	mu+2wz2erimQeskFxsLE2LkwCwN8woaAMwjuREwj6QzCGOeIkZXcku9RN+txiKxvu7o2mG5oAxteV
	KDktv4Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnFO-0000000B45I-1o9o;
	Thu, 27 Mar 2025 13:26:14 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txk5H-0000000AeMO-1crI;
	Thu, 27 Mar 2025 10:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743069815; x=1774605815;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1AYkt3UZmdT/puNZc9A2b9Jl693S9yxUDwwUM5aOO5U=;
  b=s0h4PbvR80dJ3wuah7dIgkJVCYgkCORaVa/DtROc1RZmyryIQMtTiV4W
   1/UlyTu3DG7MT1QCxYf+u4esUIaUo0GcOE+LJKLOo7+WL7LiH9NWvY0+A
   alHxhWY/0SNHEUdl1UJOwGqXaCp61AaFkNhB2ACIFRJh7dqCjF/oW6xWL
   A=;
X-IronPort-AV: E=Sophos;i="6.14,280,1736812800"; 
   d="scan'208";a="478704841"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:03:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:25558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.232:2525] with esmtp (Farcaster)
 id a4642778-ac88-44ce-8afd-012d72d51f0e; Thu, 27 Mar 2025 10:03:25 +0000 (UTC)
X-Farcaster-Flow-ID: a4642778-ac88-44ce-8afd-012d72d51f0e
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 10:03:18 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 10:03:18 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 10:03:18 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTP id BE3CE40570;
	Thu, 27 Mar 2025 10:03:17 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 7A8925228; Thu, 27 Mar 2025 10:03:17 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Changyuan Lyu <changyuanl@google.com>
CC: <linux-kernel@vger.kernel.org>, <graf@amazon.com>,
	<akpm@linux-foundation.org>, <luto@kernel.org>, <anthony.yznaga@oracle.com>,
	<arnd@arndb.de>, <ashish.kalra@amd.com>, <benh@kernel.crashing.org>,
	<bp@alien8.de>, <catalin.marinas@arm.com>, <dave.hansen@linux.intel.com>,
	<dwmw2@infradead.org>, <ebiederm@xmission.com>, <mingo@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <krzk@kernel.org>, <rppt@kernel.org>,
	<mark.rutland@arm.com>, <pbonzini@redhat.com>, <pasha.tatashin@soleen.com>,
	<hpa@zytor.com>, <peterz@infradead.org>, <robh+dt@kernel.org>,
	<robh@kernel.org>, <saravanak@google.com>,
	<skinsburskii@linux.microsoft.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<will@kernel.org>, <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <20250320015551.2157511-10-changyuanl@google.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
	<20250320015551.2157511-10-changyuanl@google.com>
Date: Thu, 27 Mar 2025 10:03:17 +0000
Message-ID: <mafs0y0wqrdsq.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_030335_572741_FCDB0A46 
X-CRM114-Status: GOOD (  31.79  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:10:27 -0700
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

Hi Changyuan,

On Wed, Mar 19 2025, Changyuan Lyu wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Introduce APIs allowing KHO users to preserve memory across kexec and
> get access to that memory after boot of the kexeced kernel
>
> kho_preserve_folio() - record a folio to be preserved over kexec
> kho_restore_folio() - recreates the folio from the preserved memory
> kho_preserve_phys() - record physically contiguous range to be
> preserved over kexec.
> kho_restore_phys() - recreates order-0 pages corresponding to the
> preserved physical range
>
> The memory preservations are tracked by two levels of xarrays to manage
> chunks of per-order 512 byte bitmaps. For instance the entire 1G order
> of a 1TB x86 system would fit inside a single 512 byte bitmap. For
> order 0 allocations each bitmap will cover 16M of address space. Thus,
> for 16G of memory at most 512K of bitmap memory will be needed for order 0.
>
> At serialization time all bitmaps are recorded in a linked list of pages
> for the next kernel to process and the physical address of the list is
> recorded in KHO FDT.

Why build the xarray only to transform it down to bitmaps when you can
build the bitmaps from the get go? This would end up wasting both time
and memory. At least from this patch, I don't really see much else being
done with the xarray apart from setting bits in the bitmap.

Of course, with the current linked list structure, this cannot work. But
I don't see why we need to have it. I think having a page-table like
structure would be better -- only instead of having PTEs at the lowest
levels, you have the bitmap.

Just like page tables, each table is page-size. So each page at the
lowest level can have 4k * 8 == 32768 bits. This maps to 128 MiB of 4k
pages. The next level will be pointers to the level 1 table, just like
in page tables. So we get 4096 / 8 == 512 pointers. Each level 2 table
maps to 64 GiB of memory. Similarly, level 3 table maps to 32 TiB and
level 4 to 16 PiB.

Now, __kho_preserve() can just find or allocate the table entry for the
PFN and set its bit. Similar work has to be done when doing the xarray
access as well, so this should have roughly the same performance. When
doing KHO, we just need to record the base address of the table and we
are done. This saves us from doing the expensive copying/transformation
of data in the critical path.

I don't see any obvious downsides compared to the current format. The
serialized state might end up taking slightly more memory due to upper
level tables, but it should still be much less than having two
representations of the same information exist simultaneously.

>
> The next kernel then processes that list, reserves the memory ranges and
> later, when a user requests a folio or a physical range, KHO restores
> corresponding memory map entries.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
[...]
> +static void deserialize_bitmap(unsigned int order,
> +			       struct khoser_mem_bitmap_ptr *elm)
> +{
> +	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
> +	unsigned long bit;
> +
> +	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
> +		int sz = 1 << (order + PAGE_SHIFT);
> +		phys_addr_t phys =
> +			elm->phys_start + (bit << (order + PAGE_SHIFT));
> +		struct page *page = phys_to_page(phys);
> +
> +		memblock_reserve(phys, sz);
> +		memblock_reserved_mark_noinit(phys, sz);

Why waste time and memory building the reserved ranges? We already have
all the information in the serialized bitmaps, and memblock is already
only allocating from scratch. So we should not need this at all, and
instead simply skip these pages in memblock_free_pages(). With the
page-table like format I mentioned above, this should be very easy since
you can find out whether a page is reserved or not in O(1) time.

> +		page->private = order;
> +	}
> +}
> +
> +static void __init kho_mem_deserialize(void)
> +{
> +	struct khoser_mem_chunk *chunk;
> +	struct kho_in_node preserved_mem;
> +	const phys_addr_t *mem;
> +	int err;
> +	u32 len;
> +
> +	err = kho_get_node(NULL, "preserved-memory", &preserved_mem);
> +	if (err) {
> +		pr_err("no preserved-memory node: %d\n", err);
> +		return;
> +	}
> +
> +	mem = kho_get_prop(&preserved_mem, "metadata", &len);
> +	if (!mem || len != sizeof(*mem)) {
> +		pr_err("failed to get preserved memory bitmaps\n");
> +		return;
> +	}
> +
> +	chunk = *mem ? phys_to_virt(*mem) : NULL;
> +	while (chunk) {
> +		unsigned int i;
> +
> +		memblock_reserve(virt_to_phys(chunk), sizeof(*chunk));
> +
> +		for (i = 0; i != chunk->hdr.num_elms; i++)
> +			deserialize_bitmap(chunk->hdr.order,
> +					   &chunk->bitmaps[i]);
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +	}
> +}
> +
>  /* Helper functions for KHO state tree */
>  
>  struct kho_prop {
[...]

-- 
Regards,
Pratyush Yadav

