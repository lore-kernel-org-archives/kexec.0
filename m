Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DFD606A332
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U9gjhHNh;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2VP9dmAA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=J1xrO2Y7n8BOFe6QC7CesVydiqyoOrVKZU9JIFCW6gc=; b=U9gjhHNhVHQKZPkrYiMHLzY73C
	yXBVd3PcjUNa7IPOhbCw/x1gH1JG/PIllpEkcbPhDKAlcxpYsmqY/wnDZGhFkkhJ9UwGXiJB0YJ4E
	PPNLJuSQvkNQSnCxcYz8oMH/eKuuiuvBFXWEEHv8DYieWzHICyTOGnU4W35NcXPvkK6rUQT2ZdM9U
	Q5VPU7LkZUgXMhBfY/vkFCv6CebbUkyEfwRLXWQChpJqPVPEWN3NrL9/MmmBjQ/EDCjLACBVkBnH7
	bA/lSBHCp5058ovF7ixQk4naxoewAHNxhzT+aJ1AXwKcofEUQ+AbSCDKeCdub9/w8v5pzZbWMXsEd
	qgWlyUUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyyA-0000000BTVD-38tj;
	Thu, 19 Nov 2026 10:02:18 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyy6-0000000BTUE-2pQz
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 10:02:17 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=J1xrO2Y7n8BOFe6QC7CesVydiqyoOrVKZU9JIFCW6gc=;
	b=2VP9dmAANqSdFteXZIsBtMHxXgy3OCelrSi9r7RWeTV7SOEMBPKTGUoKrRxKXqaoIXu3LyLeO
	b8VVekInQ4nT3Ag8LPC/ugpx+E1fiIenhdwfEuJmkQLW64hixhf+oeiszAi1+nxylfdzQa0EaIF
	x9dI5GddupCRViCP9xMMLyo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jVYsd0Xf1z1prM1;
	Thu, 19 Nov 2026 18:01:57 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 930A140561;
	Thu, 19 Nov 2026 18:02:10 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 18:02:09 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>
CC: <graf@amazon.com>, <leitao@debian.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <linux-mm@kvack.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH v3] kho: do not expose incoming sub-blob contents in debugfs
Date: Thu, 19 Nov 2026 17:59:37 +0800
Message-ID: <20261119095937.826980-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_020215_409151_C8B7D7B2 
X-CRM114-Status: GOOD (  17.95  )
X-Spam-Score: -2.1 (--)
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

Incoming sub-blob pages are owned by their consumers and have independent
lifetimes.  Some consumers, such as LUO, restore and free their state in
early_initcall, i.e. before kho_init() (fs_initcall) builds the debugfs
view:

  early_initcall: luo_early_startup()
                    -> kho_retrieve_subtree("LUO")
                    -> kho_restore_free(luo_ser)   /* page is freed */

  fs_initcall:    kho_init()
                    -> kho_in_debugfs_init()
                         -> phys_to_virt(luo_ser_phys)
                         -> debugfs_create_blob("LUO", ...)

debugfs therefore ends up pointing at a page that was already handed back
to the page allocator, and reading the file triggers a use-after-free:

  # cat /sys/kernel/debug/kho/in/sub_fdts/LUO
  ==================================================================
  BUG: KASAN: use-after-free in _copy_to_user+0x37/0x60
  Read of size 32 at addr ffff88810309c000 by task cat/27436

  Call Trace:
   <TASK>
   kasan_report+0xb9/0xf0
   kasan_check_range+0x100/0x1b0
   _copy_to_user+0x37/0x60
   simple_read_from_buffer+0x77/0xd0
   read_file_blob+0x75/0xa0
   vfs_read+0x12d/0x520
   ksys_read+0xc3/0x160
   do_syscall_64+0x97/0x4b0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1fd
  pfn:0x10309c
  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
  page_type: f0(buddy)
  ==================================================================

The page is already in the buddy allocator (page_type: f0(buddy),
refcount 0), which confirms it was freed before the debugfs view was
created.

KHO does not own these pages, so it cannot safely expose their contents at
all.  Drop the in/sub_fdts directory.  The incoming FDT is reserved by KHO
and remains exposed as in/fdt, where the same metadata is available.

The incoming sub-blob debugfs directory is gone, so remove its description
from the KHO admin guide as well.

Note that in/sub_fdts has exposed memory KHO does not own since
commit c609c144b0e8 ("kexec: add KHO parsing support"), but the
use-after-free only became reachable after commit d376e4b55c9a0
("liveupdate: centralize state management into struct luo_ser") which
added kho_restore_free()

Fixes: d376e4b55c9a0 ("liveupdate: centralize state management into struct luo_ser")
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Long Wei <longwei27@huawei.com>
---
Changes in v3:
- Fold documentation removal into this patch (per Mike Rapoport)
- Update Fixes tag to d376e4b55c9a0 (per Mike Rapoport)

Changes in v2:
- Drop the in/blobs metadata file entirely (per Pasha Tatashin)
- Remove unused sub_fdt_dir member and #include <linux/io.h>

 Documentation/admin-guide/mm/kho.rst       |  4 --
 kernel/liveupdate/kexec_handover_debugfs.c | 47 +---------------------
 2 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 902d171a780a..4281da6be5fa 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -117,7 +117,3 @@ stabilized.
     kernel's state is in this file in the format of flattened
     device tree. This file may disappear when all consumers of
     it finished to interpret their metadata.
-
-``/sys/kernel/debug/kho/in/sub_fdts/``
-    Similar to ``kho/out/sub_fdts/``, but contains sub blobs
-    of KHO producers passed from the old kernel.
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 7d74477da0b7..3a91c47ad7a6 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) "KHO: " fmt
 
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/mm.h>
 #include <linux/kho/abi/kexec_handover.h>
@@ -97,8 +96,8 @@ DEFINE_SHOW_ATTRIBUTE(bootmem_len);
 
 __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 {
-	struct dentry *dir, *sub_fdt_dir;
-	int err, child;
+	struct dentry *dir;
+	int err;
 
 	INIT_LIST_HEAD(&dbg->fdt_list);
 
@@ -108,54 +107,12 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		goto err_out;
 	}
 
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
-	if (IS_ERR(sub_fdt_dir)) {
-		err = PTR_ERR(sub_fdt_dir);
-		goto err_rmdir;
-	}
-
 	err = __kho_debugfs_blob_add(&dbg->fdt_list, dir, "fdt", fdt,
 				     fdt_totalsize(fdt));
 	if (err)
 		goto err_rmdir;
 
-	fdt_for_each_subnode(child, fdt, 0) {
-		int len = 0;
-		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *blob_phys;
-		const u64 *blob_size;
-		void *blob;
-
-		blob_phys = fdt_getprop(fdt, child,
-					KHO_SUB_TREE_PROP_NAME, &len);
-		if (!blob_phys)
-			continue;
-		if (len != sizeof(*blob_phys)) {
-			pr_warn("node %s prop %s has invalid length: %d\n",
-				name, KHO_SUB_TREE_PROP_NAME, len);
-			continue;
-		}
-
-		blob_size = fdt_getprop(fdt, child,
-					KHO_SUB_TREE_SIZE_PROP_NAME, &len);
-		if (!blob_size || len != sizeof(*blob_size)) {
-			pr_warn("node %s missing or invalid %s property\n",
-				name, KHO_SUB_TREE_SIZE_PROP_NAME);
-			continue;
-		}
-
-		blob = phys_to_virt(*blob_phys);
-		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
-					     blob, *blob_size);
-		if (err) {
-			pr_warn("failed to add blob %s to debugfs: %pe\n",
-				name, ERR_PTR(err));
-			continue;
-		}
-	}
-
 	dbg->dir = dir;
-	dbg->sub_fdt_dir = sub_fdt_dir;
 
 	return;
 err_rmdir:
-- 
2.43.0


