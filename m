Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C38EF06E3
	for <kexec@archiver.kernel.org>; Sun,  8 Feb 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMcDMMO5pUL3iromxDqvHXOfyfcuNP17tBgk7jNq3a8=; b=46MacSR4SxUV2+wEO4/DPh86Me
	GAgfsflRp3Ok0sfGjfqMjTP0eDLyXszLe5NNFAd18+lAIfTFQg+oHCbpFCq9323AYiajyNdub+dZP
	ZkNkvESnqx4ClygOUZ7gDLS+jnOZSGEDUr4T/r7TsHimvqYjj0TKuXOAWBUx0DZQJLxPUB1xnbu12
	+eiBuvjlIORVpf39gum7Ca7UtDURtX+l5gkqqI3xiNMhV5ZSBDPfse5JxQHLrIvq18j3/W/bTcWfe
	WE8egJYApDqnDFpro5zZ0ouHES9r8vRkKg1G2EeR/qeHyWWa+4u+QHOGGVir90egIsba9fZ+Mal4B
	r+cdCRiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vp9C6-0000000DXPz-36qU;
	Sun, 08 Feb 2026 18:07:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vp9C2-0000000DXPq-1NLc
	for kexec@lists.infradead.org;
	Sun, 08 Feb 2026 18:07:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 49CD4600BB;
	Sun,  8 Feb 2026 18:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158FAC4CEF7;
	Sun,  8 Feb 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770574053;
	bh=PxcXwLUBRw69pj0y/iw2r5Y8so1kEeFr6i4iz7h+PcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIjSMF/3JMss8Yv+gzQCRJWnr30dkiCVPZJUb/Twq/rYj3Ce0b2P3ZsnTT+JbZyka
	 vlOgGbPj+Hs+7evu4WQ5ZZjNMTbLg8eophnbVM8l5Yw9ZGiNNRYPAhr1wZw7Mnbbjp
	 s2KPl5J79HQ1SNpCBVRfzZ5+IMwcNfGdFOgsV3UiLeNGfPu/PNNdp4cUxruGUrFEv4
	 wvtSKOjCooDTcqBbHi/diKNhFZrcnm2EgIxJKYeJivAggYo04X0Rr5a4R6B9kAT3/m
	 7midGG2ywBRApW/wuU82yzTseJINdxFPeWtLzn+sGRIQ3Xm9/dKr0cw8XkzCYvxSLP
	 yE1Cl6ejYcP8g==
Date: Sun, 8 Feb 2026 20:07:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <aYjQ3WlwJkcvJOZz@kernel.org>
References: <20260206021428.3386442-1-jasonmiu@google.com>
 <20260206021428.3386442-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206021428.3386442-2-jasonmiu@google.com>
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

On Thu, Feb 05, 2026 at 06:14:27PM -0800, Jason Miu wrote:
> Introduce a radix tree implementation for tracking preserved memory
> pages and switch the KHO memory tracking mechanism to use it. This
> lays the groundwork for a stateless KHO implementation that eliminates
> the need for serialization and the associated "finalize" state.
> 
> This patch introduces the core radix tree data structures and
> constants to the KHO ABI. It adds the radix tree node and leaf
> structures, along with documentation for the radix tree key encoding
> scheme that combines a page's physical address and order.
> 
> To support broader use by other kernel subsystems, such as hugetlb
> preservation, the core radix tree manipulation functions are exported
> as a public API.
> 
> The xarray-based memory tracking is replaced with this new radix tree
> implementation. The core KHO preservation and unpreservation functions
> are wired up to use the radix tree helpers. On boot, the second kernel
> restores the preserved memory map by walking the radix tree whose root
> physical address is passed via the FDT.
> 
> The ABI `compatible` version is bumped to "kho-v2" to reflect the
> structural changes in the preserved memory map and sub-FDT property
> names. This includes renaming "fdt" to "preserved-data" to better
> reflect that preserved state may use formats other than FDT.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

