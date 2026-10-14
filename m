Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8064C3DA7A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7ObxhoVmcKp7FKwThZtHmmrAzt8O/xJpkopjoaCninw=; b=rafOXFdxFs7iq227AmSt+W6ob0
	9tIzbed4jkShVUkvgZuuE7rtdZmMVCML9I0gkxa0REn7zxtcnXoVaZk824JpOoDebnBdt1hCyHQAZ
	as7B6aT53Kt9SjEPgk4PtOUnWw4gleaIip8U2MiMhAtKnmhe3RbA7lq/FVu/P8KuwXVONEhQxWWGf
	jlnm6zvBOufrsopS59W7fOmvchb4pHGHgwtkPBT8cvbxz/4VKYjWpiu7JN/Hr5lktCreWU3pINMPn
	SaHZUHXLPy+XAwtzYK0a7B8TTPQ5oOuljkUyeBjkFWFm99MS8rDuX6VUyLSF2awj0oKFI6QvCvmzK
	GyfEbExQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5AP-0000000GEgK-3UrV;
	Wed, 14 Oct 2026 20:01:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5AK-0000000GEds-05ER
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 20:01:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BCE7960230;
	Wed, 14 Oct 2026 20:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083F21F000C6;
	Wed, 14 Oct 2026 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008090;
	bh=7ObxhoVmcKp7FKwThZtHmmrAzt8O/xJpkopjoaCninw=;
	h=From:To:Cc:Subject:Date;
	b=oFCcMWV7wOyX42GATyWunKk75YTi91sNND+7gNW6ldFdngx3ChvCgjOZCVg2C5O2b
	 xUr0AQhwRUizBrgIs5Oo5VPeIDG6JkfqIvzBV7PGp4JH1oGuhboqEKn7SE1/I3KPDS
	 Z8N917B3hVPbLaZlZrB5FCMq7caOTunxTHAY33cOYDgEFTW69Wk1C7zGw8VQjGu7T8
	 PflYlj7gOWp4oWkRdzwZdnWTqfq/csi9GpzhpKeFc1Ml4JWVWULzx/kORCNetiZcVT
	 1/09pLEYgp8n/GcH3AAbU6nsNpZgO7dtJtDJyOBjwZmseMaSycm3FF60ilBsVd5wzG
	 qJSy56ZPk+WaQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] selftests: target selection fixes for cross and LLVM builds
Date: Wed, 14 Oct 2026 16:01:22 -0400
Message-ID: <20261014200127.1363472-1-sashal@kernel.org>
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

A few suites select their tests from the build host instead of the
target, or depend on the host C library in ways that break cross
builds. This series fixes the ones found while building the selftests
for several architectures:

 - prctl and the Intel thermal suites build nothing when CROSS_COMPILE
   is set, even for x86, and prctl restricts two generic tests to x86.

 - set-anon-vma-name-test fails instead of skipping on kernels built
   without CONFIG_ANON_VMA_NAME.

 - kexec only recognizes the ppc64le spelling of PowerPC and decides
   about the x86-64 jump test from the build host.

 - size links a custom _start against the static C library, which
   fails on ARM with clang and on LoongArch; it now uses nolibc.

The patches are independent of each other.

Sasha Levin (5):
  selftests/prctl: build generated tests for the target architecture
  selftests/prctl: skip the anonymous VMA naming test when unsupported
  selftests/thermal: allow cross builds of the Intel tests
  selftests/kexec: select tests using the target compiler
  selftests/size: use nolibc startup and syscall wrappers

 tools/testing/selftests/kexec/Makefile        | 26 ++++++++-------
 tools/testing/selftests/prctl/Makefile        | 18 +++++-----
 .../selftests/prctl/set-anon-vma-name-test.c  |  3 ++
 tools/testing/selftests/size/Makefile         |  9 ++++-
 tools/testing/selftests/size/get_size.c       | 33 +++++--------------
 .../thermal/intel/power_floor/Makefile        | 12 +++----
 .../thermal/intel/workload_hint/Makefile      | 12 +++----
 7 files changed, 52 insertions(+), 61 deletions(-)


base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0


