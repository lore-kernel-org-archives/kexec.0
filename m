Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBD9CAC5A7
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 05:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JNXQ7XIu0fz9LKitfDfRv/5GsRWOvEXSnCvtX8rTplA=; b=auAb+18ITGXB2Ziad6hQhB+Vo9
	gGSzSM67stxcFV9E9Krha8hp16F9X6rHce1EgpXDqdGDKkja4cP3luxkgWvjDI8IJ+EyyEt/ZucV6
	cSjPpQDJSWhMyGTJk0ED/moK/JgOMCwxlz45goAgUsaGWiW5twpr+lim/UokpNibKpjnam2y4nLBe
	IHZ7OvkNWireDtZmfe27KyikbA0b6nPEWVZQLiNS02kg4eQ6JbpsxPxzKN7EIutZe+dqhlk6gZabh
	GuQuTxB5KtElahmr5lntPqRy4AF+CfDQ8eN6TdnjKsE2/TQeOlmZXXB19O6WI8MijFF/r7dEwgABM
	H4LhnBWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Csp-00000006h9g-2fO6;
	Sun, 21 Sep 2025 05:45:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0Csn-00000006h8x-18DT
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 05:45:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 42D1442BAD;
	Sun, 21 Sep 2025 05:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA553C4CEE7;
	Sun, 21 Sep 2025 05:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433506;
	bh=nwWluE/HYzt54TgZr7bT7uoFJDOTM+N37KaOXrsGYlQ=;
	h=From:To:Cc:Subject:Date:From;
	b=cl8tO/bRb/V9ewUSs4La8qYHpF4Z3+KoUTgHWBULmErJDhTF7Ix/56fjyZ5NbYHey
	 Yzzv4ucletwMmo+1u31sQpVt8TR4cPkcSaFdi6i3+UlzIFYCuNHoOkfYcZhA3YpH/5
	 BbbChUN7TmVGwECjW8b1FtMXzpt2PEbWepqoBSqCLctJleGlZcu3U1krwxKmx32cFm
	 E/A9FM2fVN+MK/GVLAlqOcSOSwPjMLVD4vTs9rJ1+vIh+oFqMrV0KvQprMriZcXnqS
	 JE03KZoBV7XjhxPmqc2RJtDfVItMEFhdO0cl2LUIYyWRII2eFJ7gW6mPIahoOwP6rC
	 I65J0fb9eQJRg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] kho: add support for preserving vmalloc allocations
Date: Sun, 21 Sep 2025 08:44:54 +0300
Message-ID: <20250921054458.4043761-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_224509_364865_A83C1204 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following the discussion about preservation of memfd with LUO [1] these
patches add support for preserving vmalloc allocations.

Any KHO uses case presumes that there's a data structure that lists
physical addresses of preserved folios (and potentially some additional
metadata). Allowing vmalloc preservations with KHO allows scalable
preservation of such data structures.

For instance, instead of allocating array describing preserved folios in
the fdt, memfd preservation can use vmalloc:

        preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
        memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
        kho_preserve_vmalloc(preserved_folios, &folios_info);

[1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com

v5 changes:
* rebase on mm-new of September 17
* use kho_restore_pages() in kho_restore_vmalloc(). Required to resolve
  a conflict with "kho: make sure page being restored is actually from KHO"
* use more descriptive local variable names in kho_restore_vmalloc()

v4: https://lore.kernel.org/all/20250917174033.3810435-1-rppt@kernel.org 
* rebase on mm-stable
* use 'struct kho_vmalloc' as preservation metadata instead of storing it in the first chunk
* separate KHO flags from VM_ flags
* unreserve vmalloc pages on error
* add checks for under- and overflow of preserved metadata

v3: https://lore.kernel.org/all/20250908103528.2179934-1-rppt@kernel.org
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  kho: check if kho is finalized in __kho_preserve_order()
  kho: replace kho_preserve_phys() with kho_preserve_pages()
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in
    fdt

 include/linux/kexec_handover.h |  33 ++-
 kernel/kexec_handover.c        | 361 +++++++++++++++++++++++++++++----
 lib/test_kho.c                 |  41 ++--
 mm/memblock.c                  |   4 +-
 4 files changed, 381 insertions(+), 58 deletions(-)


base-commit: c565f9816932dc8d164bd8c69acf077840565ce7
-- 
2.50.1


