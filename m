Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B1D29C50
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1f2oPOqAYByozw+PIAV4Leo7Wp4BePrrwg2Br+G5G0g=; b=zF1Ae1nUS7Hd4aLSevTpGKpX/L
	LbjuA9vg/lYMISYFzVnzHHxpauN42KIbCdDNCV360WGzjsR1PuxqmpwmwFyfy3tHVf3XhBpstal18
	M0q8WYSsoeuAfS/xOXDD0Fo2oxUKKwDv408099sf2VZm4pgTTxwwu6b45/6EZrl92+o2dWPiGaWqK
	BIadV+8Jx1B9MGANpzy/Raov+LydMnsrh1VfE0fcFHambKYhcYT7aKv7hs04hGgIDLNG3UYN6tMtt
	mwXruur7SMa8GNZPYlhiNl1uFCPq21Zmf3CDPYMRa4ngTZ6wZ6XkaU8VvGSeP/PtzP74zHudlBAB+
	6M81FVhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuDh-00000002jJI-07eC;
	Mon, 19 Jan 2026 18:43:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuDf-00000002jJC-3JlA
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:43:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3975B60054;
	Mon, 19 Jan 2026 18:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF682C116C6;
	Mon, 19 Jan 2026 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848198;
	bh=0jusXPuIwXIPjxzuxFwH6bINDFwmNsrGqBF1AyAan4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YM0QqjqdUWbm50XeI0p+NG1eLf0kzunlAOfcRNZ0NB853n0+RKvlIUwYvlshIg0+W
	 Zk3SQfmJqf89mLGzySXSdjkp+9F0et7hr7pZgBbHWzx4FMbWHAImWbAfe27haI2Fce
	 NredufFmP9X9HwEpeZbpxUfaZi7kF1xM56WGMid0jC6/4zEVdDLBXriJ6k+jZmw1IY
	 1j7yON5Qk3ZJa4NtiBder0W/z//vg4Ss6OM4tywuYtvl7lZW8T4eVoKzXwYKHxiORs
	 HyGK2e5M6HQfm11Y4SqNf21eieyjng6xKG/NVn/0xs/YcJj2ucoOlLy/LIWX2aG2nf
	 BEcLSVND6WvFQ==
Date: Mon, 19 Jan 2026 20:43:10 +0200
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
Subject: Re: [PATCH v7 0/2] Make KHO Stateless
Message-ID: <aW57Pn4gj8lHoOO3@kernel.org>
References: <20260116034432.1520731-1-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116034432.1520731-1-jasonmiu@google.com>
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

Hi Jason,

On Thu, Jan 15, 2026 at 07:44:30PM -0800, Jason Miu wrote:
> This series transitions KHO from an xarray-based metadata tracking system
> with serialization to a radix tree data structure that can be passed
> directly to the next kernel.
> 
> The key motivations for this change are to:
> - Eliminate the need for data serialization before kexec.
> - Remove the KHO finalize state.
> - Pass preservation metadata more directly to the next kernel via the FDT.
> 
> The new approach uses a radix tree to mark preserved pages. A page's
> physical address and its order are encoded into a single value. The tree
> is composed of multiple levels of page-sized tables, with leaf nodes
> being bitmaps where each set bit represents a preserved page. The
> physical address of the radix tree's root is passed in the FDT, allowing
> the next kernel to reconstruct the preserved memory map.
> 
> This series is broken down into the following patches:
> 
> 1.  kho: Adopt radix tree for preserved memory tracking:    
>     Replaces the xarray-based tracker with the new radix tree
>     implementation and increments the ABI version.
> 
> 2.  kho: Remove finalize state and clients:
>     Removes the now-obsolete kho_finalize() function and its usage
>     from client code and debugfs.
> 
> ---
> 
> Changelog since v6 [1]:
> - Fixed a potential dangling pointer in kho_radix_add_page() on allocation failure
> - Fixed a premature return in __kho_radix_walk_tree()
> - Corrected the size type in kho_preserved_memory_reserve() to match memblock_reserve()

git range-diff claims that v5, v6 and v7 are identical.

Can you please verify that it's the latest version you intended to send?
 
> [1] https://lore.kernel.org/lkml/20260115230047.1220580-1-jasonmiu@google.com/
> 
> ---
> 
> Jason Miu (2):
>   kho: Adopt radix tree for preserved memory tracking
>   kho: Remove finalize state and clients
> 
>  Documentation/admin-guide/mm/kho.rst        |  53 +-
>  Documentation/core-api/kho/abi.rst          |   6 +
>  Documentation/core-api/kho/index.rst        |  18 +-
>  include/linux/kho/abi/kexec_handover.h      | 144 +++-
>  include/linux/kho_radix_tree.h              |  70 ++
>  kernel/liveupdate/kexec_handover.c          | 695 ++++++++++----------
>  kernel/liveupdate/kexec_handover_debugfs.c  |  23 -
>  kernel/liveupdate/kexec_handover_internal.h |   3 -
>  kernel/liveupdate/luo_core.c                |  12 +-
>  kernel/liveupdate/luo_flb.c                 |   2 +-
>  tools/testing/selftests/kho/init.c          |  20 -
>  11 files changed, 573 insertions(+), 473 deletions(-)
>  create mode 100644 include/linux/kho_radix_tree.h
> 
> 
> base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

-- 
Sincerely yours,
Mike.

