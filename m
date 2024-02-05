Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CD7C48295
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLBpqH63ItOkn9DVjuzEwoOnT1314+DB2B4PjWc54Q0=; b=q1r5fJ/j9u2kxl
	2al+fH1DwM5gKrAVCHc4OFU/woNgfMiFYxIcsFsJDjgn4xOJbWpNHtx2tVzkCEQYZi1KQw5Rn+D0O
	3dxG3nL4EjeoRyOS+xuvUxd4Wt9FGQNz25+68uyoXJHIQJEDsBf1cW2RgRZbjFyUTRFHUqxBtntJl
	TKL1Fls3JGpwYEP4JFcbkMruvda5MKAddwIboM23Gs3urhrd673oD5/eHXItoei4A1iaHoLHC966q
	3jX9z+Yx+gHtikl2FhxhVVWUdQhrOq05Yycx4ULZsvn86ulo7+cFKhgSitwgDCi4dOPTUOqDvTUe/
	ctbhPOFDkXN6hdLSOWFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgI-000000035qK-48ta;
	Mon, 05 Feb 2024 12:02:34 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgG-000000035oE-11yj
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134553; x=1738670553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulQJ3D4Me8ScxlcztMMDIgEvnR/mGPMynfspToLkF2M=;
  b=seVm9fgfwYgQ2hewAOZd5ul6MZApzyMmk7kewxBV5WgLxdKeq6Dho5Sf
   1ekONp5/1VVxecY8ELpCGuYPm6+kd7C4e7AbsVXuT+tevqWqiCyK0aoPi
   KvB151ouOayRRNXdQE9gc26iG/80BcnuBFJzfTzEHk2nBUh4BgIpyPOVG
   8=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="702145833"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:22 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:59802]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id c85ecf83-e3a4-4c42-963b-1a5c7099c0b7; Mon, 5 Feb 2024 12:02:20 +0000 (UTC)
X-Farcaster-Flow-ID: c85ecf83-e3a4-4c42-963b-1a5c7099c0b7
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:20 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:14 +0000
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
Subject: [RFC 01/18] pkernfs: Introduce filesystem skeleton
Date: Mon, 5 Feb 2024 12:01:46 +0000
Message-ID: <20240205120203.60312-2-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040232_356301_8D4263FC 
X-CRM114-Status: GOOD (  19.94  )
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

Add an in-memory filesystem: pkernfs. Memory is donated to pkernfs by
carving it out of the normal System RAM range with the memmap= cmdline
parameter and then giving that same physical range to pkernfs with the
pkernfs= cmdline parameter.

A new filesystem is added; so far it doesn't do much except persist a
super block at the start of the donated memory and allows itself to be
mounted.
---
 fs/Kconfig           |  1 +
 fs/Makefile          |  3 ++
 fs/pkernfs/Kconfig   |  9 ++++
 fs/pkernfs/Makefile  |  6 +++
 fs/pkernfs/pkernfs.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.h |  6 +++
 6 files changed, 124 insertions(+)
 create mode 100644 fs/pkernfs/Kconfig
 create mode 100644 fs/pkernfs/Makefile
 create mode 100644 fs/pkernfs/pkernfs.c
 create mode 100644 fs/pkernfs/pkernfs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index aa7e03cc1941..33a9770ae657 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -331,6 +331,7 @@ source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/pkernfs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index f9541f40be4e..1af35b494b5d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -19,6 +19,9 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
+
+obj-y += pkernfs/
+
 obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/pkernfs/Kconfig b/fs/pkernfs/Kconfig
new file mode 100644
index 000000000000..59621a1d9aef
--- /dev/null
+++ b/fs/pkernfs/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PKERNFS_FS
+	bool "Persistent Kernel filesystem (pkernfs)"
+	help
+	  An in-memory filesystem on top of reserved memory specified via
+	  pkernfs= cmdline argument.  Used for storing kernel state and
+	  userspace memory which is preserved across kexec to support
+	  live update.
diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
new file mode 100644
index 000000000000..17258cb77f58
--- /dev/null
+++ b/fs/pkernfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for persistent kernel filesystem
+#
+
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
new file mode 100644
index 000000000000..4c476ddc35b6
--- /dev/null
+++ b/fs/pkernfs/pkernfs.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/fs_context.h>
+#include <linux/io.h>
+
+static phys_addr_t pkernfs_base, pkernfs_size;
+static void *pkernfs_mem;
+static const struct super_operations pkernfs_super_ops = { };
+
+static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	struct pkernfs_sb *psb;
+
+	pkernfs_mem = memremap(pkernfs_base, pkernfs_size, MEMREMAP_WB);
+	psb = (struct pkernfs_sb *) pkernfs_mem;
+
+	if (psb->magic_number == PKERNFS_MAGIC_NUMBER) {
+		pr_info("pkernfs: Restoring from super block\n");
+	} else {
+		pr_info("pkernfs: Clean super block; initialising\n");
+		psb->magic_number = PKERNFS_MAGIC_NUMBER;
+	}
+
+	sb->s_op = &pkernfs_super_ops;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_atime = inode->i_mtime = current_time(inode);
+	inode_set_ctime_current(inode);
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+
+	dentry = d_make_root(inode);
+	if (!dentry)
+		return -ENOMEM;
+	sb->s_root = dentry;
+
+	return 0;
+}
+
+static int pkernfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, pkernfs_fill_super);
+}
+
+static const struct fs_context_operations pkernfs_context_ops = {
+	.get_tree	= pkernfs_get_tree,
+};
+
+static int pkernfs_init_fs_context(struct fs_context *const fc)
+{
+	fc->ops = &pkernfs_context_ops;
+	return 0;
+}
+
+static struct file_system_type pkernfs_fs_type = {
+	.owner                  = THIS_MODULE,
+	.name                   = "pkernfs",
+	.init_fs_context        = pkernfs_init_fs_context,
+	.kill_sb                = kill_litter_super,
+	.fs_flags               = FS_USERNS_MOUNT,
+};
+
+static int __init pkernfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&pkernfs_fs_type);
+	return ret;
+}
+
+/**
+ * Format: pkernfs=<size>:<base>
+ * Just like: memmap=nn[KMG]!ss[KMG]
+ */
+static int __init parse_pkernfs_extents(char *p)
+{
+	pkernfs_size = memparse(p, &p);
+	p++; /* Skip over ! char */
+	pkernfs_base = memparse(p, &p);
+	return 0;
+}
+
+early_param("pkernfs", parse_pkernfs_extents);
+
+MODULE_ALIAS_FS("pkernfs");
+module_init(pkernfs_init);
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
new file mode 100644
index 000000000000..bd1e2a6fd336
--- /dev/null
+++ b/fs/pkernfs/pkernfs.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define PKERNFS_MAGIC_NUMBER 0x706b65726e6673
+struct pkernfs_sb {
+	unsigned long magic_number;
+};
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
