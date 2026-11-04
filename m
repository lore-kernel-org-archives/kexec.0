Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D260AFC6D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fj6EbyKY;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHogC9f+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Itb/+XUxzwDjuKQwsAJFR47NDknmWF5dyrfvKBFmIfk=; b=Fj6EbyKY1zXWupP8jhgy1FIaPe
	YdBNsuN0Nj84przpGqC+8YCXbLRe34YxmMql/Uk1+T2MWUyK+fWe49KeaPb+yqO8tFWY/YblcpX6u
	iCcvduyz6vqePRhq7jqwl+2K0Z8yDBHHaSZcgoDjuapbKn8GJtrqiUk4fcgZUbGV/3Oe0O7eN65aI
	imJlynyOhqA0eWu7ztrWKu4OuaLYQSplXTJehU3JMEanoAjH+zGIRDztIRSJ7Ynby+wxSeJxtnFHI
	4QtSeiuHPhCsTKyOcmcc4qTpAKZ6UdnEvpFbA0DNdNUBw9cptoBCFsB67oIVxhvNDRD+D62sX65ZP
	pvqufQYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgmm-00000006gHW-3K5m;
	Wed, 04 Nov 2026 19:36:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgml-00000006gGP-3BJY
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 19:36:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 506D141392;
	Wed,  4 Nov 2026 19:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1551F00919;
	Wed,  4 Nov 2026 19:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820999;
	bh=Itb/+XUxzwDjuKQwsAJFR47NDknmWF5dyrfvKBFmIfk=;
	h=From:To:Cc:Subject:Date;
	b=kHogC9f+CSu/YIkuUTNAcDq003+8HXU+ITLFDlsbwhw1GoU2HyvqiJyoPVfMQzBgE
	 9HruiKS/bFPfYumogbwljnXrOHutj64vVseMoFoRn9i9mEavOHl0UIm0bjUPQpKJ9W
	 T+T13Jpx4AwuUkCdMUsJAyIDWZPplt4C3fqsFD0uoRK87ngTX/FkNtSN4mm9zNeQ89
	 ucg9ydD5/4kJQX+WxSqyzRaqQQWjsfb+WO/hSRgnJ4+ICMb+o+FB7fNM+mDTr7RlDj
	 xaY+CJhUWXFYOBMcFjGyDgsjpo6sAl6wCBhhBBD08MBSCq7EWW21waQ625FLE1khsw
	 M5STEaQpYDSOQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Baoquan He <baoquan.he@linux.dev>,
	kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/kexec: don't fail the build on other architectures
Date: Wed,  4 Nov 2026 14:36:37 -0500
Message-ID: <20261104193637.333158-1-sashal@kernel.org>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kexec tests are only built for x86 and ppc64le. On other
architectures the Makefile defines no rules, so building or installing
the suite fails:

  make[1]: *** No targets.  Stop.

Give the Makefile empty targets there, as sparc64 and
drivers/s390x/uvdevice do, so that the suite builds and installs
nothing.

Fixes: a802ed0dd9c2 ("selftests/ima: kexec_load syscall test")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with KernelCI-style TuxMake builds that record per-suite results
with KSFT_BUILD_REPORT. x86_64 builds don't change, and arm64 and arm
builds now succeed without installing anything.

With ARCH=powerpc, as passed by the kernel's kselftest targets and by
CI, the ppc64le check doesn't match either, so the tests are only built
on powerpc when ARCH is taken from uname -m. This patch leaves that
alone.

 tools/testing/selftests/kexec/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 874cfdd3b75b3..11b30d49a7f23 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -17,4 +17,8 @@ endif
 
 include ../lib.mk
 
+else
+nothing:
+.PHONY: all clean run_tests install
+.SILENT:
 endif
-- 
2.53.0


