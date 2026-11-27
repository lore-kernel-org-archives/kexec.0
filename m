Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CB606A337
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lLPG/WoE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8QpTmvZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=75kKPzvsdMlgmlPcHulcGoHaZEGP7r10gYVkY3tBkZo=; b=lLPG/WoEkL3QZB
	ASDfpeSrrCkVX9KiNAmJ3baSI3pzzM55PrAYI41/i2W2y3CRGlGKZQqTyN3CEI/znTVx/L74A6g+n
	zbwNymaQpG3vqA9MQIzsG1YdgYga57/FQamIEk+kz0JAtmC+SVFuHJico5ic8jb8vqb5hqfF3gMje
	XcTC9sWBAJb5NBzhe37TA7Ve7SHVgnbDprzvDTkIEwIAtKAu2JvYdQiEF3lE5iPngTgmcMpABq91z
	UA6eqz4YEM36GVCCeqAiZHNdXHSNA/ZHI8EpsYuZAMtZBoxrj1dzWBWOV1awbHN4dnWhvq4lZHIfB
	uks5doR+b+DWFgTAyTTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1n-0000000G7Tu-1Xs4;
	Fri, 27 Nov 2026 12:26:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1l-0000000G7S6-1yxy
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:26:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3ED89432EF;
	Fri, 27 Nov 2026 12:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136911F0089A;
	Fri, 27 Nov 2026 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782368;
	bh=75kKPzvsdMlgmlPcHulcGoHaZEGP7r10gYVkY3tBkZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8QpTmvZiK0wxgukaP82PoaUJV9KSkEPe8hR9/n0t45x0yoja6sGvUlEKdXYd94H9
	 cBYtfJaP7iOIcee8+9eETlZ/Gmqj9ijRoN1j9/PE5Xx5OoqT+SHNtmcDpz6+meH1qx
	 JXfxFtV6NcGPCT38HRmFKBnny+8kTBGa2ce+0AszmskMfLGqt/r+mdtmfnbkINb1Xh
	 WC5b3ykpU6M8mNrY+veveaaOqPJFnlt2bWyEWGej+lBoEyxQMZrSmpL8HXyLt5ApzA
	 gnmEecpZ4JThgjK1qM6II+l7qeNwwBoyIVBrw3nDZXXsJS08LvqwF3RjLmRTz9rz+U
	 QYAYHjfLIafEA==
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
Subject: [PATCH 6/6] kho: don't reference subtree blobs as FDTs
Date: Fri, 27 Nov 2026 12:25:32 +0000
Message-ID: <20261127122536.3708770-7-pratyush@kernel.org>
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

KHO started out with using FDT for all subtrees. This is why debugfs
used "sub_fdts" as the directory name and in the code. Since then, KHO
subtrees started also using raw C structs for serialization. Commit
4916ae386760 ("kho: rename fdt parameter to blob in
kho_add/remove_subtree()") updated some of the code to match this
reality.

Still, references to sub FDTs were left around. The data structure to
track the blobs is still called fdt_debugfs, the list of blobs is called
"fdt_list", and most importantly, the subdirectory holding them in
debugfs is called "sub_fdts".

Update all this to use blob in the naming.

The only functional change is the rename of the debugfs subdirectory
from "sub_fdts" to "sub_blobs". Everything else is a pure rename.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kho_debugfs.c  | 50 ++++++++++++++++----------------
 kernel/liveupdate/kho_internal.h |  4 +--
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/liveupdate/kho_debugfs.c b/kernel/liveupdate/kho_debugfs.c
index 8d04368c1978..1580e1a27566 100644
--- a/kernel/liveupdate/kho_debugfs.c
+++ b/kernel/liveupdate/kho_debugfs.c
@@ -17,7 +17,7 @@
 
 static struct dentry *debugfs_root;
 
-struct fdt_debugfs {
+struct kho_debugfs_blob {
 	struct list_head list;
 	struct debugfs_blob_wrapper wrapper;
 	struct dentry *file;
@@ -27,24 +27,24 @@ static int __kho_debugfs_blob_add(struct list_head *list, struct dentry *dir,
 				  const char *name, const void *blob,
 				  size_t size)
 {
-	struct fdt_debugfs *f;
+	struct kho_debugfs_blob *b;
 	struct dentry *file;
 
-	f = kmalloc_obj(*f);
-	if (!f)
+	b = kmalloc_obj(*b);
+	if (!b)
 		return -ENOMEM;
 
-	f->wrapper.data = (void *)blob;
-	f->wrapper.size = size;
+	b->wrapper.data = (void *)blob;
+	b->wrapper.size = size;
 
-	file = debugfs_create_blob(name, 0400, dir, &f->wrapper);
+	file = debugfs_create_blob(name, 0400, dir, &b->wrapper);
 	if (IS_ERR(file)) {
-		kfree(f);
+		kfree(b);
 		return PTR_ERR(file);
 	}
 
-	f->file = file;
-	list_add(&f->list, list);
+	b->file = file;
+	list_add(&b->list, list);
 
 	return 0;
 }
@@ -57,20 +57,20 @@ int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
 	if (root)
 		dir = dbg->dir;
 	else
-		dir = dbg->sub_fdt_dir;
+		dir = dbg->sub_blob_dir;
 
-	return __kho_debugfs_blob_add(&dbg->fdt_list, dir, name, blob, size);
+	return __kho_debugfs_blob_add(&dbg->blob_list, dir, name, blob, size);
 }
 
 void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob)
 {
-	struct fdt_debugfs *ff;
+	struct kho_debugfs_blob *b;
 
-	list_for_each_entry(ff, &dbg->fdt_list, list) {
-		if (ff->wrapper.data == blob) {
-			debugfs_remove(ff->file);
-			list_del(&ff->list);
-			kfree(ff);
+	list_for_each_entry(b, &dbg->blob_list, list) {
+		if (b->wrapper.data == blob) {
+			debugfs_remove(b->file);
+			list_del(&b->list);
+			kfree(b);
 			break;
 		}
 	}
@@ -99,7 +99,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	struct dentry *dir;
 	int err;
 
-	INIT_LIST_HEAD(&dbg->fdt_list);
+	INIT_LIST_HEAD(&dbg->blob_list);
 
 	dir = debugfs_create_dir("in", debugfs_root);
 	if (IS_ERR(dir)) {
@@ -107,7 +107,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		goto err_out;
 	}
 
-	err = __kho_debugfs_blob_add(&dbg->fdt_list, dir, "fdt", fdt,
+	err = __kho_debugfs_blob_add(&dbg->blob_list, dir, "fdt", fdt,
 				     fdt_totalsize(fdt));
 	if (err)
 		goto err_rmdir;
@@ -131,16 +131,16 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 
 __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 {
-	struct dentry *dir, *f, *sub_fdt_dir;
+	struct dentry *dir, *f, *sub_blob_dir;
 
-	INIT_LIST_HEAD(&dbg->fdt_list);
+	INIT_LIST_HEAD(&dbg->blob_list);
 
 	dir = debugfs_create_dir("out", debugfs_root);
 	if (IS_ERR(dir))
 		return -ENOMEM;
 
-	sub_fdt_dir = debugfs_create_dir("sub_fdts", dir);
-	if (IS_ERR(sub_fdt_dir))
+	sub_blob_dir = debugfs_create_dir("sub_blobs", dir);
+	if (IS_ERR(sub_blob_dir))
 		goto err_rmdir;
 
 	f = debugfs_create_file("bootmem_phys", 0400, dir, NULL,
@@ -154,7 +154,7 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 		goto err_rmdir;
 
 	dbg->dir = dir;
-	dbg->sub_fdt_dir = sub_fdt_dir;
+	dbg->sub_blob_dir = sub_blob_dir;
 	return 0;
 
 err_rmdir:
diff --git a/kernel/liveupdate/kho_internal.h b/kernel/liveupdate/kho_internal.h
index 5b349f451cf6..22950fe3bcc8 100644
--- a/kernel/liveupdate/kho_internal.h
+++ b/kernel/liveupdate/kho_internal.h
@@ -11,8 +11,8 @@
 
 struct kho_debugfs {
 	struct dentry *dir;
-	struct dentry *sub_fdt_dir;
-	struct list_head fdt_list;
+	struct dentry *sub_blob_dir;
+	struct list_head blob_list;
 };
 
 #else
-- 
2.56.1.839.g22a8290db9-goog


