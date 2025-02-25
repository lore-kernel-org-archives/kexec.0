Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B9C021B8
	for <kexec@archiver.kernel.org>; Tue, 25 Feb 2025 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uwv0a4dzm+5HpJk54FntQugqsgzOGHWa5a/atNDvfEI=; b=yeSkhVw7Ce7TS1eaG9FGRdSoSC
	KjzC2yWw4ZPIaRyQkCaOit0PwOc/xjC/VmZZz5oElEuUgX3jOxJFylJjoN9NxKRAKN8bSLsky9uFG
	BL20tr9RtOeUjspYAfjLmmppBony7VYffbV4w3afUmraHfwPKNazuCTMGAer3FrfFdUW198X2UdEn
	iOx3Za7I6piO6e5qmYeI6kjE9kTUZEb3fcWckybkXqhBWvRpCCA+Hw6ge9v028+zANCn6UXskt3Ez
	DFO/nSrAspTnMhX6j1wcW8yWDcbSg/nFiS5Xnh7fW8+GsWBa838QM3idHCVLh/ZJIXCxgDGffxPlT
	mOj1jY8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpfw-0000000GFw5-181v;
	Tue, 25 Feb 2025 07:48:20 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmpeV-0000000GFOI-0RBC;
	Tue, 25 Feb 2025 07:46:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ECB006123A;
	Tue, 25 Feb 2025 07:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BF0C4CEDD;
	Tue, 25 Feb 2025 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469609;
	bh=ufWHWQ1xjvwW0hl8NZb6j0p51Ljh1vhupp5zrhn05g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNF5vIXE8AI1M72/t0vxMc2XxKToFenm/PAwm6NZlyzcXaF3GjKp3p8wjKOQxZsS7
	 U5SdmrZ6BYaIYN/FwLyRn6F6fE1le5OiAG1N1ERsiHU12nBZ0Mpu+uoTJxsNcrzgL5
	 FecXJjFgXjXiQvXjfk0dv540gXmPw1NfbWIvf34KHRA1eYhDFFirjnTSuwgDS6kEOd
	 1qDcx0OgryYeV466p9C+RQAkPDKOvmVtK2XQyZFdYwXGOngf8RClrW5TVTs70NL83+
	 yvakFILGXUbl3fYUBTPeGqmiA4fnXW4OaTfniPVNR1nBcO4RYgvzzBPR4DQ+sz2u+j
	 fzz+pKVE/XpLg==
Date: Tue, 25 Feb 2025 09:46:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <Z711VP45tjBi0kwx@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224013131.fzz552bn7fs64umq@master>
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

On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
> >Hi,
> >
> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> >to denote areas that were reserved for kernel use either directly with
> >> >memblock_reserve_kern() or via memblock allocations.
> >> >
> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> >---
> >> > include/linux/memblock.h | 16 +++++++++++++++-
> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >> >
> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >> >index e79eb6ac516f..65e274550f5d 100644
> >> >--- a/include/linux/memblock.h
> >> >+++ b/include/linux/memblock.h
> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >> 
> >> Above memblock_flags, there are comments on explaining those flags.
> >> 
> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
> >
> >Right, thanks!
> > 
> >> > 
> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >> > again:
> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> >> > 					    flags);
> >> >-	if (found && !memblock_reserve(found, size))
> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> >> 
> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> >> correct, the reserved region's nid is not used.
> >
> >We use nid of reserved regions in reserve_bootmem_region() (commit
> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
> >know the distribution of reserved memory among the nodes before
> >memmap_init_reserved_pages().
> > 
> >> BTW, one question here. How we handle concurrent memblock allocation? If two
> >> threads find the same available range and do the reservation, it seems to be a
> >> problem to me. Or I missed something?
> >
> >memblock allocations end before smp_init(), there is no possible concurrency.
> > 
> 
> Thanks, I still have one question here.
> 
> Below is a simplified call flow.
> 
>     mm_core_init()
>         mem_init()
>             memblock_free_all()
>                 free_low_memory_core_early()
>                     memmap_init_reserved_pages()
>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>                     __free_memory_core()
>         kmem_cache_init()
>             slab_state = UP;                                          --- (2)
> 
> And memblock_allloc_range_nid() is not supposed to be called after
> slab_is_available(). Even someone do dose it, it will get memory from slab
> instead of reserve region in memblock.
> 
> From the above call flow and background, there are three cases when
> memblock_alloc_range_nid() would be called:
> 
>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>   * If it is called after (2), we don't touch memblock.reserved.
>   * If it happens between (1) and (2), it looks would break the consistency of
>     nid information in memblock.reserved. Because when we use
>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
> 
> So my question is if the third case happens, would it introduce a bug? If it
> won't happen, seems we don't need to specify the nid here?

We don't really care about proper assignment of nodes between (1) and (2)
from one side and the third case does not happen on the other side. Nothing
should call membloc_alloc() after memblock_free_all(). 

But it's easy to make the window between (1) and (2) disappear by replacing
checks for slab_is_available() in memblock with a variable local to
memblock.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

