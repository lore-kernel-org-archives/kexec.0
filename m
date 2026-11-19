Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1260A2610
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tXT+YN9M;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=GrSmFFMN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P6tm7LnDa5d5V2BsH/GMpXWLmcsqjeCKsjklUdm51D0=; b=tXT+YN9MVeUCcN19HqSQzx7bxM
	WU5MT1s5XmpwEkufZmswtjTnpzmNNg6jY8hgkMwOD5jjPRgEnksnbSvoWeQPSRM9r6X1QV4fkx0Tt
	VgpSV7eQt4QftvfzRJZAxWY+bEmjfCzUMD4+ytpwY+tO7Zf5wL3HRshrzpTSSdADbN89Gn+7ZvZKi
	qvDQB9SwqXlyvVa2W3Ajdf56p5RwKQzz5NcDuabWfHfLISYPetFka0M8ULmdNrYCp3GmYQdlZs0dH
	MZggqbYrTAWDDBs03NHWZoYeGDLIKTUvrGiLcvhiJdlsYTjutiom/oLAOFmMQ11o5k7cWdfwT1D88
	zySweC9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvpN-0000000B0oa-1rTg;
	Thu, 19 Nov 2026 06:41:01 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvpJ-0000000B0lw-12A0
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:40:59 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P6tm7LnDa5d5V2BsH/GMpXWLmcsqjeCKsjklUdm51D0=;
	b=GrSmFFMN3PMyGzQB42WLWdiPokP3GC7aB/JDex7tzaXzJ7+LujTSMa5iTXIMbhgrCmy0da8I1
	Rfqj9ZXXGlhq0rurZGTvm/1hBIe6BXZ8Ecem+RKe7F24AT/5yd/zn+wqMlEG0YJua4aKE7oo7FM
	WFAiXhx95fHvEQA3MYMihno=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jVTNZ1MN9z12LCr;
	Thu, 19 Nov 2026 14:39:58 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id E103140685;
	Thu, 19 Nov 2026 14:40:49 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 14:40:49 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>
CC: <graf@amazon.com>, <leitao@debian.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <linux-mm@kvack.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH v2 1/2] kho: do not expose incoming sub-blob contents in debugfs
Date: Thu, 19 Nov 2026 14:37:59 +0800
Message-ID: <20261119063800.698863-2-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119063800.698863-1-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261119063800.698863-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_224057_637737_C4D0F78A 
X-CRM114-Status: GOOD (  14.65  )
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

Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
Signed-off-by: Long Wei <longwei27@huawei.com>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 47 +---------------------
 1 file changed, 2 insertions(+), 45 deletions(-)

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


