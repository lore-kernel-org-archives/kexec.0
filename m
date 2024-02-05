Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0602C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+i5f70MT/0rATbiAWMFKS0Cvh6iamLPwZl80iwSMXw0=; b=YlRD2eU6EGDZCl
	8D4+Y3QwqojMjJgb5GgNz3F6KKMXPCrDwE4ljqPAJfDoR6XImmId7GqQKL2WImydRadYOrmXMBS6b
	bxS50yH0tT8Fm1AtLHKo4hOIgGwyRd7ee+jenU+tpaOrJvlq2tNYFJdds+Fx5nyWkMwoPE4VwqaVc
	xNh4uuLvn8TYy7UVcjSMd3mQZtoch3enNOwRA9kxbgrB8FdD4TLTA0HEeuwSnHhK+RQGqqcvidvtd
	QRuxoqT59pSFS6MskKCsaTbhTsLWrh0iEuBUVWJn9XUlkj37mdSJs5j99z0oN2bpXBq1AWSW5KSS2
	WrQmZ3e96Y6QSIvj6r4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgo-0000000364L-2cVl;
	Mon, 05 Feb 2024 12:03:06 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgl-00000003620-1KaQ
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134583; x=1738670583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09HM9kCtJQ5fhByhNyO/r0il26Ag7KNxaSp1FSa3SKw=;
  b=IZEtQD3iEeyS0Re0Pyw3VNRrgbw/7v5PWTij2tONTNIkdmGQWIURDlJV
   AkbHYrz8rD6HKKGerPcJ/A1LA9MvC0UWiqrz3Y3h2sE+EJyeKz5AJ5i8K
   noxQadX5rt71l526lc4eMlc3fIsqxFrBRmMef9FRHLeStxN7b32R2YxiE
   4=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63755246"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:02:58 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:37383]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.186:2525] with esmtp (Farcaster)
 id 0e22be1f-cb32-4c25-b8b9-6a540783cffe; Mon, 5 Feb 2024 12:02:57 +0000 (UTC)
X-Farcaster-Flow-ID: 0e22be1f-cb32-4c25-b8b9-6a540783cffe
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:02:57 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:02:50 +0000
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
Subject: [RFC 03/18] pkernfs: Define an allocator for persistent pages
Date: Mon, 5 Feb 2024 12:01:48 +0000
Message-ID: <20240205120203.60312-4-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040303_426218_4F44F9D7 
X-CRM114-Status: GOOD (  19.39  )
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

This introduces the concept of a bitmap allocator for pages from the
pkernfs filesystem. The allocation bitmap is stored in the second half
of the first page. This imposes an artificial limit of the maximum size
of the filesystem; this needs to be made extensible.

The allocations can be zeroed, that's it so far. The next commit will
add the ability to allocate and use it.
---
 fs/pkernfs/Makefile    |  2 +-
 fs/pkernfs/allocator.c | 27 +++++++++++++++++++++++++++
 fs/pkernfs/pkernfs.c   |  1 +
 fs/pkernfs/pkernfs.h   |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 fs/pkernfs/allocator.c

diff --git a/fs/pkernfs/Makefile b/fs/pkernfs/Makefile
index 0a66e98bda07..d8b92a74fbc6 100644
--- a/fs/pkernfs/Makefile
+++ b/fs/pkernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for persistent kernel filesystem
 #
 
-obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o dir.o
+obj-$(CONFIG_PKERNFS_FS) += pkernfs.o inode.o allocator.o dir.o
diff --git a/fs/pkernfs/allocator.c b/fs/pkernfs/allocator.c
new file mode 100644
index 000000000000..1d4aac9c4545
--- /dev/null
+++ b/fs/pkernfs/allocator.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "pkernfs.h"
+
+/**
+ * For allocating blocks from the pkernfs filesystem.
+ * The first two blocks are special:
+ * - the first block is persitent filesystme metadata and
+ *   a bitmap of allocated blocks
+ * - the second block is an array of persisted inodes; the
+ *   inode store.
+ */
+
+void *pkernfs_allocations_bitmap(struct super_block *sb)
+{
+	/* Allocations is 2nd half of first block */
+	return pkernfs_mem + (1 << 20);
+}
+
+void pkernfs_zero_allocations(struct super_block *sb)
+{
+	memset(pkernfs_allocations_bitmap(sb), 0, (1 << 20));
+	/* First page is persisted super block and allocator bitmap */
+	set_bit(0, pkernfs_allocations_bitmap(sb));
+	/* Second page is inode store */
+	set_bit(1, pkernfs_allocations_bitmap(sb));
+}
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 518c610e3877..199c2c648bca 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -25,6 +25,7 @@ static int pkernfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	} else {
 		pr_info("pkernfs: Clean super block; initialising\n");
 		pkernfs_initialise_inode_store(sb);
+		pkernfs_zero_allocations(sb);
 		psb->magic_number = PKERNFS_MAGIC_NUMBER;
 		pkernfs_get_persisted_inode(sb, 1)->flags = PKERNFS_INODE_FLAG_DIR;
 		strscpy(pkernfs_get_persisted_inode(sb, 1)->filename, ".", PKERNFS_FILENAME_LEN);
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 192e089b3151..4655780f31f2 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -34,6 +34,7 @@ struct pkernfs_inode {
 };
 
 void pkernfs_initialise_inode_store(struct super_block *sb);
+void pkernfs_zero_allocations(struct super_block *sb);
 struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino);
 struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
 
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
