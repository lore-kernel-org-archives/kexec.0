Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39919C79FA7
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ivdXEMRjHX8ActYuqmF+142e8M/tE9eaqLHBL0xTXos=; b=vQ/euT7O7JmGYtIhs2Q3SfjSTl
	/XF9y/PWfmFLn5qEH2u7HwMlAcw48NRhkvBXzfQeHB4lWqCV53Iqxcs6xObwDi2VaQyLN+Le3/+rF
	Hm0Hq6p1JJ1ilVLmF7J0NQJu57vNX4sIWrTb7DGXyaimFD1qoxXsH7dztrZATi2zUecEwwN+DKn2l
	yAgdlQPA2P83qjrO+qmDG2tIfj/dS1xKl9X5h/vxu0wsyiluxObIDRKacn/si95u7whRvlpvNJvt+
	PQu5L1OlwB6zCl+aW4VboO7/VXWzWzqLLYZrmg6zk7GP1578aii/f0/WurcrYYk2VmhBkbHOK/IAE
	h5sBNV4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnur-0000000BlmT-08Vb;
	Mon, 05 Jan 2026 16:58:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnup-0000000Blm8-15p1
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 16:58:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 441C642A32;
	Mon,  5 Jan 2026 16:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF57C116D0;
	Mon,  5 Jan 2026 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632326;
	bh=mupDn7J1NSAUZ9GV/4Xx6+A3fMSwov+EkCqaBWzjOm0=;
	h=From:To:Cc:Subject:Date:From;
	b=YxhbXFH76Gyi1Q1IeKu6BX24k5shRmCdHTfQU6bcQLC+cFfvY6krzkB7bYUSyKShM
	 uG3/cpRYYGDTPOIHfDhg2kcFrP5Gp6NamzlQawAXRrOlyltMcby7Mt9b8DBtYbpKto
	 96jjELOv3zquxG0gGWkrpuk7p0oWRgvwDoo1qoJl3fH6tAs2rYwQ4SqlsRgydOkP3B
	 NNkzjtmUJXTBdpSoq4sJFo9aigVIYb24zrKwUzbbPMlbk2LV4TRc/U+BGF9XgsMk1M
	 ASKyg5/3mtBaFz2gwK99f/FbiD3h8zdRbVQp+P3XwjyWFE/ZxoqDI4dziDjI6+yBUY
	 Qe4yO5QYs0iig==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] kho: ABI headers and Documentation updates
Date: Mon,  5 Jan 2026 18:58:33 +0200
Message-ID: <20260105165839.285270-1-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_085847_369842_10671321 
X-CRM114-Status: GOOD (  11.39  )
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

LUO started adding KHO ABI headers to include/linux/kho/abi, but the
core parts of KHO and memblock are still using the old way for
descriptions on their ABIs.

Let's consolidate all things KHO in include/linux/kho/abi.

And while on that, make some documentation updates to have more coherent
KHO docs.

Jason Miu (2):
  kho: Introduce KHO FDT ABI header
  kho: Relocate vmalloc preservation structure to KHO ABI header

Mike Rapoport (Microsoft) (4):
  kho/abi: luo: make generated documentation more coherent
  kho/abi: memfd: make generated documentation more coherent
  kho: docs: combine concepts and FDT documentation
  kho/abi: add memblock ABI header

 Documentation/core-api/kho/abi.rst            |  28 +++
 Documentation/core-api/kho/bindings/kho.yaml  |  43 -----
 .../kho/bindings/memblock/memblock.yaml       |  39 -----
 .../kho/bindings/memblock/reserve-mem.yaml    |  40 -----
 .../core-api/kho/bindings/sub-fdt.yaml        |  27 ---
 Documentation/core-api/kho/concepts.rst       |  74 --------
 Documentation/core-api/kho/fdt.rst            |  80 ---------
 Documentation/core-api/kho/index.rst          |  78 ++++++++-
 Documentation/core-api/liveupdate.rst         |   2 +-
 Documentation/mm/memfd_preservation.rst       |   2 +-
 MAINTAINERS                                   |   1 +
 include/linux/kexec_handover.h                |  27 +--
 include/linux/kho/abi/kexec_handover.h        | 163 ++++++++++++++++++
 include/linux/kho/abi/luo.h                   |   8 +-
 include/linux/kho/abi/memblock.h              |  72 ++++++++
 include/linux/kho/abi/memfd.h                 |   6 +-
 kernel/liveupdate/kexec_handover.c            |  34 +---
 lib/test_kho.c                                |   1 +
 mm/memblock.c                                 |   4 +-
 19 files changed, 361 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/core-api/kho/abi.rst
 delete mode 100644 Documentation/core-api/kho/bindings/kho.yaml
 delete mode 100644 Documentation/core-api/kho/bindings/memblock/memblock.yaml
 delete mode 100644 Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml
 delete mode 100644 Documentation/core-api/kho/bindings/sub-fdt.yaml
 delete mode 100644 Documentation/core-api/kho/concepts.rst
 delete mode 100644 Documentation/core-api/kho/fdt.rst
 create mode 100644 include/linux/kho/abi/kexec_handover.h
 create mode 100644 include/linux/kho/abi/memblock.h


base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
-- 
2.51.0


