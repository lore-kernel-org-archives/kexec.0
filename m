Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E650EC5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfAKwb7BHAfKwks4BwOH8LurhNbOUrjBmbZm8v/M8ho=; b=YuughaOZjgIxMwqsT2nX5bGAU6
	rmf1Psw5lRcU4hRG42WdMH60Fycd3++z0VhUx4gRY4EVaZ+57AATxar23QTSieezpKia8FeaaMiLn
	y4wII7N7Jwi0I8jox/C+wBkxyc+3QTk22VJNSVJk9nxpx8HgKExyA3j4mKDUZC1V+z+RSJJncT29N
	zGhyeVmGtfkxVgCAwKKpdjeDqbDTF00crsYKR/tWjVX5MAFRVD1ogbnORakI7vuhBLh0NzYqlKFhs
	tqGT2s70xfBRlLErwZOXScJxFdit2dl4xFJfzINuoMjNDzEnnxx89gnsL3dnVrLEKBnu9EOgshYVc
	kV8DlhNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6sr-0000000G13m-2oMp;
	Wed, 12 Aug 2026 11:12:33 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6sp-0000000G112-0S0E
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wfAKwb7BHAfKwks4BwOH8LurhNbOUrjBmbZm8v/M8ho=; b=o2/oPsgT8gcfdJPToPnecYrXEY
	JESoF7pDhaqGxbh9ocFyX3YVUH/FjZuDIMgtE8vfuQEIj70ltqRFqBjiIcDWdegYRMCqRYVdVuYl4
	UlDTVngR5rQP97DrXqNPuQdNunlIJa7ZDeNlVB1FfnQN0PJGV8e4tpypn9hUMpwmHpR29xidDMEJU
	WTHogF/NFBajrCoiytFW3YQfECpHTAfXHEtxyWh/8rSTzrSR4SZwXkojbSAsw9bQ1t3J1TBRcjy5Q
	AoStvSzvaSIfQD2VqXmQbfl9y9x77/1080CcswJUXIj1gsFMVybP5PXZA11/KnbSgKk4nP7jAVCKo
	5VEGAkAg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu6sK-004Ifd-32;
	Wed, 12 Aug 2026 11:12:01 +0000
Date: Wed, 12 Aug 2026 04:11:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <anxUnuML9UTepBTu@gmail.com>
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
 <ann9Kcesyb4T9Z8b@kernel.org>
 <anr59P1ZCAuHxv6x@gmail.com>
 <2vxzldac51om.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzldac51om.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_041231_176257_2EDB7E86 
X-CRM114-Status: GOOD (  23.96  )
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

On Tue, Aug 11, 2026 at 01:36:25PM +0200, Pratyush Yadav wrote:
> On Tue, Aug 11 2026, Breno Leitao wrote:
> 
> > On Mon, Aug 10, 2026 at 07:32:41PM +0300, Mike Rapoport wrote:
> >> Hi Breno,
> >> 
> >> On Mon, Aug 10, 2026 at 06:32:04AM -0700, Breno Leitao wrote:
> [...]
> >> > +	for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
> >> > +
> >> > +		cond_resched();
> >> 
> >> cond_resched() for every pfn is too much, isn't it?
> >
> > It is what the other pfn walkers do: the kpageflags read loop in
> > fs/proc/page.c and read_page_owner() in mm/page_owner.c both call it
> > once per pfn. 
> >
> > But I honestly don't have a strong opinion here, though, happy to batch
> > it if you prefer. Would this one look better?:
> >
> > 	if (!(pfn % MAX_ORDER_NR_PAGES))
> > 		cond_resched();
> >
> 
> Now that we are looking at this, Sashiko also complains about a race
> with memory hotunplug.
> 
>     Can the page pointer become invalid here due to concurrent memory hotplug?
> 
>     The loop retrieves the struct page pointer using pfn_to_online_page() and
>     then yields the CPU with cond_resched(). Since this iteration runs without
>     holding get_online_mems(), could a concurrent memory hot-unplug event offline
>     and remove the memory section while the thread is sleeping?
> 
>     If the vmemmap backing the struct page is freed and its page tables torn
>     down, dereferencing the pointer in is_page_hwpoison(page) upon waking
>     could cause a use-after-free regression.
> 
> Kind of makes sense at first glance but I didn't go and look. Perhaps it
> is better to do the cond_resched() at the end of the loop?

Agree. I was calling cond_resched() earlier because I wanted to call it
before the "continue", but it is rather unusal. Let me move it at the
end of the loop.

Thanks for the review,
--breno

