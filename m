Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163EFCD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6YHTA1Y1yfstf1VS88i/WxtTnRtrqsXvhH2dMssxuMI=; b=HeFWvm/eX+1Hi9/JnWTx+NGX3y
	NpT6U1jCTGvMJ/FlGMjsLI+muPeAm7oTlGTu+UmSZqnYvEXtDbyNh/4slMhj5TirQgtMPQ+ojOT/6
	Ncbu/oUU85XxGzWfMey2Jw3IIEyZK5oiHDLtyQHna3MgFbuTZrG/s1dZr4AmuMM7VXJqqQj1aO4dN
	KmcteLNWpPBzdRsb+f0AFsOU2zSy0cCtgK932cRZhQODDttyuAijYmBUCqxEWkTr/SHFNiNmQPWqi
	t1e81Gh8gjrMgNnRncwj+J8H1POO9q+K5rA3Bp0XpP7/eag63Mtp00Zvjg1JmyfQ6Fyb6Vxmescoe
	c8zUcEqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPP3-0000000DSXO-1dpx;
	Mon, 11 May 2026 12:06:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPP1-0000000DSWw-1g3R
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 12:06:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98C466001A;
	Mon, 11 May 2026 12:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79730C2BCB0;
	Mon, 11 May 2026 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501186;
	bh=lngDUFP4KgpPffCrIS4q+IK7DqwfawlMa55S7VcjFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q84m+u7F9OyKhYoEEUc4C9Ew/QoiuZLPTbqwk/qnqW5tIwrU6Gj2+VRJqRsGG3v9F
	 6vpaYhZ6wGUUdvrcyV4OpvHA5bLUIyECCVmBHkf0xAOqIi+h+dDd0Bvzd90GIAXl5O
	 IxZtDm0koUYaX0s/DkAmB2a1ObH5N/SrJFkEmv2Zvqw+hogYE/j+h2DXi7kyqCv7+H
	 SnasqQphKIfPMvHfBDsFnSlnbAcahFpOBSI5VYphM0BINXwR/s3otJJYtE+1zuZSbk
	 DXajYNIEnH9qTZWgpE4jhnefZ1sFeiHhbA9mFRCqMRej4rsQ1JpsrRLem/PYnU7ztu
	 RaxM+cl65AfcQ==
Date: Mon, 11 May 2026 15:06:19 +0300
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
Subject: Re: [PATCH 09/12] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Message-ID: <agHGOxSnP_VraH1M@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-10-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429133928.850721-10-pratyush@kernel.org>
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

On Wed, Apr 29, 2026 at 03:39:11PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> In the upcoming commits, the KHO will learn how to discover free blocks
> of memory by walking the KHO radix tree. It will then mark those regions
> as scratch to allow memory allocation in case scratch runs low.
> 
> To differentiate the extended scratch areas from the main scratch areas,
> introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
> for allocations during scratch-only. Teach should_skip_region() to check
> for both flags before deciding if the region should be skipped.

Why there's a need to differentiate SCRATCH and SCRATCH_EXT?
SCRATCH (I still hate the name) means "memory memblock can safely use for
the allocations". Initially this memory comes from the reservations in the
first kernel, but if the second kernel can find more memory to extend it,
why that additional memory should be treated differently? 

> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     Checkpatch complains about no space after MEMBLOCK_KHO_SCRATCH_EXT in
>     the declaration, but doing so makes it nicely align with all the other
>     numbers. Mike, if you'd like I can add some whitespace.
> 
>  include/linux/memblock.h | 10 ++++++++++
>  mm/memblock.c            | 41 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 45 insertions(+), 6 deletions(-)
 
-- 
Sincerely yours,
Mike.

