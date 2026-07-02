Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B31C43327
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AiJ+fIwy08lW7l+07g4Wos8y5mKqbMsd4Teu1JWjgVE=; b=Os54/UxKmTwe9PjVk04cjusWfI
	cr5WmB/+jn8Ta8BSnnGjUBjnTRBGzg15m3sYq0BJTztx59z6qYWMVSsDijKl8vEmS7o8d6/1Wfuyr
	pc6yfDGC2x+vxSHjNP6Nw+f7wplI/kqAZVkL7/TbRWCJtEH/bR+C8iGWs7pYbcEwMTjwyz4pyIcDK
	n5oNKuEyxQnj5+grhFeaWn3CQX+FIpM48IlhaET9wfuHd9I674fFDYT2ecxaaO5a4p94LLk8vz9nh
	bip4prMeBoQv5gYiatdPJpy6IFNg9ojV65zE1vO8kM3aDjOlSM/nl4TVvampKzyiTg4RBqp5OyMgm
	we7rWt6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLPE-000000059uv-0mDS;
	Thu, 02 Jul 2026 17:40:56 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLP5-000000059rH-2eCF
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014047; x=1814550047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiJ+fIwy08lW7l+07g4Wos8y5mKqbMsd4Teu1JWjgVE=;
  b=l5+ieICrYpOLTqi/pdSuyCWG/ucbS1qEvrz0FaR5QhcULfzBhoiSu5Sn
   /mxiDxgUBn9Qo/xIi8yQpoP2HGESzEU2Sb1JXOePMMLnrPyp234cej/Q9
   RHmMhQHxFNLNaTc/A/XZhRrAtP3a+5TVQtovGZMcM58D0xL87V+6WjiRM
   ZDUzbbptLBJ/dT/SFGdbo6ALHbzV+tCtsPy7YUUhd0M8pX/or0tQaaZeU
   TTlZiEctnXsuaDPrjz0afGIKcmHfizTIcWk3u+aX+n0AFnd6K9Be6o1w5
   pwtYRQEVplyEc97XzZjOf5IhW4yCQ77Cjy35xb6Nk/q3JaZD5jfUuuisW
   A==;
X-CSE-ConnectionGUID: y8bq6zIvS6CTijaNZj9tSA==
X-CSE-MsgGUID: Fpv+CJ64T1GbwMXtot/bbQ==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22963126"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:40:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:7235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.125:2525] with esmtp (Farcaster)
 id 142e4248-2dc0-4fae-beb4-1b19cf2b1670; Thu, 2 Jul 2026 17:40:40 +0000 (UTC)
X-Farcaster-Flow-ID: 142e4248-2dc0-4fae-beb4-1b19cf2b1670
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:40:40 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:40:37 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 01/14] kernfs: add populate callbacks and KERNFS_LAZY flag for lazy dir population
Date: Thu, 2 Jul 2026 19:40:20 +0200
Message-ID: <20260702174033.32116-2-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702174033.32116-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_104049_497513_F2DB81A6 
X-CRM114-Status: GOOD (  21.69  )
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

Add populate() and populate_all() callbacks to struct
kernfs_syscall_ops:

  - populate() runs on a KERNFS_LAZY parent from
    kernfs_iop_lookup() before kernfs_rwsem is taken; the locked
    lookup then proceeds and its result is authoritative. The
    subsystem may materialize the named child during the call.

  - populate_all() runs from kernfs_fop_readdir() before
    kernfs_rwsem is taken. The subsystem may materialize all
    deferred children.

Both are invoked with the parent's active reference held by the
kernfs lookup path, so parent->priv stays live across the
(sleeping) callback. The callback must not drop this pin.

Add KERNFS_LAZY (0x8000) to enum kernfs_node_flag; non-lazy
directories skip the indirect call entirely.

Add kernfs_set_lazy() to mark a directory lazy between linking
into the parent tree and kernfs_activate(). It returns -EINVAL
for namespaced and non-directory nodes: populate dispatch does
not propagate the namespace tag, so a namespaced lazy node would
silently fail tagged lookups. The error code lets callers detect
contract violations without polluting dmesg with a stack trace
and lets KUnit cover the rejection paths via return-value
assertions rather than triggering WARN_ON_ONCE.

Add matching populate/populate_all fields to struct kobj_type.
These are sysfs-only; non-sysfs kernfs roots do not invoke them.

No behavior change: no subsystem sets these callbacks yet.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 fs/kernfs/dir.c         | 43 +++++++++++++++++++++++++++++++++++++++--
 include/linux/kernfs.h  | 28 +++++++++++++++++++++++++++
 include/linux/kobject.h | 10 ++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4f9ade82b08ab..9c5ec8b82d940 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -975,6 +975,20 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 }
 EXPORT_SYMBOL_GPL(kernfs_find_and_get_ns);
 
+int kernfs_set_lazy(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	if (kn->ns || (kn->flags & KERNFS_NS) ||
+	    kernfs_type(kn) != KERNFS_DIR)
+		return -EINVAL;
+
+	down_write(&root->kernfs_rwsem);
+	kn->flags |= KERNFS_LAZY;
+	up_write(&root->kernfs_rwsem);
+	return 0;
+}
+
 /**
  * kernfs_walk_and_get_ns - find and get kernfs_node with the given path
  * @parent: kernfs_node to search under
@@ -1255,6 +1269,19 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const struct ns_common *ns = NULL;
+	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
+	int populate_ret = 0;
+
+	/* Dispatch populate before taking kernfs_rwsem; kernfs_get_active()
+	 * pins @parent so @parent->priv stays live across the sleepable call.
+	 */
+	if (scops && scops->populate && (READ_ONCE(parent->flags) & KERNFS_LAZY)) {
+		if (kernfs_get_active(parent)) {
+			populate_ret = scops->populate(parent,
+						       dentry->d_name.name);
+			kernfs_put_active(parent);
+		}
+	}
 
 	root = kernfs_root(parent);
 	down_read(&root->kernfs_rwsem);
@@ -1285,6 +1312,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		kernfs_set_rev(parent, dentry);
 	up_read(&root->kernfs_rwsem);
 
+	/* Transient populate error: do not cache a negative dentry. */
+	if (!kn && populate_ret && populate_ret != -ENOENT)
+		return ERR_PTR(populate_ret);
+
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
 }
@@ -1973,13 +2004,21 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
+	struct kernfs_root *root = kernfs_root(parent);
+	struct kernfs_syscall_ops *scops = root->syscall_ops;
 	const struct ns_common *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
+	/* Same pinning invariant as kernfs_iop_lookup. */
+	if (scops && scops->populate_all && (READ_ONCE(parent->flags) & KERNFS_LAZY)) {
+		if (kernfs_get_active(parent)) {
+			scops->populate_all(parent);
+			kernfs_put_active(parent);
+		}
+	}
+
 	down_read(&root->kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e21b2f7f4159f..cd529fd843831 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -113,6 +113,7 @@ enum kernfs_node_flag {
 	KERNFS_EMPTY_DIR	= 0x1000,
 	KERNFS_HAS_RELEASE	= 0x2000,
 	KERNFS_REMOVING		= 0x4000,
+	KERNFS_LAZY		= 0x8000,  /* subsystem defers child creation */
 };
 
 /* @flags for kernfs_create_root() */
@@ -239,6 +240,7 @@ struct kernfs_node {
  * kernfs_node parameter.
  */
 struct kernfs_syscall_ops {
+	/* Syscall-reactive callbacks */
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
 
 	int (*mkdir)(struct kernfs_node *parent, const char *name,
@@ -248,6 +250,12 @@ struct kernfs_syscall_ops {
 		      const char *new_name);
 	int (*show_path)(struct seq_file *sf, struct kernfs_node *kn,
 			 struct kernfs_root *root);
+
+	/* Lazy dispatch for KERNFS_LAZY directories; @parent is pinned
+	 * via kernfs_get_active() across the call. Both may sleep.
+	 */
+	int (*populate)(struct kernfs_node *parent, const char *name);
+	void (*populate_all)(struct kernfs_node *parent);
 };
 
 struct kernfs_node *kernfs_root_to_node(struct kernfs_root *root);
@@ -398,6 +406,24 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 	return kn->flags & KERNFS_NS;
 }
 
+/**
+ * kernfs_set_lazy - mark a kernfs directory for lazy population
+ * @kn: directory kernfs_node (must not be namespaced)
+ *
+ * Sets KERNFS_LAZY under kernfs_rwsem to serialize with other
+ * kn->flags writers.  The flag is set once and never cleared.
+ *
+ * Populate dispatch does not propagate the namespace tag, so a
+ * namespaced lazy node would silently fail tagged lookups.  The
+ * function therefore rejects namespaced and non-directory nodes.
+ *
+ * Return:
+ * * %0           - on success.
+ * * %-EINVAL     - @kn is namespaced (@kn->ns non-NULL or KERNFS_NS
+ *                  flag set) or is not a directory.
+ */
+int kernfs_set_lazy(struct kernfs_node *kn);
+
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
 int kernfs_path_from_node(struct kernfs_node *kn_to, struct kernfs_node *kn_from,
 			  char *buf, size_t buflen);
@@ -481,6 +507,8 @@ static inline void kernfs_enable_ns(struct kernfs_node *kn) { }
 static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 { return false; }
 
+static inline int kernfs_set_lazy(struct kernfs_node *kn) { return 0; }
+
 static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 { return -ENOSYS; }
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index bcb5d4e320015..cec6de1720076 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -120,6 +120,16 @@ struct kobj_type {
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
 	const struct ns_common *(*namespace)(const struct kobject *kobj);
 	void (*get_ownership)(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
+
+	/*
+	 * Lazy sysfs population. Invoked from kernfs lookup / readdir
+	 * paths only when the directory is flagged KERNFS_LAZY. May
+	 * sleep; @kobj is pinned across the call. populate() returns
+	 * 0 / -ENOENT / -errno (kernfs propagates non-ENOENT errors
+	 * to userspace). populate_all() is best-effort.
+	 */
+	int (*populate)(struct kobject *kobj, const char *name);
+	void (*populate_all)(struct kobject *kobj);
 };
 
 struct kobj_uevent_env {
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


