Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111F6CA1017
	for <kexec@archiver.kernel.org>; Sun,  7 Sep 2025 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aIyksWTmF+WPRQfDWNQ3wfYCg86aJi793lKO/e/geg0=; b=Z9hC2GONah8DzvrQCW5rEfAEX4
	7r2y6Az02hYNVkGLdLRi/tFfTiF3AvRaF8ujE17SxpPinMi25fiaHnUbgFStQ7kHQcMQLuBHo9JZi
	xF8gNYyqdYglmeNVYkcaHAzGRshZ4PVVV1A7c2xd9v/fWvjnZMYgRDwHCfSRLxSc7A4N1yu8FFXR2
	NWvwXHwSZRp4eNeP65qaNGAja3s4o3p5ltZz9/5KocP/6Z/d6K9HIVUdUvSlQ4iny8d+bWFoF1NTw
	6hha4SSEiA1pAd7gr9eCpwntRL/+A50ujzu1bNnX6NjLnpvgNBmc6ZUQhbcChIJBgWpAiIZ9dmNrG
	bYqgFEmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv8Vy-00000009hNe-2DzJ;
	Sun, 07 Sep 2025 06:04:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uv8Vv-00000009hNC-36Wa
	for kexec@lists.infradead.org;
	Sun, 07 Sep 2025 06:04:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BF97E43DA0;
	Sun,  7 Sep 2025 06:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF20C4CEF0;
	Sun,  7 Sep 2025 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757225073;
	bh=Y+6NT7qGhfiYpIQPVV4I0mtOFqnghk5yu59oPQEuT2I=;
	h=From:To:Cc:Subject:Date:From;
	b=haXlZ207G0qpRnmByYvNsmw0JNfqiAaOWam3kbsqOPErDLMXsEshkfvubab9jT1Iv
	 1EsfHRPcCfBb/kX57nh1sb/nXMBWWizrNPR7BXJzeyM0I8e34ZFgkDk6enH9CUzUH/
	 +8wV7owr1jTRIULdJU43VRMFrD41BIvVyBy6ERgjo+Kq4S1SFixIAFNd/1jIqhIzHX
	 KbzPnzGz59GmbarsOi70dgjNMdY7iNUJFudyE/xeA+O3VzuUiys0LA7mLpL0fdPCsc
	 zm3wlMU+hpMhSzkpHMt17fH0Jg2VoOQ/vbEkTjX/AdjbkATpaQ5QChPFzvFzvZG+qN
	 RS7tHHD2QgbTg==
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
Subject: [PATCH v3 0/2] kho: add support for preserving vmalloc allocations
Date: Sun,  7 Sep 2025 09:04:26 +0300
Message-ID: <20250907060426.2177717-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250906_230435_808310_DF9B3112 
X-CRM114-Status: UNSURE (   8.14  )
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

v3 changes:
* rebase on mm-unstable

v2: https://lore.kernel.org/all/20250905131302.3595582-1-rppt@kernel.org
* support preservation of vmalloc backed by large pages
* add check for supported vmalloc flags and preserve the flags to be
  able to identify incompatible preservations
* don't use kho_preserve_phys()
* add kernel-doc

v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt

 include/linux/kexec_handover.h |  12 ++
 kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
 lib/test_kho.c                 |  41 +++++--
 3 files changed, 241 insertions(+), 12 deletions(-)


base-commit: b024763926d2726978dff6588b81877d000159c1
-- 
2.50.1


