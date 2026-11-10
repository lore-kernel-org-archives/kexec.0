Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62E606A33A
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jhF6HTEs;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OR+qLhkt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aBOpD08FcZgUdX6sSVHpe8Q+9Wl4ICsDP/3Nx2bwfmI=; b=jhF6HTEsxVW7TS
	3dpijO18qXsaLKjNzdRPcaRfMs4stgobm2eU/jTKWqvdk82gOmFNcVi9DrcN+lN4H8h9I7tJvNzCm
	VyvPcphBecjjme19bm3pwirG8gga9tcwylOpvip+GLes/+nZuorcpv4r8IFgdQ4rGeKA7HYLWxWM2
	gnxtr6iFmOxLdmIpiQkGcDr0pQhmktLbmoYTlFFruPmn4at+VkZ1x4GmDI6jze23m20C91oB+16ZS
	O7oNrHmdc9m8cJG2eFSG7XN/hVJC+Cr8X0SrtRj5M4Ukz3pfoy5g5K8heaWFig078/XvbDa2e4y01
	LTO9zK4kJBKejN42b7aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnlA-00000004McB-1pdf;
	Tue, 10 Nov 2026 15:27:44 +0000
Received: from out-176.mta1.migadu.com ([95.215.58.176] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnl7-00000004MbN-3yZE
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 15:27:44 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=gvY+EFrn3LUi+QbgDmol5Cy3h4iylPle2lZKtkPoW2c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794324458; v=1; x=1794929258;
 b=OR+qLhktr1EIyaPLVAyrm/NiuXlWjGdVW7HFby/zGsMn7+heEFKgnhY5oqQIGGm8Uv2LKXJR
 3aLuSxxJcdB+NuBSZ8sLXvUyyMOxxUn9ohJwpqP8f7n+m3AtTmK+o4t5UG3iAPP9WeWKkhCQvpA
 RJ6Ak9Vea2mgI0vDcg/HGq8A=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id dddf5df93d8bee57;
	Tue, 10 Nov 2026 15:27:38 +0000
X-Mizu-Trace-ID: dddf5df93d8bee57
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	jbohac@suse.cz,
	sourabhjain@linux.ibm.com,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	zaslonko@linux.ibm.com,
	brads@mainlining.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory
Date: Tue, 10 Nov 2026 07:27:29 -0800
Message-ID: <20261110152731.2841707-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9d2d6f81-ceb7-48a7-99a0-18a0bb8c504f@huawei.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_072742_196927_B9837CEB 
X-CRM114-Status: GOOD (  19.94  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 18:39:34 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> 
> 
> 在 2026/11/7 0:51, Usama Arif 写道:
> > crashkernel=size,cma reserves a separate CMA pool. On systems that
> > already reserve several gigabytes with hugetlb_cma= (which is common in
> > the Meta fleet), the crash kernel cannot use that existing memory as
> > part of its working set. With hugetlb_cma=6G, requesting another 2G
> > with crashkernel=2G,cma brings the total CMA reservation to 8G, none of
> > which can serve unmovable kernel allocations.
> > 
> > Use existing HugeTLB CMA memory first for crashkernel=size,cma and
> > reserve dedicated CMA areas only for the remainder. With hugetlb_cma=6G,
> > a 2G request reuses 2G without reserving more CMA. With hugetlb_cma=2G,
> > a 4G request reuses 2G and reserves another 2G.
> > 
> > The full HugeTLB CMA pool remains available to HugeTLB and movable
> > allocations during normal operation. After a crash, the capture kernel
> > can use the selected ranges as working memory. The conventional
> > reservation is still required to hold the kernel image and initrd.
> > 
> > The ,cma option already opts into excluding userspace memory from the
> > vmcore. This includes allocated HugeTLB pages in the selected ranges,
> > which the capture kernel can overwrite. The existing dump completeness
> > and pending DMA risks apply to these ranges as well.
> > 
> > Have architecture code record the requested CMA size and perform the
> > reservation in mm_core_init_early(), immediately after
> > hugetlb_cma_reserve(). The HugeTLB CMA areas are then available for reuse
> > while memblock can still reserve any remainder.
> > 
> > Use the existing four range slots for both reused and dedicated memory.
> > Limit reused memory to the page-aligned request, account for dedicated
> > CMA alignment, and report any shortfall. Ignore malformed optional sizes
> > and reject requests that would overflow page rounding.
> > 
> > Suggested-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > ---
> > v1 -> v2:
> > - Use existing HugeTLB CMA memory first for crashkernel=size,cma and
> >   reserve dedicated CMA areas only for the remainder. (Kiryl)
> > ---
> >  .../ABI/testing/sysfs-kernel-kexec-kdump      |  3 ++
> >  Documentation/admin-guide/kdump/kdump.rst     | 22 ++++++--
> >  .../admin-guide/kernel-parameters.txt         | 16 +++++-
> >  arch/arm64/mm/init.c                          |  2 +-
> >  arch/powerpc/include/asm/kexec.h              |  2 -
> >  arch/powerpc/kexec/core.c                     | 12 ++---
> >  arch/powerpc/mm/mem.c                         |  6 +--
> >  arch/riscv/mm/init.c                          |  2 +-
> >  arch/x86/kernel/setup.c                       |  2 +-
> >  include/linux/crash_reserve.h                 | 14 ++++-
> >  include/linux/hugetlb.h                       | 12 +++++
> >  kernel/crash_reserve.c                        | 51 ++++++++++++++-----
> >  mm/hugetlb_cma.c                              | 50 ++++++++++++++++++
> >  mm/mm_init.c                                  |  2 +
> >  14 files changed, 159 insertions(+), 37 deletions(-)
> 
> Should it be separated according to the architecture and framework code?
> 

IMO, the commit and change ins small and simple enough that it doesnt need
to be separated into different commits.



