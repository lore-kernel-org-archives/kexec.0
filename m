Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ADA10854A6
	for <kexec@archiver.kernel.org>; Sat, 14 Mar 2026 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BFzIVfNe1KLJMON07NojT/t4iHrovHjx1RDsdHaFvhA=; b=LRmhAhjIty4tOLTJzFHEu0igOS
	RPYRVPu56CdEo1VppQ17JVv4F0EJXCpq3kvUnc2Hr8jkadpD42ruNKZGq+Fe+6GYgYOzsC73hXZx4
	H/BQIDpxrAgspnRON3MPCVSdYoxEjxKnikZ+NH54lEuRR+LxrgzQFZn9CkClyhYgaFToqpZ/wrplh
	C6vnOIkhK1T918x35QXTpEY8GQAVyxJvPYcgOhr69+JhA1EBj+PgI/mYQaLGA23fdSLKwqvHu5cNL
	+/F3W5m6L7+jNW2zNbae5U19I2qDop7/YANP7EHtSBO3qDtxJ20baeWOz6hg7CNxLIyPyMxL92a5E
	uUabia+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1VpI-000000029Zy-1ebd;
	Sat, 14 Mar 2026 20:43:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1VpG-000000029ZP-2Fmu
	for kexec@lists.infradead.org;
	Sat, 14 Mar 2026 20:43:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F2A8960121;
	Sat, 14 Mar 2026 20:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6983AC116C6;
	Sat, 14 Mar 2026 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773520989;
	bh=TdCww+NF5SsX18iNG8r5Sjp5dR2V5TsoiZj+4UpZtL8=;
	h=From:To:Cc:Subject:Date:From;
	b=QrSqei8Pwn4Zjl4OYrvlVuv/N2WNHjNY+WRZBSLpwEykVYTbvF5bUsBsAXN4+1sK8
	 U67OKlOvcnRQ5NaPilM8bny/p+0cS7wWEKaKGD02MpSBNgg1L9EofqlrxU8TrRO0B6
	 37MwfQwccmgBUOC6wXqOiaydATnd46lCWw3Duxiz7/8vz7zOhlQ0HHRzYN3LPl4nJP
	 LrgZojqUHPP+x3n5C2jn+UP+UhwLrJ4/N5Rjs2+xuBXiN7XnfTxAipjuwrxBCIrbSc
	 mUxLM16KFDmxkwWmyu3i0UmjYbnMH7VdHrW2qtl1a/LHzAcIT7Anx7I9PnuO5xikzB
	 ivy7A2flk6UNA==
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] kernel/crash: Remove inclusion of crypto/sha1.h
Date: Sat, 14 Mar 2026 13:42:43 -0700
Message-ID: <20260314204243.45001-1-ebiggers@kernel.org>
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

Several files related to kernel crash dumps include crypto/sha1.h but
never use any of its functionality.  Remove these includes so that these
files don't unnecessarily come up in searches for which kernel code is
still using the obsolete SHA-1 algorithm.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 kernel/crash_core.c    | 2 --
 kernel/crash_reserve.c | 2 --
 kernel/vmcore_info.c   | 2 --
 3 files changed, 6 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2c1a3791e4101..4f21fc3b108b8 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -25,12 +25,10 @@
 #include <linux/panic.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
-#include <crypto/sha1.h>
-
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 62e60e0223cff..eee37a11380ce 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -18,12 +18,10 @@
 #include <linux/crash_reserve.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
-#include <crypto/sha1.h>
-
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
 /* Location of the reserved area for the crash kernel */
 struct resource crashk_res = {
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8d82913223a13..36772126385ce 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -16,12 +16,10 @@
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
 
-#include <crypto/sha1.h>
-
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;

base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.53.0


