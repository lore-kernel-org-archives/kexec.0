Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLta-004vfq-GB
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:34 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 24/43] mm: shmem: enable saving to PKRAM
Date: Tue, 30 Mar 2021 14:35:59 -0700
Message-Id: <1617140178-8773-25-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

This patch illustrates how the PKRAM API can be used for preserving tmpfs.
Two options are added to tmpfs:
    The 'pkram=' option specifies the PKRAM node to load/save the
    filesystem tree from/to.
    The 'preserve' option initiates preservation of a read-only
    filesystem tree.

If the 'pkram=' options is passed on mount, shmem will look for the
corresponding PKRAM node and load the FS tree from it.

If the 'pkram=' options was passed on mount and the 'preserve' option is
passed on remount and the filesystem is read-only, shmem will save the
FS tree to the PKRAM node.

A typical usage scenario looks like:

 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # echo something > /mnt/smth
 # mount -o remount ro,preserve /mnt
 <possibly kexec>
 # mount -t tmpfs -o pkram=mytmpfs none /mnt
 # cat /mnt/smth

Each FS tree is saved into a PKRAM node, and each file is saved into a
PKRAM object. A byte stream written to the object is used for saving file
metadata (name, permissions, etc) while the page stream written to
the object accommodates file content pages and their offsets.

This implementation serves as a demonstration and therefore is
simplified: it supports only regular files in the root directory without
multiple hard links, and it does not save swapped out files and aborts if
any are found. However, it can be elaborated to fully support tmpfs.

Originally-by: Vladimir Davydov <vdavydov@parallels.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/shmem_fs.h |  24 +++
 mm/Makefile              |   2 +-
 mm/shmem.c               |  64 ++++++++
 mm/shmem_pkram.c         | 385 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 474 insertions(+), 1 deletion(-)
 create mode 100644 mm/shmem_pkram.c

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3f0dd95efd46..78149d702a62 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,11 @@ struct shmem_inode_info {
 	struct inode		vfs_inode;
 };
 
+#define SHMEM_PKRAM_NAME_MAX	128
+struct shmem_pkram_info {
+	char name[SHMEM_PKRAM_NAME_MAX];
+};
+
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
@@ -43,6 +48,8 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	struct shmem_pkram_info *pkram;
+	bool preserve;		    /* PKRAM-enabled data is preserved */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
@@ -106,6 +113,23 @@ extern int shmem_getpage(struct inode *inode, pgoff_t index,
 extern int shmem_insert_page(struct mm_struct *mm, struct inode *inode,
 		pgoff_t index, struct page *page);
 
+#ifdef CONFIG_PKRAM
+extern int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram);
+extern void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram,
+			bool preserve);
+extern int shmem_save_pkram(struct super_block *sb);
+extern void shmem_load_pkram(struct super_block *sb);
+extern int shmem_release_pkram(struct super_block *sb);
+#else
+static inline int shmem_parse_pkram(const char *str,
+			struct shmem_pkram_info **pkram) { return 1; }
+static inline void shmem_show_pkram(struct seq_file *seq,
+			struct shmem_pkram_info *pkram, bool preserve) { }
+static inline int shmem_save_pkram(struct super_block *sb) { return 0; }
+static inline void shmem_load_pkram(struct super_block *sb) { }
+static inline int shmem_release_pkram(struct super_block *sb) { return 0; }
+#endif
+
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/Makefile b/mm/Makefile
index f5c0dd0a3707..a4e9dd5545df 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,4 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o shmem_pkram.o
diff --git a/mm/shmem.c b/mm/shmem.c
index 60e4f0ad23b9..c1c5760465f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -111,16 +111,20 @@ struct shmem_options {
 	unsigned long long blocks;
 	unsigned long long inodes;
 	struct mempolicy *mpol;
+	struct shmem_pkram_info *pkram;
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
 	bool full_inums;
+	bool preserve;
 	int huge;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
+#define SHMEM_SEEN_PKRAM 16
+#define SHMEM_SEEN_PRESERVE 32
 };
 
 #ifdef CONFIG_TMPFS
@@ -3441,6 +3445,8 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_pkram,
+	Opt_preserve,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3462,6 +3468,8 @@ enum shmem_param {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_string("pkram",		Opt_pkram),
+	fsparam_flag_no("preserve",	Opt_preserve),
 	{}
 };
 
@@ -3545,6 +3553,22 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_pkram:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			kfree(ctx->pkram);
+			if (shmem_parse_pkram(param->string, &ctx->pkram))
+				goto bad_value;
+			ctx->seen |= SHMEM_SEEN_PKRAM;
+			break;
+		}
+		goto unsupported_parameter;
+	case Opt_preserve:
+		if (IS_ENABLED(CONFIG_PKRAM)) {
+			ctx->preserve = result.boolean;
+			ctx->seen |= SHMEM_SEEN_PRESERVE;
+			break;
+		}
+		goto unsupported_parameter;
 	}
 	return 0;
 
@@ -3641,6 +3665,41 @@ static int shmem_reconfigure(struct fs_context *fc)
 		err = "Current inum too high to switch to 32-bit inums";
 		goto out;
 	}
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		if (!sbinfo->pkram && !(ctx->seen & SHMEM_SEEN_PKRAM)) {
+			err = "Cannot set preserve/nopreserve. Not enabled for PKRAM";
+			goto out;
+		}
+		if (ctx->preserve && !(fc->sb_flags & SB_RDONLY)) {
+			err = "Cannot preserve. Filesystem must be read-only";
+			goto out;
+		}
+	}
+
+	if (ctx->pkram) {
+		kfree(sbinfo->pkram);
+		sbinfo->pkram = ctx->pkram;
+	}
+
+	if (ctx->seen & SHMEM_SEEN_PRESERVE) {
+		int error;
+
+		if (!sbinfo->preserve && ctx->preserve) {
+			error = shmem_save_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to preserve";
+				goto out;
+			}
+			sbinfo->preserve = true;
+		} else if (sbinfo->preserve && !ctx->preserve) {
+			error = shmem_release_pkram(fc->root->d_sb);
+			if (error) {
+				err = "Failed to unpreserve";
+				goto out;
+			}
+			sbinfo->preserve = false;
+		}
+	}
 
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
@@ -3714,6 +3773,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
 #endif
 	shmem_show_mpol(seq, sbinfo->mpol);
+	shmem_show_pkram(seq, sbinfo->pkram, sbinfo->preserve);
 	return 0;
 }
 
@@ -3726,6 +3786,7 @@ static void shmem_put_super(struct super_block *sb)
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+	kfree(sbinfo->pkram);
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3780,6 +3841,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
 	ctx->mpol = NULL;
+	sbinfo->pkram = ctx->pkram;
+	ctx->pkram = NULL;
 
 	spin_lock_init(&sbinfo->stat_lock);
 	if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
@@ -3809,6 +3872,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+	shmem_load_pkram(sb);
 	return 0;
 
 failed:
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
new file mode 100644
index 000000000000..904b1b861ce5
--- /dev/null
+++ b/mm/shmem_pkram.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
+#include <linux/dcache.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/mount.h>
+#include <linux/mutex.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
+#include <linux/pagevec.h>
+#include <linux/pkram.h>
+#include <linux/seq_file.h>
+#include <linux/shmem_fs.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+struct file_header {
+	__u32	mode;
+	kuid_t	uid;
+	kgid_t	gid;
+	__u32	namelen;
+	__u64	size;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+};
+
+int shmem_parse_pkram(const char *str, struct shmem_pkram_info **pkram)
+{
+	struct shmem_pkram_info *new;
+	size_t len;
+
+	len = strlen(str);
+	if (!len || len >= SHMEM_PKRAM_NAME_MAX)
+		return 1;
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return 1;
+	strcpy(new->name, str);
+	*pkram = new;
+	return 0;
+}
+
+void shmem_show_pkram(struct seq_file *seq, struct shmem_pkram_info *pkram, bool preserve)
+{
+	if (pkram) {
+		seq_printf(seq, ",pkram=%s", pkram->name);
+		seq_printf(seq, ",%s", preserve ? "preserve" : "nopreserve");
+	}
+}
+
+static int shmem_pkram_name(char *buf, size_t bufsize,
+			   struct shmem_sb_info *sbinfo)
+{
+	if (snprintf(buf, bufsize, "shmem-%s", sbinfo->pkram->name) >= bufsize)
+		return -ENAMETOOLONG;
+	return 0;
+}
+
+static int save_page(struct page *page, struct pkram_access *pa)
+{
+	int err = 0;
+
+	if (page)
+		err = pkram_save_file_page(pa, page);
+
+	return err;
+}
+
+static int save_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	struct pagevec pvec;
+	unsigned long start, end;
+	int err = 0;
+	int i;
+
+	start = 0;
+	end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+	pagevec_init(&pvec);
+	for ( ; ; ) {
+		pvec.nr = find_get_pages_range(mapping, &start, end,
+					PAGEVEC_SIZE, pvec.pages);
+		if (!pvec.nr)
+			break;
+		for (i = 0; i < pagevec_count(&pvec); ) {
+			struct page *page = pvec.pages[i];
+
+			lock_page(page);
+			BUG_ON(page->mapping != mapping);
+			err = save_page(page, &pa);
+			if (PageCompound(page)) {
+				start = page->index + compound_nr(page);
+				i += compound_nr(page);
+			} else {
+				i++;
+			}
+
+			unlock_page(page);
+			if (err)
+				break;
+		}
+		pagevec_release(&pvec);
+		if (err || (start > end))
+			break;
+		cond_resched();
+	}
+
+	pkram_finish_access(&pa, err == 0);
+	return err;
+}
+
+static int save_file(struct dentry *dentry, struct pkram_stream *ps)
+{
+	PKRAM_ACCESS(pa_bytes, ps, bytes);
+	struct inode *inode = dentry->d_inode;
+	umode_t mode = inode->i_mode;
+	struct file_header hdr;
+	ssize_t ret;
+	int err;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(inode->i_nlink > 1))
+		return -EINVAL;
+
+	hdr.mode = mode;
+	hdr.uid = inode->i_uid;
+	hdr.gid = inode->i_gid;
+	hdr.namelen = dentry->d_name.len;
+	hdr.size = i_size_read(inode);
+	hdr.atime = timespec64_to_ns(&inode->i_atime);
+	hdr.mtime = timespec64_to_ns(&inode->i_mtime);
+	hdr.ctime = timespec64_to_ns(&inode->i_ctime);
+
+
+	ret = pkram_write(&pa_bytes, &hdr, sizeof(hdr));
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+	ret = pkram_write(&pa_bytes, dentry->d_name.name, dentry->d_name.len);
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+
+	err = save_file_content(ps, inode->i_mapping);
+out:
+	pkram_finish_access(&pa_bytes, err == 0);
+	return err;
+}
+
+static int save_tree(struct super_block *sb, struct pkram_stream *ps)
+{
+	struct dentry *dentry, *root = sb->s_root;
+	int err = 0;
+
+	inode_lock(d_inode(root));
+	spin_lock(&root->d_lock);
+	list_for_each_entry(dentry, &root->d_subdirs, d_child) {
+		if (d_unhashed(dentry) || !dentry->d_inode)
+			continue;
+		dget(dentry);
+		spin_unlock(&root->d_lock);
+
+		err = pkram_prepare_save_obj(ps, PKRAM_DATA_pages|PKRAM_DATA_bytes);
+		if (!err)
+			err = save_file(dentry, ps);
+		if (!err)
+			pkram_finish_save_obj(ps);
+		spin_lock(&root->d_lock);
+		dput(dentry);
+		if (err)
+			break;
+	}
+	spin_unlock(&root->d_lock);
+	inode_unlock(d_inode(root));
+
+	return err;
+}
+
+int shmem_save_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo || !sbinfo->pkram || is_kdump_kernel())
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_save(&ps, buf, GFP_KERNEL);
+	if (err)
+		goto out_free_buf;
+
+	err = save_tree(sb, &ps);
+	if (err)
+		goto out_discard_save;
+
+	pkram_finish_save(&ps);
+	goto out_free_buf;
+
+out_discard_save:
+	pkram_discard_save(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM save failed: %d\n", err);
+
+	return err;
+}
+
+static int load_file_content(struct pkram_stream *ps, struct address_space *mapping)
+{
+	PKRAM_ACCESS(pa, ps, pages);
+	unsigned long index;
+	struct page *page;
+	int err = 0;
+
+	do {
+		page = pkram_load_file_page(&pa, &index);
+		if (!page)
+			break;
+
+		err = shmem_insert_page(current->mm, mapping->host, index, page);
+		put_page(page);
+		cond_resched();
+	} while (!err);
+
+	pkram_finish_access(&pa, err == 0);
+	return err;
+}
+
+static int load_file(struct dentry *parent, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	PKRAM_ACCESS(pa_bytes, ps, bytes);
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file_header hdr;
+	size_t ret;
+	umode_t mode;
+	int namelen;
+	int err = -EINVAL;
+
+	ret = pkram_read(&pa_bytes, &hdr, sizeof(hdr));
+	if (ret != sizeof(hdr))
+		goto out;
+
+	mode = hdr.mode;
+	namelen = hdr.namelen;
+	if (!S_ISREG(mode) || namelen > bufsize)
+		goto out;
+	if (pkram_read(&pa_bytes, buf, namelen) != namelen)
+		goto out;
+
+	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
+
+	dentry = lookup_one_len(buf, parent, namelen);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out_unlock;
+	}
+
+	err = vfs_create(&init_user_ns, parent->d_inode, dentry, mode, NULL);
+	dput(dentry); /* on success shmem pinned it */
+	if (err)
+		goto out_unlock;
+
+	inode = dentry->d_inode;
+	inode->i_mode = mode;
+	inode->i_uid = hdr.uid;
+	inode->i_gid = hdr.gid;
+	inode->i_atime = ns_to_timespec64(hdr.atime);
+	inode->i_mtime = ns_to_timespec64(hdr.mtime);
+	inode->i_ctime = ns_to_timespec64(hdr.ctime);
+	i_size_write(inode, hdr.size);
+
+	err = load_file_content(ps, inode->i_mapping);
+out_unlock:
+	inode_unlock(d_inode(parent));
+out:
+	pkram_finish_access(&pa_bytes, err == 0);
+	return err;
+}
+
+static int load_tree(struct super_block *sb, struct pkram_stream *ps,
+		     char *buf, size_t bufsize)
+{
+	int err;
+
+	do {
+		err = pkram_prepare_load_obj(ps);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
+			break;
+		}
+		err = load_file(sb->s_root, ps, buf, PAGE_SIZE);
+		pkram_finish_load_obj(ps);
+	} while (!err);
+
+	return err;
+}
+
+void shmem_load_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&ps, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	err = load_tree(sb, &ps, buf, PAGE_SIZE);
+
+	pkram_finish_load(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+}
+
+int shmem_release_pkram(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = sb->s_fs_info;
+	struct pkram_stream ps;
+	char *buf;
+	int err = -ENOMEM;
+
+	if (!sbinfo->pkram)
+		return 0;
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	err = shmem_pkram_name(buf, PAGE_SIZE, sbinfo);
+	if (!err)
+		err = pkram_prepare_load(&ps, buf);
+	if (err) {
+		if (err == -ENOENT)
+			err = 0;
+		goto out_free_buf;
+	}
+
+	pkram_finish_load(&ps);
+out_free_buf:
+	free_page((unsigned long)buf);
+out:
+	if (err)
+		pr_err("SHMEM: PKRAM load failed: %d\n", err);
+
+	return err;
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
