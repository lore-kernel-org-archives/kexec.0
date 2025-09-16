Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42728CAC598
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lP+hEXGVxPwkOMM7p2V+b+lQoPvNSqOTwc7tNn5pKYI=; b=4N+WOjr50uhrx/60XaVZLPzAiL
	/Pxwg5QGbLG/cEt5y4lhxmRxdx5qnemYTkM1GfFqY4d1j+dYMNCNUkKpck6VesE2XwScDZat5SXoZ
	mN5DBEiRkUIcGV07H5/Wk32TBjzVNNc0rA6Qrp797PSWISmq86hp/lFF4/sQrk0ppnLMnxj1prWcp
	O7tm7GMk3nU7/i64zNxZuXIYx9Pllfdi4nqIKgyOb/dYTsu8gs7K268P+iIfxBjw9Xxy09QHBv96c
	XK0artoEnU2qpPIACCiRe/BdSEFBWI+xYZpjIR8zEPFXxnoaZvcjS3acxp+1EdtnWCxhrB/58EPII
	MLxnZ9Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWlB-000000088oN-2za2;
	Tue, 16 Sep 2025 14:34:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWl9-000000088n8-1e9I
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 14:34:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EE2F44964;
	Tue, 16 Sep 2025 14:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF58C4AF09;
	Tue, 16 Sep 2025 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758033258;
	bh=3MH7gD+Tsr6/+WWbc5XNbhhMDRlAVwAmSiICzgleW9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYE8Efn+Rtz49VyeXFT+OA9QWcbqM6ZXeDrJnDya8oYEdZbQzubfb9N/1S8hoNNCX
	 gp9rau+XytOIg1+un9Mguc/q1TX8w4O/yPllotB9qGt5PXIOpqIXJjaVFVSKy5T/Js
	 hRokgc0yIP2bQL9tlVDvbUDm6WUC6w22W6TJv3jNOc6eznzrEo36jFDnLYTKiXnvCx
	 gsRzOcL5ehCcUdEQDnpGsSGqwV9EdD+BaSUTy2xuxwEU8JRJutD7k2bDjreQ6HIXdT
	 utIlA1mGCdnleTYeWeuuFajS3OxCIufVPpSy4JBfMgNdWXy+4bXnz5Gk7otR7W0T7n
	 ym5FukQVNHB5w==
Date: Tue, 16 Sep 2025 17:34:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMl1Yj7_iw1kCU2D@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
 <mafs0ldmnlmq0.fsf@yadavpratyush.com>
 <aMgey9qEC_XUejXm@kernel.org>
 <20250915144335.GL1024672@nvidia.com>
 <aMhAiR6qnXMA-c8r@kernel.org>
 <20250916130516.GB1086830@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916130516.GB1086830@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_073419_447679_D805165C 
X-CRM114-Status: GOOD (  14.18  )
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

On Tue, Sep 16, 2025 at 10:05:16AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 07:36:25PM +0300, Mike Rapoport wrote:
> > > Under the covers it all uses the generic folio based code we already
> > > have, but we should have appropriate wrappers around that code that
> > > make clear these patterns.
> > 
> > Right, but that does not mean that vmalloc preserve/restore should use the
> > public KHO APIs and avoid using internal methods.
> 
> I think it does, the same way vmalloc is layered on top of the buddy
> allocator. Why wouldn't you build things in clean understandable
> layers like this?

Here it's more like __vmalloc_node_range_noprof() and get_vm_area() calling
__get_vm_area()
 
> Jason

-- 
Sincerely yours,
Mike.

