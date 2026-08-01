Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71429C55174
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c/vB3WD/7Dj176UGptU16rqTkNJk3eC17XvdFm9X+ws=; b=zmToB0jXNi2Q4bqeOxqr/Inj6F
	2ak0Rb8ezca/uvj0OjNpeN5nbDffrQY5rmZG9CCwKbLFsMtudaAAb0UJuKvYMyZiwqh8Mvz1p6hkC
	gLNO9vaJathJVl2zwDaIJECvUBixoFJtlAuilZMXm8/7pfhTtfztxwVr87aSprhARMS9AlywMgayX
	r5AsN9Agdk51mGqHwKWGxJ+PEXxkln09tlLC/4Z/e9yt7z6qBvwsTvwVarmSg/HWYTxMedO7kxVJY
	nzjQypiv278E45/r8Bmd69zfJdBdvo3w8q3DCuOmiKt2edwZhCv8N2XSbXESAWvsARmaJgIuoM/uY
	haLWO+pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5Pb-0000000E56U-2RNw;
	Sat, 01 Aug 2026 08:49:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PZ-0000000E535-1Uw9
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8B9760AAC;
	Sat,  1 Aug 2026 08:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5867C1F00ACF;
	Sat,  1 Aug 2026 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574180;
	bh=c/vB3WD/7Dj176UGptU16rqTkNJk3eC17XvdFm9X+ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kt4e7q6DHaIsNzhM8Hw4l1ztlRsErtKU4viX9Gl/BNomAKQpvGAAA9c1FE0iHWYQj
	 nrVNtyiE5aY63+cESIDyPXCrFy7e2q74mPOoylQJMu4gGxMWF2kr5NzUI1BDn65pn8
	 jbJOTl9xHM5zcJvjqZIvC21TOnnJt1G/0IO99ACEjJ+VrShTKRZM/9QzwPoCWcTdtE
	 r3qs7ag92TaD5qxD6N3WLvhQAz0SVdJ9h/4nHr6Gsk5rhGUP/XMf8/RRA1RpcYXbNI
	 7rWXFthAp+VPTyzkn1FdzeneJP4Id5dqbZvQqvFml7AyqYtfzeZLWVcG4OH0AfBGby
	 rgUfQXBanMW9w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/22] memblock: always include KHO headers
Date: Sat,  1 Aug 2026 10:48:28 +0200
Message-ID: <20260801084833.1897543-20-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

In a coming commit, memblock will start using kho_scratch_overlap()
without a compile guard. The compile guard for the function is in
kexec_handover.h and provides a stub when CONFIG_KEXEC_HANDOVER is
disabled.

Since in memblock the call will exist unconditionally, always include
the KHO headers.

Including these headers unconditionally breaks memblock test
compilation. Add stubs to fix that.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/memblock.c                                   |  2 --
 tools/testing/memblock/linux/kexec_handover.h   |  9 +++++++++
 tools/testing/memblock/linux/kho/abi/memblock.h | 10 ++++++++++
 tools/testing/memblock/linux/libfdt.h           |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/memblock/linux/kexec_handover.h
 create mode 100644 tools/testing/memblock/linux/kho/abi/memblock.h
 create mode 100644 tools/testing/memblock/linux/libfdt.h

diff --git a/mm/memblock.c b/mm/memblock.c
index 8b2e551435ae..ea735bcd4dd1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -19,11 +19,9 @@
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
 
-#ifdef CONFIG_KEXEC_HANDOVER
 #include <linux/libfdt.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/memblock.h>
-#endif /* CONFIG_KEXEC_HANDOVER */
 
 #include <asm/sections.h>
 #include <linux/io.h>
diff --git a/tools/testing/memblock/linux/kexec_handover.h b/tools/testing/memblock/linux/kexec_handover.h
new file mode 100644
index 000000000000..bdfd9445b1fd
--- /dev/null
+++ b/tools/testing/memblock/linux/kexec_handover.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_H
+#define LINUX_KEXEC_HANDOVER_H
+
+/*
+ * Header stub to avoid test build breakage; we don't need to actually implement
+ * any KHO functions as they are not used in the tests.
+ */
+#endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/tools/testing/memblock/linux/kho/abi/memblock.h b/tools/testing/memblock/linux/kho/abi/memblock.h
new file mode 100644
index 000000000000..71cf6982a2b9
--- /dev/null
+++ b/tools/testing/memblock/linux/kho/abi/memblock.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KHO_ABI_MEMBLOCK_H
+#define _LINUX_KHO_ABI_MEMBLOCK_H
+
+/*
+ * Header stub to avoid test build breakage; we don't need to actually define
+ * any ABI as they are not used in the tests.
+ */
+#endif /* _LINUX_KHO_ABI_MEMBLOCK_H */
diff --git a/tools/testing/memblock/linux/libfdt.h b/tools/testing/memblock/linux/libfdt.h
new file mode 100644
index 000000000000..6137b788fe8d
--- /dev/null
+++ b/tools/testing/memblock/linux/libfdt.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INCLUDE_LIBFDT_H_
+#define _INCLUDE_LIBFDT_H_
+
+/*
+ * Header stub to avoid test build breakage; we don't need to actually implement
+ * any FDT functions as they are not used in the tests.
+ */
+#endif /* _INCLUDE_LIBFDT_H_ */
-- 
2.55.0.571.g244d577d93-goog


