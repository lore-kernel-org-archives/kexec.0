Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFD8CD6E57
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WLye1OeGSvGfRb8KDc6cQsEQJDuu8/tX64BsRlEPQ/8=; b=opgMoVlvksr795vOyHQM6qIaHz
	0v0pad4jIQXfhmBHguxgQezuUQwYXOaot9QqBaSFGjbTpdf/zBd/OsVrIjmJx+p1dsHnanki+rl+h
	biaAuPsZ6X3PJBBTuUg4ZY4jAjAg6ws8PTEz2eItkCgLSrAtPKZPlVmW1rhkdpKqhc5Qwh3TZ0//q
	HxB6wqIRr0EBH/HU7rKdXueX/q/cwHcNDiSXPdWtvk4ns3lrrwiECOeucxvdhKGazbM0xJQES1iHh
	/n2CZ7WG5mYgNnd7IUSdBCCUiWb38VqBagzf5YCbdJa4PG1xkEGMz27yu8fYmGqM+SlkLsgukMswI
	9nbzGeMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTjgF-00000009mCw-0Cmc;
	Sun, 31 May 2026 17:10:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTjgB-00000009mCk-1zAX;
	Sun, 31 May 2026 17:10:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 67806601DE;
	Sun, 31 May 2026 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B131F00893;
	Sun, 31 May 2026 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247426;
	bh=WLye1OeGSvGfRb8KDc6cQsEQJDuu8/tX64BsRlEPQ/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cd5xFtLc8CgSUAo5VbGm+pKIlSN5dodN7UW+f0GhB53myIoxNH6p+dDCuSowwLt1M
	 tn6pbkJrs6TvruipRFHl17aKPzkzwwClUW3OCw2kaVqtuO8SCeKbwrz+glC8UeZEHr
	 GtexD/nJZv5cqchIGk9LPD0u7HqxLjrc8lVMZ8tUA9w35qyh8ltsFucDy0MxNZ9tZU
	 d2U6RyTtMK1CdN+Cj8hhy00WNDZZe6O2rSmmW7KgtJNLz+pYi9BC6RF5u4rlYqXqdK
	 OLXNC8wRdf5z8eAJSKbI+sKv+ylMD/5luOBySRgN6a7aVGyuVCVVx7szWKIZv4EWX4
	 cUVPlWHqBfd5Q==
Date: Sun, 31 May 2026 20:10:11 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <ahxrc4pTvVU20RTX@kernel.org>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
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

Hi Jork,

Only had time to skim through the patches.
I have a couple of high level questions for now.

On Wed, May 27, 2026 at 05:41:42PM -0700, Jork Loeser wrote:
> When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
> root partition driver deposits pages to the hypervisor and creates
> partitions for guest VMs. Prior patches enabled kexec for L1VH, but
> only when no partitions had been created and no memory had been donated.
> 
> This series lifts that limitation. It uses KHO (Kexec Handover) to:
> 
>  - Track all pages deposited to the hypervisor in a KHO radix tree
>    and preserve them across kexec so the new kernel knows which pages
>    are owned by the hypervisor.
> 
>  - Freeze running partitions before kexec, record their IDs in the
>    KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
>    after kexec.
> 
>  - In case of a crash, exclude hypervisor-owned pages from crash
>    dump collection by passing the radix tree root PA via Hyper-V
>    crash MSR P2 to the crash kernel.
> 
> Dependency on Pratyush's KHO series
> ===================================
> 
> Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
> "kho: make boot time huge page allocation work nicely with KHO" [1],
> which is still under discussion. This series uses functionality from
> those patches -- specifically the meta-data page enumeration via table
> callbacks and the restructured radix tree API. It also extends the
> KHO radix tree with:
> 
>  - A freeze mechanism to lock the tree before serializing for kexec
>    (patch 13).

There were a lot of effort to make KHO stateless and drop the requirement
for finalization/freeze.

Why is this necessary to add a freeze mechanism to kho_radix_tree?
If it's a hard requirement of mshv maybe the freeze part should be handled
there?
 
>  - A crash-kernel-safe variant that memremaps radix nodes for use
>    outside the direct map (patch 14).
> 
> Patch overview
> ==============
> 
> Patches 1-12:  KHO radix tree and memblock changes (from [1])
> Patch 13:      Radix tree freeze and del_key() error reporting

del_key() error reporting sounds like something we'd want to avoid.
del_key() is called on "freeing" path and during error handling, it would
be hard if at all possible to deal with errors from del_key().

> Patch 14:      Crash-kernel-safe radix tree presence check
> Patch 15:      Page tracker using KHO radix tree for deposited pages
> Patch 16:      Debugfs interface for page tracker
> Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
> Patch 19:      Export kexec_in_progress for modules

Isn't there another way to differentiate kexec reboot?

> Patch 20:      Freeze and vacuum partitions across kexec
> 
> Feedback
> ========
> 
> This is an RFC. I am looking for feedback on the overall approach as
> well as the KHO changes (patches 13-14).
> 
> [1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/
> 
> Based-on: linux-next/master (next-20260527)

-- 
Sincerely yours,
Mike.

