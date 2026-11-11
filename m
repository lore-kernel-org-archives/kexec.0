Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB8606A320
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0BWoQNVc;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IHVRJJBR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pfnkpC25liOJ53c0mQZ6/TSQvyf0Bspw+v/pqKKkn6s=; b=0BWoQNVcKW/0OtSzZzfYNEjSfZ
	NeSrCGR59Xcn6ghj8CAKX5frhAbwj0PcguFUdGG7v4D9Tf+oFj/Yu26NUl1HbCAPkC4VuzupdADyU
	C7fKM3uKOh8ZdHgtf+NhCrrEfV9tTxB6ZyU3TwZe8W2ZQGgp8j3T+pLyQ4Y47P7p0NyYZVNCsG/0S
	q0Juj+IKDjp2VvpkLvGcbHGnPQIgRTK8bM2SsFtom0npTkQ5Jnwy8FOVGd/96sLxbXNj+09yTZpzL
	qL/lg9jHWB6er+clMaNVh6jCiQq7Uv5NeCmfKqKrRteyPHslnfasCDmvK6O7TjNUSZha35cdz1MzR
	8CtY+mYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR2Sg-00000005qaD-1gFf;
	Wed, 11 Nov 2026 07:09:38 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR2Sd-00000005qZp-0uxX
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:09:36 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so2011068a91.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794380974; x=1794985774; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfnkpC25liOJ53c0mQZ6/TSQvyf0Bspw+v/pqKKkn6s=;
        b=IHVRJJBRwiG87ToGkVi9+V3cw6SLMT3WO2kB3ULbUjwndf6FEwAPBlF5x7fivHjDYS
         KMclETQSBUJ6GnmF3vdPOF+LaXwPSsyeDCNBCCVTScvyjYMiKrcAXxefGEVDJi5tFT3P
         6Sj5xJTgPu1lIeD+CuPN85slhe10tMgwMuiKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380974; x=1794985774;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pfnkpC25liOJ53c0mQZ6/TSQvyf0Bspw+v/pqKKkn6s=;
        b=mP/NDSnH06ZlH2RaS3XaCpGPCJYNztPFT3FuCzy/P54fmkgQFoQ+HS2Ne6+J9NqizA
         4PSWWEPNULbz6Qd+ucOCUHQjuz7XDZAtL87V7PnAd6JjrvjGmB/bOEjs7w5yC2uD53mU
         dgXQMvDMTkXYLT7lJsf0mwBo0uaYJNxvCPrK647bp/5DFAnT99LC0SS5HOQRgIPXL5Lp
         /ru6VdHBgoCKRpfgr5w7ZerFgODveCjQr8T48vx1+ndOHKaamFnnyZp+kh6fiztNzYMZ
         Pv1JoNEj2lMLvjHUTmM22RanC+9ZlN03sEdW9R844JIzM8boE0ImYhw1M1I8ackOvu0X
         ax7w==
X-Forwarded-Encrypted: i=1; AL+hErGknn4u/Vtj3pqEqgKA/7FuOA4qLkBYPbODW81pN8y+L9gdJBmcsvKZgFt+uzsLizOCDZmROA==@lists.infradead.org
X-Gm-Message-State: APuU4Z9zBbyBwJv/hxb7j51fEXW4APqPT8nVR1v9an/lemCKQf2BjQoS
	s7ikpFn3DE+farzST83ffexXU9iUEDa53v4Wi6sR31LzHkx5ji17DxDWFJcOQQCihR9mHef8MHM
	naJgSp4YttQRFYbg=
X-Gm-Gg: AYBFou3uuRs4ENQfVVI+hv3x/7YfeuaXWMB88YYfoqdXIS80Jkismocgu41IhxIDSEL
	VAESqoYWq3FYh5qzo3fIghsrOSxNpshUZ4RkKMcY85eTYiOw1THM3MUISH0gwoXmqmQj3fgwAVN
	mTIXDF280vxirR/i6JSl1LXLXBepcHzb2+4J7HVvDHZPqkKMDBd/5rIpkyiP9oJMVrxZQJo1n0r
	fr4zwcYduC9HFca54XRXVvDRKTm9ALD73+Kos/lzQuXvk6gQX1LJcT+jhTDI9yCf9cs5lyZn4Lp
	p0dyEpJq0j5th6xC+DHO6xEm1h2b1RhnS6bj0V42SwpmjiqDku9+f0QAjNJLe56B+cbRxd1QYXg
	S+vhcdRVueLNGuLtLiGAKLnlw44tNOGBqX9iXaQuF/nMBVoMdVJgqnC3vQC5MOtgitBuOfjuBAY
	PcjuBPl1TVafW2433f9PJF02SMfSVSKhHI+jtIoQDYxvYI7nQi4A055HtyzcxhLXR172ywqytbU
	4RxgqbwpkKiJXoI04WPHOM3iBS+TLCtEOIAFzmeECjBWUhK9Oimt5rMpyzF63tEhzhHmcbMniOh
	OK81xbIYB1l7MLFIvPnbCPLk3D9Y8ewCb1aedOeiLMIYSwKrUEZ9pyUM2N5sURkn2Y/9dtyM6az
	SP6BfB/mo3WtF1P5K+8WWfLqrDTYvL22UfSXmukoQKFDi/qy1cWW/P87tvNLXJ7cvjDuYQ1shQE
	z8rHC1dj1y8pewfncd7xY5yz3YYX/+VZSY5/na3qAViBZ2f2+rmXll
X-Received: by 2002:a17:90b:17c8:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b182edc482mr1816027a91.29.1794380974284;
        Tue, 10 Nov 2026 23:09:34 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17da51f80sm3175523a91.1.2026.11.10.23.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:09:33 -0800 (PST)
Date: Tue, 10 Nov 2026 23:09:30 -0800
From: Chris Down <chris@chrisdown.name>
To: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: graf@amazon.com, kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH] kho: Prevent reuse of preserved pages after a reservation
 failure
Message-ID: <avQUquBK6cO6tUUI@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_230935_290935_C8F47C53 
X-CRM114-Status: GOOD (  16.34  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho_preserved_memory_reserve() reserves each range of preserved memory
in memblock and marks it noinit, but ignores both return values. Either
can fail when memblock has to grow its reserved array and can't find
room, which at this point in boot it may only take from KHO bootmem.
The boot then goes on as if the range were reserved, and two things
can follow:

- If the reservation failed, memblock_free_all() hands the range to the
  page allocator with the previous kernel's data still in it, while its
  KHO user still expects to restore it. A memfd preserved through LUO
  can then get back pages that belong to someone else. Oh dear!
- If only the noinit marking failed, the struct pages can be
  initialised later, wiping the KHO magic, so restoring the range fails.

Dropping the handover at this point isn't safe either. reserve_mem=
revives its regions from the handover before mm_core_init(), and
relies on this walk to reserve them.

Carrying on could hand out private data, so let's panic if either call
fails.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/liveupdate/kexec_handover.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index eeec298aa9d6..0faa21ebb0cf 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -629,9 +629,14 @@ static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 	sz = 1UL << (order + PAGE_SHIFT);
 	page = kho_get_preserved_page(phys, order);
 
-	/* Reserve the memory preserved in KHO in memblock */
-	memblock_reserve(phys, sz);
-	memblock_reserved_mark_noinit(phys, sz);
+	/*
+	 * Reserve the memory preserved in KHO in memblock. It's too late to
+	 * drop the handover if that fails: reserve_mem may already have revived
+	 * regions from it.
+	 */
+	if (memblock_reserve(phys, sz) || memblock_reserved_mark_noinit(phys, sz))
+		panic("KHO: failed to reserve preserved memory %pa+%#llx\n",
+		      &phys, sz);
 	info.magic = KHO_PAGE_MAGIC;
 	info.order = order;
 	page->private = info.page_private;

base-commit: a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425
-- 
2.54.0


