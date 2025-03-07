Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D38C282EC
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 01:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Us+2oflLvLaA9Q+lohHm25RujTrS6yw5N7o3L4t/IOc=; b=jvVYHFl+c3xweszlQnXZ20U/xI
	LoU6v0svkmUORIiTGfeT7D5GobcO0QjGdxt0p+b9XrnS/FsZiOvv4FysLoEEojXjzdyVnhE3hyxmu
	3mSYbtdaQgjGfeNj16igrtZbs7xSXcGVr1+rtKNK7YqwZEmmIAqzr6AZJWJi6V+o2GiY6QF/MJnXh
	7D6VmcLhTgArpZQvSNHNn1Eix8Y4ukS0RJu+nZlIrwu1Nxz013EU9VIJclyoODHAnNvBWjMCz+J8D
	Ua5RWlCPKvDIaC0Ny6AUIgylwixI05PuF9ft0yQJICvzNluaXmX5ul6QsWHhoIkNildUCMTlci4xq
	1RdBX6yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqMUq-0000000CnOo-2mo2;
	Fri, 07 Mar 2025 01:27:28 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqM2w-0000000CiGz-1ljB
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 00:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309118; x=1772845118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Us+2oflLvLaA9Q+lohHm25RujTrS6yw5N7o3L4t/IOc=;
  b=sHT4RbJvinCqc+EOPRR/mW8SrFgzVAoAieuHQKlHwvgDSafb1k63SLz8
   /zWtBX/l0Dz9n/DmW6PuzINXfEeJ3LLtR5U3OE+b3fIVrYxeWyHc8kqO0
   ZDsiAeLd1KLOJkM7JhLPqTHbEoxZ6cOXTE4G19PHX7GlqgTm6xU6UZO6V
   k=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="29275899"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:32828]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 9eec1440-3b96-4a48-a704-b02f65525c99; Fri, 7 Mar 2025 00:58:34 +0000 (UTC)
X-Farcaster-Flow-ID: 9eec1440-3b96-4a48-a704-b02f65525c99
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:33 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTP id 4FF9A401E0;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0F4D14FF6; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 4/5] mm: shmem: allow preserving file over FDBOX + KHO
Date: Fri, 7 Mar 2025 00:57:38 +0000
Message-ID: <20250307005830.65293-5-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_165838_517449_6118B40D 
X-CRM114-Status: GOOD (  30.81  )
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

For applications with a large amount of memory that takes time to
rebuild, reboots to consume kernel upgrades can be very expensive. FDBox
allows preserving file descriptors over kexec using KHO. Combining that
with memfd gives those applications reboot-persistent memory that they
can use to quickly save and reconstruct that state.

Since memfd is backed either by hugetlbfs or shmem, use shmem as the
first backend for memfd that is FDBOX + KHO capable.

To preserve the file's contents during KHO activation, the file's page
cache must be walked and all entries removed, and their indices stored.
Use the newly introduced shmem_undo_range_ops to achieve this. Walk each
entry and before truncating it, take a refcount on the folio so it does
not get freed, and store its physical address and index in the kho_mem
and indices arrays.

Swap pages, partial folios, and huge folios are not supported yet.
Encountering those results in an error.

On the restore side, an empty file is created and then the mems array
walked to insert the pages into the page cache. The logic in
shmem_alloc_and_add_folio() is roughly followed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 include/linux/shmem_fs.h |   6 +
 mm/shmem.c               | 333 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 339 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0b273a7b9f01d..263416f357fe1 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -205,6 +205,12 @@ extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+bool is_node_shmem(const void *fdt, int offset);
+int shmem_fdbox_kho_write(struct fdbox_fd *ffd, void *fdt);
+struct file *shmem_fdbox_kho_recover(const void *fdt, int offset);
+#endif
+
 /*
  * Used space is stored as unsigned 64-bit value in bytes but
  * quota core supports only signed 64-bit values so use that
diff --git a/mm/shmem.c b/mm/shmem.c
index d6d9266b27b75..c2efdb34a1a18 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -41,6 +41,12 @@
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/libfdt.h>
+#include <linux/fdbox.h>
+#include <linux/vmalloc.h>
+#include <linux/kexec.h>
+#include <linux/kexec_handover.h>
+#include <linux/cleanup.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
@@ -5283,6 +5289,333 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 	return 0;
 }
 
+#if defined(CONFIG_FDBOX) && defined(CONFIG_KEXEC_HANDOVER)
+static const char fdbox_kho_compatible[] = "fdbox,shmem-v1";
+
+bool is_node_shmem(const void *fdt, int offset)
+{
+	return fdt_node_check_compatible(fdt, offset, fdbox_kho_compatible) == 0;
+}
+
+struct shmem_fdbox_put_arg {
+	struct kho_mem *mems;
+	unsigned long *indices;
+	unsigned long nr_mems;
+	unsigned long idx;
+};
+
+static long shmem_fdbox_undo_swap(struct address_space *mapping, pgoff_t index,
+				  void *old, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static int shmem_fdbox_undo_folio(struct address_space *mapping,
+				  struct folio *folio, void *__arg)
+{
+	struct shmem_fdbox_put_arg *arg = __arg;
+	struct kho_mem *mem;
+
+	if (arg->idx == arg->nr_mems)
+		return -ENOSPC;
+
+	if (folio_nr_pages(folio) != 1)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Grab an extra refcount to the folio so it sticks around after
+	 * truncation.
+	 */
+	folio_get(folio);
+
+	mem = arg->mems + arg->idx;
+
+	mem->addr = PFN_PHYS(folio_pfn(folio));
+	mem->size = PAGE_SIZE;
+	arg->indices[arg->idx] = folio_index(folio);
+	arg->idx++;
+
+	truncate_inode_folio(mapping, folio);
+	return 0;
+}
+
+static int shmem_fdbox_undo_partial_folio(struct folio *folio, pgoff_t lstart,
+					  pgoff_t lend, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct shmem_undo_range_ops shmem_fdbox_undo_ops = {
+	.undo_swap = shmem_fdbox_undo_swap,
+	.undo_folio = shmem_fdbox_undo_folio,
+	.undo_partial_folio = shmem_fdbox_undo_partial_folio,
+};
+
+static struct kho_mem *shmem_fdbox_kho_get_mems(struct inode *inode,
+						unsigned long **indicesp,
+						unsigned long *nr)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	unsigned long *indices __free(kvfree) = NULL;
+	struct kho_mem *mems __free(kvfree) = NULL;
+	struct shmem_fdbox_put_arg arg;
+	unsigned long nr_mems;
+	int ret, i;
+
+	scoped_guard(spinlock, &info->lock) {
+		/* TODO: Support swapped pages. Perhaps swap them back in? */
+		if (info->swapped)
+			return ERR_PTR(-EOPNOTSUPP);
+
+		/*
+		 * Estimate the size of the array using the size of the inode,
+		 * assuming there are no contiguous pages.
+		 */
+		nr_mems = info->alloced;
+	}
+
+	mems = kvmalloc_array(nr_mems, sizeof(*mems), GFP_KERNEL);
+	if (!mems)
+		return ERR_PTR(-ENOMEM);
+
+	indices = kvmalloc_array(nr_mems, sizeof(*indices), GFP_KERNEL);
+	if (!indices)
+		return ERR_PTR(-ENOMEM);
+
+	arg.mems = mems;
+	arg.indices = indices;
+	arg.nr_mems = nr_mems;
+	arg.idx = 0;
+
+	ret = shmem_undo_range(inode, 0, -1, false, &shmem_fdbox_undo_ops, &arg);
+	if (ret < 0) {
+		pr_err("shmem: failed to undo fdbox range: %d\n", ret);
+		goto err;
+	}
+
+	*nr = arg.idx;
+	*indicesp = no_free_ptr(indices);
+	return_ptr(mems);
+
+err:
+	/*
+	 * TODO: This kills the whole file on failure to KHO. We should keep the
+	 * contents around for another try later. The problem is, if re-adding
+	 * pages fails, there would be no recovery at that point. Ideally, we
+	 * should first serialize the whole file, and only then remove things
+	 * from page cache so we are sure to never fail.
+	 */
+	for (i = 0; i < arg.idx; i++) {
+		struct folio *folio = page_folio(phys_to_page(mems[i].addr));
+
+		folio_put(folio);
+	}
+
+	/* Undo the rest of the file. This should not fail. */
+	WARN_ON(shmem_undo_range(inode, 0, -1, false, &shmem_default_undo_ops, NULL));
+	return ERR_PTR(ret);
+}
+
+int shmem_fdbox_kho_write(struct fdbox_fd *box_fd, void *fdt)
+{
+	struct inode *inode = box_fd->file->f_inode;
+	unsigned long *indices __free(kvfree) = NULL;
+	struct kho_mem *mems __free(kvfree) = NULL;
+	u64 pos = box_fd->file->f_pos, size = inode->i_size;
+	unsigned long nr_mems, i;
+	int ret = 0;
+
+	/*
+	 * mems can be larger than sizeof(*mems) * nr_mems, but we should only
+	 * look at things in the range of 0 to nr_mems.
+	 */
+	mems = shmem_fdbox_kho_get_mems(inode, &indices, &nr_mems);
+	if (IS_ERR(mems))
+		return PTR_ERR(mems);
+
+	/*
+	 * fdbox should have already started the node. We can start adding
+	 * properties directly.
+	 */
+	ret |= fdt_property(fdt, "compatible", fdbox_kho_compatible,
+			    sizeof(fdbox_kho_compatible));
+	ret |= fdt_property(fdt, "pos", &pos, sizeof(u64));
+	ret |= fdt_property(fdt, "size",  &size, sizeof(u64));
+	ret |= fdt_property(fdt, "mem", mems, sizeof(*mems) * nr_mems);
+	ret |= fdt_property(fdt, "indices", indices, sizeof(*indices) * nr_mems);
+
+	if (ret) {
+		pr_err("shmem: failed to add properties to FDT!\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	/*
+	 * TODO: This kills the whole file on failure to KHO. We should keep the
+	 * contents around for another try later. The problem is, if re-adding
+	 * pages fails, there would be no recovery at that point. Ideally, we
+	 * should first serialize the whole file, and only then remove things
+	 * from page cache so we are sure to never fail.
+	 */
+	for (i = 0; i < nr_mems; i++) {
+		struct folio *folio = page_folio(phys_to_page(mems[i].addr));
+
+		folio_put(folio);
+	}
+	return ret;
+}
+
+struct file *shmem_fdbox_kho_recover(const void *fdt, int offset)
+{
+	struct address_space *mapping;
+	char pathbuf[1024] = "", *path;
+	const unsigned long *indices;
+	const struct kho_mem *mems;
+	unsigned long nr_mems, i = 0;
+	const u64 *pos, *size;
+	struct inode *inode;
+	struct file *file;
+	int len, ret;
+
+	ret = fdt_node_check_compatible(fdt, offset, fdbox_kho_compatible);
+	if (ret) {
+		pr_err("shmem: invalid compatible\n");
+		goto err;
+	}
+
+	mems = fdt_getprop(fdt, offset, "mem", &len);
+	if (!mems || len % sizeof(*mems)) {
+		pr_err("shmem: invalid mems property\n");
+		goto err;
+	}
+	nr_mems = len / sizeof(*mems);
+
+	indices = fdt_getprop(fdt, offset, "indices", &len);
+	if (!indices || len % sizeof(unsigned long)) {
+		pr_err("shmem: invalid indices property\n");
+		goto err_return;
+	}
+	if (len / sizeof(unsigned long) != nr_mems) {
+		pr_err("shmem: number of indices and mems do not match\n");
+		goto err_return;
+	}
+
+	size = fdt_getprop(fdt, offset, "size", &len);
+	if (!size || len != sizeof(u64)) {
+		pr_err("shmem: invalid size property\n");
+		goto err_return;
+	}
+
+	pos = fdt_getprop(fdt, offset, "pos", &len);
+	if (!pos || len != sizeof(u64)) {
+		pr_err("shmem: invalid pos property\n");
+		goto err_return;
+	}
+
+	/*
+	 * TODO: This sets UID/GID, cgroup accounting to root. Should this
+	 * be given to the first user that maps the FD instead?
+	 */
+	file = shmem_file_setup(fdt_get_name(fdt, offset, NULL), 0,
+				VM_NORESERVE);
+	if (IS_ERR(file)) {
+		pr_err("shmem: failed to setup file\n");
+		goto err_return;
+	}
+
+	inode = file->f_inode;
+	mapping = inode->i_mapping;
+	vfs_setpos(file, *pos, MAX_LFS_FILESIZE);
+
+	for (; i < nr_mems; i++) {
+		struct folio *folio;
+		void *va;
+
+		if (mems[i].size != PAGE_SIZE) {
+			pr_err("shmem: unknown kho_mem size %llx. Expected %lx\n",
+			       mems[i].size, PAGE_SIZE);
+			goto err_return;
+		}
+
+		va = kho_claim_mem(&mems[i]);
+		folio = virt_to_folio(va);
+
+		/* Set up the folio for insertion. */
+
+		/*
+		 * TODO: This breaks falloc-ed folios since now they get marked
+		 * uptodate when they might not actually be zeroed out yet. Need
+		 * a way to distinguish falloc-ed folios.
+		 */
+		folio_mark_uptodate(folio);
+		folio_mark_dirty(folio);
+
+		/*
+		 * TODO: Should find a way to unify this and
+		 * shmem_alloc_and_add_folio().
+		 */
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		ret = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to charge folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		ret = shmem_add_to_page_cache(folio, mapping, indices[i], NULL,
+					      mapping_gfp_mask(mapping));
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to add to page cache folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		ret = shmem_inode_acct_blocks(inode, 1);
+		if (ret) {
+			folio_unlock(folio);
+			folio_put(folio);
+			fput(file);
+			pr_err("shmem: failed to account folio index %lu\n", i);
+			goto err_return_next;
+		}
+
+		shmem_recalc_inode(inode, 1, 0);
+		folio_add_lru(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	inode->i_size = *size;
+
+	return file;
+
+err_return:
+	kho_return_mem(mems + i);
+err_return_next:
+	for (i = i + 1; i < nr_mems; i++)
+		kho_return_mem(mems + i);
+err:
+	ret = fdt_get_path(fdt, offset, pathbuf, sizeof(pathbuf));
+	if (ret)
+		path = "unknown";
+	else
+		path = pathbuf;
+
+	pr_err("shmem: error when recovering KHO node '%s'\n", path);
+	return NULL;
+}
+
+#endif /* CONFIG_FDBOX && CONFIG_KEXEC_HANDOVER */
+
 static const struct address_space_operations shmem_aops = {
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
-- 
2.47.1


