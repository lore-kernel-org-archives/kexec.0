Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D20C48298
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oUVfJk8PSxWw9dIvbRudToqJTg7pFtnV+xhRFpt85ZA=; b=l+kP404f1UJ/Sx
	upL4fu5dKn9CXNAfaKrq+nEBMzPqun7vD+5/0xGoRH8kKvlFTioAT6gmdx3uEmOuCll/aDSH6OgUw
	Uw9DaGai9nRiu/CiO4OapgUYvZjn7M/xsr2Te0L9GN6n5zo3dmyLlkdYvRyAn//TDBeLZ8tD2YY/M
	IiSIyh2nwvKru2MyN459Wi/OIUYcFLIIuFq6VaJ+ERgnN7Oa6zqBoEeDI/sCad6BpsODqUZwZUk10
	JegOBFeFhHATbykDaLnvMsB+ERupc3Vi42AT9Zi7PKi4OJrArEVsuBQpARXf4mX4HQ2YStLui68Ts
	4+QNHSH80DED+bF8J0fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgK-000000035rq-3EBJ;
	Mon, 05 Feb 2024 12:02:36 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgG-000000035oG-2QW1
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:02:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134553; x=1738670553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNmTqGFg0B4wwqijKuh2wndJnn1CFCRShUGGQJLOmFw=;
  b=Nshw4kSKCe1n/oV17hGu3tSGCSYOlOBEV2RkSq4OtVHjNUqJLR+/Usx2
   8+lZTblFv9h8YKwd7tzlJb9rtcHH/67moul2z4pIrjAjBO983j4tnenj8
   Talzul/AKNzwAkw0t/7UnSjGoOK9fyVI8WkY32LXA0GXAuHeg2pZba/o/
   4=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="271936637"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:28 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:3818]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.186:2525] with esmtp (Farcaster)
 id e767a7b8-4373-41b8-af32-a81e33b618aa; Mon, 5 Feb 2024 12:02:27 +0000 (UTC)
X-Farcaster-Flow-ID: e767a7b8-4373-41b8-af32-a81e33b618aa
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:26 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:20 +0000
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
Subject: [RFC 02/18] pkernfs: Add persistent inodes hooked into directies
Date: Mon, 5 Feb 2024 12:01:47 +0000
Message-ID: <20240205120203.60312-3-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040232_730862_8B9C112C 
X-CRM114-Status: GOOD (  34.62  )
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

Add the ability to create inodes for files and directories inside
directories. Inodes are persistent in the in-memory filesystem; the
second 2 MiB is used as an "inode store." The inode store is one big array
of struct pkernfs_inodes and they use a linked list to point to the next
sibling inode or in the case of a directory the child inode which is the
first inode in that directory.

Free inodese are similarly maintained in a linked list with the first
free inode being pointed to by the super block.

Directory file_operations are added to support iterating through the
content of a directory.

Simiarly inode operations are added to support creating a file inside a
directory. This allocate the next free inode and makes it the head of
tthe "child inode" linked list for the directory. Unlink is implemented
to remove an inode from the linked list. This is a bit finicky as it is
done differently depending on whether the inode is the first child of a
directory or somewhere later in the linked list.
---
 fs/pkernfs/Makefile  |   2 +-
 fs/pkernfs/dir.c     |  43 +++++++++++++
 fs/pkernfs/inode.c   | 148 +++++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c |  13 ++--
 fs/pkernfs/pkernfs.h |  34 ++++++++++
 5 files changed, 234 insertions(+), 6 deletions(-)
 create mode 100644 fs/pkernfs/dir.c
 create mode 100644 fs/pkernfs/inode.c

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index 17258cb77f58..0a66e98bda07 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o dir.o
diff --git a/fs/pkernfs/dir.c b/fs/pkernfs/dir.c
new file mode 100644
index 000000000000..b10ce745f19d
--- /dev/null
+++ b/fs/pkernfs/dir.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+
+static int pkernfs_dir_iterate(struct file *dir, struct dir_context *ctx)
+{
+	struct pkernfs_inode *pkernfs_inode;
+	struct super_block *sb = dir->f_inode->i_sb;
+
+	/* Indication from previous invoke that there's no more to iterate. */
+	if (ctx->pos == -1)
+		return 0;
+
+	if (!dir_emit_dots(dir, ctx))
+		return 0;
+
+	/*
+	 * Just emitted this dir; go to dir contents. Use pos to smuggle
+	 * the next inode number to emit across iterations.
+	 * -1 indicates no valid inode. Can't use 0 because first loop has pos=0
+	 */
+	if (ctx->pos == 2) {
+		ctx->pos = pkernfs_get_persisted_inode(sb, dir->f_inode->i_ino)->child_ino;
+		/* Empty dir case. */
+		if (ctx->pos == 0)
+			ctx->pos = -1;
+	}
+
+	while (ctx->pos > 1) {
+		pkernfs_inode = pkernfs_get_persisted_inode(sb, ctx->pos);
+		dir_emit(ctx, pkernfs_inode->filename, PKERNFS_FILENAME_LEN,
+				ctx->pos, DT_UNKNOWN);
+		ctx->pos = pkernfs_inode->sibling_ino;
+		if (!ctx->pos)
+			ctx->pos = -1;
+	}
+	return 0;
+}
+
+const struct file_operations pkernfs_dir_fops = {
+	.owner = THIS_MODULE,
+	.iterate_shared = pkernfs_dir_iterate,
+};
diff --git a/fs/pkernfs/inode.c b/fs/pkernfs/inode.c
new file mode 100644
index 000000000000..f6584c8b8804
--- /dev/null
+++ b/fs/pkernfs/inode.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+#include <linux/fs.h>
+
+const struct inode_operations pkernfs_dir_inode_operations;
+
+struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino)
+{
+	/*
+	 * Inode index starts at 1, so -1 to get memory index.
+	 */
+	return ((struct pkernfs_inode *) (pkernfs_mem + PMD_SIZE)) + ino - 1;
+}
+
+struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
+{
+	struct inode *inode = iget_locked(sb, ino);
+
+	/* If this inode is cached it is already populated; just return */
+	if (!(inode->i_state & I_NEW))
+		return inode;
+	inode->i_op = &pkernfs_dir_inode_operations;
+	inode->i_sb = sb;
+	inode->i_mode = S_IFREG;
+	unlock_new_inode(inode);
+	return inode;
+}
+
+static unsigned long pkernfs_allocate_inode(struct super_block *sb)
+{
+
+	unsigned long next_free_ino;
+	struct pkernfs_sb *psb = (struct pkernfs_sb *) pkernfs_mem;
+
+	next_free_ino = psb->next_free_ino;
+	if (!next_free_ino)
+		return -ENOMEM;
+	psb->next_free_ino =
+		pkernfs_get_persisted_inode(sb, next_free_ino)->sibling_ino;
+	return next_free_ino;
+}
+
+/*
+ * Zeroes the inode and makes it the head of the free list.
+ */
+static void pkernfs_free_inode(struct super_block *sb, unsigned long ino)
+{
+	struct pkernfs_sb *psb = (struct pkernfs_sb *) pkernfs_mem;
+	struct pkernfs_inode *inode = pkernfs_get_persisted_inode(sb, ino);
+
+	memset(inode, 0, sizeof(struct pkernfs_inode));
+	inode->sibling_ino = psb->next_free_ino;
+	psb->next_free_ino = ino;
+}
+
+void pkernfs_initialise_inode_store(struct super_block *sb)
+{
+	/* Inode store is a PMD sized (ie: 2 MiB) page */
+	memset(pkernfs_get_persisted_inode(sb, 1), 0, PMD_SIZE);
+	/* Point each inode for the next one; linked-list initialisation. */
+	for (unsigned long ino = 2; ino * sizeof(struct pkernfs_inode) < PMD_SIZE; ino++)
+		pkernfs_get_persisted_inode(sb, ino - 1)->sibling_ino = ino;
+}
+
+static int pkernfs_create(struct mnt_idmap *id, struct inode *dir,
+			  struct dentry *dentry, umode_t mode, bool excl)
+{
+	unsigned long free_inode;
+	struct pkernfs_inode *pkernfs_inode;
+	struct inode *vfs_inode;
+
+	free_inode = pkernfs_allocate_inode(dir->i_sb);
+	if (free_inode <= 0)
+		return -ENOMEM;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, free_inode);
+	pkernfs_inode->sibling_ino = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+	pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino = free_inode;
+	strscpy(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN);
+	pkernfs_inode->flags = PKERNFS_INODE_FLAG_FILE;
+
+	vfs_inode = pkernfs_inode_get(dir->i_sb, free_inode);
+	d_instantiate(dentry, vfs_inode);
+	return 0;
+}
+
+static struct dentry *pkernfs_lookup(struct inode *dir,
+		struct dentry *dentry,
+		unsigned int flags)
+{
+	struct pkernfs_inode *pkernfs_inode;
+	unsigned long ino;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino);
+	ino = pkernfs_inode->child_ino;
+	while (ino) {
+		pkernfs_inode = pkernfs_get_persisted_inode(dir->i_sb, ino);
+		if (!strncmp(pkernfs_inode->filename, dentry->d_name.name, PKERNFS_FILENAME_LEN)) {
+			d_add(dentry, pkernfs_inode_get(dir->i_sb, ino));
+			break;
+		}
+		ino = pkernfs_inode->sibling_ino;
+	}
+	return NULL;
+}
+
+static int pkernfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	unsigned long ino;
+	struct pkernfs_inode *inode;
+
+	ino = pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino;
+
+	/* Special case for first file in dir */
+	if (ino == dentry->d_inode->i_ino) {
+		pkernfs_get_persisted_inode(dir->i_sb, dir->i_ino)->child_ino =
+			pkernfs_get_persisted_inode(dir->i_sb, dentry->d_inode->i_ino)->sibling_ino;
+		pkernfs_free_inode(dir->i_sb, ino);
+		return 0;
+	}
+
+	/*
+	 * Although we know exactly the inode to free, because we maintain only
+	 * a singly linked list we need to scan for it to find the previous
+	 * element so it's "next" pointer can be updated.
+	 */
+	while (ino) {
+		inode = pkernfs_get_persisted_inode(dir->i_sb, ino);
+		/* We've found the one pointing to the one we want to delete */
+		if (inode->sibling_ino == dentry->d_inode->i_ino) {
+			inode->sibling_ino =
+				pkernfs_get_persisted_inode(dir->i_sb,
+						dentry->d_inode->i_ino)->sibling_ino;
+			pkernfs_free_inode(dir->i_sb, dentry->d_inode->i_ino);
+			break;
+		}
+		ino = pkernfs_get_persisted_inode(dir->i_sb, ino)->sibling_ino;
+	}
+
+	return 0;
+}
+
+const struct inode_operations pkernfs_dir_inode_operations = {
+	.create		= pkernfs_create,
+	.lookup		= pkernfs_lookup,
+	.unlink		= pkernfs_unlink,
+};
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 4c476ddc35b6..518c610e3877 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -8,7 +8,7 @@
 #include <linux/io.h>
 
 static phys_addr_t pkernfs_base, pkernfs_size;
-static void *pkernfs_mem;
+void *pkernfs_mem;
 static const struct super_operations pkernfs_super_ops = { };
 
 static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -24,23 +24,26 @@ static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		pr_info("pkernfs: Restoring from super block\n");
 	} else {
 		pr_info("pkernfs: Clean super block; initialising\n");
+		pkernfs_initialise_inode_store(sb);
 		psb->magic_number = PKERNFS_MAGIC_NUMBER;
+		pkernfs_get_persisted_inode(sb, 1)->flags = PKERNFS_INODE_FLAG_DIR;
+		strscpy(pkernfs_get_persisted_inode(sb, 1)->filename, ".", PKERNFS_FILENAME_LEN);
+		psb->next_free_ino = 2;
 	}
 
 	sb->s_op = &pkernfs_super_ops;
 
-	inode = new_inode(sb);
+	inode = pkernfs_inode_get(sb, 1);
 	if (!inode)
 		return -ENOMEM;
 
-	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR;
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
+	inode->i_fop = &pkernfs_dir_fops;
 	inode->i_atime = inode->i_mtime = current_time(inode);
 	inode_set_ctime_current(inode);
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
+	inode_init_owner(&nop_mnt_idmap, inode, NULL, inode->i_mode);
 
 	dentry = d_make_root(inode);
 	if (!dentry)
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index bd1e2a6fd336..192e089b3151 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -1,6 +1,40 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#include <linux/fs.h>
+
 #define PKERNFS_MAGIC_NUMBER 0x706b65726e6673
+#define PKERNFS_FILENAME_LEN 255
+
+extern void *pkernfs_mem;
+
 struct pkernfs_sb {
 	unsigned long magic_number;
+	/* Inode number */
+	unsigned long next_free_ino;
 };
+
+// If neither of these are set the inode is not in use.
+#define PKERNFS_INODE_FLAG_FILE (1 << 0)
+#define PKERNFS_INODE_FLAG_DIR (1 << 1)
+struct pkernfs_inode {
+	int flags;
+	/*
+	 * Points to next inode in the same directory, or
+	 * 0 if last file in directory.
+	 */
+	unsigned long sibling_ino;
+	/*
+	 * If this inode is a directory, this points to the
+	 * first inode *in* that directory.
+	 */
+	unsigned long child_ino;
+	char filename[PKERNFS_FILENAME_LEN];
+	int mappings_block;
+	int num_mappings;
+};
+
+void pkernfs_initialise_inode_store(struct super_block *sb);
+struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
+struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
+
+extern const struct file_operations pkernfs_dir_fops;
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
