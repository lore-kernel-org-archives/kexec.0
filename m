Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC83D7236A
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w1MBNjkWGTQKD+0yvtdp75Gw+2OA0Wj33WLt2TbOs7I=; b=f4VIX1jnviS8uM+wjxW20k85UQ
	g1BmBs1TXiI/6+saRrrWPEDVAgJ+cg/RdlYlY1tnu58jCJqcYFv/CqQ30art+1ApLqqbyqBLkrMmE
	7hyMRue3lf4BCxYTCjjoPiykJFlLQMq/8ZDpeAiCPpkHZD1z8NIq23y0OEOu5aE2hsdJCGL/mhkNA
	vfRmO2amdxVEHwmxLY3SgH0h2Fr26ZpLWbTaOH9WaVEqhRgyRUataC2JBA3puFkfD0FHGYfGIpVtw
	U4ebWNcNZkvtFu4aliWVT4KM7vC8r2LAQstGFpq9Rr4jBEixJQo8HYMjZUZ47apunaYsQES60LR8j
	JNp0znvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwd-00000008f28-1AvJ;
	Fri, 23 Jan 2026 09:59:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwZ-00000008f0e-45Gc
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 09:59:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CF3060010;
	Fri, 23 Jan 2026 09:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B91C116D0;
	Fri, 23 Jan 2026 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162346;
	bh=lJjM8x7dS3YIgG0GBsn8XGVAYDTLZLKZZO6yMQTePbI=;
	h=From:To:Cc:Subject:Date:From;
	b=SJ7og4hoGhYtUQuzu2z/K8eaIIthucOHysug8uhYPPd+WLGayt1UyIKBjy24YV13P
	 idAlxjMzQXTC4m1HbSEm9j6H0MECzsdPtWn/v26vXmncrJ1Hsf/fSuAeOx+BP3rgk4
	 ljpK5ICNBbyh3QCUlo4s4le4L+rZSzZ2VV42UhQcJdrPerdzXwmJuZGgqI2Sv9STgi
	 RGVk15w1XwZnqhbDvNwFQ/ybch7b+vLHcmQKG/pSA5PlRN8P9Ic+/32IkL+43CyLnk
	 ExwEiRTn3JFyNdBKgX0pAjlRAsXNZX25kKXUjiSOLA0KXF+mtfllcQ4kHdR9hDZ0Rr
	 v10Ii6a+dHEJg==
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
Subject: [PATCH 0/2] mm: memfd_luo: preserve file seals
Date: Fri, 23 Jan 2026 10:58:49 +0100
Message-ID: <20260123095854.535058-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

I also plan to add some tests for this. I quickly hacked together
something to test this series, but I am working on some patches
that would add multiple selftests for memfd preservation. It might take
me a couple weeks to get to it, so sending the main support now in the
hopes of making it into the upcoming merge window.

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (2):
  memfd: export memfd_{add,get}_seals()
  mm: memfd_luo: preserve file seals

 include/linux/kho/abi/memfd.h |  9 ++++++++-
 include/linux/memfd.h         | 12 ++++++++++++
 mm/memfd.c                    |  4 ++--
 mm/memfd_luo.c                | 23 +++++++++++++++++++++--
 4 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


