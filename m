Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767EF606A32E
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TpfBvz1M;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQb71zmK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZxIzf1rOBt5UVX6T+4jsFLqJIyKEfYJr89yjL6zf2/U=; b=TpfBvz1M7D8G9Mlw+SqUs/VuB2
	9lAHZQRZoZKK3Fk41nHXMOF4f9x9CYum9fhXilZxTsgSMHaP8yLwbp9rGvFJFD1cP07zTQNdJ+1L3
	bA9xhuqwOyBXwDZrrKHOAVzH1LuPPQtPXGA3AV6jAM5nGvRHfm/e8vRL3g6CJDlePrB0Kv/f3lJ1x
	Pm8PQ8/bMuBZPivAr54NwAs5zSdS2RXV+zsjE6+luVRGQ8nrLqCr+a6npwMfANBoOg8LnnNMzQuyc
	sKFB4E/TTosAeLGX/i89Fh5+j1axOo+yqmPAb30M7qCV82oCia2FPF+uPw7pd5O8S6wXdxuKtz4mV
	oHu8Pn3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfdw-00000000Mu0-2Myf;
	Sun, 15 Nov 2026 19:12:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfdv-00000000Mts-1lII
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 19:11:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C182342A23;
	Sun, 15 Nov 2026 19:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BA51F000C4;
	Sun, 15 Nov 2026 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769918;
	bh=ZxIzf1rOBt5UVX6T+4jsFLqJIyKEfYJr89yjL6zf2/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQb71zmKT7FEnL7pd/rUA4mBP+ArRSohAYMmWp7K3aKZPN53O8r4cQUMdmW0cK6kO
	 26rQC2rpgdE1JrBb2SO9nmpP8d3+zhlkOiAFAFNK21MAWV1lWq+uB9txYcdInHf02V
	 HMVT12eD2GhINHfUUCEw4DOUxY2NGlqUR+RvqGk9UP5O/fVgmfmV4/8lQAwDQ1gtSw
	 6BVYpuvBUcrF5MXElUHmD45Qkke4sZgKaWtfRD72YX0jPxRFztd6JHJs+7Zufj+bOz
	 rWZ4jM3N2KCmsgYhyofDmNzbWszbLyBnzTMB/E6Ej3mvzqqRL9UiKWsdztLH/RDJNo
	 QsdzUX890TszQ==
Date: Sun, 15 Nov 2026 21:11:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/9] kho: Make bootmem reservations visible to fleet
 monitoring
Message-ID: <avoD9gIBLvMW4vPp@kernel.org>
References: <cover.1794383544.git.chris@chrisdown.name>
 <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
 <179443886218.2329176.10742245280418377061.b4-review@b4>
 <20261113003059.056dd036a6546756@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113003059.056dd036a6546756@chrisdown.name>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chris,

On Fri, Nov 13, 2026 at 12:30:59AM -0800, Chris Down wrote:
> Hi Pasha,
> 
> Pasha Tatashin writes:
> > > The reservation varies with the kernel, memory size, NUMA layout and
> > > command line. Our fleet collector needs the actual size from each host
> > > so we can decide where to enable KHO and catch a kernel release that
> > > takes those hosts over their bootmem budget.
> > 
> > HM, that works for cold boot not for live update :-)
> 
> Yeah, that's true :-) A kernel we live update into just inherits the areas, so
> we'd only see a release change the size once hosts cold boot into it. I'll say
> that in the changelog in v2.
> 
> > > Today the collector would have to sum kho/out/bootmem_len in debugfs,
> > > which isn't a userspace ABI. In /proc/meminfo, free bootmem contributes
> > > to CmaFree, but the reservation doesn't contribute to CmaTotal. The cma
> > 
> > Is this a different bug?
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
> counted in both.

Yes, please :)

> It wouldn't give us the bootmem size though, because CmaTotal
> would still include any other CMA areas.
> 
> > I have some concerns about exposing this as a stable API. What if we get
> > rid of bootmem or make it resizable? We only recently renamed it from
> > scratch to bootmem, and we have been exploring for way to optimize it.
> > 
> > I would keep this exposed under /sys/kernel/debug/kho/bootmem_size for
> > now, and not worry about it being stable.
> 
> That's fair. I'll move it to /sys/kernel/debug/kho/bootmem_size in v2, and we
> can look at sysfs again once bootmem has settled down.

The sysfs vs debugfs argument applies to anything KHO/LUO right now.

But we'll need sysfs at some point to lift the requirement for debugfs
mount.
 
> > Keeping it together with the rest of KHO code would be better.
> 
> Will do, it'll go in kexec_handover_debugfs.c next to the other bootmem files.
> 
> The kho_incoming files in 6/9 are already in kexec_handover.c, but kexec_core.c
> still adds the group to /sys/kernel/kexec. Is that ok, or would you rather KHO
> set that up itself as well?

We'll need sysfs at some point to lift the requirement for debugfs mount.
And I think it can live in /sys/kernel/kho and there we can have incoming
and outgoing and the implementation can be in kernel/liveupdate/kho-sysfs.[ch]

BTW, kexec_handover_debugfs.c was initially given the "full" name because
it lived along kexec_* in kernel. These days I believe we can make it
kho-debugfs.c

I promise to look at the rest of the series Really Soon :)

> Thanks!
> 
> Chris

-- 
Sincerely yours,
Mike.

