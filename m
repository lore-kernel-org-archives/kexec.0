Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C64606BA37
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cC1RCHgQ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSurYKoG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SzS7eItWzxSO4z8YwuJ1uSgZgWQNzMZ6Ahb1OPoDZMo=; b=cC1RCHgQvlQw3O
	pwpyfFA0Yim5yqdFY5KRfJq2+MyZl0mMWpXDkY6fk9nc6KOJZ6SSRdn1tefptX/oP+fUVKqM6qhEt
	cWnqP2ctEbGhNgO0W8SXfN6klBcx5bUAZdtzGrHstNAVM3dO0TgrR/C6TqzG5dhamGAGahBUQomk+
	yN2e9DG4UKTSW67xk0NI8NdurwUX9XW6NXjDjGJH8CXcN8DOLseqHdYnzvVFmYAq7ocL0rcdZ3Hfa
	OJC5v5pzXMQ+rEQW3SorDpJz/LLiS26992D+NaBYl0rFdiblgAV/XQnYict9u5FNn56Qft6kwE1uy
	GCXzZDtoGWr91NwoLiQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgh3-00000006ds6-3XY1;
	Wed, 04 Nov 2026 19:30:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgh2-00000006drT-1q0R;
	Wed, 04 Nov 2026 19:30:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 347F843EA8;
	Wed,  4 Nov 2026 19:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481671F00919;
	Wed,  4 Nov 2026 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820644;
	bh=SzS7eItWzxSO4z8YwuJ1uSgZgWQNzMZ6Ahb1OPoDZMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSurYKoGAIDif/wqmX3FgZQwTiCgG+tnCgKSYLzdBWLORSkW/KjPSpiKICziP0EcS
	 9/yDwVUJ1VGST3+eeKxnRmC58bkU95GtCGg+AOkVWOP9i8o2Yz9AE39KNjAznOzbNc
	 LZBdV+hFzabshy2uKPlA9htHgRMl0TGCn72g9xRoa5pORuGv5ZoDbcZ71WsO2tgN9q
	 HY7o5mrylylD9i2wPIprqH6i/TD3VA9kfg2WfMShh4s03pjBHfLeZZObOCd5gI9iT+
	 wuoe26knPwtRVZbWwRHnhenA94dtRu+lIO1/zOPt0aT/nnoTDQAotVqxzmQAhPpzvf
	 9fjgkLUVUYm7g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	ntfs3@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org,
	kexec@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	ibm-acpi-devel@lists.sourceforge.net,
	jfs-discussion@lists.sourceforge.net,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sh@vger.kernel.org,
	linux-usb@vger.kernel.org,
	samba-technical@lists.samba.org,
	sparclinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	Takashi Iwai <tiwai@suse.de>,
	linux-input@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH RESEND v2 05/23] proc: keep the open files of an entry in an open node
Date: Wed,  4 Nov 2026 20:30:30 +0100
Message-ID: <20261104-work-procfs-core-v2-5-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7650; i=brauner@kernel.org; h=from:subject:message-id; bh=23kBqn99A2yJqnmYF9LJE/l5cgOyT8JgYFtYwqrik1A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9bi9zNfkydcVJx960mhOT5vot8lzweI3irB1t/DfCv pW3/uSr7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiITzIjQ7NYYY7n1+XMz9/+ adnA/vfsjcjZc/L/TuKredHMeVzOZQPDX+FwB7+jVy7y9Wvbft6TbcDzeXOhX1Fv15PeN08Fbuh PYwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

procfs remembers the open files of an entry that has a ->proc_release(),
so that it can call the release hook when the entry is removed while
files are still open. The list head for that and the lock that protects
it sit in every struct proc_dir_entry, for the few entries that need
them, and the next patches want to keep more there, the vm_operations
of an entry's mappings for a start.

Move the list into a struct pde_open_node that only those entries get.
It is allocated when the entry is registered, whether an entry needs
one follows from its proc_ops, and freed with the entry. So ->open is
constant for the life of an entry, nothing has to look it up or pin it,
and the removal path stays what it is. kernfs allocates its
kernfs_open_node on the first open instead, but there every attribute
can be polled and so every one of them would need one. In procfs the
entries that need the node are the exception. Permanent entries don't
get one, they are never removed, so their release hook only ever runs
when a file is closed.

The spinlock stays in the entry and now protects what hangs off ->open.
Moving it behind the gid fills a hole, so struct proc_dir_entry shrinks
from 160 to 144 bytes on x86_64 here, and it ends up at 160 bytes at
the end of this series instead of the 184 it would have grown to with
the read and write limits and the vm_operations of its mappings in it.
That keeps 32 bytes of inline name instead of 8. 34 of the 68 /proc/net
names a network namespace gets are longer than 7 characters.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/generic.c  | 20 +++++++++++++++++++-
 fs/proc/inode.c    | 23 +++++++++++++----------
 fs/proc/internal.h | 16 +++++++++++++---
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index f6d620a5c3d2..84f064a651e4 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -40,6 +40,7 @@ void pde_free(struct proc_dir_entry *pde)
 		kfree(pde->data);
 	if (pde->name != pde->inline_name)
 		kfree(pde->name);
+	kfree(pde->open);
 	kmem_cache_free(proc_dir_entry_cache, pde);
 }
 
@@ -445,6 +446,18 @@ static void pde_set_flags(struct proc_dir_entry *pde)
 		pde->flags |= PROC_ENTRY_proc_lseek;
 }
 
+/*
+ * procfs has to know the open files of an entry whose ->proc_release() it
+ * calls at removal. A permanent entry is never removed and skips all that,
+ * see proc_reg_open().
+ */
+static bool pde_needs_open_node(const struct proc_dir_entry *pde)
+{
+	if (!S_ISREG(pde->mode) || pde_is_permanent(pde))
+		return false;
+	return pde->proc_ops->proc_release;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp)
@@ -454,6 +467,12 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 
 	if (!S_ISDIR(dp->mode))
 		pde_set_flags(dp);
+	if (pde_needs_open_node(dp)) {
+		dp->open = kzalloc(sizeof(*dp->open), GFP_KERNEL);
+		if (!dp->open)
+			goto out_free_inum;
+		INIT_LIST_HEAD(&dp->open->files);
+	}
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
@@ -533,7 +552,6 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	ent->subdir = RB_ROOT;
 	refcount_set(&ent->refcnt, 1);
 	spin_lock_init(&ent->pde_unload_lock);
-	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
 	/* Revalidate everything under /proc/${pid}/net */
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8795add1898d..56eab69e1dcc 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -271,12 +271,13 @@ void proc_entry_rundown(struct proc_dir_entry *de)
 	if (atomic_add_return(BIAS, &de->in_use) != BIAS)
 		wait_var_event(&de->in_use, atomic_read(&de->in_use) == BIAS);
 
-	/* ->pde_openers list can't grow from now on. */
-
+	/* ->open->files can't grow from now on. */
+	if (!de->open)
+		return;
 	spin_lock(&de->pde_unload_lock);
-	while (!list_empty(&de->pde_openers)) {
+	while (!list_empty(&de->open->files)) {
 		struct pde_opener *pdeo;
-		pdeo = list_first_entry(&de->pde_openers, struct pde_opener, lh);
+		pdeo = list_first_entry(&de->open->files, struct pde_opener, lh);
 		close_pdeo(de, pdeo);
 		spin_lock(&de->pde_unload_lock);
 	}
@@ -499,13 +500,13 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	 * 2) rmmod isn't blocked by opening file in /proc and sitting on
 	 *    the descriptor (including "rmmod foo </proc/foo" scenario).
 	 *
-	 * Save every "struct file" with custom ->release hook.
+	 * Save every "struct file" with custom ->release hook. Those entries
+	 * have an open node, see proc_register().
 	 */
 	if (!use_pde(pde))
 		return -ENOENT;
 
-	const auto release = pde->proc_ops->proc_release;
-	if (release) {
+	if (pde->open) {
 		pdeo = kmem_cache_alloc(pde_opener_cache, GFP_KERNEL);
 		if (!pdeo) {
 			rv = -ENOMEM;
@@ -517,14 +518,14 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	if (open)
 		rv = open(inode, file);
 
-	if (release) {
+	if (pde->open) {
 		if (rv == 0) {
 			/* To know what to release. */
 			pdeo->file = file;
 			pdeo->closing = false;
 			pdeo->c = NULL;
 			spin_lock(&pde->pde_unload_lock);
-			list_add(&pdeo->lh, &pde->pde_openers);
+			list_add(&pdeo->lh, &pde->open->files);
 			spin_unlock(&pde->pde_unload_lock);
 		} else
 			kmem_cache_free(pde_opener_cache, pdeo);
@@ -547,8 +548,10 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 		return 0;
 	}
 
+	if (!pde->open)
+		return 0;
 	spin_lock(&pde->pde_unload_lock);
-	list_for_each_entry(pdeo, &pde->pde_openers, lh) {
+	list_for_each_entry(pdeo, &pde->open->files, lh) {
 		if (pdeo->file == file) {
 			close_pdeo(pde, pdeo);
 			return 0;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index ab4d7bd1fb75..33776bc00ff0 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -35,9 +35,6 @@ struct proc_dir_entry {
 	 */
 	atomic_t in_use;
 	refcount_t refcnt;
-	struct list_head pde_openers;	/* who did ->open, but not ->release */
-	/* protects ->pde_openers and all struct pde_opener instances */
-	spinlock_t pde_unload_lock;
 	const struct inode_operations *proc_iops;
 	union {
 		const struct proc_ops *proc_ops;
@@ -47,6 +44,8 @@ struct proc_dir_entry {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
 	};
+	/* the open files procfs has to know, see struct pde_open_node */
+	struct pde_open_node *open;
 	proc_write_t write;
 	void *data;
 	unsigned int state_size;
@@ -54,6 +53,8 @@ struct proc_dir_entry {
 	nlink_t nlink;
 	kuid_t uid;
 	kgid_t gid;
+	/* protects ->open->files and all struct pde_opener instances */
+	spinlock_t pde_unload_lock;
 	loff_t size;
 	struct proc_dir_entry *parent;
 	struct rb_root subdir;
@@ -325,6 +326,15 @@ struct pde_opener {
 	bool closing;
 	struct completion *c;
 } __randomize_layout;
+
+/*
+ * The open files of an entry whose ->proc_release() procfs has to call when
+ * the entry is removed while they are still open. Allocated with the entry,
+ * see proc_register().
+ */
+struct pde_open_node {
+	struct list_head files;		/* who did ->open, but not ->release */
+};
 extern const struct inode_operations proc_link_inode_operations;
 extern const struct inode_operations proc_pid_link_inode_operations;
 extern const struct super_operations proc_sops;

-- 
2.53.0


