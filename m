Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A2607099B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aZkDaMNI;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YUqCGuzE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EOQecW951XnrbiS/Up+TYLD26Kqi5K026ERWTR9xkgQ=; b=aZkDaMNIYs0nIW
	U5EOsX6DNgWBIJt2wvXDz99emNjgJs5YsXoSySmo/C22bWktqtkcGVKKDiIeb6mJzUvQAeoerNITs
	M4FKaHVhnKNGnAYjDBvu6msi4xeYgZa16czi2yVp92v1pmVVJVik/n6jcUMffu6xN7Ck92q/I4iWc
	IRyblAsGeHpzdQyZDxGyruw2pw0BZiampw5HeFmA4UIBakjyBTg+97EMK+x8RnDRVD+vRNMzOp7mY
	X6Y/8intw0/T/INjL6C0K9UQ+29hwu/qUIhZiHHGAm6M8BvRud6F+ZEs4gdENZlPLPGRSgIZztP3O
	h/DyRLut62EGCUyWOI1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiuX-000000075sP-2D0W;
	Wed, 04 Nov 2026 21:52:49 +0000
Received: from out-54.mta0.migadu.com ([2001:41d0:1004:224b::36] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOiuU-000000075rF-3VFD
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 21:52:48 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=M0FIOF1DLHsXObG+kd/KQNs8mRLPiwWKZte8OxN1x/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793829164; v=1; x=1794433964;
 b=YUqCGuzEVdhMmFNJfjT5gW9ZPjpsGP70FP3YGkFSa5bivcYI+PaGCHrR9BqQ4erw0r34A6Yy
 kpGJv7LjfZOy5qSSS46MCpnaJXL2wCEWyJv2vrMIlpOEwZhyMB0o5uggci15ileavOnMI6EBWge
 k7BiymnnIx4JTkIDEo9lx74k=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id a0a1d10de7c52127;
	Wed, 04 Nov 2026 21:52:44 +0000
X-Mizu-Trace-ID: a0a1d10de7c52127
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Bradley Morgan <brads@mainlining.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	david@kernel.org,
	hannes@cmpxchg.org,
	hbathini@linux.ibm.com,
	jbohac@suse.cz,
	kas@kernel.org,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	riel@surriel.com,
	rppt@kernel.org,
	ruirui.yang@linux.dev,
	shakeel.butt@linux.dev
Subject: Re: [PATCH] crash: keep crashkernel C =?US-ASCII?Q?MA_pages_reserved_if_activation_fails?=
Date: Wed,  4 Nov 2026 13:52:36 -0800
Message-ID: <20261104215237.203332-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <661AFDEC-B8DF-4A5B-8C58-1D39F518F068@mainlining.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_135247_106924_705CB9B4 
X-CRM114-Status: GOOD (  19.85  )
X-Spam-Score: -2.1 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 19:16:42 +0000 Bradley Morgan <brads@mainlining.org> wrote:

> On 4 November 2026 14:56:00 GMT, Usama Arif <usama.arif@linux.dev> wrote:
> >reserve_crashkernel_cma() adds each crashkernel CMA area to
> >crashk_cma_ranges[] as soon as it is declared. If the area later fails
> >activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
> >inside it, cma_activate_area() releases the pages to the buddy allocator
> >as ordinary memory. The range is still handed to the crash kernel and
> >excluded from the vmcore, so kernel data that lands there is overwritten
> >by the crash kernel and missing from the dump.
> >
> >Mark the areas with cma_reserve_pages_on_error(), so that a failed
> >activation leaves the pages reserved: lost to the first kernel, but safe
> >for the crash kernel to use.
> >
> >Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> >Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >---
> > kernel/crash_reserve.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> >index a03f0a4305a4e..a4b616ed49482 100644
> >--- a/kernel/crash_reserve.c
> >+++ b/kernel/crash_reserve.c
> >@@ -498,6 +498,7 @@ void __init reserve_crashkernel_cma(unsigned long long cma_size)
> > 			continue;
> > 		}
> > 
> >+		cma_reserve_pages_on_error(res);
> 
> You do know that this will activate under every bitmap_zalloc() failure,
> right? Is that accounted for?

Yes, that's intended. By the time cma_activate_area() runs, the range is
already in crashk_cma_ranges[], so the crash kernel will use it no matter
why activation failed. Keeping the pages reserved is the only way to make
sure the first kernel has nothing there that gets overwritten or goes
missing from the vmcore; the area then behaves like a regular
crashkernel= reservation of the same size.

fadump made the same choice; it is what cma_reserve_pages_on_error() was
added for in commit 27d121d0ec6d ("mm/cma: provide option to opt out
from exposing pages on activation failure").

The bitmap is one bit per page (32 KiB per GiB with 4K pages) and is
allocated at core_initcall, so a failure there is very unlikely.

The alternative is to give the memory back and to drop the
range from crashk_cma_ranges[] when activation fails, leaving the crash
kernel with less memory than requested. I do think that is acceptable as
well. But we do need either whats done in this patch or give the memory
back. Happy to send the alternative as v2 is everyone thinks that the
better way forward.

> 
> > 		crashk_cma_ranges[crashk_cma_cnt].start = cma_get_base(res);
> > 		crashk_cma_ranges[crashk_cma_cnt].end =
> > 			crashk_cma_ranges[crashk_cma_cnt].start +
> >
> 
> --- Thanks!
> 

