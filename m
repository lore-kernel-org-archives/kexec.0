Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00A1C61CE7
	for <kexec@archiver.kernel.org>; Fri,  6 Jun 2025 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+ln5P26Ak/j4ElmXSdvwPFgYvBe+Jc+lOmVACLTtk8=; b=UxPr2McTCZIxFoXmbXtjJx/pM5
	OdqJtK5qVWpikGUNDByKjjzaYmdRFz3puVV/vL31UgEjzHBNRR7eJ/XvgWB1AG2N8+jglQ9d/pzJ7
	7iz649WAQdhQynzmy5K9GHfQ0JEv5g8fQ4vfkhTx784o12mF8d1KWp28CMBl6oCEqT5IDAWroCrUE
	KOmNhtaNJwf4RpKqudhVDDp2gsBebztM1lhIelYotoSjwwyIIH/X5U4h/pteZul7z+lHst7WbOgCN
	nBgmCvYFoFUxkLmrfseG4FqWbpbiTBc/R4eLzifyNlBa1nN42bDYvXAYo/X+Xa/Kr+F3w/ooy6QQX
	eqnu3wSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNZsA-00000000d5G-252n;
	Fri, 06 Jun 2025 16:24:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNZqZ-00000000cqE-2UUv
	for kexec@lists.infradead.org;
	Fri, 06 Jun 2025 16:23:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BED943779;
	Fri,  6 Jun 2025 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92EC4CEEB;
	Fri,  6 Jun 2025 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749226989;
	bh=6rhc/ZDVVnpQpTCIp4jX95hAhu4FDuDrKeo8BKnWZ3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sQPmZdLHLDPhq6jJ5XL+69EoRnhjMkxvVY02bXGdIzR8rAJFIDjMWNkcQ3mzkVyOw
	 SWxGsxofSa1kUHpBTyAahAd6/+RXffUuxRDtPig2b8G8kbHEkUiR1Qr63ZZnKQFXWp
	 VAj7YZHGU4wHItd2HmgNa1LocUE1ghegfrqy/rimkd/ZEXb8cOx6zolEvp0+LqGfZp
	 vSc8M16uHz7Gmqq8D6pZ46l0S0t5aSJB6s4Rn0vDS6FwBEYP91i6zYcFTme3lt15P4
	 6AyWwRzzV2jZWdUmZKzBAD5ca/1SaODXVN5v6cWCo9cjjjGWCNqikn9KbpmDPQ6BHO
	 gqFSAGnA4eMjA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Changyuan Lyu <changyuanl@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH] kho: initialize tail pages for higher order folios
 properly
In-Reply-To: <aEKhF3HcrvG77Ogb@kernel.org>
References: <20250605171143.76963-1-pratyush@kernel.org>
	<aEKhF3HcrvG77Ogb@kernel.org>
Date: Fri, 06 Jun 2025 18:23:06 +0200
Message-ID: <mafs0jz5osutx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_092311_677208_F591C2C8 
X-CRM114-Status: GOOD (  30.36  )
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

Hi Mike,

On Fri, Jun 06 2025, Mike Rapoport wrote:

> On Thu, Jun 05, 2025 at 07:11:41PM +0200, Pratyush Yadav wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>> 
>> Currently, when restoring higher order folios, kho_restore_folio() only
>> calls prep_compound_page() on all the pages. That is not enough to
>> properly initialize the folios. The managed page count does not
>> get updated, the reserved flag does not get dropped, and page count does
>> not get initialized properly.
>> 
>> Restoring a higher order folio with it results in the following BUG with
>> CONFIG_DEBUG_VM when attempting to free the folio:
>> 
>>     BUG: Bad page state in process test  pfn:104e2b
>>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x104e2b
>>     flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
>>     raw: 002fffff80000000 0000000000000000 00000000ffffffff 0000000000000000
>>     raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
>>     page dumped because: nonzero _refcount
>>     [...]
>>     Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x4b/0x70
>>     bad_page.cold+0x97/0xb2
>>     __free_frozen_pages+0x616/0x850
>>     [...]
>> 
>> Combine the path for 0-order and higher order folios, initialize the
>> tail pages with a count of zero, and call adjust_managed_page_count() to
>> account for all the pages instead of just missing them.
>> 
>> In addition, since all the KHO-preserved pages get marked with
>> MEMBLOCK_RSRV_NOINIT by deserialize_bitmap(), the reserved flag is not
>> actually set (as can also be seen from the flags of the dumped page in
>> the logs above). So drop the ClearPageReserved() calls.
>> 
>> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>> ---
>> 
>> Side note: get_maintainers.pl for KHO only lists kexec@ as the mailing list.
>> Since KHO has a bunch of MM bits as well, should we also add linux-mm@ to its
>> MAINTAINERS entry?
>> 
>> Adding linux-mm@ to this patch at least, in case MM people have an opinion on
>> this.
>> 
>>  kernel/kexec_handover.c | 29 +++++++++++++++++------------
>>  1 file changed, 17 insertions(+), 12 deletions(-)
>> 
>> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
>> index eb305e7e61296..5214ab27d1f8d 100644
>> --- a/kernel/kexec_handover.c
>> +++ b/kernel/kexec_handover.c
>> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>>  }
>> 
>>  /* almost as free_reserved_page(), just don't free the page */
>> -static void kho_restore_page(struct page *page)
>> +static void kho_restore_page(struct page *page, unsigned int order)
>>  {
>> -	ClearPageReserved(page);
>
> So now we don't clear PG_Reserved even on order-0 pages? ;-)

We don't need to. As I mentioned in the commit message as well,
PG_Reserved is never set for KHO pages since they are reserved with
MEMBLOCK_RSRV_NOINIT, so memmap_init_reserved_pages() skips over them.

To double-check, I added some quick prints to kho_restore_page():

    /* Head page gets refcount of 1. */
    set_page_count(page, 1);
    printk("Head page flags: 0x%lx reserved: %d\n",
           page->flags, PageReserved(page));
    
    /* For higher order folios, tail pages get a page count of zero. */
    for (i = 1; i < nr_pages; i++) {
    	printk("Tail page %u flags: 0x%lx reserved: %d\n",
    		i, (page+i)->flags, PageReserved(page+i));
    	set_page_count(page + i, 0);
    }

And this is what I get:

    [    9.003187] Head page flags: 0x2fffff80000000 reserved: 0
    [    9.003730] Tail page 1 flags: 0x2fffff80000000 reserved: 0
    [    9.004229] Tail page 2 flags: 0x2fffff80000000 reserved: 0
    [    9.004740] Tail page 3 flags: 0x2fffff80000000 reserved: 0
    [    9.005265] Head page flags: 0x2fffff80000000 reserved: 0
    [    9.005759] Head page flags: 0x2fffff80000000 reserved: 0
    [...]

So PG_Reserved is never set.

That said, while reading through some of the code, I noticed another
bug: because KHO reserves the preserved pages as NOINIT, with
CONFIG_DEFERRED_STRUCT_PAGE_INIT == n, all the pages get initialized
when memmap_init_range() is called from setup_arch (paging_init() on
x86). This happens before kho_memory_init(), so the KHO-preserved pages
are not marked as reserved to memblock yet.

With deferred page init, some pages might not get initialized early, and
get initialized after kho_memory_init(), by which time the KHO-preserved
pages are marked as reserved. So, deferred_init_maxorder() will skip
over those pages and leave them uninitialized.

And sure enough, doing the same with CONFIG_DEFERRED_STRUCT_PAGE_INIT ==
y results in:

    [   10.060842] Head page flags: 0x2fffff80000000 reserved: 0
    [   10.061387] Tail page 1 flags: 0x2fffff80000000 reserved: 0
    [   10.061902] Tail page 2 flags: 0x2fffff80000000 reserved: 0
    [   10.062400] Tail page 3 flags: 0x2fffff80000000 reserved: 0
    [   10.062924] page:00000000fb3dca54 is uninitialized and poisoned
    [   10.063494] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
    [   10.064190] ------------[ cut here ]------------
    [   10.064636] kernel BUG at ./include/linux/page-flags.h:571!
    [   10.065194] Oops: invalid opcode: 0000 [#1] SMP PTI
    [   10.065661] CPU: 2 UID: 0 PID: 1954 Comm: test Not tainted 6.15.0+ #297 PREEMPT(undef)
    [   10.066449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    [   10.067353] RIP: 0010:kho_restore_folio+0x4e/0x70
    [...]

So we need to either also call init_deferred_page(), or remove the
memblock_reserved_mark_noinit() call in deserialize_bitmap(). And TBH, I
am not sure why KHO pages even need to be marked noinit in the first
place. Probably the only benefit would be if a large chunk of memory is
KHO-preserved, the pages can be initialized later on-demand, reducing
bootup time a bit.

What do you think? Should we drop noinit or call init_deferred_page()?
FWIW, my preference is to drop noinit, since init_deferred_page() is
__meminit and we would have to make sure it doesn't go away after boot.

>
>> -	init_page_count(page);
>> -	adjust_managed_page_count(page, 1);
>> +	unsigned int i, nr_pages = (1 << order);
>
> Can you please declare 'i' inside the loop, looks nicer IMHO.

Ok, will do.

>
>> +
>> +	/* Head page gets refcount of 1. */
>> +	set_page_count(page, 1);
>
> ClearPageReserved(page) here?
>
>> +
>> +	/* For higher order folios, tail pages get a page count of zero. */
>> +	for (i = 1; i < nr_pages; i++)
>> +		set_page_count(page + i, 0);
>
> and here?
>
>> +
>> +	if (order > 0)
>> +		prep_compound_page(page, order);
>> +
>> +	adjust_managed_page_count(page, nr_pages);
>>  }
>> 
>>  /**
[...]

-- 
Regards,
Pratyush Yadav

