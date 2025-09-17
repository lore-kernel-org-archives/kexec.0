Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC51CAC5A0
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SV63/ilReAX92FTIhCs/PydSy+8AOlw+EtW3gi5rMQ0=; b=f9TYbpRWffhAnub97h8BodisU/
	RALxmu9g4wzjA2GqsEabAq43+XjY3LA5SfrCPqR7nmAqpKF9NR9LoMwhjaFVwuYo+WZ3rniHDJ3ji
	Pdy9pdkpnAMVu/pj3uPCpvo0UzTu2YjRLEA5xRO2PdT06/LrbuFD2ecDFCuYGTSR1vaGN9QhuI8wA
	aDZrHiPnpZaz6XBGF+lurkXyYJb54rfxZYyEgksZumtA3eFaYRnyiqic1eGxrS7bobCUKTX/r+4pA
	dVtmP2qa9trfulCmhknnF1FlIq82Bqr0w0YZgKFmO8kVJEJRVMMghQPTb7oKLmBc/PxSLe3ZI+LDL
	kMxMkyKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw95-0000000DfDA-1CaE;
	Wed, 17 Sep 2025 17:40:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyw93-0000000DfCe-3DcU
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 17:40:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 211486023C;
	Wed, 17 Sep 2025 17:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D8AC4CEE7;
	Wed, 17 Sep 2025 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130840;
	bh=jOruTg3z11MGvKG41cspL9TY7zrdRzOtbVcIJxlzOvE=;
	h=From:To:Cc:Subject:Date:From;
	b=kS1MQwyXK7ySaTIUsclw5N1elKou9v0wFY5bhhXUVm1Ppb+EMluIWv5yDaqpDvGlT
	 /9LbI/nX0xndD+WNdENmR/l5Y+gPjyyESTsaItA/5EVRpcsUfrKv5XtxBiyaukEERO
	 InKwMtgCmTeJGlM3ExTuc5QRvEa95Bc+qmhOGdmMicogyLGKlW9gvdOGDG/seW2yLK
	 bJ3Xn5D6S9b9FPUpDxD9YohNab25q5l0hHAJwgmfEwcGJdwmSlwkHvt6SNO5ODGrjx
	 MgIQoRHBpgLTe885aJf8G/+8WDdjkRjfmPSX4uBU7YEQa9QNhZ22RXJqoY8aTREM5y
	 HmZKP7Ifjgs7w==
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
Subject: [PATCH v4 0/4] kho: add support for preserving vmalloc allocations
Date: Wed, 17 Sep 2025 20:40:29 +0300
Message-ID: <20250917174033.3810435-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v4 changes:
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
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  26 ++-
 kernel/kexec_handover.c        | 324 ++++++++++++++++++++++++++++-----
 lib/test_kho.c                 |  41 +++--
 mm/memblock.c                  |   4 +-
 4 files changed, 337 insertions(+), 58 deletions(-)


base-commit: 103e90626d3a4032d22e8b09ff14600e71cda59c
--
2.50.1

