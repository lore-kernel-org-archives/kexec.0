Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E033C5CFC1
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZFxTjqYCVDel3mBfuW3KkCSTw+cakZjOBAmHaEPkPg=; b=S1ImKLgLv+MI+bs/WtRuoS5Z+D
	zLzQIX2tmGKSVdbltmh6PnUK3vcqXowKNE8wVH9kzFc5Uuyb5nbO7NPokP0leY6cNtVoB4nnRaTqm
	/frG9Hsp3d9DCjVd+lHsH/gM+u1C9Iuv2urpFQknwc25NRS+jdfwXJXxP9wh2JBGavg2sHFY9Fi0a
	/T2kn4hSmbSgrQWAy9n2o9NTTPTGKJ6hY9fIMKH0n9hAAIhCg8a7BRU55WNpbr2JL3BUcelIecq3d
	yG43XeXoh5Dnqd1OBVq5HXWVpVoV9vkJEWW3+7fzJc9/xzRybKKS9tuB4oBPUOCeBuKGheXaKw6kS
	Q6f1619A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkmW-0000000DwWc-00Or;
	Tue, 11 Aug 2026 11:36:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtkmV-0000000DwWT-1Gxg
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 11:36:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C96AE4371C;
	Tue, 11 Aug 2026 11:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585481F000E9;
	Tue, 11 Aug 2026 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786448190;
	bh=3ZFxTjqYCVDel3mBfuW3KkCSTw+cakZjOBAmHaEPkPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AepQbUvS3w/BT/5h4dSd/Z8AO2qZV9m2S7WE5Cck5btGEsFK21iN5IJJZvXQt+Q8y
	 mF/hjb2oxuuLZjwGBFIgBaKkiuHNaS4fMRfcFpqanHRHudB+DzQwOk6o8R4dtVP1Za
	 E3TDohCnhfdGNt4UoCYUxbDMxmLCsPy6lBgpMN0zHQin7i0jEm/iECq4Hl4thAX9ax
	 TcfVD0HYwpDXWhaRJiPfB2TCh6rOIu24fOI8HSgHLLo+Yo63hG6y+wyeEHRRfzeGwA
	 Ukrmgj0wmuTjcCGYczXnY0Ufk/Kc6s6fWmLjkfsF4Bm6j67li2fnhtkFrR4TwzD/tg
	 xRY4fK0F/j3Lw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Mike Rapoport <rppt@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,
  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Baoquan He <baoquan.he@linux.dev>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Miaohe Lin <linmiaohe@huawei.com>,  Naoya Horiguchi
 <nao.horiguchi@gmail.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  rmikey@meta.com,  riel@surriel.com,  kernel-team@meta.com,  Kiryl
 Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned pages
In-Reply-To: <anr59P1ZCAuHxv6x@gmail.com> (Breno Leitao's message of "Tue, 11
	Aug 2026 04:17:41 -0700")
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
	<ann9Kcesyb4T9Z8b@kernel.org> <anr59P1ZCAuHxv6x@gmail.com>
Date: Tue, 11 Aug 2026 13:36:25 +0200
Message-ID: <2vxzldac51om.fsf@kernel.org>
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

On Tue, Aug 11 2026, Breno Leitao wrote:

> On Mon, Aug 10, 2026 at 07:32:41PM +0300, Mike Rapoport wrote:
>> Hi Breno,
>> 
>> On Mon, Aug 10, 2026 at 06:32:04AM -0700, Breno Leitao wrote:
[...]
>> > +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
>> > +
>> > +		cond_resched();
>> 
>> cond_resched() for every pfn is too much, isn't it?
>
> It is what the other pfn walkers do: the kpageflags read loop in
> fs/proc/page.c and read_page_owner() in mm/page_owner.c both call it
> once per pfn. 
>
> But I honestly don't have a strong opinion here, though, happy to batch
> it if you prefer. Would this one look better?:
>
> 	if (!(pfn % MAX_ORDER_NR_PAGES))
> 		cond_resched();
>

Now that we are looking at this, Sashiko also complains about a race
with memory hotunplug.

    Can the page pointer become invalid here due to concurrent memory hotplug?

    The loop retrieves the struct page pointer using pfn_to_online_page() and
    then yields the CPU with cond_resched(). Since this iteration runs without
    holding get_online_mems(), could a concurrent memory hot-unplug event offline
    and remove the memory section while the thread is sleeping?

    If the vmemmap backing the struct page is freed and its page tables torn
    down, dereferencing the pointer in is_page_hwpoison(page) upon waking
    could cause a use-after-free regression.

Kind of makes sense at first glance but I didn't go and look. Perhaps it
is better to do the cond_resched() at the end of the loop?

-- 
Regards,
Pratyush Yadav

