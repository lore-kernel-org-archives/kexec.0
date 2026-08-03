Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E7C55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lesqJaE1Qf80CwnHT9u+4fD+Y0+6W9ZltFdX8Makcts=; b=UAZnBbJ43eTBhEHS0bSMZJ/7Sz
	rcHD/v6ozBdmOksXSLM8eIMQQCaUaMilat0myQrWgiDvLzN0a/SNuhmhHwllLmpU8D4itK4bdMEs3
	b4oNFtU5JAAKPnAmmCpCmS1r67/4uTeC2yPTDSwciKaAkYEy2bXqFRYyo/bnvMQgSYLjKB5RwHne9
	za5gHv9JCbz4ytWSWbwTX8yhy09m2k3lqDS6i1gsius03uW2rkIKg990pLu4+6F9EU0MVhdfWIcEg
	hUOS7MSfkrTrUZS1SwDe/k4mevluUXqMSJQ8oF6wTE4NHDDOa6QrwxcgUH8kvQr6F2ffsE5Yb/qz5
	4ALASMiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqqn0-0000000Gw8l-3CvE;
	Mon, 03 Aug 2026 11:25:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqqn0-0000000Gw8a-057l
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 11:25:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D762E60A78;
	Mon,  3 Aug 2026 11:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB21F00A3A;
	Mon,  3 Aug 2026 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785756299;
	bh=lesqJaE1Qf80CwnHT9u+4fD+Y0+6W9ZltFdX8Makcts=;
	h=From:To:Cc:Subject:Date;
	b=cmBKYRqNSM3hd3dBPltzjB0ReIsYt0+FdeJYZxTSGcyzv5fh1GR5xcF9T65vXIVqu
	 7T5uE45uNiCsN2oFBL6RPS8X+HHOwcruv8jz2kwCHOSRF2ADVyIsmVRaGGI0v81kJV
	 2D9l48r9JFQtFSQvQpQcQONRcO/jmTjEafbbWE55JFmNWc6p/+EPNPromVsyFy2drP
	 5l+5gb3gtqRI7vAu5YSyFIev9u2WjJ3e5PVAzkgsCna6CUMaGAaqQJJu5H6QLZIxwW
	 R9z+n67EjE0OS5Mj/11FnTgYRhyvOJ9RMqycF8gPbIty998sXtcNb5pt5gD+9C1Ihr
	 uM/x6KsU3iCEw==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Michal Clapinski <mclapinski@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [GIT PULL] liveupdate: a fix for v7.2-rc7
Date: Mon,  3 Aug 2026 14:24:51 +0300
Message-ID: <20260803112452.1793120-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Hi Linus,

The following changes since commit 4416f8a9ed5f49256dc69c664f1386b496ca16a1:

  liveupdate: fix GET_NAME ioctl argument validation (2026-07-16 09:25:30 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-08-03

for you to fetch changes up to 797fe91e50d6927f90f0c3b4444277c2c7c8b42b:

  kho: align kho_scratch to MAX_ORDER_NR_PAGES pages (2026-07-25 15:26:30 +0300)

----------------------------------------------------------------
liveupdate: a fix for v7.2-rc7

* fix a regression caused by allowing coexistence of KHO with deferred
  initialization of the memory map.

----------------------------------------------------------------
Michal Clapinski (1):
      kho: align kho_scratch to MAX_ORDER_NR_PAGES pages

 kernel/liveupdate/kexec_handover.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

