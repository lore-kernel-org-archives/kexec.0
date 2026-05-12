Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E8CD4851
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 06:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZr0BaIdHSwJJbA1hkK0oJ81Kb/bYZuv87/XRa/7gMU=; b=I65NgEbToiMJpQRPm/i+Z71Od9
	yuS1JnMxtVg1lV+eFj2UDQY6pbS/tvMzAJ5N4M4ljkRtg+UrMf0CdOw5CoGZ1cfsU/G3uPFscidi3
	dYLyKht7wf78mYrj1+/pPO9ovIeh8evvXJvN+Zflx9YXyVq+76vfXHRWQ+8MMjnxG11U5RiPHja/N
	1LDnYps7O9gfJ3T3zwS4CoBiiV0CFNlGcYZwyAh1bO4YIQhT2ebH3T0OzVqQL7STXjNJqepQcETG9
	j/q6IhPwbfjOiDCGw0pQsz45Yg4D5Ohl2oYOh69JS0P7hXFNDaqBfRwm2LX+erYIsRM8uKgnNHuy0
	ItTRWWeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgtA-0000000Fomp-2y8s;
	Tue, 12 May 2026 06:46:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgt9-0000000FomN-1aQE
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 06:46:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A98B1600CB;
	Tue, 12 May 2026 06:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD99C2BCB8;
	Tue, 12 May 2026 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568402;
	bh=9lo3a8HNQUQfSXTkObC7PN3s4BMtQs5GlB1W7QFzB7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iq4WyErZxLPa5eoiE6vV9GoH+CAJnCkGrApLT+EmefaDjXY/+2mDAOR7SPbNRKOSX
	 DJAN1+v+XyLPXBDgwYfvsVN7qnZ3HoGKeFY7UKmQAav6t29Unz2ZDP8Djl25+dsovY
	 Aax9awSrj1xfSIKYIH2onurNuLSiP+GeF98D63cA50VnbAYy7x7GTjkr7CSQTTuDwr
	 pxwa6tzNkqebXStif+d+CflDW8A18wjD141aoQYoExJQ0uLgZHh7uW5U1UhJF/WT1t
	 V9iESmawjhAQU/kVhViAuNkUm8I3bRmYilndNwTl4dh7aR+ECGgFJr/S8b+7EWpcxT
	 oxkBD/BCsWz7Q==
Date: Tue, 12 May 2026 09:46:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] kho: store incoming radix tree in kho_in
Message-ID: <agLMyu2_oQpbPCdn@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-3-pratyush@kernel.org>
 <agHA2imH5hdMSlId@kernel.org>
 <2vxz4ikddi6y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4ikddi6y.fsf@kernel.org>
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

On Mon, May 11, 2026 at 06:28:21PM +0200, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:04PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> This allows other functions to also use the radix tree. While at it,
> >> also use kho_get_mem_map_phys() instead of duplicating the code to get
> >> the radix tree root from the FDT.
> >> 
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >>  kernel/liveupdate/kexec_handover.c | 27 ++++++++-------------------
> >>  1 file changed, 8 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> >> index ba568d34c5b4..5758dc6fab5d 100644
> >> --- a/kernel/liveupdate/kexec_handover.c
> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> @@ -1294,6 +1294,7 @@ struct kho_in {
> >>  	char previous_release[__NEW_UTS_LEN + 1];
> >>  	u32 kexec_count;
> >>  	struct kho_debugfs dbg;
> >> +	struct kho_radix_tree radix_tree;
> >>  };
> >>  
> >>  static struct kho_in kho_in = {
> >> @@ -1373,24 +1374,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> >>  
> >>  static int __init kho_mem_retrieve(const void *fdt)
> >>  {
> >> -	struct kho_radix_tree tree;
> >> -	const phys_addr_t *mem;
> >> -	int len;
> >> -
> >> -	/* Retrieve the KHO radix tree from passed-in FDT. */
> >> -	mem = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
> >> -
> >> -	if (!mem || len != sizeof(*mem)) {
> >> -		pr_err("failed to get preserved KHO memory tree\n");
> >> -		return -ENOENT;
> >> -	}
> >> -
> >> -	if (!*mem)
> >> -		return -EINVAL;
> >> -
> >> -	tree.root = phys_to_virt(*mem);
> >> -	mutex_init(&tree.lock);
> >> -	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
> >> +	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
> >
> > Do we really want to remove an explicit check for 0 and get a WARN() in
> > kho_radix_walk_tree()?
> 
> If mem_map_phys is 0 then kho_populate() never sets kho_in.scratch_phys
> and thus kho_mem_retrieve() never gets called. So here it will never be
> 0, and if it is, a WARN() is certainly warranted.
> 
> Perhaps I should add a comment since this isn't so obvious?

Yes, please.
After a few weeks it will be completely obscure.
 
> >
> >> +	mutex_init(&kho_in.radix_tree.lock);
> >> +	return kho_radix_walk_tree(&kho_in.radix_tree,
> >> +				   kho_preserved_memory_reserve);
> >>  }
> >>  
> >>  static __init int kho_out_fdt_setup(void)
> >> @@ -1597,8 +1584,10 @@ void __init kho_memory_init(void)
> >>  	if (kho_in.scratch_phys) {
> >>  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
> >>  
> >> -		if (kho_mem_retrieve(kho_get_fdt()))
> >> +		if (kho_mem_retrieve(kho_get_fdt())) {
> >>  			kho_in.fdt_phys = 0;
> >> +			kho_in.radix_tree.root = NULL;
> >
> > I'd make kho_mem_retrieve() void and put these there.
> 
> Sure, will do.
> 
> >
> >> +		}
> >>  	} else {
> >>  		kho_reserve_scratch();
> >>  	}
> >> -- 
> >> 2.54.0.545.g6539524ca2-goog
> >> 
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

