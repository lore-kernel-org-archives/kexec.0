Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B5606A323
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RDWPKC2W;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daCQz1Zh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=7ZuahbF6+z1TKgPocK6b1w/LNWgw/JvkC15VlenM0sg=; b=RDWPKC2We20KSLyn/t6EG+6mg5
	/cJTxT6yVlff1YYqa7cbk82Qlcrr35bsKnzRltTJ2uTPaALZXHoYXT0RNTxXaV5FUdiXUFyGYWpRX
	vJKXMYvQSJE5pCPJ/bRszdNBA+hXs+j9UDwBPNo9RzBY3Jwqw5JN6WukJUsUc9pE0yN6+SckCo+XA
	Cc6xUZA2vMWalzONt6o3BQeEY6ObUL3vT/a2+XuzQfogBXYs7lo7ZEYfdGV7vi9UkBizzH0yTOIfq
	5KOCW6n1lanzM6BNbl7JMRhIP2YTaPpj1AYtxdwOYp8KauTPAt3anpqwArW0eZPytVRPUb6dYSprR
	eMFFwGDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwc-00000002fLW-1hj5;
	Mon, 16 Nov 2026 13:40:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwwb-00000002fLP-348C
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 13:40:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32AEA60D5B;
	Mon, 16 Nov 2026 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055B1F000C4;
	Mon, 16 Nov 2026 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836424;
	bh=7ZuahbF6+z1TKgPocK6b1w/LNWgw/JvkC15VlenM0sg=;
	h=From:To:Cc:Subject:Date;
	b=daCQz1ZhyWXtl44VERLjzwf4McgJ7N2+wucObuWTVBGvb3rE+VtwnoUq05dSgs42q
	 1LZSyEtpWtMTp71b7BeklLRhhuuUwIqs2mZggNQen0Ew07p5B1gk0cTr+zagFCAN9M
	 v69VqSUP8U86/2u44DncKRe2BjOVrkPNXnGxurTVOYsVFomucT6Pyk+1Dfyaquexel
	 kHDjwlalUXamnXa33LjHbumfNimFC4spzOSiCzA1uJn+jyoCiYr+cMboT4tQ/uFO1d
	 JSiqfaiFJgERJPTKDh/zU25XFfS/wFn/tKEn75KV3pVoj15wye93vm/YJke3oCo+px
	 6v6+5DB8GP/5Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tarun Sahu <tarunsahu@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/5] KHO map
Date: Mon, 16 Nov 2026 14:40:05 +0100
Message-ID: <20261116134013.1636689-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series introduces the KHO map. It is a sparse map from integer keys
to u64 values. It is implemented as a radix tree of fixed depth.
Currently the tree depth is 6, so it can support keys up to 54 bits
wide.

The main user of the map is memfd. Currently memfd uses a vmalloc buffer
that has a pair of {index,pfn} to track the folios in the file. That
uses 16 bytes per page. The KHO map uses only 8 bytes per page with some
overhead. So for a 1 GiB memfd, it uses roughly half the memory.

In addition, it is a more versatile data structure. For example, it
allows for adding or removing pages from a memfd after preserve more
efficiently than the vmalloc array.

Post-LPC 2026, the plan is for KHO to maintain backwards compatibility
as much as possible. So this data structure allows the serialization
format to be more flexible to future changes. It can also be used by the
upcoming HugeTLB and guest_memfd preservation.

I have talked about this as "KHO xarray" before, but I think using
"xarray" is just going to confuse everyone since it isn't really a
xarray, and the API works a fair bit differently. So I renamed it to
"KHO map".

This series isn't complete yet, but it is in fairly good shape so I want
to share it to get some early feedback.

Things that are missing and planned in the future:

- Multi-index entry support: currently, while the map is very efficient
  with 4k folios, it is horribly inefficient with 2M folios. Each folio
  in the memfd takes up a full page to track. Multi-index entry support
  can fix this by tracking entries that cover a whole page in the
  previous level, similar to page tables.

- LUO versioning support: LUO versioning headers are still in
  discussion. This data structure should use them for future
  extensibility. I am mainly waiting for things to settle down there.

- Dynamic depth support: Currently the depth is static, so it can only
  support keys up to 54 bits wide. Adding support for multiple depth
  levels based on what the caller needs can improve efficiency and
  flexibility. I likely will only add support for this in the ABI and
  leave the actual implementation for later when we have a real use
  case.

This series is based on a couple of memfd patches I sent earlier [0][1].

[0] https://lore.kernel.org/kexec/20261103172251.2348370-1-pratyush@kernel.org/
[1] https://lore.kernel.org/kexec/20261110175855.2437084-1-pratyush@kernel.org/

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (5):
  kho: add KHOSER_CLEAR_PTR()
  kho: build KHO objects into a single kho.o
  kho: add KHO map
  kho: test: add KHO map test
  mm/memfd_luo: use KHO map for tracking folios

 Documentation/core-api/kho/abi.rst     |   5 +
 Documentation/core-api/kho/index.rst   |  12 +
 include/linux/kho/abi/kexec_handover.h |   5 +
 include/linux/kho/abi/map.h            |  94 ++++
 include/linux/kho/abi/memfd.h          |  39 +-
 include/linux/kho_map.h                |  77 ++++
 kernel/liveupdate/Makefile             |  13 +-
 kernel/liveupdate/kho_map.c            | 514 ++++++++++++++++++++++
 lib/Kconfig.debug                      |   4 +
 lib/Makefile                           |   2 +-
 lib/test_kho_map.c                     | 575 +++++++++++++++++++++++++
 mm/memfd_luo.c                         | 292 ++++++-------
 tools/testing/selftests/kho/vmtest.sh  |   2 +
 13 files changed, 1449 insertions(+), 185 deletions(-)
 create mode 100644 include/linux/kho/abi/map.h
 create mode 100644 include/linux/kho_map.h
 create mode 100644 kernel/liveupdate/kho_map.c
 create mode 100644 lib/test_kho_map.c


base-commit: a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425
prerequisite-patch-id: dc555295a2263ea9482ab393c50296636ab1e84f
prerequisite-patch-id: b0c8f9caeb6fd99a352692083e4d2e9255f13d02
prerequisite-patch-id: af8beaebdb1687c349732dc4a7773f7baa4a2c17
-- 
2.56.0.611.g1030f0b940-goog


