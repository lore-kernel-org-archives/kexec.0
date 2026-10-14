Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A66CC6B2E
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUU6GZFqMSNYXOwJs6Za3b0uigEcrfPKq411zI1Oteg=; b=cWh6vxokboQzRz8WLPdsDSUJfZ
	HbzdJRvhz2MP+jhQaqfjX1ohoI3vYkrcoDxL8Z5Y2ALSIpGlP/rW9HLTXRj9BZdXxqatpOsn0ziUR
	Yk510jJvJMaTBeyfeFtqW7x4pF/CtCJ+6EhEClzBHenKXoLyFqGSGQjpnI5DrjyQipRisNE6xMWmH
	ek/UnVh9CM8b+bz6UdFF/j6Pc3T/nHtP9U68lV4iV+kHBxfDtEjmS2hFLBflYGivBe02MvLcE7S1R
	NsYFfgY5chYHIuQ8lJYR9yw/VQ/+LGledBsmO410VJ9veqfUM1cam8ExvWq46UmB4caxy05Cw6o9n
	p0dg9C6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5AQ-0000000GEgr-3nmT;
	Wed, 14 Oct 2026 20:01:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH5AM-0000000GEef-2Grg
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 20:01:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 47829447C7;
	Wed, 14 Oct 2026 20:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8B11F000C6;
	Wed, 14 Oct 2026 20:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008094;
	bh=pUU6GZFqMSNYXOwJs6Za3b0uigEcrfPKq411zI1Oteg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afg5s7wYZxjtRm5X1k10FyzdSHWgtQlQauEBDuFRVFEIQlJlGfT3/vdfc2TQE10Yn
	 FjjrRX/dbLBBas0S+c0D0AvR4d/ehcxyBwLAdTzF8kGwnz3zQVIOn8dUAzf/ZbbjrH
	 A4Tobzd6frYYVHOSuiq6k5AFb4k1CyMbFzpPVktySyb8rSmX3uFb5Fs8SBpd9OOdol
	 x5wqyTuHbjBZmR+IJ381XuGitbn1GbkUgpEEQR5WS56BjnA8ZibfJnyfP0VTPHZl8g
	 HIi8vezZ6o5cz8wprsuiAq3S8056uFz5LpewgBVgIl2+zznbZv58C0MxFGvWXpPJFv
	 Dw0WnNOdEot2w==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] selftests/kexec: select tests using the target compiler
Date: Wed, 14 Oct 2026 16:01:26 -0400
Message-ID: <20261014200127.1363472-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200127.1363472-1-sashal@kernel.org>
References: <20261014200127.1363472-1-sashal@kernel.org>
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

The kexec Makefile recognizes PowerPC only through the ppc64le spelling
of ARCH, so the canonical ARCH=powerpc used for cross builds omits the
tests. The x86 jump test is selected with IS_64_BIT from
scripts/Makefile.arch, which describes the build host rather than the
compiler being used. On other architectures the Makefile includes no
lib.mk rules at all, so installation and runlist generation fail with
missing targets.

Select x86 and PowerPC from the target ARCH when it is given and from
the host's SUBARCH otherwise, without assigning ARCH, so that lib.mk
keeps choosing the compiler's native clang target. Ask the selected
compiler, including USERCFLAGS, whether it targets a 64-bit x86 ABI
and whether it targets little-endian 64-bit PowerPC. lib.mk expands the
generated program list before it appends USERCFLAGS to CFLAGS, so the
flags are passed explicitly to keep both probes consistent. If the
compiler cannot be run, select the jump test so that the build fails
instead of silently dropping it. Include lib.mk unconditionally so that
unsupported targets build, install and emit an empty runlist.

Fixes: 65e38e32a959 ("selftests/kexec: Enable secureboot tests for PowerPC")
Fixes: 7615b94b6371 ("selftests/kexec: Add x86_64 selftest for kexec-jump and exception handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kexec/Makefile | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 874cfdd3b75b3..97d5dd10208a1 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -1,20 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for kexec tests
 
-ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-ARCH_PROCESSED := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+top_srcdir = ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH_PROCESSED := $(shell echo $(or $(ARCH),$(SUBARCH)) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
-TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
-TEST_FILES := kexec_common_lib.sh
+PROBE_CC = $(filter-out -fuse-ld=%,$(CC)) $(CFLAGS) $(USERCFLAGS) -E -P -x c -
+CC_IS_64BIT = $(shell echo __SIZEOF_LONG__ | $(PROBE_CC) || echo 8)
+PPC64LE = $(shell printf '\043if defined(__powerpc64__) && __BYTE_ORDER__ == \
+	__ORDER_LITTLE_ENDIAN__\n1\n\043endif\n' | $(PROBE_CC))
 
-include ../../../scripts/Makefile.arch
-
-ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
-TEST_PROGS += test_kexec_jump.sh
-TEST_GEN_PROGS := test_kexec_jump
+ifeq ($(ARCH_PROCESSED),x86)
+TEST_PROGS = test_kexec_load.sh test_kexec_file_load.sh \
+	$(if $(filter 8,$(CC_IS_64BIT)),test_kexec_jump.sh)
+TEST_GEN_PROGS = $(if $(filter 8,$(CC_IS_64BIT)),test_kexec_jump)
+else ifneq (,$(filter powerpc ppc64le,$(ARCH_PROCESSED)))
+TEST_PROGS = $(if $(filter 1,$(PPC64LE)),test_kexec_load.sh test_kexec_file_load.sh)
 endif
+TEST_FILES = $(if $(TEST_PROGS),kexec_common_lib.sh)
 
 include ../lib.mk
-
-endif
-- 
2.53.0


