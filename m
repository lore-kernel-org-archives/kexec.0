Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA5C5CFDB
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ebEmXtmOZqbbZCq9k3easw636Rs7quoWN+lISUhVbvo=; b=bpur79Kd6RrbH8rmlEqK7xYHKZ
	Dh3DM52ejh9VoQi5HfcASQaujX5dE7SFZyE4g2LUG+3yliHPMWaCeZSfsD7R0Tdm9pU7ZfxrGgca9
	gnmsDhPrCQrCTPmBwnZkTZ/JfN/YQ3vUeMUVI3rPvZWjOqQBqQpjxNINTf0Blfx1stjR012YTORTT
	waMufTQL52LQMZawjSwDttES5NuqholEv87r4Ux/yC2tGp3NXXBOYfvAFjp/5R1wbtG6hBrJdk8e1
	yZWOaXRyMexQthQXiVwA7LFgFplXJOjFwkXvIo1XK5/DyeeWrHjKf8Kdlh/GgJ0CZJEXFcrcataCO
	i0PC21OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTHx-00000000Wmj-3CuY;
	Thu, 13 Aug 2026 11:07:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTHt-00000000WmQ-20KG
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 11:07:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9374B600AD;
	Thu, 13 Aug 2026 11:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD011F000E9;
	Thu, 13 Aug 2026 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786619272;
	bh=ebEmXtmOZqbbZCq9k3easw636Rs7quoWN+lISUhVbvo=;
	h=From:To:Cc:Subject:Date;
	b=S1kDeXMTyOXpgTTep2S1A7OmblaAz2UOzfW3CihjruJyDFykIOBUa7StF6+0HpNTl
	 PxgFbykNryU9d3peLd8dY2vonZM1zNhBFZRbusrirTgSt4QlyaVQBAZqAeXQS4rJ8C
	 AeaGitsZtY4xT0B9HZE6gzrCmcsMfB49hnIIxgXsEf1mjW/2TgQpA4f7abvtmEYRh/
	 fyCuUE0QTF9llEqZEuPed8/rn5r7FPNg5OCtU4/SwsrPvyK+V22mKMG0lXBc2El2i0
	 JcebXk9eextJA6ADwEwKFHCVhh+FdR1c+GjR1XD2VxP8depyqEs2H4omerUcMJgr7m
	 DDaFLkIAmvrtA==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] kexec: updates for 7.3-rc1
Date: Thu, 13 Aug 2026 14:07:23 +0300
Message-ID: <20260813110738.2482772-1-rppt@kernel.org>
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

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/kexec-v7.3-rc1

for you to fetch changes up to 9d50f7c5ad5b4b031c9b85f9a43c626d8268ab51:

  Merge branch 'crashkernel-cma' into kexec-next (2026-08-04 10:48:21 +0300)

----------------------------------------------------------------
kexec: updates for v7.3-rc1

* Deduplicate crash memory allocation and the exclusion of reserved crash
  kernel regions from architecture specific code into a generic
  crash_prepare_headers() and enable crashkernel CMA reservation on arm64 and
  riscv reservation on arm64 and riscv.
* Skip purgatory checksum verification when the kexec segments cannot be
  corrupted by DMA, which saves about 250ms on kexec.
* Replace __ASSEMBLY__ with the compiler provided __ASSEMBLER__ in
  include/linux/kexec.h.
* Fix a keyring refcount imbalance in the kdump kernel's dm-crypt key restore
  path, which over-dropped the user keyring reference when more than one key
  was restored.

----------------------------------------------------------------
Guangshuo Li (1):
      crash_dump: release keyring reference at the correct time

Jinjie Ruan (9):
      riscv: kexec_file: Fix crashk_low_res not exclude bug
      crash: Add crash_prepare_headers() to exclude crash kernel memory
      arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
      x86/crash: Use crash_prepare_headers() helper to simplify code
      riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
      LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify code
      powerpc/kexec_file: Use crash_exclude_core_ranges() helper
      arm64: kexec_file: Add support for crashkernel CMA reservation
      riscv: kexec_file: Add support for crashkernel CMA reservation

Michal Clapinski (1):
      kexec_file: skip checksum verification when safe

Mike Rapoport (Microsoft) (4):
      Merge patch series "arm64/riscv: Add support for crashkernel CMA reservation"
      Merge branch 'kexec-fixes' into kexec-next
      Merge branch 'kexec-misc' into kexec-next
      Merge branch 'crashkernel-cma' into kexec-next

Sourabh Jain (1):
      powerpc/crash: sort crash memory ranges before preparing elfcorehdr

Thomas Huth (1):
      kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in header file

 Documentation/admin-guide/kernel-parameters.txt |  16 ++--
 arch/arm64/kernel/machine_kexec_file.c          |  40 +++-------
 arch/arm64/mm/init.c                            |   5 +-
 arch/loongarch/kernel/machine_kexec_file.c      |  40 +++-------
 arch/powerpc/include/asm/kexec_ranges.h         |   1 -
 arch/powerpc/kexec/crash.c                      |   5 +-
 arch/powerpc/kexec/ranges.c                     | 101 +-----------------------
 arch/riscv/kernel/machine_kexec_file.c          |  39 +++------
 arch/riscv/mm/init.c                            |   5 +-
 arch/x86/kernel/crash.c                         |  89 +++------------------
 drivers/of/fdt.c                                |   9 ++-
 drivers/of/kexec.c                              |   9 +++
 include/linux/crash_core.h                      |   9 +++
 include/linux/crash_reserve.h                   |   4 +-
 include/linux/kexec.h                           |   2 +-
 kernel/crash_core.c                             |  89 ++++++++++++++++++++-
 kernel/crash_dump_dm_crypt.c                    |  15 ++--
 kernel/kexec_file.c                             |  27 +++++++
 18 files changed, 218 insertions(+), 287 deletions(-)

