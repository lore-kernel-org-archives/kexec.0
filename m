Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516C0D13C20
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuekLC8en0td7oT7zIqcqIdKfiM7LVatOtq67QDUGkE=; b=1NADa8lUjx5UTYSXejyEGswVbh
	dx7+iz72Bs1Zo/EjMbaVKJA7weaEhYy0CQUtXFWqSQEBcJdH+ZkCYdzL0l0s57GDKsEZIjcEQcQ8f
	wAyLLoeFEFi4BzNh+E2zvHtFCcRiW+hH8+5WsYG3mGpEY5XMquGfE6JiRotiIeTG/gTDKlVUdOBf9
	gPEXz1g65Xm/4BTDr9zH/hJEVXWL51x0lGxT+FrcpCbtR7FA7ZI8ZjQjI22w9V435HNyAZS60iSln
	qeQvvZrGjAtanwtRKIYpvCXXTRsEQvI/8ad6wR1hG+co/dZRACnHcB++1Zgw6A9mlrejLFzrh3FOO
	FqWhZGGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkNie-0000000ChwE-3VM5;
	Mon, 26 Jan 2026 14:37:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkNid-0000000Chw7-2JCs
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 14:37:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CA1660136;
	Mon, 26 Jan 2026 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CDDC116C6;
	Mon, 26 Jan 2026 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769438250;
	bh=gdfx2feLN6TCXDpAa4ggnSeI5KqTW3J3K6FBc2yfOFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rf6nge473dxjqTDe76VCvV99QZTDzBZNcuE4AVsvRCx1tVdM4YvKftbA0xuh1CZ63
	 iVw1pHZyedxQSBviJM/DhVKJzpNTb25ztptjSIqJv/oD1AfIzNakztu1716jOz++yv
	 FRkE8N4q762X+u0hBJQlN1daImLdQ4h+qGCSlSjfEVTnS+dpfVnkM0LsFkMVerHwiy
	 /K25y+D3H/rD9K+QXYDiF4Z/y/NOiPEqicW6qbDLZ6tS9GbZSybVTjprj65FtqeaCB
	 hZdClXbebcJoi9B+cRjIMeYgpJS8aCMazKmgbhPli7JipLNWZZCLJKE2MJqzutD9Fs
	 llFvM0qNIaMUw==
Date: Mon, 26 Jan 2026 16:37:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
Message-ID: <aXd8I4czYUpl72qq@kernel.org>
References: <20260123095854.535058-1-pratyush@kernel.org>
 <20260123095854.535058-3-pratyush@kernel.org>
 <aXYGkb-QtYNaWYw4@kernel.org>
 <2vxzqzrca6cm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzrca6cm.fsf@kernel.org>
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

Hi Pratyush,

On Mon, Jan 26, 2026 at 01:47:21PM +0100, Pratyush Yadav wrote:
> Hi Mike,
> 
> On Sun, Jan 25 2026, Mike Rapoport wrote:
> > On Fri, Jan 23, 2026 at 10:58:51AM +0100, Pratyush Yadav wrote:

...

> >> -	file = memfd_alloc_file("", 0);
> >> +	/*
> >> +	 * The seals are preserved. Allow sealing here so they can be added
> >> +	 * later.
> >> +	 */
> >> +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
> >
> > I think we should select flags passed to memfd_alloc_file() based on
> > ser->seals (and later based on ser->seals and ser->flags).
> 
> Not sure what you mean.
> 
> I think the only seal we can set via memfd_alloc_file() flags is
> MFD_NOEXEC_SEAL, which is really a F_SEAL_EXEC and plus a change of the
> inode's mode. And now that I think of it, that is a valid use case that
> we might as well support. But I think that should be done by preserving
> the mode of the inode directly, and then copying the seals back. The
> main reason for that is that the mode can be changed after the memfd is
> created too.
>
> Other than that, all other seals are set by fcntl (via
> memfd_add_seals()), so I don't see what else we can pass to
> memfd_alloc_file().

Hmm, "using ser->seals" was bad phrasing :)

Now we add support for creating memfd with MFD_ALLOW_SEALING and at some
point we'd want MFD_HUGETLB and huge page size.
So I think we should have a field in ser that will define what flags should
be used for creation of memfd and based on the value of that field pass the
flags to memfd_alloc_file().

For seals support this field can be hardwired to MFD_ALLOW_SEALING at preserve
time.

> >>  	if (IS_ERR(file)) {
> >>  		pr_err("failed to setup file: %pe\n", file);
> >>  		err = PTR_ERR(file);
> >>  		goto free_ser;
> >>  	}
> >>  
> >> +	err = memfd_add_seals(file, ser->seals);
> >
> > I'm not sure using MFD_ALLOW_SEALING is enough if there was F_SEAL_EXEC in
> > seals.
> 
> Why not? memfd_add_seals() can handle F_SEAL_EXEC as far as I can tell.

I just noticed it behaved differently :)
Looks like F_SEAL_EXEC indeed can handle it.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

