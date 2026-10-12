Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BEACA9EDE
	for <kexec@archiver.kernel.org>; Mon, 12 Oct 2026 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIpXBxc1Zh+5tYOYTOcIg/Ba6/+mSunX8M4pzhxilnw=; b=wJLxu2aXYb4xYcfIUS2ecFwGB+
	/5kEefm+Bbm4b7KMcSmNrd3Z1uS8bkfc+KLK8KANl1tG0isoXD1P5u3FokYidG27KDrMnyssouVzE
	rzpeozu66iA+k2DXkqFGNp7VhpF1nEiLu2c5CMRnK1dvAi6waVuS87iKhE8zuaBNxLzveqCpg4JV+
	lKTSNNHZbpcbwRg2qIESgLY5I4osgk+TX9R6kz9CqaHpCJCQHUF/5LG2w/BosAwgtuNnJP5oNT7Mf
	LbasazWhADYgovrqC/tcueZULCEeV9vvkqs41GAKnWnDqk+t3xCWf6XprInMYIdikDzikGn8mw1Z3
	kWojsfeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGJYc-0000000B46u-3xnX;
	Mon, 12 Oct 2026 17:11:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGJYZ-0000000B46c-3y0Y
	for kexec@lists.infradead.org;
	Mon, 12 Oct 2026 17:11:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 17BFE601F1;
	Mon, 12 Oct 2026 17:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452741F0089C;
	Mon, 12 Oct 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825082;
	bh=eIpXBxc1Zh+5tYOYTOcIg/Ba6/+mSunX8M4pzhxilnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i9yb8AruVWhFnaBylkZ3cCIq17GgdHNPTtRN/iIoerfLgW5ZLo57/VPpwKXuTXpX9
	 Rxqv6XA8bqubOEVIZ66EY4jsNKQP6dsMn5011o4a9WCImjqbGvlBj4xK5AaVrf9Dw5
	 L4ZbFwjbTLxhk9coLPjuPVFKyMMLSNCGbA+zXpkbdeW5YeRe7GVGiArf1Sad+EA5dw
	 N1gI/wrGWHCZFNKNzRFGKqQkuyrK80Fu14ktFl9La2Bv5kRdsKUQQOoSps/8oaxzWn
	 COJjN6dXrswLvINJaSw35/yg/vS+E9oOkIE58zsgJLAGfsPBYTdfctD/24yKKPFym2
	 WN/sATU+rv9bw==
Date: Mon, 12 Oct 2026 20:11:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Guo <guodongtai@kylinos.cn>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: fix global scratch size calculation
Message-ID: <as0UrrAvqjvUPyQx@kernel.org>
References: <20260922131217.698809-1-sourabhjain@linux.ibm.com>
 <asC3-4WNiTF3n7l1@kernel.org>
 <2vxzo6czjaa9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6czjaa9.fsf@kernel.org>
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

On Mon, Oct 12, 2026 at 03:52:46PM +0200, Pratyush Yadav wrote:
> On Sat, Oct 03 2026, Mike Rapoport wrote:
> 
> > On Tue, Sep 22, 2026 at 06:42:16PM +0530, Sourabh Jain wrote:
> >> KHO calculates the global scratch size based on memblock-reserved kernel
> >> memory. It passes NUMA_NO_NODE to memblock_reserved_kern_size() for
> >> this calculation.
> >> 
> >> When memblock_reserved_kern_size() is called with NUMA_NO_NODE, it
> >> counts both:
> >> 
> >> - memory reserved for a specific NUMA node
> >> - memory reserved with NUMA_NO_NODE
> >> 
> >> KHO needs to distinguish between these two types of reservations.
> >> When calculating the size of global scratch memory, KHO only needs to
> >> account for reservations made with NUMA_NO_NODE. Reservations made for
> >> a specific NUMA node must not be included in the global scratch size.
> >> 
> >> Add memblock_reserved_size_nid() to calculate reserved memory for a
> >> given reservation type and NUMA node. When NUMA_NO_NODE is passed, it
> >> counts only memory reserved with NUMA_NO_NODE.
> >> 
> >> Use the new API for lowmem, global, and per-node KHO scratch size
> >> calculations. For lowmem and global scratch, count only memory
> >> reservations that were made with NUMA_NO_NODE. For per-node scratch,
> >> count only memory reservations that were made with the corresponding
> >> NUMA node ID.
> >> 
> >> Remove memblock_reserved_hugetlb_size() since it has the same
> >> implementation as the new API and differs only in the memblock
> >> reservation flag being checked. The new API handles both kernel and
> >> HugeTLB reservations through its reservation type argument.
> >> 
> >> Define the new helper as a static function in the KHO implementation,
> >> since it is only used by KHO and has no users outside
> >> kernel/liveupdate/kexec_handover.c.
> >
> > I looked again and this feels like a band-aid to me.
> >
> > I think we need to step back and rethink the order of the
> > scratch/kho-bootmem sizing and consider how NUMA and lowmem are involved
> > there.
> 
> Could you elaborate? How else would you calculate the sizes?
> 
> To me, the idea sounds fine (although I also share your comments on the
> code style). This is what the global scratch size should have been doing
> from the get-go. Today it over-allocates by counting both global
> allocations and _all_ per-node allocations.
 
> There is a separate problem with CONFIG_NUMA=n, but for that I think we
> should just have a different allocation path where we only do lowmem and
> global scratch.

I mean more fundamental code refactoring that takes into the account all
cases (and I could miss some)

- NUMA vs no-NUMA
- systems that have global scratch containing lowmem scratch vs those that
  don't
- and of course fix global scratch over-allocation
 
> >> On powerpc, the difference can be seen in the scratch_len values
> >> reported by:
> >> 
> >> cat /sys/kernel/debug/kho/out/scratch_len
> >> 
> >> Before this change, the global scratch allocation was 0x12000000
> >> (288 MB):
> >> 
> >> 0x1000000   (16 MB)
> >> 0x12000000  (288 MB)  <- global allocation
> >> 0x5000000   (80 MB)
> >> 
> >> After this change, the global scratch allocation is 0xd000000
> >> (208 MB):
> >> 
> >> 0x1000000   (16 MB)
> >> 0xd000000   (208 MB)  <- global allocation
> >> 0x5000000   (80 MB)
> >> 
> >> The 80 MB difference is the per-node reservation that was previously
> >> being included in the global allocation.
> >> 
> >> The same issue also affects lowmem scratch memory, but its impact is
> >> limited because the lowmem scratch memory calculation is restricted to
> >> the first 4G of memory. The changes also cover the lowmem scratch
> >> memory case.
> >> 
> >> Cc: Alexander Graf <graf@amazon.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: George Guo <guodongtai@kylinos.cn>
> >> Cc: Mike Rapoport <rppt@kernel.org>
> >> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> >> Cc: Pratyush Yadav <pratyush@kernel.org>
> >> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-mm@kvack.org
> >> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

