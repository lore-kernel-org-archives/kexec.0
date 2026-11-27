Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F9606A32F
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mH5QWWpH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcP8S6t8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lnIqqYjeXqPPSZa+aej0B5CBul0phvtQ8KiVL9/wl4s=; b=mH5QWWpHX3t+i5
	1QbFQ+qNxcKsu2fYsd/WuzuajuuvGnJpQSmHMHfM1aZV75yQlRkM8IJHJYtYvtF5lZAe4oZXdg+IV
	yVOwcatr4TRSYW4KiZaeDwQVTTmbkP+zjnZr5mQG7CKnkZV03qWYrZTpv7x4udLWVjNFvw2ORDX5h
	4+RDsYE2LX4dp5JfBmjfKZAHv+RnbeNIRbzAVpvqV1yqUW+TODUP7BTzrY0bOXNzgB2QqFuOUr0pq
	SnSUVBXWpzmRvpRegmNoe9ftD6j4TfAknKsF3ZDaN+gHqVBTc2KF1hyjlaR+kAlZH7lsRYlsyn7NV
	2WhVesvTDZpQMMKI2/iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1e-0000000G7N9-1SSK;
	Fri, 27 Nov 2026 12:26:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1a-0000000G7Ko-36yv
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:25:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5AAB8400E6;
	Fri, 27 Nov 2026 12:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803A1F00893;
	Fri, 27 Nov 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782357;
	bh=lnIqqYjeXqPPSZa+aej0B5CBul0phvtQ8KiVL9/wl4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcP8S6t8a0tp6B00sALT4aIOpWQUglo7wF22WnppBJbF1JOPU0Og4E4JBeBQ+rJzh
	 7S3t8T9X5nLGPtwsHOR0EeziYdCMzlWHDA+b6S8UnlsANAEm+oxm49MyvpEtDx+JI/
	 /baTB10Dj0E3adVrlQNsW99WZ5ucrpy8M5E79pmVCYWfZu1fn6LBr6TR1mqlqIezJJ
	 gUvKF9mkghKAh7lFok0SAnZtPbuZC3V2jYH7Q11YNFN7X+sDjVrINLjUykcrbMzExW
	 F1LAZcVDyonOjZwQkVYNTAl3SlncjPccHD1zMjEF80FiBM/pc0I4JjE4GWIoYGt8os
	 KfHjKaGkeqmtw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/6] kho: move kho_{block,radix_tree}.h into include/linux/kho/
Date: Fri, 27 Nov 2026 12:25:29 +0000
Message-ID: <20261127122536.3708770-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hierarchical file systems have been around for a while now. Let's use
them.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 Documentation/core-api/kho/index.rst                 | 4 ++--
 MAINTAINERS                                          | 1 -
 drivers/pci/liveupdate.c                             | 2 +-
 include/linux/{kho_block.h => kho/block.h}           | 0
 include/linux/{kho_radix_tree.h => kho/radix_tree.h} | 0
 kernel/liveupdate/kho_block.c                        | 2 +-
 kernel/liveupdate/kho_core.c                         | 2 +-
 kernel/liveupdate/luo_internal.h                     | 2 +-
 kernel/liveupdate/luo_session.c                      | 2 +-
 9 files changed, 7 insertions(+), 8 deletions(-)
 rename include/linux/{kho_block.h => kho/block.h} (100%)
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (100%)

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index fc759213ddb9..b09547e10ba2 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -83,7 +83,7 @@ the next KHO, because kexec can overwrite even the original kernel.
 Kexec Handover Radix Tree
 =========================
 
-.. kernel-doc:: include/linux/kho_radix_tree.h
+.. kernel-doc:: include/linux/kho/radix_tree.h
   :doc: Kexec Handover Radix Tree
 
 Public API
@@ -98,7 +98,7 @@ KHO Serialization Blocks API
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :doc: KHO Serialization Blocks
 
-.. kernel-doc:: include/linux/kho_block.h
+.. kernel-doc:: include/linux/kho/block.h
 
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index fa9ee8051139..4469f9978ecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14784,7 +14784,6 @@ F:	Documentation/core-api/kho/*
 F:	include/asm-generic/kexec_handover.h
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
-F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kho_*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 76e939ea52eb..d99d2eb4e2ad 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -207,7 +207,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/liveupdate.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
diff --git a/include/linux/kho_block.h b/include/linux/kho/block.h
similarity index 100%
rename from include/linux/kho_block.h
rename to include/linux/kho/block.h
diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho/radix_tree.h
similarity index 100%
rename from include/linux/kho_radix_tree.h
rename to include/linux/kho/radix_tree.h
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..6cedcd36bfd2 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/block.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/slab.h>
 
 /*
diff --git a/kernel/liveupdate/kho_core.c b/kernel/liveupdate/kho_core.c
index 7544bc0b99e5..3f9d408b9d29 100644
--- a/kernel/liveupdate/kho_core.c
+++ b/kernel/liveupdate/kho_core.c
@@ -18,7 +18,7 @@
 #include <linux/kasan.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_radix_tree.h>
+#include <linux/kho/radix_tree.h>
 #include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/kho/abi/kexec_metadata.h>
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..6c034be2d390 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -10,7 +10,7 @@
 
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 
 struct luo_ucmd {
 	void __user *ubuffer;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f1b86f701238..1ed914db513d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -90,7 +90,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
-- 
2.56.1.839.g22a8290db9-goog


