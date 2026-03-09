Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75283F3C263
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ki42cLPnp8Qeyh0kILceJ+Cv5Lvk3JbK3h54C1+Mwj8=; b=u5CD2cUYgOmoh0lsGC+uDwCpCr
	rivM+laKYRLhrREafJaCkmwn+LNve9no+VC8yE0CT48BEdoDjhVstljXke6Yq+ofXfoTL6/s9x0x7
	5DQTzvttcCmpbGGmtWo6WJ3oV5pcpav940OoB/9oi5XnJolIhEw+0rFkNm2WypEOOAOnYbsM+HbXt
	nX+xhG3Gr33VcmEsS+Q8r6X2bwWMx2muyx2K3pYV6tkKGngy5n8ympt5KNmNUbv+J1klV9LVDj8Ne
	Cvxh1Og0xhkpjadKaEPalCDLhSUKWL8IUxih08jX0mxln73+T3J9/8qM9Wid2KT8hQwO2ciy0GBpd
	gQ+JVe6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasb-00000007QDJ-3yAl;
	Mon, 09 Mar 2026 13:42:41 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasZ-00000007QAD-04Ra
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 13:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Ki42cLPnp8Qeyh0kILceJ+Cv5Lvk3JbK3h54C1+Mwj8=; b=dDG+1siO5bIqzBPb12wlG3NvS5
	EN79ITNUuMRYWb1u/3APu6BeWNKyTmA6hToFHqiHqlkdiRKIA9vIrtstl2+uBPp6ulVEXPpHIY8S+
	/qPvP4qh9R+kZxaNl4rFrhkU83Nxe5JPXoNHmSYP96GQfkng196aUNuNdDxm1mK8+5+Y15RgAjmud
	tmX9OHDK9qsmmC/NOlJliGldXPzZ5sFU2q578//Lo06FbVEOh2aJ9xaWuGi4pzMMviTq09uIs7/mN
	oj2A4LlDnp2AqxBzyRMT+39n4fJOunQF+VSc8FjsK8f/S0NZeXOxCePsuZ5IsPMoJgEhsFOa0Ao48
	Bg65Ng3w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzasS-002G3r-Hy; Mon, 09 Mar 2026 13:42:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 06:41:47 -0700
Subject: [PATCH v8 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-kho-v8-4-c3abcf4ac750@debian.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
In-Reply-To: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=leitao@debian.org;
 h=from:subject:message-id; bh=pgo9Bbif/Iq2LY22Zf8vKl/gIhQNmdeP3CUxMaHZ9Dw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprs4yoKfrHmBJbEuCrYV9rdiomUpCNqeGUD49s
 JR++cG0exWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa7OMgAKCRA1o5Of/Hh3
 bQWLD/98p0l+FcT2BDdyTKmRTYD8ikYqEE7RChHTT4zoIMfKc1BwA+xtvZUUAVJXhXqdxUS4s79
 0uGsW8iYers5S5MQIn79gWL44duPHmAIANIZlzBe7WE1lV7JYculVbw67zBpCKv8MZcRrDmJoHx
 GXw4uVdTrXe/EXgvJlAmNEfmamGKe0nLq93P9LRUcKsgVgTKW71hQBlvxv5XP8MZfaoU9swIWc3
 2PpJHC+cXA3+rEbXG1KVzM+eVyT7MPLMhuTKKdfbFyyAT9tPZ9UkiMpJKtVbgueuLN7KpWHhohR
 wd7sj7uHsMfWsL2bQtpf888+xZYLqRGvqn8ioA3lb/KGw4l8DVoXzqazDibQ0w1X/3+aiop5AY1
 KWBQ+FZnaQEFlmCT5lfX4fdDOyCFB4AI1OSlCS6hEiOUvRtV5RZ3s10bhyBx9CnPAoH2f06ci/G
 g0Z3LvvdcOCNz1lcOodOu0cQkFRmUL8LmD4wEmRybFtMps5ZPVVax00gYgv+kjZEMUvWBpht5jG
 kVMFwn0VVfXGiSgMrTOIO/BVvgu0CHkibLtrXdCMSru24HseBgV62fjTDdmyFEPfQ0W1L6oUFV9
 rI+y+a4L7i2QX/SaGirRr5UdNjaw2HaQeX60PK6zOS/K9JBcmIV5R9PfadMTGQXO4KJuIEoU0D9
 Nc+zunbNNdsk26Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_064239_081452_9FE74933 
X-CRM114-Status: GOOD (  11.69  )
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
   KHO_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
   subtrees stored by the current kho_add_subtree().

2. It calls fdt_totalsize() to determine blob sizes, which assumes
   all blobs are FDTs. This breaks for non-FDT blobs like struct
   kho_kexec_metadata.

Fix both issues by using KHO_SUB_TREE_PROP_NAME to find subtrees
and reading the "blob-size" property from the FDT (persisted by
kho_add_subtree()) instead of calling fdt_totalsize().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 34 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 7a100f2bf3947..257ee8a52be66 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/mm.h>
+#include <linux/kho/abi/kexec_handover.h>
 #include "kexec_handover_internal.h"
 
 static struct dentry *debugfs_root;
@@ -121,23 +122,34 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	fdt_for_each_subnode(child, fdt, 0) {
 		int len = 0;
 		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *fdt_phys;
-		void *sub_fdt;
+		const u64 *blob_phys;
+		const u64 *blob_size;
+		void *blob;
 
-		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
-		if (!fdt_phys)
+		blob_phys = fdt_getprop(fdt, child,
+					KHO_SUB_TREE_PROP_NAME, &len);
+		if (!blob_phys)
 			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node %s prop fdt has invalid length: %d\n",
-				name, len);
+		if (len != sizeof(*blob_phys)) {
+			pr_warn("node %s prop %s has invalid length: %d\n",
+				name, KHO_SUB_TREE_PROP_NAME, len);
 			continue;
 		}
-		sub_fdt = phys_to_virt(*fdt_phys);
+
+		blob_size = fdt_getprop(fdt, child,
+					KHO_SUB_TREE_SIZE_PROP_NAME, &len);
+		if (!blob_size || len != sizeof(*blob_size)) {
+			pr_warn("node %s missing or invalid %s property\n",
+				name, KHO_SUB_TREE_SIZE_PROP_NAME);
+			continue;
+		}
+
+		blob = phys_to_virt(*blob_phys);
 		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
-					     sub_fdt, fdt_totalsize(sub_fdt));
+					     blob, *blob_size);
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


