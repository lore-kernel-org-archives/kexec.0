Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D5606A320
	for <kexec@archiver.kernel.org>; Sat, 24 Oct 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o/tQACMS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRNbwXhW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cGiQ8OTVAeX0o47MTz+ktInH/fOBwJghtHtytzaWqSA=; b=o/tQACMSiSh9KTJpqkfivZvmtC
	9aUoSotl/Qbk5tCBTZgywc7ttRiEACe1j0uFkcQiHmQIiZRXrWUw+JvuHIemNXLaA1W6aTk7cTKMw
	/Nwu3bpvHDyEa+0aWtkzboaVYDrZNvmaI6OMBSBpVEPX+cS/AdW8y5K+uUetjAo1FnU/eMT3riIvF
	VuusG9a0xftgQT3Yij6/Evx9kKbTPNLCZlMVnwie+Qj0ATdQQPUdvJkZhjy/LTZB+h0RRy6L/CZoi
	/kAwlsB7Suk9Kd52bKAz25Ww57BUIghbtCr1xl4SNWJk98oBzG3WohwxfXQsMH9sP4pjBal/LGISP
	p5+n311A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZp8-000000007wN-0xny;
	Sat, 24 Oct 2026 11:22:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKZp7-000000007wH-2E9H
	for kexec@lists.infradead.org;
	Sat, 24 Oct 2026 11:22:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6D1B60A52;
	Sat, 24 Oct 2026 11:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA88F1F01825;
	Sat, 24 Oct 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840924;
	bh=cGiQ8OTVAeX0o47MTz+ktInH/fOBwJghtHtytzaWqSA=;
	h=From:To:Cc:Subject:Date;
	b=TRNbwXhWlrh6M/1ClNTKGyPNstnCcPOnZb6JJKfrQxHhK7/JK+RatDhSfByg57hNX
	 6oFHvIvyDJMBVMWPyZS9ugRtKgj4cqHmurv4A3xBJZMVjjPreNyP/DIMecHI4gvKWl
	 kva6WY1FEjD2e5PiBQCCZ6x77//aFUiU/7AtSgCapiJRh83Xr1Ohl9YqG4B86UjD+x
	 XpEeuXs799qQOIV+vDIJNnIsTTQdJLWZxjYVKpVRQcHYLPPdJnyH0KEKW68/7J31yu
	 DJZTU9CGZQRYpK1z5zfgDBumgHjN9fy2xKKHeyALrUhXc6iTrXfkgmtUayzEeqLwkH
	 NeqgDwLuidrqQ==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] kexec: updates for 7.4-rc1
Date: Sat, 24 Oct 2026 14:21:54 +0300
Message-ID: <20261024112155.3384616-1-rppt@kernel.org>
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
X-Spam-Status: No, score=-24.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.4-rc1

for you to fetch changes up to 833d2b79ed9520e77c5d83eb11644e5239b2c5bb:

  Merge branch 'kexec-7.4' into kexec-next (2026-10-15 11:38:21 +0300)

----------------------------------------------------------------
kexec: updates for 7.4-rc1

* Fix probe error codes and error propagation:
  * make architecture functions that probe loaded image consistenly return
    -ENOEXEC when they do not recognize the image format
  * Make kexec_image_probe_default() to distinguish image format mismatches
    (-ENOEXEC) from real errors (e.g. -ENOMEM), propagating real errors
    immediately and only continuing to the next loader on -ENOEXEC
* Make sure the next kernel does not land on hardware-poisoned pages
* Remove unused arch_kexec_locate_mem_hole hook

----------------------------------------------------------------
Breno Leitao (2):
      kexec_file: stop the top-down search before it underflows
      kexec: keep the next kernel off hardware-poisoned pages

Mike Rapoport (Microsoft) (4):
      Merge patch series "kexec: keep the next kernel off hardware-poisoned pages"
      Merge patch series "kexec: fix probe error codes and error propagation"
      Merge branch 'kexec-fixes' into kexec-next
      Merge branch 'kexec-7.4' into kexec-next

Mukesh Pilaniya (2):
      kexec: return -ENOEXEC from image probe functions on mismatch
      kexec: fix error propagation in kexec_image_probe_default()

Sourabh Jain (1):
      kexec_file: remove unused arch_kexec_locate_mem_hole hook

 arch/arm64/kernel/kexec_image.c   |  4 ++--
 arch/loongarch/kernel/kexec_efi.c |  4 ++--
 arch/riscv/kernel/kexec_elf.c     |  2 +-
 arch/riscv/kernel/kexec_image.c   |  4 ++--
 include/linux/kexec.h             | 15 ---------------
 include/linux/mm.h                | 14 ++++++++++++++
 kernel/kexec_core.c               | 10 ++++++++++
 kernel/kexec_elf.c                |  4 ++--
 kernel/kexec_file.c               | 34 ++++++++++++++++++++++++++-------
 mm/memory-failure.c               | 40 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 100 insertions(+), 31 deletions(-)

