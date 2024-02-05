Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC3C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FegBT7JeKORnVBue0nBr2RwIf8WtZCCDLams4TVUuu4=; b=KSviuwh3C80OEp
	v8DpyWz4NdQ8Ld6R72mrFk2PVbO5p0xPVwRdkfeGPbqSMxnGPiUw+xEYHpxDRDnOEOvL4OWFpKw0x
	vcUGIfpI6FZr/BWJQ/UJImd8leiRr1naPgCea0tPGt2eWMe+3uBnXv2kTpjc72qq4Yly32lKV5BMP
	G3J4m49dsb7FN8v6ExEGXpljCwhF0j+MwdBWXpG2vA4prtFnxI0ux8a0T8NiMl8T6TXiIloMTcYdQ
	WVrsN6pml4eFiUxTLw+xHcsI3cEmUc7E1jKN+9EuVF9dgTirKv6eJu/1X+MmlknPG2JppCQ2LnMZL
	A89ALaoeXDmpnVOi5wvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxh0-000000036Cs-3iJR;
	Mon, 05 Feb 2024 12:03:18 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxgx-0000000368e-30zI
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134596; x=1738670596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0/oASfY5H1JyciZlNLWYHif+Zbb5czst+5Ds70M97DI=;
  b=as8xu0PnpM5xmgWe5KRejEIV4bUzP5LAMhjAy80PEcm7B1FIhM+jaScv
   dK8l7c2T0LqUv59zzRwHXKV3UDqCgLmP1meEIlxTXVCeKcrMBByLGFLKM
   R1HuUbq1NHuYtOlU1o8B9oaIVjlXXVQPRsAz0lr31qGVDH4VUW8ctliaB
   g=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="632119672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:03:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:5859]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.207:2525] with esmtp (Farcaster)
 id 80b5446f-c47d-4e7f-ae7e-e8668aadf81b; Mon, 5 Feb 2024 12:03:10 +0000 (UTC)
X-Farcaster-Flow-ID: 80b5446f-c47d-4e7f-ae7e-e8668aadf81b
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:03:10 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:03:03 +0000
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
Subject: [RFC 05/18] pkernfs: add file mmap callback
Date: Mon, 5 Feb 2024 12:01:50 +0000
Message-ID: <20240205120203.60312-6-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040316_094995_9486B9B2 
X-CRM114-Status: GOOD (  21.16  )
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

Make the file data useable to userspace by adding mmap. That's all that
QEMU needs for guest RAM, so that's all be bother implementing for now.

When mmaping the file the VMA is marked as PFNMAP to indicate that there
are no struct pages for the memory in this VMA. Remap_pfn_range() is
used to actually populate the page tables. All PTEs are pre-faulted into
the pgtables at mmap time so that the pgtables are useable when this
virtual address range is given to VFIO's MAP_DMA.
---
 fs/pkernfs/file.c    | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/pkernfs/pkernfs.c |  2 +-
 fs/pkernfs/pkernfs.h |  2 ++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/pkernfs/file.c b/fs/pkernfs/file.c
index 27a637423178..844b6cc63840 100644
--- a/fs/pkernfs/file.c
+++ b/fs/pkernfs/file.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "pkernfs.h"
+#include <linux/mm.h>
 
 static int truncate(struct inode *inode, loff_t newsize)
 {
@@ -42,6 +43,45 @@ static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct
 	return 0;
 }
 
+/*
+ * To be able to use PFNMAP VMAs for VFIO DMA mapping we need the page tables
+ * populated with mappings. Pre-fault everything.
+ */
+static int mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int rc;
+	unsigned long *mappings_block;
+	struct pkernfs_inode *pkernfs_inode;
+
+	pkernfs_inode = pkernfs_get_persisted_inode(filp->f_inode->i_sb, filp->f_inode->i_ino);
+
+	mappings_block = (unsigned long *)pkernfs_addr_for_block(filp->f_inode->i_sb,
+			pkernfs_inode->mappings_block);
+
+	/* Remap-pfn-range will mark the range VM_IO */
+	for (unsigned long vma_addr_offset = vma->vm_start;
+			vma_addr_offset < vma->vm_end;
+			vma_addr_offset += PMD_SIZE) {
+		int block, mapped_block;
+
+		block = (vma_addr_offset - vma->vm_start) / PMD_SIZE;
+		mapped_block = *(mappings_block + block);
+		/*
+		 * It's wrong to use rempa_pfn_range; this will install PTE-level entries.
+		 * The whole point of 2 MiB allocs is to improve TLB perf!
+		 * We should use something like mm/huge_memory.c#insert_pfn_pmd
+		 * but that is currently static.
+		 * TODO: figure out the best way to install PMDs.
+		 */
+		rc = remap_pfn_range(vma,
+				vma_addr_offset,
+				(pkernfs_base >> PAGE_SHIFT) + (mapped_block * 512),
+				PMD_SIZE,
+				vma->vm_page_prot);
+	}
+	return 0;
+}
+
 const struct inode_operations pkernfs_file_inode_operations = {
 	.setattr = inode_setattr,
 	.getattr = simple_getattr,
@@ -49,5 +89,5 @@ const struct inode_operations pkernfs_file_inode_operations = {
 
 const struct file_operations pkernfs_file_fops = {
 	.owner = THIS_MODULE,
-	.iterate_shared = NULL,
+	.mmap = mmap,
 };
diff --git a/fs/pkernfs/pkernfs.c b/fs/pkernfs/pkernfs.c
index 199c2c648bca..f010c2d76c76 100644
--- a/fs/pkernfs/pkernfs.c
+++ b/fs/pkernfs/pkernfs.c
@@ -7,7 +7,7 @@
 #include <linux/fs_context.h>
 #include <linux/io.h>
 
-static phys_addr_t pkernfs_base, pkernfs_size;
+phys_addr_t pkernfs_base, pkernfs_size;
 void *pkernfs_mem;
 static const struct super_operations pkernfs_super_ops = { };
 
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index 8b4fee8c5b2e..1a7aa783a9be 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -6,6 +6,8 @@
 #define PKERNFS_FILENAME_LEN 255
 
 extern void *pkernfs_mem;
+/* Units of bytes */
+extern phys_addr_t pkernfs_base, pkernfs_size;
 
 struct pkernfs_sb {
 	unsigned long magic_number;
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
