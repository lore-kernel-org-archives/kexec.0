Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EFBF01832
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r3UzGEG+EMO5hQVHIScmxOOOv+tHtfPy3q+mI1q7KDo=; b=oS26Fj4az1Mq4nx/BkEJOdnYBr
	FIEYWhJ/Clcv+u4TeaICNGb5MBQBo3+OsxX++ba89Zmmh5IK6bD06rL3gkRtcY8HTELlcbxgWssI+
	UzggVR56Fk+I/qpaAUw4j69r/h09wM/z2O2j8BNZZr42ERhLngA7VbSYoTf9TbVmpjefTZxTAPOzx
	oRK/X2ox83+5EMFpl4ce4W69b0cA3eYdqUYbKhhEk2A5iTV+u+IZ0i0Yv4ibeO4PcR4NAH81ZlRAL
	liNC4j+jRwJdPM2ESCILETMJcxOKWPwCY6hxo/SzcMLC0XuQiovYdaoUX21MLRqFoMX+kiBwQm7Ks
	9ZJzQxCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTJ-00000003f3B-1dRq;
	Fri, 06 Mar 2026 12:40:01 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTG-00000003f1G-00KJ
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 12:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=r3UzGEG+EMO5hQVHIScmxOOOv+tHtfPy3q+mI1q7KDo=; b=UXPEiSm3MiUPouY7UBy0zb/KBs
	GMdw4BdFGlt2480xHC/IIKzr+vh1Ae4UZPWWQJXZb0h0KlJEsxl3U+9Ud5p3olZKrJZU/w7cm1qDJ
	g52RpheYz9KCzPP4JIkmhIOcyuBrgKl0HHQD04+OOQImCk8mh5rGpO4uUvfvnWSj0mIyK66UjxTjG
	bcFMBzDBMWkRLmLRlLQvPOz2mC2u9ZPQQ4ajYGe51Q+PHFwU2bTPnSXzU3z3L5KaFYGBy+AfccoJr
	WjW7OgUatQCJBnAiipLjrDYgB1KkIy8Bs7nvTs9EYpem76YFB5ji5lgaw1JAHtAzGMxt5/b5Rjiu8
	xIuf8xxQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vyUTE-00HVRP-35; Fri, 06 Mar 2026 12:39:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Mar 2026 04:39:23 -0800
Subject: [PATCH v7 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-kho-v7-4-404d14c188bb@debian.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
In-Reply-To: <20260306-kho-v7-0-404d14c188bb@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2820; i=leitao@debian.org;
 h=from:subject:message-id; bh=4JJwA4BhcQH0vypVqf0AFPnXED7DjJgKgSgxLA0Nv5k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpqssGmTaJ8Ll+XqkUU13uPDLWy3W9GTdb/bEvL
 kPgndgfIICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaarLBgAKCRA1o5Of/Hh3
 bbqFD/4rbEXrPDtNBWZD7+8GEQ5PvrWyCEoLl4we3SLx+m0aZfb7JTLB1XE7e9YH4zNT0Kfi7MB
 6gm3bkNjfQ0v5moSTjVXPdOh6A2SOi2HN8Hs4tRXI1UUL90QSbANNQ2v3R/ZgMi94mGToy6bA2M
 4jmFTiUwv/pxTYNL4x8BTNB8CI1UOF1qVIO6iQ86ngXmu4pOMunCf5q9yv5KO/a8m6N509BNtbn
 SdbzysegryN2W+0ztpNIx80v7PGY2xNUKZ0HHjWrfvZd8RbBBa/cYu/WOHtl3jKCCoJzRq4HV4E
 v3OOcafotjyxzzK91DNwzKZTLZbPg4dmLIGgws5Yp/0hkMBFT1cLoNJyn/a915HyMBWDVaC67TT
 Za7G1HQNfIjYvWy2CYky9ylPrGNtrtpELbtzuyOFIDJ6skUV/CybdZpHOHu3xPGFrrCmpdxQ0C7
 z3P1+pKYNsuite31v3E9H3IcN0gwG+XWeq5Xe+PofXTVJRei5dGkgnXhoNcQk6BOd87RPW78KCG
 FAB0uY0Ev7+G5dvcIeS/OESx5xfs0Yy4d5EFTAjJTtkGMVZSfkn9OcGd3y+YeSV7JV2g7E/5ZHE
 fBkUcLL7fN5hUNg7cMVY2hsOhKSfq4M+vnPe62VdYNXuhlrNFb9Yd2qJwnTPY/PiUykBuEBYaRT
 6HMrPdq0cPVRvow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_043958_048086_BA56C317 
X-CRM114-Status: GOOD (  10.61  )
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

kho_in_debugfs_init() has two problems when displaying incoming
sub-blobs in debugfs:

1. It uses the hardcoded property name "fdt" instead of
   KHO_FDT_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
   subtrees stored by the current kho_add_subtree().

2. It calls fdt_totalsize() to determine blob sizes, which assumes
   all blobs are FDTs. This breaks for non-FDT blobs like struct
   kho_kexec_metadata.

Fix both issues by using KHO_FDT_SUB_TREE_PROP_NAME to find subtrees
and reading the "blob-size" property from the FDT (persisted by
kho_add_subtree()) instead of calling fdt_totalsize().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 38 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 7a100f2bf3947..fc2baa8b104fd 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/mm.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include "kexec_handover_internal.h"
 
 static struct dentry *debugfs_root;
@@ -121,23 +122,36 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	fdt_for_each_subnode(child, fdt, 0) {
 		int len = 0;
 		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *fdt_phys;
-		void *sub_fdt;
-
-		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
-		if (!fdt_phys)
+		const u64 *blob_phys;
+		const u64 *blob_size;
+		void *blob;
+		size_t size;
+
+		blob_phys = fdt_getprop(fdt, child,
+					KHO_FDT_SUB_TREE_PROP_NAME, &len);
+		if (!blob_phys)
 			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node %s prop fdt has invalid length: %d\n",
-				name, len);
+		if (len != sizeof(*blob_phys)) {
+			pr_warn("node %s prop %s has invalid length: %d\n",
+				name, KHO_FDT_SUB_TREE_PROP_NAME, len);
 			continue;
 		}
-		sub_fdt = phys_to_virt(*fdt_phys);
+
+		blob_size = fdt_getprop(fdt, child,
+					KHO_FDT_SUB_TREE_SIZE_PROP_NAME, &len);
+		if (!blob_size || len != sizeof(*blob_size)) {
+			pr_warn("node %s missing or invalid %s property\n",
+				name, KHO_FDT_SUB_TREE_SIZE_PROP_NAME);
+			continue;
+		}
+		size = (size_t)*blob_size;
+
+		blob = phys_to_virt(*blob_phys);
 		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
-					     sub_fdt, fdt_totalsize(sub_fdt));
+					     blob, size);
 		if (err) {
-			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
-				ERR_PTR(err));
+			pr_warn("failed to add blob %s to debugfs: %pe\n",
+				name, ERR_PTR(err));
 			continue;
 		}
 	}

-- 
2.47.3


