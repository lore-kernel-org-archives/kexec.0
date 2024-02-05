Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0598C48299
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EaqOBxEo7sr28sxcU7x00eyjMpV/nDIOg14gZBewJHc=; b=1bT7k96rkAeyW3
	IpsHg6w0hdTRVdxkAwVRdZl6q1BQ2vSf2Wavnlt+aS9+j3Bh36wQmoVLP8PPgNlGoBOdq1J01Nq/S
	A5WVJl43hOvnkpuNwp44YMz1/3H+q6muicuUr/LvVCFJt6gD/VW3y/fv1+rTUpNaXtmauebh9Gix5
	cGXI7hXfQ8jXGx8epmE6fWVDdqO4RvOSoYWHY4KAKd5GNYuTILchjkeNgURiK2L52ErFoUB0ZVESo
	ztj6FkJJt4mlL6HRGP3HvfyXl3hoMSKN2Mm5vEzZrBDhMWqjavIMj372/uyaSxUZnoo2rfxSBLYMW
	/a7SKDs96IrjPR3MC+Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgq-0000000365Z-1QTB;
	Mon, 05 Feb 2024 12:03:08 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgm-00000003620-4ApU
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134585; x=1738670585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Am0Sels7NAPtGwBi87Q194PvOn79+zUBtD9YBYxO8Vc=;
  b=tRoTa+6NKF1TTmvU+S524n3sBkweAW2lRFo7R2Nd1951ePXPtp5iKLkI
   M0jhxHM66+/G9zFDQb8jbGOHRnw4BC7qaB/dAmVt2ochRIriJ/P5l8dq+
   h3vFgYBLenYFvBsUtg3gK+cEoMb5iUIcJO3Mto/Yu3XFaTNU3eegf9qFL
   c=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755258"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:04 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:35084]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id a0419078-eb19-4b6b-acd7-2633051ba0ca; Mon, 5 Feb 2024 12:03:03 +0000 (UTC)
X-Farcaster-Flow-ID: a0419078-eb19-4b6b-acd7-2633051ba0ca
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:03 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:57 +0000
From: James Gowans <jgowans@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	<kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, Alexander Graf <graf@amazon.com>, David Woodhouse
	<dwmw@amazon.co.uk>, "Jan H . Schoenherr" <jschoenh@amazon.de>, Usama Arif
	<usama.arif@bytedance.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	<madvenka@linux.microsoft.com>, <steven.sistare@oracle.com>,
	<yuleixzhang@tencent.com>
Subject: [RFC 04/18] pkernfs: support file truncation
Date: Mon, 5 Feb 2024 12:01:49 +0000
Message-ID: <20240205120203.60312-5-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040305_194542_01F27261 
X-CRM114-Status: GOOD (  26.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In the previous commit a block allocator was added. Now use that block
allocator to allocate blocks for files when ftruncate is run on them.

To do that a inode_operations is added on the file inodes with a getattr
callback handling the ATTR_SIZE attribute. When this is invoked pages
are allocated, the indexes of which are put into a mappings block.
The mappings block is an array with the index being the file offset
block and the value at that index being the pkernfs block backign that
file offset.
---
 fs/pkernfs/Makefile    |  2 +-
 fs/pkernfs/allocator.c | 24 +++++++++++++++++++
 fs/pkernfs/file.c      | 53 ++++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/inode.c     | 27 ++++++++++++++++++---
 fs/pkernfs/pkernfs.h   |  7 ++++++
 5 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 fs/pkernfs/file.c

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index d8b92a74fbc6..e41f06cc490f 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o file.o
diff --git a/fs/pkernfs/allocator.c b/fs/pkernfs/allocator.c
index 1d4aac9c4545..3905ce92b4a9 100644
--- a/fs/pkernfs/allocator.c
+++ b/fs/pkernfs/allocator.c
@@ -25,3 +25,27 @@ void pkernfs_zero_allocations(struct super_block *sb)
 	/* Second page is inode store */
 	set_bit(1, pkernfs_allocations_bitmap(sb));
 }
+
+/*
+ * Allocs one 2 MiB block, and returns the block index.
+ * Index is 2 MiB chunk index.
+ */
+unsigned long pkernfs_alloc_block(struct super_block *sb)
+{
+	unsigned long free_bit;
+
+	/* Allocations is 2nd half of first page */
+	void *allocations_mem = pkernfs_allocations_bitmap(sb);
+	free_bit = bitmap_find_next_zero_area(allocations_mem,
+			PMD_SIZE / 2, /* Size */
+			0, /* Start */
+			1, /* Number of zeroed bits to look for */
+			0); /* Alignment mask - none required. */
+	bitmap_set(allocations_mem, free_bit, 1);
+	return free_bit;
+}
+
+void *pkernfs_addr_for_block(struct super_block *sb, int block_idx)
+{
+	return pkernfs_mem + (block_idx * PMD_SIZE);
+}
diff --git a/fs/pkernfs/file.c b/fs/pkernfs/file.c
new file mode 100644
index 000000000000..27a637423178
--- /dev/null
+++ b/fs/pkernfs/file.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+
+static int truncate(struct inode *inode, loff_t newsize)
+{
+	unsigned long free_block;
+	struct pkernfs_inode *pkernfs_inode;
+	unsigned long *mappings;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(inode->i_sb, inode->i_ino);
+	mappings = (unsigned long *)pkernfs_addr_for_block(inode->i_sb,
+		pkernfs_inode->mappings_block);
+	i_size_write(inode, newsize);
+	for (int block_idx = 0; block_idx * PMD_SIZE < newsize; ++block_idx) {
+		free_block = pkernfs_alloc_block(inode->i_sb);
+		if (free_block <= 0)
+			/* TODO: roll back allocations. */
+			return -ENOMEM;
+		*(mappings + block_idx) = free_block;
+		++pkernfs_inode->num_mappings;
+	}
+	return 0;
+}
+
+static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct iattr *iattr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	error = setattr_prepare(idmap, dentry, iattr);
+	if (error)
+		return error;
+
+	if (iattr->ia_valid & ATTR_SIZE) {
+		error = truncate(inode, iattr->ia_size);
+		if (error)
+			return error;
+	}
+	setattr_copy(idmap, inode, iattr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+const struct inode_operations pkernfs_file_inode_operations = {
+	.setattr = inode_setattr,
+	.getattr = simple_getattr,
+};
+
+const struct file_operations pkernfs_file_fops = {
+	.owner = THIS_MODULE,
+	.iterate_shared = NULL,
+};
diff --git a/fs/pkernfs/inode.c b/fs/pkernfs/inode.c
index f6584c8b8804..7fe4e7b220cc 100644
--- a/fs/pkernfs/inode.c
+++ b/fs/pkernfs/inode.c
@@ -15,14 +15,28 @@ struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int in
 
 struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
 {
+	struct pkernfs_inode *pkernfs_inode;
 	struct inode *inode = iget_locked(sb, ino);
 
 	/* If this inode is cached it is already populated; just return */
 	if (!(inode->i_state & I_NEW))
 		return inode;
-	inode->i_op = &pkernfs_dir_inode_operations;
+	pkernfs_inode = pkernfs_get_persisted_inode(sb, ino);
 	inode->i_sb = sb;
-	inode->i_mode = S_IFREG;
+	if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_DIR) {
+		inode->i_op = &pkernfs_dir_inode_operations;
+		inode->i_mode = S_IFDIR;
+	} else {
+		inode->i_op = &pkernfs_file_inode_operations;
+		inode->i_mode = S_IFREG;
+		inode->i_fop = &pkernfs_file_fops;
+	}
+
+	inode->i_atime = inode->i_mtime = current_time(inode);
+	inode_set_ctime_current(inode);
+	set_nlink(inode, 1);
+
+	/* Switch based on file type */
 	unlock_new_inode(inode);
 	return inode;
 }
@@ -79,6 +93,8 @@ static int pkernfs_create(struct mnt_idmap *id, struct inode *dir,
 	pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino = free_inode;
 	strscpy(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN);
 	pkernfs_inode->flags = PKERNFS_INODE_FLAG_FILE;
+	pkernfs_inode->mappings_block = pkernfs_alloc_block(dir->i_sb);
+	memset(pkernfs_addr_for_block(dir->i_sb, pkernfs_inode->mappings_block), 0, (2 << 20));
 
 	vfs_inode = pkernfs_inode_get(dir->i_sb, free_inode);
 	d_instantiate(dentry, vfs_inode);
@@ -90,6 +106,7 @@ static struct dentry *pkernfs_lookup(struct inode *dir,
 		unsigned int flags)
 {
 	struct pkernfs_inode *pkernfs_inode;
+	struct inode *vfs_inode;
 	unsigned long ino;
 
 	pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino);
@@ -97,7 +114,10 @@ static struct dentry *pkernfs_lookup(struct inode *dir,
 	while (ino) {
 		pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, ino);
 		if (!strncmp(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN)) {
-			d_add(dentry, pkernfs_inode_get(dir->i_sb, ino));
+			vfs_inode = pkernfs_inode_get(dir->i_sb, ino);
+			mark_inode_dirty(dir);
+			dir->i_atime = current_time(dir);
+			d_add(dentry, vfs_inode);
 			break;
 		}
 		ino = pkernfs_inode->sibling_ino;
@@ -146,3 +166,4 @@ const struct inode_operations pkernfs_dir_inode_operations = {
 	.lookup		= pkernfs_lookup,
 	.unlink		= pkernfs_unlink,
 };
+
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 4655780f31f2..8b4fee8c5b2e 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -34,8 +34,15 @@ struct pkernfs_inode {
 };
 
 void pkernfs_initialise_inode_store(struct super_block *sb);
+
 void pkernfs_zero_allocations(struct super_block *sb);
+unsigned long pkernfs_alloc_block(struct super_block *sb);
 struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
+void *pkernfs_addr_for_block(struct super_block *sb, int block_idx);
+
 struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
 
+
 extern const struct file_operations pkernfs_dir_fops;
+extern const struct file_operations pkernfs_file_fops;
+extern const struct inode_operations pkernfs_file_inode_operations;
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
