Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74502D4A5F4
	for <kexec@archiver.kernel.org>; Sun, 18 Jan 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFBnWOh1Hw/rPWlfuxf1cyW+AyiguOS5AieRNy1N54E=; b=wosyljI8Wb2kn67F9TuQqEpOaa
	Gj6ghqTCPN6KsGktKDEhe7MX+ChaXEgVIHznzKZX9dBphGZ6vnYdR41q/4IoIr64HFAJV4WhZ6MRN
	3kNh6cB8NSj1nJdC7ll+Mrizxh5gTQSZpVs9EqiL3A1aNq6av3mnhopLaor9xn8OX+kT183sXjuVo
	4S00F6W6bvF7hOxifetGL+tIvVhw0REmm8Y3KUUS2JrgEAAOPCffcQyAYDvmQTshO9dWINgSmFCNw
	HnOC/Qbn8D8ONm5xow8oAQ2smY5Vw9yqAI3XwhXaVd9Z3LNcUwVgI2G4ACr8mrAMq9W6E1rRFmR8q
	qA0GVR9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhRi3-0000000HYAy-1X7R;
	Sun, 18 Jan 2026 12:16:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhRhy-0000000HYAX-1vY6
	for kexec@lists.infradead.org;
	Sun, 18 Jan 2026 12:16:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 80BE560126;
	Sun, 18 Jan 2026 12:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2C9C116D0;
	Sun, 18 Jan 2026 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768738601;
	bh=GNLKijSufyMywtxmWVA+8J1TEZuTFKnq101th6Vg7vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPKKUPNLIgdW1FVtu6t0pHQsFANoX0X/bfdI+nnOOtyQoWwUbEywGQkG0rtvqmvGJ
	 I3fAz5b927vx35wgy9mmIcb/LEBGigkxdXVsXS79z3NI6I+Di69mAqfOaHBu+2L+yB
	 ELOdNY+us7iSLo3Lny9KrYowyJ5s2dyobs+AHGfsLddWBdxC8LbYHSyhkbvTJ9gAtj
	 BMpNCeNJZaLY8IGUm3MUR/Ke2Dt1HhIc6DFtQuShEuOKMN9UpecLCWh0BM36d1Z+Fc
	 Ld6sNLxtkUbxn+jDOi0025JJGv9MvgPnsRrK6n4r380JHjlwt3SOGRbH+6FfkNESVb
	 8pCvlPCJUbhkw==
Date: Sun, 18 Jan 2026 14:16:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, nh-open-source@amazon.com
Subject: Re: [PATCH] kho: skip memoryless NUMA nodes when reserving scratch
 areas
Message-ID: <aWzPIfZ0WeH0vca8@kernel.org>
References: <20260116112640.64900-1-epetron@amazon.de>
 <2vxzsec57oth.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzsec57oth.fsf@kernel.org>
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

On Fri, Jan 16, 2026 at 11:57:14AM +0000, Pratyush Yadav wrote:
> Hi Evangelos,
> 
> On Fri, Jan 16 2026, Evangelos Petrongonas wrote:
> 
> > kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> > per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> > that have CPUs but no memory), memblock_alloc_range_nid() fails because
> > there is no memory available on that node. This causes KHO initialization
> > to fail and kho_enable to be set to false.
> >
> > Some ARM64 systems have NUMA topologies where certain nodes contain only
> > CPUs without any associated memory. These configurations are valid and
> > should not prevent KHO from functioning.
> >
> > Fix this by introducing kho_mem_nodes_count() which counts only nodes
> > that have memory (N_MEMORY state), and skip memoryless nodes in the
> > per-node scratch allocation loop.
> >
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 9dc51fab604f..c970ed08b477 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -623,6 +623,23 @@ static phys_addr_t __init scratch_size_node(int nid)
> >  	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> >  }
> >  
> > +/*
> > + * Count online NUMA nodes that have memory. Memoryless nodes cannot have
> > + * scratch memory and should be excluded.
> > + */
> > +static unsigned int __init kho_mem_nodes_count(void)
> > +{
> > +	unsigned int cnt = 0;
> > +	int nid;
> > +
> > +	for_each_online_node(nid) {
> > +		if (node_state(nid, N_MEMORY))
> > +			cnt++;
> > +	}
> > +
> > +	return cnt;
> > +}
> > +
> 
> You don't need this. You can use nodes_weight(nodes_state[N_MEMORY])
> directly. Other than this, LGTM.
> 
> >  /**
> >   * kho_reserve_scratch - Reserve a contiguous chunk of memory for kexec
> >   *
> > @@ -643,7 +660,7 @@ static void __init kho_reserve_scratch(void)
> >  	scratch_size_update();
> >  
> >  	/* FIXME: deal with node hot-plug/remove */
> > -	kho_scratch_cnt = num_online_nodes() + 2;
> > +	kho_scratch_cnt = kho_mem_nodes_count() + 2;
> >  	size = kho_scratch_cnt * sizeof(*kho_scratch);
> >  	kho_scratch = memblock_alloc(size, PAGE_SIZE);
> >  	if (!kho_scratch)
> > @@ -674,6 +691,10 @@ static void __init kho_reserve_scratch(void)
> >  	i++;
> >  
> >  	for_each_online_node(nid) {
> > +		/* Skip memoryless nodes - we cannot allocate scratch memory there */
> > +		if (!node_state(nid, N_MEMORY))
> > +			continue;
> > +

And here you can use for_each_node_state(nid, N_MEMORY)

> >  		size = scratch_size_node(nid);
> >  		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
> >  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

