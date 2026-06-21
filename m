Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7CCCD98F0
	for <kexec@archiver.kernel.org>; Sun, 21 Jun 2026 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dboNO/Kx/0uIBkqffpSvN7CDtPhD1ZkLmBxEBQA9/hQ=; b=WLr/L7w0BBazSSMkBcGjM2ft8L
	EKi9PKxm6kg43MsNCKryiILaFpLl0KyPXM3yeeWFVynLuup6REBFdf8B1EVpWVeLglyih6JP/zXJz
	CF7hNtJYfxuZHgXAxFUmMyRwn+paOHnD17IroNB2owW/Oy/g2kOnq0KXrI2U9YXp+nROsWVhsWa/k
	Wy0rMoz6XEAB1sbwf5/LRB0RSaUF1wUZxACKR556ozAidf6teUD3+bvrOSqDwW2j7Iu7SJkUu7th6
	XkON+1kuNSNl91QvuSH5sADlL7GXXWCWetc83OSzrQ0pFogZ+pBgWEGxDRZtm0O2wt7tQKGv5SqL6
	a3Va4L6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbHRM-00000003vzC-1iHE;
	Sun, 21 Jun 2026 12:38:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbHRH-00000003vz6-36mo
	for kexec@lists.infradead.org;
	Sun, 21 Jun 2026 12:38:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E68AD60051;
	Sun, 21 Jun 2026 12:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18791F000E9;
	Sun, 21 Jun 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782045492;
	bh=dboNO/Kx/0uIBkqffpSvN7CDtPhD1ZkLmBxEBQA9/hQ=;
	h=From:To:Cc:Subject:Date;
	b=lJ51hY+sttF6eVMMlBEz5/3DzI8/gZ7cQzove4YXfsb36/4wI098vZcmE5LsC6Jqm
	 PZ7PKngs0lv1AvmWSiEsMuHEZ4WWMrx+0JgBY1YClT/Z9/+0+DvM67RlIEC2mrM+hi
	 Kq1gwUHbK5H2a4Aj1TlAZeeyyA4e/Pw7R6BH867+ADqVuy7Tz5EZCrOJP4rnTfOCaf
	 qMVIu0qCMSZDZd/nl8LfTO3dmnKyfy+Arqh8DJRyKcciSZy1+jbAKDLzGU1gL6L4Rt
	 4JAZhp2KF2N2ZPd6y4H8zAnnnWZTLRYgcl4AzIH9Xi82yz7iIYOkS9NLx2zRa6lOTb
	 y3M1t+LDrv1CQ==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] liveupdate: updates for 7.2-rc1
Date: Sun, 21 Jun 2026 15:38:04 +0300
Message-ID: <20260621123807.2873974-1-rppt@kernel.org>
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

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.2-rc1

for you to fetch changes up to e98a9c61721c14bcd29f11f4802e52e908701f7a:

  liveupdate: Document that retrieve failure is permanent (2026-06-11 15:49:51 +0300)

----------------------------------------------------------------
liveupdate: updates for 7.2-rc1

- kho: make memory preservation compatible with deferred initialization of
  the memory map

- luo: add LIVEUPDATE_SESSION_GET_NAME ioctl and parameter verification for
  LIVEUPDATE_IOCTL_CREATE_SESSION ioctl

- luo: documentation updates for liveupdate=on command line option, systemd
  support and the current compatibility status

- luo: remove the fixed limits on the number of files that can be preserved
  within a single session, and the total number of sessions managed by the
  Live Update Orchestrator

- fixes that didn't cut as urgent and were delayed until the merge window:

  * reference count incoming File-Lifecycle-Bound (FLB) data so it cannot
    be freed while a subsystem is still using it

  * fixes for a TOCTOU race in luo_session_retrieve(), a use-after-free in
    the file finish and unpreserve paths, concurrent session mutations
    during reboot and serialization on preserve_context kexec

  * make sure ioctls for incoming LUO sessions are blocked for outgoing
    sessions and vice versa

  * make sure KHO scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES

  * fix memblock tests build issue introduced by KHO changes

----------------------------------------------------------------
David Matlack (2):
      liveupdate: Use refcount_t for FLB reference counts
      liveupdate: Reference count incoming FLB data

Evangelos Petrongonas (1):
      kho: make preserved pages compatible with deferred struct page init

LongWei (1):
      kho: docs: fix typo in ABI documentation

Luca Boccassi (6):
      liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name length
      selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
      liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
      selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
      liveupdate: document systemd support
      liveupdate: document current compatibility status

Michal Clapinski (2):
      kho: fix deferred initialization of scratch areas
      selftests: kho: test with deferred struct page init

Mike Rapoport (Microsoft) (1):
      Merge patch series "liveupdate: Remove limits on sessions and files"

Pasha Tatashin (18):
      liveupdate: skip serialization for context-preserving kexec
      liveupdate: fix TOCTOU race in luo_session_retrieve()
      liveupdate: block session mutations during reboot
      liveupdate: fix u-a-f in luo_file_unpreserve_files() and luo_file_finish()
      liveupdate: Remove unused ser field from struct luo_session
      liveupdate: change file_set->count type to u64 for type safety
      liveupdate: avoid mixing cleanup guards with goto in luo_session_retrieve_fd
      liveupdate: centralize state management into struct luo_ser
      liveupdate: register luo_ser as KHO subtree
      liveupdate: Extract luo_file_deserialize_one helper
      liveupdate: Extract luo_session_deserialize_one helper
      kho: add support for linked-block serialization
      liveupdate: defer session block allocation and physical address setting
      liveupdate: Remove limit on the number of sessions
      liveupdate: Remove limit on the number of files per session
      selftests/liveupdate: Test session and file limit removal
      selftests/liveupdate: Add stress-sessions kexec test
      selftests/liveupdate: Add stress-files kexec test

Pratyush Yadav (Google) (5):
      memblock tests: define MIGRATE_CMA
      liveupdate: validate session type before performing operation
      liveupdate: document liveupdate=on
      kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES
      docs: memfd_preservation: fix rendering of ABI documentation

Tarun Sahu (1):
      liveupdate: Document that retrieve failure is permanent

 Documentation/core-api/kho/abi.rst                 |   5 +
 Documentation/core-api/kho/index.rst               |  11 +
 Documentation/mm/memfd_preservation.rst            |   2 +-
 Documentation/userspace-api/liveupdate.rst         |  31 ++
 MAINTAINERS                                        |   1 +
 include/linux/kho/abi/block.h                      |  54 +++
 include/linux/kho/abi/kexec_handover.h             |   4 +-
 include/linux/kho/abi/luo.h                        | 148 +++-----
 include/linux/kho_block.h                          | 106 ++++++
 include/linux/liveupdate.h                         |   9 +-
 include/linux/memblock.h                           |  21 +-
 include/uapi/linux/liveupdate.h                    |  25 +-
 kernel/kexec_core.c                                |   8 +-
 kernel/liveupdate/Kconfig                          |   2 -
 kernel/liveupdate/Makefile                         |   1 +
 kernel/liveupdate/kexec_handover.c                 |  84 +++--
 kernel/liveupdate/kho_block.c                      | 416 +++++++++++++++++++++
 kernel/liveupdate/luo_core.c                       | 103 +++--
 kernel/liveupdate/luo_file.c                       | 210 +++++------
 kernel/liveupdate/luo_flb.c                        | 112 ++----
 kernel/liveupdate/luo_internal.h                   |  18 +-
 kernel/liveupdate/luo_session.c                    | 336 ++++++++++-------
 lib/tests/liveupdate.c                             |   3 +
 mm/memblock.c                                      |  56 ++-
 mm/mm_init.c                                       |  30 +-
 tools/testing/memblock/linux/mmzone.h              |   4 +
 tools/testing/selftests/kho/vmtest.sh              |   4 +
 tools/testing/selftests/liveupdate/Makefile        |   2 +
 tools/testing/selftests/liveupdate/liveupdate.c    | 188 ++++++++++
 .../selftests/liveupdate/luo_stress_files.c        |  97 +++++
 .../selftests/liveupdate/luo_stress_sessions.c     | 102 +++++
 .../testing/selftests/liveupdate/luo_test_utils.c  |  24 ++
 .../testing/selftests/liveupdate/luo_test_utils.h  |   2 +
 33 files changed, 1635 insertions(+), 584 deletions(-)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_files.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c


