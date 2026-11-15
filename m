Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1C606A339
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4bJyX6kk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQrW1hFA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=azq6hlaktEMUDgLyNyRfk0hKL7yGmOVuQpf+tMmLcs8=; b=4bJyX6kkhV4CDLHtYk/AmLGGzi
	uF+pi+lyJlI5wKyBYz+EBe9k3EcxwWSDYHRxLaKtwwm3NQ4Bg1ob+iApgb71rizrzM9//oC4nk8eh
	Fq5KvHGHvjJfYj0Qtkny/Kazp+re9M7eQY3SvYnLF3c6dKFWT159/Lqb2xeC6NtTVAMwWCKmhwSQV
	IRMxWOjiyAd68OivSutRwzoqVQ1Xvc3GR+8fWBz7rVwvJ6edBUGkEC3zIZeYHYrMggsWGQ1SA7Z2x
	4RSMfNd0t6QGBojbyFwCx71CuyNiFpHCtTVOGnrtwp2Y59YuA4h4iKK+kHvlontj44e2xiu/GXmYZ
	AJYeKctg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSSOR-0000000H4ix-1Aj9;
	Sun, 15 Nov 2026 05:03:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSSOQ-0000000H4ir-0Gdr
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 05:03:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2042D60D36;
	Sun, 15 Nov 2026 05:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098C31F000C4;
	Sun, 15 Nov 2026 05:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794718984;
	bh=azq6hlaktEMUDgLyNyRfk0hKL7yGmOVuQpf+tMmLcs8=;
	h=From:To:Cc:Subject:Date;
	b=kQrW1hFA9eLROj+8e9HgGk1bBbcWq7RXQkuKPs9FiAK/S3BOBKoe776SyNhHchMa3
	 Sc57o9flKR5qM7CJFj5NoIM6e4nwb6krOaxMUGtTrFL6Pg9f3xAZ3HM+rs9nGYcoTZ
	 gRcGCAYfU+1NY99N6C7eoFjeaXymFovRdrhEoG5WX+DXlYPdQ801Fp/1UZJNQZ9p0n
	 o54/BgyH/7moBX2pEhuVL7ExS4gvOuyWguy6X96/BRARkEqooe/Hd13sU4UkQUfH6g
	 5/ZX/MDGeKzHeKspVqQe0jCODYSTB01Dzt/wNfeTS/WiNlr/lPWpkDqLxxGVLjG0UR
	 I+mqd2/+5wj0g==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] liveupdate: fixes for 7.4-rc3
Date: Sun, 15 Nov 2026 07:02:58 +0200
Message-ID: <20261115050300.1847760-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/fixes-2026-11-15

for you to fetch changes up to 58c5852ca96c58cdfdb9646870b217fc54d06a97:

  kho: check fdt_phys in is_kho_boot() (2026-11-08 11:20:19 -0500)

----------------------------------------------------------------
liveupdate: fixes for 7.4-rc3

* avoid address translation in is_kho_boot() before the linear map is
  initialized, fixing early boot BUG_ONs on arm64
* check for duplicate session names before growing the sessions
  preservations block set to avoid preserving an empty block that causes
  restoration to panic()

----------------------------------------------------------------
Christian Aurich Zanettini Martins (1):
      liveupdate: check for duplicate session before growing block set

Greg Thelen (1):
      kho: check fdt_phys in is_kho_boot()

 kernel/liveupdate/kexec_handover.c |  2 +-
 kernel/liveupdate/luo_session.c    | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

