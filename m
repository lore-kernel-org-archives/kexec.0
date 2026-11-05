Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2862606A336
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3frn8Gri;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hffKrapl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=6ZdWd9DpqOCzkQFl85BzLJVbsF2MwY+Jr5TxyApvNGc=; b=3frn8GriGNyQNakPehvDEEYGWm
	QyvPEIHCYSX6BmHxokIoRtiyrC6hb3m1Tn/i+ytAMpBYtXFfj/L5eWeyrfqxJhHxHdjejno31kx/w
	Q6mZTekw6IjsFameuf7R9trpEal39eFQzoIpSSITx+risNknjeDtjci4quJxe3mDL4HnDmVoSwqAf
	r5Ewn8tbcUCqM2tSze26qIDDDoCwvKSN5hdipIwTCFnqP4fFYMA86jm8kdoaZwJgoMJkSd8RkiPQ/
	QVrQj5hhcsCG9NENfOYzRUHGQed4TrGknxrt21/ablps+9K+PjbcltEBjtkQqKeAjtzquLKXyoy2V
	FV0VTZ/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx1d-00000009228-1aTK;
	Thu, 05 Nov 2026 12:57:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx1c-0000000921s-0uRU
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 12:57:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F34164196B;
	Thu,  5 Nov 2026 12:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E6D1F000C1;
	Thu,  5 Nov 2026 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883423;
	bh=6ZdWd9DpqOCzkQFl85BzLJVbsF2MwY+Jr5TxyApvNGc=;
	h=From:To:Cc:Subject:Date;
	b=hffKraplRz7pqDxe4LqjKCfL+qBomnmHugPychqHpetlgNHHWqDQUg/B1ws+/L7Ai
	 c45iEvZFAp15HvNvOrku6zRVJcc/zWQV2Y8/Gbzvyom1Qv96VkHHcW7PKRbWSiyMyD
	 XNO7QdCKcc7/tIueBN/FdRlxqzFU9MfNsKycGk2LfrGiOOOWX1361oNldIeuVWJ+gz
	 79LrsyvM3ZV6GkJIWtFwqHaeFpGsZJlzPL48nceBYmOeaH5cp2eOejKzoopF56njlV
	 gNekU72mdfTWk+zEdK6cuHEQupBlI6U03JcbJUNhRcnZl40Y/4ILpEQVMy6alJP2ZV
	 OxkygSUrKA7wQ==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] selftests: target selection fixes for cross and LLVM builds
Date: Thu,  5 Nov 2026 07:56:58 -0500
Message-ID: <20261105125701.1605281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A few suites select their tests from the build host instead of the
target, or depend on the host C library in ways that break cross
builds:

 - set-anon-vma-name-test fails instead of skipping on kernels built
   without CONFIG_ANON_VMA_NAME.

 - kexec only recognizes the ppc64le spelling of PowerPC and decides
   about the x86-64 jump test from the build host.

 - size links a custom _start against the static C library, which
   fails on ARM with clang and on LoongArch; it now uses nolibc.

The patches are independent of each other and apply on
mm-nonmm-unstable.

Since the original posting:

 - "selftests/prctl: build generated tests for the target architecture"
   is dropped. "selftests/prctl: select the tests by ARCH alone" in
   mm-nonmm-unstable replaces it.

 - "selftests/thermal: allow cross builds of the Intel tests" is dropped,
   it went in through the thermal tree as ff4194e54f84.

 - The size patch has Thomas's Reviewed-by.

Original posting:
https://lore.kernel.org/r/20261014200127.1363472-1-sashal@kernel.org

Sasha Levin (3):
  selftests/prctl: skip the anonymous VMA naming test when unsupported
  selftests/kexec: select tests using the target compiler
  selftests/size: use nolibc startup and syscall wrappers

 tools/testing/selftests/kexec/Makefile        | 26 ++++++++-------
 .../selftests/prctl/set-anon-vma-name-test.c  |  3 ++
 tools/testing/selftests/size/Makefile         |  9 ++++-
 tools/testing/selftests/size/get_size.c       | 33 +++++--------------
 4 files changed, 34 insertions(+), 37 deletions(-)


base-commit: 72afe7762a29508ae89831540347c1be3b7ba621
-- 
2.53.0


