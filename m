Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B43FCD4855
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nts3d11hQEbWfK9I61sLETdJHahMN5gMF0KYY0lf5cQ=; b=ZdOg1bNJ6zqX2qPoy+1Kn9CHdI
	nxAUVg1xmqwf6Ecka7o66dGLxuHoQI/jmg+UdMfz1a6wb0S6Z2j/YwLQxhZp6IA/PrUyrkO8YIsmB
	xiG5o/0HKaWPnpOAI+nIxem7fv/74F8pbLS+KAyOPO1CG2Nh3bfOY/zQPGQpK6MQpU41kjc1ce07z
	TDWa4NgiwwcLISjvaKX3Rz+Odjr6sMq6Me2nsKFIQUU4SiRBSTMWR4eCf75HumtUW0QB0ShbHhzQu
	TpGE1oYHMV73ifaU8j7NHmP+ITkv2/T9DQu/cd8jGKyCXiG7TzOH7qPmOfPeLBVPOpti3m8Hmm6TL
	A6W7pIlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgyK-0000000FpwF-2eBd;
	Tue, 12 May 2026 06:52:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgyJ-0000000Fpvf-1N2u
	for kexec@bombadil.infradead.org;
	Tue, 12 May 2026 06:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nts3d11hQEbWfK9I61sLETdJHahMN5gMF0KYY0lf5cQ=; b=KA78dOX5rCTEcwiiorhig7U6xA
	fN4idVGuP8CpWHcYEKZSb0cVok/kC1fwGbxj7QOgOAbEMgLTOQLe/zyv8KaL8lbsz/tP2gumVUb8S
	AGn10TwWyLww4vDv2KpmbvnZB0T2LIxynonSR2rU3Oa8PXbIInv8l/EPobG8YWneCyyuV5t9A3Nii
	b0x6ns2A5lJdv0USyqzFOmHtCh+Ieiipw2//HsX6S9FYLpwcLm+zxyGV4it2qNDEm51N5eAgc28sX
	qMuipGFyUOp8HeQPyDDdLzqzTG3NMvRAtnMqdlBt+SyzdmA9eP275IhkEcrcEiB7mbLRULsMjSFLL
	iTvky2Ew==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgyD-0000000Ds1F-28VZ
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 06:52:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CAFC438DA;
	Tue, 12 May 2026 06:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BACC2BCB0;
	Tue, 12 May 2026 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568714;
	bh=JrQbMHAIUgObA1+mKB9cmwyGVWli0GV/3xeXEfKec+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy9X4nJLqbWsnvDt8maKE5p+Nu099G37eshBismCInFuhZUp0yS0mHJRGNOCYas3Z
	 Ptisd0du9040+8gjOTnEODmTYnmAgnmQR2ks9AC63/6/+Cx5tWjISj+mj4QDivKrWP
	 eiAExqCh7de66jSYTZAAcA2sff0U9HMTGo1yLPIZJRtEoBpeKwJA2DRVWe8+GkJuzl
	 KZZ4pqd6K+LF8Yc7wqZ0/SWrEW6flO9Gw7x5jg/bnfAthyENKsc4+9CVAk9CxbHBel
	 CYfiaFBj3tSQNgvexfXGwBg9CQjLGmUFhZcDMuS5hpWrRf3mFLvbVMoACa2QMBSAPe
	 rQf21poTG03oA==
Date: Tue, 12 May 2026 09:51:46 +0300
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
Subject: Re: [PATCH 11/12] kho: return virtual address of mem_map
Message-ID: <agLOAtdL0rXL1HJ2@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-12-pratyush@kernel.org>
 <agHHzJS7bLPHk1GJ@kernel.org>
 <2vxza4u5c2oq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxza4u5c2oq.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_075159_852915_5999118C 
X-CRM114-Status: GOOD (  19.54  )
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

On Mon, May 11, 2026 at 06:48:37PM +0200, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:13PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> There are currently 3 callers of kho_get_mem_map_phys(). Two of them,
> >> kho_mem_retrieve() and kho_extend_scratch() need the virtual address.
> >> The third, kho_populate() doesn't care. Make things simpler by
> >> directly returning the virtual address. Rename kho_get_mem_map_phys() to
> >> kho_get_mem_map() to accurately reflect what it returns.
> >
> > This should be moved earlier, before replacing open-coded get_mem_map()
> > with a call to kho_get_mem_map_phys().
> 
> Do you mean move it before patch 2 "kho: store incoming radix tree in
> kho_in"?

Yes.
 
> I can do that. I did it this way to show a clear need for this function,
> but I don't mind doing it as a preparatory step.

With the usual "it will be used in the upcoming changes" text in the log
it's fine :)
 
> >  
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >>  kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
> >>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

