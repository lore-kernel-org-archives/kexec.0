Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DD4C48291
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6JT4UGyHQh6LSN4DPbDc1cA7AmI9h+AzXBYaEfY9No=; b=wP+9SiuxwtJfTh
	BlmY8ab3DXdiFXeP9bKKg3aLO6xV124xlQbWOupHK0j2qDFyz3QCxzJh4+j8sKeqr7+NuJm9/Sv66
	b5CU63C9k0vwnvToZoheJFGDP5Z66457Zzba91eav2KA3gm8rJuTM3fVYrlLUZxV4Eq3Xs3MtU+b6
	aJgzIk3o4U/JvK3pixiL1MC/qxHb+10faMXW7/ce/YIEJ4oTH7HcHqN74GAM8TD9IZSrBNhg4qed/
	C/zwLTe1bn1fSaYoIGQWS+TRmAabv0q+3mQ29Li1AqenJxnMSD1Jy+s6Na2wFzz0JIC4oizufMP6v
	dJ7pEK5ri6wfCZyLU+VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxix-0000000371g-0vVZ;
	Mon, 05 Feb 2024 12:05:19 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWxit-000000036yg-3nNF
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707134716; x=1738670716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfAwJVvQHyFiTbONYCZnQNlkav6R7SrA1Dbs6XI8844=;
  b=QA+dgP7gcGBP3k8W1XqmzhumMC4yzYGvgC4sW8BhQEj+UvlhIiIHl/ZG
   k8js3voZIaC9jJnhJjxRQWUiECYEdNm7N2kxDk2Ope8BsNbqlL17v27WR
   psUh/jimyS0374bSPPsCMpeInJyGRh5OsqbLc7jHfA56TPgqUyJJ71hgN
   U=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="610940405"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:05:08 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:20056]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.155:2525] with esmtp (Farcaster)
 id 0814e71f-b1b8-4c6d-9ee2-790efdbab159; Mon, 5 Feb 2024 12:05:06 +0000 (UTC)
X-Farcaster-Flow-ID: 0814e71f-b1b8-4c6d-9ee2-790efdbab159
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 12:05:06 +0000
Received: from dev-dsk-jgowans-1a-a3faec1f.eu-west-1.amazon.com
 (172.19.112.191) by EX19D014EUC004.ant.amazon.com (10.252.51.182) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 12:05:00 +0000
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
Subject: [RFC 12/18] pkernfs: Add IOMMU domain pgtables file
Date: Mon, 5 Feb 2024 12:01:57 +0000
Message-ID: <20240205120203.60312-13-jgowans@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.112.191]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_040516_119322_6B3D6DEE 
X-CRM114-Status: GOOD (  25.06  )
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

Similar to the IOMMU root pgtables file which was added in a previous
commit, now support a file type for IOMMU domain pgtables in the IOMMU
directory. These domain pgtable files only need to be useable after the
system has booted up, for example by QEMU creating one of these files
and using it to back the IOMMU pgtables for a persistent VM. As such the
filesystem abstraction can be better maintained here as the kernel code
doesn't need to reach "behind" the filesystem abstraction like it does
for the root pgtables.

A new inode type is created for domain pgtable files, and the IOMMU
directory gets inode_operation callbacks to support creating and
deleting these files in it.

Note: there is a use-after-free risk here too: if the domain pgtable
file is truncated while it's in-use for IOMMU pgtables then freed memory
could still be mapped into the IOMMU. To mitigate this there should be a
machanism to "freeze" the files once they've been given to the IOMMU.
---
 fs/pkernfs/inode.c      |  9 +++++--
 fs/pkernfs/iommu.c      | 55 +++++++++++++++++++++++++++++++++++++++--
 fs/pkernfs/pkernfs.h    |  4 +++
 include/linux/pkernfs.h |  1 +
 4 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/fs/pkernfs/inode.c b/fs/pkernfs/inode.c
index 1d712e0a82a1..35842cd61002 100644
--- a/fs/pkernfs/inode.c
+++ b/fs/pkernfs/inode.c
@@ -35,7 +35,11 @@ struct inode *pkernfs_inode_get(struct super_block *sb, unsigned long ino)
 		inode->i_op = &pkernfs_iommu_dir_inode_operations;
 		inode->i_fop = &pkernfs_dir_fops;
 		inode->i_mode = S_IFDIR;
-	} else if (pkernfs_inode->flags | PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES) {
+	} else if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES) {
+		inode->i_fop = &pkernfs_file_fops;
+		inode->i_mode = S_IFREG;
+	} else if (pkernfs_inode->flags & PKERNFS_INODE_FLAG_IOMMU_DOMAIN_PGTABLES) {
+		inode->i_fop = &pkernfs_file_fops;
 		inode->i_mode = S_IFREG;
 	}
 
@@ -175,6 +179,7 @@ const struct inode_operations pkernfs_dir_inode_operations = {
 };
 
 const struct inode_operations pkernfs_iommu_dir_inode_operations = {
+	.create		= pkernfs_create_iommu_pgtables,
 	.lookup		= pkernfs_lookup,
+	.unlink		= pkernfs_unlink,
 };
-
diff --git a/fs/pkernfs/iommu.c b/fs/pkernfs/iommu.c
index 5bce8146d7bb..f14e76013e85 100644
--- a/fs/pkernfs/iommu.c
+++ b/fs/pkernfs/iommu.c
@@ -4,6 +4,27 @@
 #include <linux/io.h>
 
 
+void pkernfs_alloc_iommu_domain_pgtables(struct file *ppts, struct pkernfs_region *pkernfs_region)
+{
+	struct pkernfs_inode *pkernfs_inode;
+	unsigned long *mappings_block_vaddr;
+	unsigned long inode_idx;
+
+	/*
+	 * For a pkernfs region block, the "mappings_block" field is still
+	 * just a block index, but that block doesn't actually contain mappings
+	 * it contains the pkernfs_region data
+	 */
+
+	inode_idx = ppts->f_inode->i_ino;
+	pkernfs_inode = pkernfs_get_persisted_inode(NULL, inode_idx);
+
+	mappings_block_vaddr = (unsigned long *)pkernfs_addr_for_block(NULL,
+			pkernfs_inode->mappings_block);
+	set_bit(0, mappings_block_vaddr);
+	pkernfs_region->vaddr = mappings_block_vaddr;
+	pkernfs_region->paddr = pkernfs_base + (pkernfs_inode->mappings_block * (2 << 20));
+}
 void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
 {
 	unsigned long *mappings_block_vaddr;
@@ -63,9 +84,8 @@ void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
 	 * just a block index, but that block doesn't actually contain mappings
 	 * it contains the pkernfs_region data
 	 */
-
 	mappings_block_vaddr = (unsigned long *)pkernfs_addr_for_block(NULL,
-		iommu_pgtables->mappings_block);
+			iommu_pgtables->mappings_block);
 	set_bit(0, mappings_block_vaddr);
 	pkernfs_region->vaddr = mappings_block_vaddr;
 	pkernfs_region->paddr = pkernfs_base + (iommu_pgtables->mappings_block * PMD_SIZE);
@@ -88,6 +108,29 @@ void pkernfs_alloc_iommu_root_pgtables(struct pkernfs_region *pkernfs_region)
 		(iommu_pgtables->mappings_block * PMD_SIZE);
 }
 
+int pkernfs_create_iommu_pgtables(struct mnt_idmap *id, struct inode *dir,
+				  struct dentry *dentry, umode_t mode, bool excl)
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
+	pkernfs_inode->flags = PKERNFS_INODE_FLAG_IOMMU_DOMAIN_PGTABLES;
+	pkernfs_inode->mappings_block = pkernfs_alloc_block(dir->i_sb);
+	memset(pkernfs_addr_for_block(dir->i_sb, pkernfs_inode->mappings_block), 0, (2 << 20));
+	vfs_inode = pkernfs_inode_get(dir->i_sb, free_inode);
+	d_add(dentry, vfs_inode);
+	return 0;
+}
+
 void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long paddr)
 {
 	if (WARN_ON(paddr >= region->paddr + region->bytes))
@@ -96,3 +139,11 @@ void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long
 		return NULL;
 	return region->vaddr + (paddr - region->paddr);
 }
+
+bool pkernfs_is_iommu_domain_pgtables(struct file *f)
+{
+	return f &&
+		pkernfs_get_persisted_inode(f->f_inode->i_sb, f->f_inode->i_ino)->flags &
+			PKERNFS_INODE_FLAG_IOMMU_DOMAIN_PGTABLES;
+}
+
diff --git a/fs/pkernfs/pkernfs.h b/fs/pkernfs/pkernfs.h
index e1b7ae3fe7f1..9bea827f8b40 100644
--- a/fs/pkernfs/pkernfs.h
+++ b/fs/pkernfs/pkernfs.h
@@ -21,6 +21,7 @@ struct pkernfs_sb {
 #define PKERNFS_INODE_FLAG_DIR (1 << 1)
 #define PKERNFS_INODE_FLAG_IOMMU_DIR (1 << 2)
 #define PKERNFS_INODE_FLAG_IOMMU_ROOT_PGTABLES (1 << 3)
+#define PKERNFS_INODE_FLAG_IOMMU_DOMAIN_PGTABLES (1 << 4)
 struct pkernfs_inode {
 	int flags;
 	/*
@@ -50,8 +51,11 @@ void *pkernfs_addr_for_block(struct super_block *sb, int block_idx);
 unsigned long pkernfs_allocate_inode(struct super_block *sb);
 struct pkernfs_inode *pkernfs_get_persisted_inode(struct super_block *sb, int ino);
 
+int pkernfs_create_iommu_pgtables(struct mnt_idmap *id, struct inode *dir,
+				  struct dentry *dentry, umode_t mode, bool excl);
 
 extern const struct file_operations pkernfs_dir_fops;
 extern const struct file_operations pkernfs_file_fops;
 extern const struct inode_operations pkernfs_file_inode_operations;
 extern const struct inode_operations pkernfs_iommu_dir_inode_operations;
+extern const struct inode_operations pkernfs_iommu_domain_pgtables_inode_operations;
diff --git a/include/linux/pkernfs.h b/include/linux/pkernfs.h
index 0110e4784109..4ca923ee0d82 100644
--- a/include/linux/pkernfs.h
+++ b/include/linux/pkernfs.h
@@ -33,4 +33,5 @@ void pkernfs_alloc_page_from_region(struct pkernfs_region *pkernfs_region,
 				    void **vaddr, unsigned long *paddr);
 void *pkernfs_region_paddr_to_vaddr(struct pkernfs_region *region, unsigned long paddr);
 
+bool pkernfs_is_iommu_domain_pgtables(struct file *f);
 #endif /* _LINUX_PKERNFS_H */
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
