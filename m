Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79015C5B572
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ulz4BpJ4Po8Y2MvKJhJDY4PM6VLgEsQ3nOUNgt5Cf+I=; b=3Jiek3BWgvjpkMzsYI+VihVdil
	neLyC+Awntbm8uuz3R2ORNC4AGom0e2Mi7G61/KqFvpcQBDgITKQtjS83G0XJXFckvTD3RpoDag60
	lOWmLZRIX5dp9Hbqdgs8Q4uTanDadRwXCJb+NwuQWo2g7mEpomp8MudO3WoOsqI92X5U7Q3SpXjE4
	6RR143W6Dn9A30wT+KM2yTkNHTyDNLkJpFBkYGiW+orfWvZQMs5uBus0KVrOrpc6wWNYXvz8n296P
	k5dQjiAF8YY0vBD5bJ6BYbZOaQPh1UjhK9ERTs92uaO2N+qD9V/VBBpgFN6CfxFssImiRW8uHMXsL
	btfdvumA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTIT-00000000WqT-3qRd;
	Thu, 13 Aug 2026 11:08:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuTIS-00000000WqK-2KFQ
	for kexec@lists.infradead.org;
	Thu, 13 Aug 2026 11:08:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A955E600AF;
	Thu, 13 Aug 2026 11:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEF51F000E9;
	Thu, 13 Aug 2026 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786619307;
	bh=Ulz4BpJ4Po8Y2MvKJhJDY4PM6VLgEsQ3nOUNgt5Cf+I=;
	h=From:To:Cc:Subject:Date;
	b=dzq+bPerkF7lMVFj9GsGylafib9JKca3FD3MtAAbv8cZJEhXOxuu3PCeQyBekJWSm
	 3ph+ZaFZppFTzZkEdTNEeDy3yOw6Wcs8hla2XgZcRyGr/BjoQcEE8pqTsd0BPiT8P9
	 F2Z+74rhgfFFnGlJh4v+NhDOI4f44CvZD9uRC/RN0cWS0DNGXF+2a3vQ54r2DUSWCv
	 S09utsRR4rZcNgX+j9rI3rbPa/Tnfi8V1Q/1gl+9VNM/C1t43eiInV8e4sdoCeNMMA
	 T4wVVK1Oauq2K70ZRMSfiLiGaFqXQo4UqKI6oxuVIvhGKv1q52xx8thNmUNFpbCczm
	 gqP111Wb+Tiow==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] liveupdate: updates for 7.3-rc1
Date: Thu, 13 Aug 2026 14:07:58 +0300
Message-ID: <20260813110815.2482807-1-rppt@kernel.org>
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

The following changes since commit 797fe91e50d6927f90f0c3b4444277c2c7c8b42b:

  kho: align kho_scratch to MAX_ORDER_NR_PAGES pages (2026-07-25 15:26:30 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-v7.3-rc1

for you to fetch changes up to bcf2a0b55e322a663c9602c9e773770b87d3e629:

  Merge branch 'selftests-lib' into next (2026-08-04 10:52:22 +0300)

----------------------------------------------------------------
liveupdate: updates for v7.3-rc1

KHO:
* Fix size calculation in kho_preserved_memory_reserve() for preservations
  larger than 2 GiB

LUO:
  * move liveupdate selftest utilities into a library so that selftests of
    subsystems participating in liveupdate, e.g. PCI and VFIO, can use them and
    drop direct ioctl calls from the tests
  * add end to end liveupdate test infrastructure that allows running the
    tests across a kexec in QEMU
  * remove redundant INIT_LIST_HEAD in luo_session_alloc()
  * remember the error status of an FLB retrieve() and return it on subsequent
    attempts rather than retrying retrieve() with an FLB in an unexpected
    state
  * reference count the outgoing FLB so that it cannot be freed while a caller
    is using it, the same way it's done for the incoming FLB
  * reject nonzero reserved field in LIVEUPDATE_SESSION_FINISH so that it can
    be reused by a future extension

----------------------------------------------------------------
David Matlack (2):
      liveupdate: Reference count outgoing FLB data
      liveupdate: Remember FLB retrieve() status

Hongfu Li (1):
      liveupdate: Remove redundant INIT_LIST_HEAD in luo_session_alloc

Jackie Liu (1):
      liveupdate: reject nonzero reserved value for SESSION_FINISH

Mike Rapoport (Microsoft) (4):
      Merge patch series "Make liveupdate selftests library"
      Merge branch 'fixes' into next
      Merge branch 'misc' into next
      Merge branch 'selftests-lib' into next

Pasha Tatashin (1):
      selftests/liveupdate: add end to end test infrastructure and scripts

Pratyush Yadav (Google) (1):
      kho: fix size calculation in kho_preserved_memory_reserve()

Vipin Sharma (2):
      selftests/liveupdate: Use luo_test_utils.c for liveupdate ioctl APIs
      selftests/liveupdate: Move luo_test_utils.* into a reusable library

 include/linux/liveupdate.h                         |  11 +-
 kernel/liveupdate/kexec_handover.c                 |   2 +-
 kernel/liveupdate/luo_flb.c                        |  20 +-
 kernel/liveupdate/luo_session.c                    |   7 +-
 tools/testing/selftests/liveupdate/.gitignore      |   2 +
 tools/testing/selftests/liveupdate/Makefile        |  14 +-
 tools/testing/selftests/liveupdate/config          |   1 +
 tools/testing/selftests/liveupdate/config.aarch64  |   2 +
 tools/testing/selftests/liveupdate/config.x86_64   |   2 +
 tools/testing/selftests/liveupdate/init.c          | 179 ++++++++++++++
 .../include/libliveupdate.h}                       |  11 +-
 .../selftests/liveupdate/lib/libliveupdate.mk      |  20 ++
 .../{luo_test_utils.c => lib/lu_utils.c}           |  78 ++++--
 tools/testing/selftests/liveupdate/liveupdate.c    | 106 +++------
 .../selftests/liveupdate/luo_kexec_simple.c        |   2 +-
 .../selftests/liveupdate/luo_multi_session.c       |   2 +-
 .../selftests/liveupdate/luo_stress_files.c        |   3 +-
 .../selftests/liveupdate/luo_stress_sessions.c     |   3 +-
 tools/testing/selftests/liveupdate/run-vmtests.sh  |  97 ++++++++
 tools/testing/selftests/liveupdate/vmtest.sh       | 263 +++++++++++++++++++++
 20 files changed, 700 insertions(+), 125 deletions(-)
 create mode 100644 tools/testing/selftests/liveupdate/config.aarch64
 create mode 100644 tools/testing/selftests/liveupdate/config.x86_64
 create mode 100644 tools/testing/selftests/liveupdate/init.c
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (77%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/lu_utils.c} (80%)
 create mode 100755 tools/testing/selftests/liveupdate/run-vmtests.sh
 create mode 100755 tools/testing/selftests/liveupdate/vmtest.sh

