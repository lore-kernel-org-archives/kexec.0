Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A6CD4F24
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pr7dARIqK00yCxhYhbkD1anSUq6hc0OaN5jqWiJwO3Q=; b=EybYeZyVkN4s5IGZLywmwpbN87
	IwC6RFmQenqg8K+jWWYEdq4+catoPt1gX2jao75GN108QPAktBTDDTZtzmtqkOXQiHIaT387kk8lp
	mTN6+3ycPI5LgIDcyjyQimd9G4r9zVuh8wAV8z3Tf/yi7pPJz+Yfq42pBcpPx++koC61M9UTV7Tc3
	d0hon6NUc8p3maRaOmMDozqOpDm8e6vwe6zzbMaTH0whGi6JUIFpHQbBdKAKFtKQ02MTG58I593+p
	hvesJdd5kMM42miOvbbVZpPDX5KRXwdYQvTEeYGS6jziN5gcrjr+Fr2FYeHYBmA9FZAauovSWhlZF
	17DwpqUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6jS-000000029ti-2TYf;
	Wed, 13 May 2026 10:22:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6jQ-000000029s0-2AVD
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 10:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F1C5E409A2;
	Wed, 13 May 2026 10:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE50C2BCB7;
	Wed, 13 May 2026 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778667743;
	bh=1DYgdZzlhmRaiikUzEm1OxduP6ObZQtAfPa74GcnTQk=;
	h=Date:From:To:Cc:Subject:From;
	b=pvgZqZU/12y+6wJxVUEhDGuzGP86yD23cqn7pwJTdOB9Z1awiUX69w2aaRPkNdmnq
	 z62juYMPcbXwCdfroQEAEbOKDW+Dt+eD8VDGaAXdPucl62xwmvYkZ3mLmLBtK7/t3+
	 ApemIKPXE89HAho8u0azAf26rA7W5rRouJFU31SvQ97Z8AIS3xbc6J8JlALSCETBIs
	 gQiDogwno7LNGYaNxedkDBjadltMZhCDtrnTvkT8s1MVqI3l8Q+SsJTYfsmf/ZhUbW
	 NCEfkAEffZejBBbEKUQ9UdqyF7jNCenrCQweAr8OM2cNL40+EH7FLevaKov+TBgMly
	 MvXMqSNQRVTDQ==
Date: Wed, 13 May 2026 13:22:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Carlier <devnexen@gmail.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [GIT PULL] liveupdate updates for v7.1-rc4
Message-ID: <agRQ2pV1vsO-MoTB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_032224_576612_35E632F7 
X-CRM114-Status: UNSURE (   8.31  )
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

Hi Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-05-13

for you to fetch changes up to 7b0b68b2b95606e65594958686833e53423f58f2:

  mm/memfd_luo: document preservation of file seals (2026-05-04 14:03:16 +0000)

----------------------------------------------------------------
liveupdate fixes for v7.1-rc4

A few fixes for kexec handover and liveupdate:

* make sure KHO is skipped for crash kernel
* fix error reporting in memfd preservation if it fails mid-loop
* don't allow preserving memfds whose page count exceeds UINT_MAX
* fix documentation of memfd seals preservation to match the code

----------------------------------------------------------------
David Carlier (3):
      mm/memfd_luo: report error when restoring a folio fails mid-loop
      mm/memfd_luo: reject memfds whose page count exceeds UINT_MAX
      mm/memfd_luo: document preservation of file seals

Evangelos Petrongonas (1):
      kho: skip KHO for crash kernel

 kernel/liveupdate/kexec_handover.c |  2 +-
 mm/memfd_luo.c                     | 25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
Sincerely yours,
Mike.

