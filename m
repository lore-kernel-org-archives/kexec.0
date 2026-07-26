Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE9AC531FA
	for <kexec@archiver.kernel.org>; Sun, 26 Jul 2026 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spr/SmfOjPmaJI8lzrFOgqnfwsvYYhOk1VLcniRBUcI=; b=ee/jfmGfFgBVYXfU+P1dLauG5a
	tokimfqQfi4AecjHaU1WVL4A+BvKtGG3BQJQ05bR4uOk3uQZvE5cBSaSl5k4yWAl7RCZNfSZsjRn1
	PQ+BMe4kQVUN+1YZyvJ+Vrs+5lTvQTsu1zo74gFDdT/zcaqrl056CRityXw4JFvlEtz0NPH5gHxRj
	nHXbFSQEXT0mcO4YuhHQAbXEnc1wM4QyPAGVF/G6b/KTP7SWlEbyvq+qkwIBD3oeO+saRfkWyWCpd
	5Lh1Bq4/6xgJBjIJNBxZl+7U37eUjmnbns8OS+ZVlwraLXQN+RpxiPdcIH4d5jqfiIYWvfX89ETJW
	TA4M1j7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnt0V-00000000yOw-0JlM;
	Sun, 26 Jul 2026 07:10:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnt0T-00000000yOn-2tHn;
	Sun, 26 Jul 2026 07:10:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE63742BA3;
	Sun, 26 Jul 2026 07:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FEE1F000E9;
	Sun, 26 Jul 2026 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785049840;
	bh=spr/SmfOjPmaJI8lzrFOgqnfwsvYYhOk1VLcniRBUcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gBlvMIxQNWBBWE7Se28bgQLzPVqN60xYrY8DlKRT3aGhfXwM8DKtw8In3lCobQ+vh
	 g1alBRmrjg+8NOKIsr6dN74Qz13AjE1dQsVdjl6fwHz7Yb0wOX5eWvws0BGYptghk2
	 i4iSDdK5BoYB+vqxQipvZkJ2hIFjkGWGwrSZ3xFTcOPHJYt4S6nJ/H9u/L0wEKET8U
	 W5MyT1QYk4EwhlkHvjB/+6b9XzbffrdGgMPZjCN0vvyv74t8mMjAWQDBnADVb0bqdK
	 9IHJMRT6viJlszcCge90+kKqr6OeZq16xrvYmvl0Nne/PLbB/VO5iGADt/petKQbvO
	 uuZU1LSBTLg3Q==
Date: Sun, 26 Jul 2026 10:10:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com,
	vladimir.murzin@arm.com, mark.rutland@arm.com, ardb@kernel.org,
	james.morse@arm.com, leitao@debian.org, yeoreum.yun@arm.com,
	robh@kernel.org, kees@kernel.org, coxu@redhat.com,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	adityag@linux.ibm.com, hbathini@linux.ibm.com, makb@juniper.net,
	piliu@redhat.com, graf@amazon.com, liaoyuanhong@vivo.com,
	jbouron@amazon.com, bauerman@linux.ibm.com, bgwin@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/8] arm64: crash: Add crash hotplug support
Message-ID: <amWy4u9tXoWX6Wtp@kernel.org>
References: <20260723131242.1537633-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723131242.1537633-1-ruanjinjie@huawei.com>
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

Hi Jinjie,

On Thu, Jul 23, 2026 at 09:12:34PM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump image
> becomes stale, potentially leading to incomplete crash dumps.
> 
> Currently, userspace udev rules reload the entire kdump image upon such
> events, which is inefficient and leaves kdump inactive for a long time.
> 
> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
> support") introduced a kernel mechanism to update only the elfcorehdr.
> This patch set implements crash hotplug support for arm64.
> 
> It also addresses and fixes several critical pre-existing code issues
> and Sashiko AI review findings extracted from the previous patch set,
> following Baoquan's suggestions.
> 
> The major improvements and fixes included in this series are:
> 
> - Fix powerpc memory leak, null-ptr-def and overlapping memory
>   range truncation bug.
> 
> - Fix several memory leaks for arm64.
> 
> - Simplify arm64 load_other_segments().
> 
> - Implement infrastructure for arm64 crash memory hotplug support.
> 
> This patch set is rebased on liveupdate/crashkernel-cma.
> 
> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> 
> Jinjie Ruan (8):
>   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr()
>   powerpc/kexec_file: Fix null-ptr-def in extra size calculation
>   powerpc/kexec_file: Prevent kexec range truncation

It's weird to see powerpc fixes in a series that adds a feature for arm64.
Judging by the subjects, they are completely unrelated to to crash support
for hotplug and should be sent as a separate set.

>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix image->elf_headers memory leak during retry
>     loop
>   arm64: kexec_file: Simplify load_other_segments()
>   arm64: crash: Add crash hotplug support
> 
>  arch/arm64/Kconfig                     |   3 +
>  arch/arm64/include/asm/kexec.h         |  13 +++
>  arch/arm64/kernel/Makefile             |   2 +-
>  arch/arm64/kernel/crash.c              | 148 +++++++++++++++++++++++++
>  arch/arm64/kernel/kexec_image.c        |   1 +
>  arch/arm64/kernel/machine_kexec_file.c |  76 ++++++-------
>  arch/powerpc/kexec/crash.c             |   2 +-
>  arch/powerpc/kexec/file_load_64.c      |   2 +-
>  arch/powerpc/kexec/ranges.c            |  12 +-
>  include/linux/kexec.h                  |   2 +
>  kernel/kexec_core.c                    |  25 +++--
>  11 files changed, 223 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash.c
> 
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

