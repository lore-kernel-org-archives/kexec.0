Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FEE83826
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FkfExXpZWckKd6SgoaSjuTk6MTr1egwXV+v1Qow5XSU=; b=SDpgI24x4iW3Gd4RUa0wwptBJw
	LmHEU8MeqvfmdzUoETVaexpzMxL2HZ7Au6WOooPYaKImwLwsMYII1hzyz8IZmdZVRxUIZ7VWzw9Ht
	ZafWtQbLlqNDTP1zyDek9K6s+vO7iwe4jPIeeq9yimeVAjH5B8llK3LCSvwMmCFYheP4aqdr+O3hX
	trxIAHkXy1+csEGlZm9ep4cGlcohqK1RIqf8Vb9QMQ/LwY3PWRDxjWhNooazPp4fszfZM150R4PA0
	w5DBagNy1o7z8QPguDH9siECDOs5c4+JJOnydTCtl3wF1hsZqfHh/Nz3YC+C5mXi+tvDiqoQ7WUHD
	xPdqsqog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pD-00000007AuH-3kQa;
	Mon, 16 Feb 2026 19:00:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pB-00000007Ato-1shV
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 19:00:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 32A3C6013F;
	Mon, 16 Feb 2026 18:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB10BC116C6;
	Mon, 16 Feb 2026 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771268398;
	bh=N9wQ4aA83fUFDKk8sMuj4R2Ktgs7ll1vpgEUx3H9geg=;
	h=From:To:Cc:Subject:Date:From;
	b=Z7j84/9TmeCX5asCWLDzYYJ3DBnLI9qKK8wHfKDmGHp5ETpMH1oDphtnS/faLRCIJ
	 r+uq+p6A81c6o4idpYXovYmruGfOUkK8P7YfgnZhx98BElAEC34vQDafc5ayLCh4Km
	 3WD35QQaLjHz7F0O9oahCwTlUcUlMF1qrNmDtcfYgsHkgiTHpx0aXZaZEihSpWRcJM
	 F9TSp4+2dZ/UPOkfUfIV0fIdVdSjQihxKFJQ9wyRKPpuJGhsKnf6NvdRgMFFFJtceM
	 bdUi/QNn2XDMK9Ge1HO6Cz7bGHUVWGOAtgM/WdAXJX2e4U2jRGBOG0JfIGJhhN/Tp0
	 BJW/RzgnNl/SA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm: memfd_luo: preserve file seals
Date: Mon, 16 Feb 2026 19:59:31 +0100
Message-ID: <20260216185946.1215770-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series adds support for preserving file seals when preserving a
memfd using LUO. Patch 1 exports some memfd seal manipulation functions
and patch 2 adds support for preserving them. Since it makes changes to
the serialized data structure for memfd, it also bumps the version
number.

Changes in v2:
- Define the set of seals supported by this version. Support for any
  other seal would need a version bump. Make sure the memfd only has
  this set of seals. Reject any that don't.

- Make seals a u32 since uABI defined it as an int. Change the
  __reserved into flags.

Pratyush Yadav (Google) (2):
  memfd: export memfd_{add,get}_seals()
  mm: memfd_luo: preserve file seals

 include/linux/kho/abi/memfd.h | 18 +++++++++++++++++-
 include/linux/memfd.h         | 12 ++++++++++++
 mm/memfd.c                    |  4 ++--
 mm/memfd_luo.c                | 35 +++++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.53.0.335.g19a08e0c02-goog


