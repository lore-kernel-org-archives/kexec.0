Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81931CD5BD0
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NjWhMi7ol32O9kyUWWfMx4g883LE1ApapjqDf0LQz0E=; b=PDxJk7srzv4amq0E6REQN2uM75
	TjJv0TckINVAee14YO3MRUIj0pW3M5LTnApfqyeWR48ep62bRgaX3TpDaqrqpfE2efAylgJK+a1XI
	muvEXalwtbU9iD5BMDZQGuHe+JWntDSECqTGgnG1SwYUmUgqE9hA23IltuEDoz3V/qZKy/3C+tFbc
	FEMClgmu+jDPsqzIlCvB5+pWLBcx+DVWJgQCycbavc07w86Y8Y7p1Cjk1tuzjrE+nVP2wiTV13pdb
	e1QAKsTfrXwE8uo8zThSMbhTplZ+eXk/aU468riA8lcp/suo6W3+wy+NuEp8Himl2E1I1W+NSriOm
	voX/Rvhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTNGZ-00000008xNU-3KHS;
	Sat, 30 May 2026 17:14:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTNGW-00000008xN5-1dtb
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 17:14:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A00142D73;
	Sat, 30 May 2026 17:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955201F00898;
	Sat, 30 May 2026 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780161267;
	bh=NjWhMi7ol32O9kyUWWfMx4g883LE1ApapjqDf0LQz0E=;
	h=From:To:Cc:Subject:Date;
	b=al/BPAobx1/Lz/FncLND9xcqox0xSzkYfo42NtlnYuGME4E0iqZ1SQB9azH6CcU5R
	 62vn3DZFXhpJTZwaiSNKfvjillG6GIl+kczuklnpRxOjXiPXS2lnmtLmIkALgTPgGs
	 ZYwhbAdcZ3j9acHTRj4Om4Iz5kGIUYcvUqqZSH0jJYs+MYabYI4Fqyv4z3WdShuvD6
	 77Ay59ZAbjFA4A+GuCQKlFvx5AllbmaIzfb8Ih1gm2OJlc/UUa6GP/O4h1aY37DS0Y
	 hxS/pLrWrGum6WdOv2XK10wdrBWljSrKvkT1FuniHm9YlW+3wS/L4d8xVMo4ir7U5a
	 m0eN3Jdh32vFw==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [GIT PULL] liveupdate: kho: two regression fixes
Date: Sat, 30 May 2026 20:14:20 +0300
Message-ID: <20260530171420.1430298-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_101428_456692_9DA77D3F 
X-CRM114-Status: UNSURE (   7.64  )
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-05-30

for you to fetch changes up to 8fd2f26fa2a33cfe8ac043f976137ecf5b567f03:

  kho: fix order calculation for kho_unpreserve_pages() (2026-05-26 11:01:49 +0300)

----------------------------------------------------------------
liveupdate: kho: two regression fixes

* fix order calculation for kho_unpreserve_pages() to make sure sure that
  the order calculation in kho_unpreserve_pages() mathes the order
  calculation in kho_preserve_pages().
* fix math in calculation of KHO_TREE_MAX_DEPTH to make it work with 16KB
  pages.

----------------------------------------------------------------
George Guo (1):
      kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes

Pratyush Yadav (Google) (1):
      kho: fix order calculation for kho_unpreserve_pages()

 include/linux/kho/abi/kexec_handover.h |  2 +-
 kernel/liveupdate/kexec_handover.c     | 56 +++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 25 deletions(-)

--
Sincerely yours,
Mike.

