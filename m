Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AC606A330
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xZMjo5QJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjhVBDf7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gzDN1QG2r+ew53MNcYjRJsztIJ6bXJi3dv7JbJUryts=; b=xZMjo5QJTrYoUo/qAd5G2Zn0mB
	7aO9RjXgVgwl2ZE4MTJ1WPWXwzkERo9TdMYYEXhvs28XpRZJdn/XpkIHLvxRvqjsLIZqRdhpgvgko
	mo2Hz5Iy9sUxIK0YoSVZspAj73lwbnh3l1EvWS4b+Y1QDGK/kuO299cHQZ+Vp+kl3y/vTBBJDLZpb
	K0y0+6Q1Laj0C7tYLgB+YU5aibT2ZUH6cnXYO3OYBpPDLMbh1zSPvPzQpdwltEXwIkCRe+CDg+fqN
	dzp0kJesl/7SIQbA0v88wTfjMDMjnaDdvYSh0vrF0RdJdK53T4ngnXJLPn0Ci23y98ls8SWJdnSqy
	2m0qIF0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWepy-0000000EE7b-0qzt;
	Thu, 26 Nov 2026 19:08:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWepx-0000000EE7T-28lZ
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 19:08:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A4FF43D9A;
	Thu, 26 Nov 2026 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DF91F000C0;
	Thu, 26 Nov 2026 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720132;
	bh=gzDN1QG2r+ew53MNcYjRJsztIJ6bXJi3dv7JbJUryts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZjhVBDf7i01xUwHDBDd6t5Dd9jfrgoOKt66dR9QNrrc7L0T0YpubcyqvMK0wbN/ia
	 N5atc2f24UBtRU0S+Od103hhN6aomFIo4lUV8NH7otae9s9CkrP1XNak7SusKsyuNi
	 JkL+MoY04YXrIsQU1zFKVFP9T3f4PE1zgUKcKB7/NL84/k+6u74vQKvJZyupKIEt0o
	 AZfV4KXHHyeCjiK2GYQNrImZuCoSUW/eVZRcsXIQFlsap0dkg8rCu7Ve55neanZp3M
	 VUneTvy83IDOxnbJ490HE8Lefc1MHbwcbYRzOzVKlpqtjxIzuSYB9j8bRAoC5SerdJ
	 hF+qL17Mb0c0Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <baoquan.he@linux.dev>,  Jonathan Corbet
 <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kernel-team@meta.com
Subject: Re: [PATCH 2/9] kho: Make bootmem reservations visible to fleet
 monitoring
In-Reply-To: <20261113003059.056dd036a6546756@chrisdown.name> (Chris Down's
	message of "Fri, 13 Nov 2026 00:30:59 -0800")
References: <cover.1794383544.git.chris@chrisdown.name>
	<c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
	<179443886218.2329176.10742245280418377061.b4-review@b4>
	<20261113003059.056dd036a6546756@chrisdown.name>
Date: Thu, 26 Nov 2026 19:08:48 +0000
Message-ID: <2vxz4id3wgu7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13 2026, Chris Down wrote:
> Pasha Tatashin writes:
[...]
>>> Today the collector would have to sum kho/out/bootmem_len in debugfs,
>>> which isn't a userspace ABI. In /proc/meminfo, free bootmem contributes
>>> to CmaFree, but the reservation doesn't contribute to CmaTotal. The cma
>>
>>Is this a different bug?
>
> I think so, yes. Bootmem pageblocks are MIGRATE_CMA, so their free pages are
> counted in NR_FREE_CMA_PAGES, but totalcma_pages only counts the areas that
> mm/cma.c knows about.
>
> zone->cma_pages is a separate problem. It only gets bootmem added by
> init_cma_reserved_pageblock() in kho_init(), and on a KHO boot we return before
> we get there.
>
> I can send patches for those separately if you agree that bootmem should be
> counted in both. It wouldn't give us the bootmem size though, because CmaTotal
> would still include any other CMA areas.

I have a internal bug assigned to me to fix this. It would be great if
you could fix it for me. I'd owe you a beer ;-)

On cold boot it is pretty easy. Call cma_init_reserved_mem() on each
bootmem region.

On a KHO boot it gets tricky. Not all of bootmem is CMA, since some of
it is given out to early boot allocators like memmap. So we need to
count the pageblocks that we mark as MIGRATE_CMA during MM init. And
then update totalcma_pages directly, which already sounds kinda iffy.

Plugging the accounting directly into kho_bootmem_migratetype() might
work, but I don't like giving it a side effect. Maybe we do it directly
in pageblock_migratetype_init_range() and __init_deferred_page()?

None of it is super elegant and I never got around to figuring out
something good.

>
>>I have some concerns about exposing this as a stable API. What if we get
>>rid of bootmem or make it resizable? We only recently renamed it from
>>scratch to bootmem, and we have been exploring for way to optimize it.
>>
>>I would keep this exposed under /sys/kernel/debug/kho/bootmem_size for
>>now, and not worry about it being stable.
>
> That's fair. I'll move it to /sys/kernel/debug/kho/bootmem_size in v2, and we
> can look at sysfs again once bootmem has settled down.

Is it really that hard for your collector to sum up the areas. I don't
mind this change since it is in debugfs and very simple, but I'm curious
if you really need it.

[...]

-- 
Regards,
Pratyush Yadav

