Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349EBD0C85C
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqM1VqPV4pdZPHBofjf5rNabyDMfWZXNBYIxMfUVkBk=; b=Lx4rG/tK71O2OonD3aW/8O4Zdp
	pkeweVXjUDra6BGn84w4305xhVx7S6zsdek3e68uMcmvzodivLkOdS12I7WIaem9yDX9ZqmPzyEN/
	WExe4M79+0f54jsvMkFhHqgE6uuJ+mrVhnTPwA9b2qxLpOhVpJvpx4Q4TJHGkmgioLrABviOd/Mh4
	hy338npuEvNCdufu4x8elzFH7ahevZNX6qH4OCp6sbosBnv1Zi3f7isH6behNj+YStSKMWrv4RKIl
	0R3VHjglxFvZ/9wmBxGL0FwsZO4MR3MtlG9vMJ+hMX/nOQs36hVGAbyxlPu3Wwcv0CA9tQxA6Pd61
	EwQAg5fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfcfk-000000071nj-3ocV;
	Tue, 13 Jan 2026 11:34:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfcfj-000000071nd-03yy
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 11:34:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4AE1560017;
	Tue, 13 Jan 2026 11:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B10FC116C6;
	Tue, 13 Jan 2026 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768304089;
	bh=8SYRj/Bn4n03WlxO9wJ4xkhgbEiQG0xyAbcovfmvVts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LT4WJ8AUH5aCphVvnO6bYgyhUe5bT8rop9QoZ0j0AkV6KUH6ZdnQ7WITlMY+Aroh5
	 XyeoZi06OaJfBC2KeAm4S+VkmZxcpym/0kNLYZyTilDlK1bwM5omG4Vt8DKYZ1bSf7
	 xo4x24DibF7EDTAoAq9j2UXbLez9g3LLPrxGr5BhX1Nol0s+cZSNdyurbPSS6hUWUM
	 3SWI4rToibpkd0bHJGKMqhhPoqZewpast2WdoS/DA6x66M+ynpqiFGsTDFflOUH4jN
	 JGZLUrkIrqD2lHSf117dDkADBOr/T0pUrZqvvaCPOKbZuO3WeZ0vHhfHC7l3MQrhqa
	 EaEU1mX+LRJEQ==
Date: Tue, 13 Jan 2026 13:34:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aWYt0gBHxDCKqj9Q@kernel.org>
References: <20260109001127.2596222-1-jasonmiu@google.com>
 <20260109001127.2596222-2-jasonmiu@google.com>
 <aWTJ2v9J-Aa6ykBf@kernel.org>
 <20260112143904.GA812923@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112143904.GA812923@nvidia.com>
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

On Mon, Jan 12, 2026 at 10:39:04AM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 12, 2026 at 12:15:54PM +0200, Mike Rapoport wrote:
> > > + * The tree is traversed using a key that encodes the page's physical address
> > > + * (pa) and its order into a single unsigned long value. The encoded key value
> > > + * is composed of two parts: the 'order bit' in the upper part and the 'page
> > > + * offset' in the lower part.::
> > > + *
> > > + *   +------------+-----------------------------+--------------------------+
> > > + *   | Page Order | Order Bit                   | Page Offset              |
> > > + *   +------------+-----------------------------+--------------------------+
> > > + *   | 0          | ...000100 ... (at bit 52)   | pa >> (PAGE_SHIFT + 0)   |
> > > + *   | 1          | ...000010 ... (at bit 51)   | pa >> (PAGE_SHIFT + 1)   |
> > > + *   | 2          | ...000001 ... (at bit 50)   | pa >> (PAGE_SHIFT + 2)   |
> > > + *   | ...        | ...                         | ...                      |
> > > + *   +------------+-----------------------------+--------------------------+
> > > + *
> > > + * Page Offset:
> > 
> > To me "page offset" reads as offset from somewhere and here it's rather pfn
> > on steroids :) 
> > Also in many places in the kernel "page offset" refers to the offset inside a
> > page.
> > 
> > Can't say I can think of a better name, but it feels that it should express
> > that this is an address more explicitly.
> 
> It is "Shifted Physical Address"
> 
> > > +			node = phys_to_virt((phys_addr_t)node->table[idx]);
> > > +	}
> > > +
> > > +	/* Handle the leaf level bitmap (level 0) */
> > > +	leaf = (struct kho_radix_leaf *)node;
> > > +	idx = kho_radix_get_index(key, 0);
> > > +	__clear_bit(idx, leaf->bitmap);
> > 
> > I think I already mentioned it in earlier reviews, but I don't remember any
> > response.
> > 
> > How do we approach freeing empty bitmaps and intermediate nodes?
> > If we do a few preserve/uppreserve cycles for memory that can be allocated
> > and freed in between we might get many unused bitmaps.
> 
> Surely this is an error case??
> 
> We shouldn't be unpreserving at all in a normal flow?

That's an error case for KHO/LUO, but might not be an error case for other
users of the kho_radix_tree.
For example mshv intends to use kho_radix_tree to track the hypervisor
memory and there unpreserving will be a part of the normal flow.

I'm not saying we must implement freeing of empty bitmaps from day 1, but
at least there should be a comment about it.
 
> Jason

-- 
Sincerely yours,
Mike.

