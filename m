Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D199DCD484E
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 06:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DqJXMG4AbbLvtxyV8k0pDme0ixuoamEMGaG4tQgEDmE=; b=Xrw2fLObYgzkYSbSut3fXWZCQZ
	puYV02z6kqBJCA7jiImziRJTksLHuFLJcJiKnc2lhGy3gwGciI0PB8P5xStGRYt4EFHxhnlV2d+WC
	Y1Y/vtT2J5L+m4v/zNQQpRocp4gE7WVGkWMINI7TlVlAY1MlVQ1IgSEVxA/ib6u0XTJHyt1Lg2SGY
	O3xYbUn65/nJEFkDmpEkTctCxXqkzVg1GGmp6kYQ4vsj/0S8R1cjBZL1BImDk20IAGRtiMaFLo+ga
	GbPelZi4JhPPC8/D9Pn6pCl7RBNgWw774s7wlTqOyyVfXjRO5NpP3f5cFG7Olx0YRWmOmtwQbUaRA
	CFLwVBjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgvJ-0000000FpJB-0RPz;
	Tue, 12 May 2026 06:48:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgvI-0000000FpIz-2hEN
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 06:48:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E1276012A;
	Tue, 12 May 2026 06:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33335C2BCB0;
	Tue, 12 May 2026 06:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568535;
	bh=7xqrAItGMPFyfU6pVB+y7187hkbW+5r5jDMYDqJoTiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fS1MMDK/QN+dzfCxgYeQoTcjMJ6ttyRYGb+GSjpCa2iG+uGxKaqxoEaqAY7XgpLqj
	 h7gUD3lvWerOn0JiTixBa6c19jpcru3ryNOL92poGX3XMSk1iRVr+IZnyFSMn7o7EV
	 EHiWqSP27esFnTSHl9Vxf/76IRsntTbyDzIF/9pucqUWazVu/9m2QRMtcjEwNsJBu+
	 ML7cfHnDWBi/7OR5wTxB6MpCzVeZH47EHccjWxf4mrJcm6pyMhLYCveiPX3vPceR4Z
	 vq8d/Z6DZ+GeD2vrRL20SRAT3tW5YhAY2yZCz7B/NDHxTUN+Z8LVjZLJUE+dNqebCY
	 62nm+RXEgU0sg==
Date: Tue, 12 May 2026 09:48:48 +0300
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
Subject: Re: [PATCH 03/12] kho: add a struct for radix callbacks
Message-ID: <agLNUKE5LZqcoUex@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-4-pratyush@kernel.org>
 <agHB7HB-p_vkLS7R@kernel.org>
 <2vxzzf25c39x.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzzf25c39x.fsf@kernel.org>
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

On Mon, May 11, 2026 at 06:35:54PM +0200, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:05PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> A future commit will add more callbacks for the KHO radix tree. Add a
> >> struct for collecting the callbacks.
> >> 
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> [...]
> >> --- a/kernel/liveupdate/kexec_handover.c
> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> @@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
> >>  }
> >>  EXPORT_SYMBOL_GPL(kho_radix_del_key);
> >>  
> >> -static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
> >> -			       unsigned long key,
> >> -			       kho_radix_tree_walk_callback_t cb)
> >> +static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
> >> +			       const struct kho_radix_walk_cb *cb)
> >>  {
> >>  	unsigned long *bitmap = (unsigned long *)leaf;
> >>  	unsigned int i;
> >>  	int err;
> >>  
> >> +	if (!cb->key)
> >> +		return 0;
> >> +
> >>  	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
> >> -		err = cb(key | i);
> >> +		err = cb->key(key | i);
> >
> > key(key) reads weird :)
> > Can't say I have a good name, maybe key_action()?
> 
> I thought the context of it being under a callback struct would make it
> more obvious. I don't like key_action() much better TBH, but I don't
> have a strong opinion. Perhaps Pasha can suggest a 3rd option and we
> pick on randomly ;-)

Another option I thought is to call them ->leaf() and ->node().
 
> >
> >>  		if (err)
> >>  			return err;
> >>  	}
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

