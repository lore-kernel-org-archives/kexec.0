Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B4CD4F58
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yB4XsnS5O2tJ5kB+OIL7J7kvYCLgSP2Q9yHfNFYen64=; b=TMfGh4w/2Gw8+vnBHuC7nQHCcz
	2IP6LOLUSMcs41CLYU6/we7NdkCE+5zAz7yDkQZ9g0SOJcnUZ/5KcA71kjWLDfo0q3CCvPKPJAbeN
	/amQzOSPsIzsfc2Gqr4UHx7CJN8mED+gDQ5NRbXEulUn4LJGIOeon/ULbbKszONeOoefKcbmzkifh
	RdBcs3M6zGFSghV5uekO5zGrpqdqm7kAMhmZExm+vGEzmEyCZF6kQmpiok4k1uzbRU+kSbglRVOhD
	iHFw1ltJgOwO1p6qEJLC9yjp2ctki1NEgX5csQcQNtFVh/nZ2q2nR0VBDshZP+gFVhOC7YA/0KOCq
	NSn318MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP9-0000000F2j3-0KOx;
	Mon, 18 May 2026 09:36:55 +0000
Received: from mail-ej1-f74.google.com ([209.85.218.74])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP5-0000000F2cX-3SCB
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 09:36:53 +0000
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bcc22a042b1so265149866b.2
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097009; x=1779701809; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB4XsnS5O2tJ5kB+OIL7J7kvYCLgSP2Q9yHfNFYen64=;
        b=ObI4dQvj6dTeyEV5+yoD4yZdwQO9fxnoI0jNWyPpiWOlBl1kY081MwFk85Y1tfMd3/
         HMNu1XVg7XKSktV94tQeU6tRBVNYbS41XLL2lrS6+TZ9ysDIbaFZehnADf4yGk/FEHXw
         Q6Rur3jn4vQ22NUFMEx7dXzlyPA3R9paYhqYa2r63wHyicstO58kTk6bej8t/hymPlsx
         axAu8tOuzDbIvcglwXUQT6JrurnY+5d0E4RsVphdfyfwp4ep4lfeEpCDYI/xsI0ZrlsP
         IpQ6XR2xZQbSljjUmRbcah1lqU6AnVwmaXp5Wy9C+y4GLBqM82aV2bZRW3zMMCqtnPhq
         Pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097009; x=1779701809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB4XsnS5O2tJ5kB+OIL7J7kvYCLgSP2Q9yHfNFYen64=;
        b=R/L5OJlVmN/QOoix1rBI03bdUOQnFL2xq/Yj4OueEfq6CJxZtCy0B0D1YZcsotP6au
         eI+zK7Y6UuqgrI2jNRC0ECP6tdWAEoX+j/AJnMCBkCASi14M/E/OtlzGkIt40kE63GcP
         E+Hd1QP+Q2uhoIf1BoBLwH7N9faWoXPY3lSuJx+0MYVb6hEiSdBtDcPbWJzGqioHTYw4
         QwtFrDqitwJIWT8LG4LxB3ZSy8J3NN+LEkfHmOUDWv3Vg3yslnOnN+a5tTqUD3Ekv+PH
         P9iI3w7iJMgoUkR1IXDgJwo9oaR60Am9Qn3t8SO1EAIsO8gkvAT6AyNB/XyQGfBygcta
         VPaA==
X-Forwarded-Encrypted: i=1; AFNElJ/g5B7qFI2f/ev5x2FKlbZKCc9QTpeexsgzaPqlgyvQkysRnYFMQJm9Z93277B0vjvRPUR9Gg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwT4HgSjOpqXd3UoVLkCI5dyuGxWU8I3FcsGG+Z6y3T5pMRWJi3
	RP+SISpt4ej+4xifbzNrCEHLBe/FOcMifloBvaVuCxidZeiFBG6Mx1+rFIj8WBsNmWIk0jZsGAO
	MAH4TVXNGeJSGmmeOVg==
X-Received: from edj17.prod.google.com ([2002:a05:6402:3251:b0:66f:cd9f:9fd7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d1d:b0:bb9:36dd:cd3d with SMTP id a640c23a62f3a-bd51776c98bmr687818166b.4.1779097008430;
 Mon, 18 May 2026 02:36:48 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:36 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <823a5f2af1d794c61560d0bad96863c4c851f29b.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 6/9] kvm: guest_memfd: Add support for freezing and
 unfreezing mappings
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_023651_917820_37190F1F 
X-CRM114-Status: GOOD (  26.51  )
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

This patch introduces the freeze on gmem_inode which prevents
the fallocate call. This will avoid gmem file modification when it is
being preserved

Used srcu lock to synchronise the freeze call, where write blocks
until all the reads are free. And reads are re-entrant.

This can be extended to freeze the fault path as well. But currently
the fault failure due to sudden freeze might be fatal to the running
guest.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 112 +++++++++++++++++++++++++++++++++++++----
 virt/kvm/guest_memfd.h |   5 ++
 2 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6740ae2bf948..91e42f717286 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,11 +7,13 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/srcu.h>
 #include "guest_memfd.h"
 
 #include "kvm_mm.h"
 
 static struct vfsmount *kvm_gmem_mnt;
+static struct srcu_struct kvm_gmem_freeze_srcu;
 
 
 #define kvm_gmem_for_each_file(f, inode) \
@@ -96,6 +98,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	/* TODO: Support huge pages. */
 	struct mempolicy *policy;
 	struct folio *folio;
+	int idx;
 
 	/*
 	 * Fast-path: See if folio is already present in mapping to avoid
@@ -273,16 +276,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 			       loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	int ret;
+	int idx;
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE))
-		return -EOPNOTSUPP;
+	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
+	if (kvm_gmem_is_frozen(inode)) {
+		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+		return -EPERM;
+	}
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
-		return -EOPNOTSUPP;
+	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
-	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
-		return -EINVAL;
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
@@ -291,6 +308,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!ret)
 		file_modified(file);
+
+out:
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
 	return ret;
 }
 
@@ -944,7 +964,9 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 
 static void kvm_gmem_free_inode(struct inode *inode)
 {
-	kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	kmem_cache_free(kvm_gmem_inode_cachep, gi);
 }
 
 static const struct super_operations kvm_gmem_super_operations = {
@@ -1001,12 +1023,21 @@ int kvm_gmem_init(struct module *module)
 	if (!kvm_gmem_inode_cachep)
 		return -ENOMEM;
 
+	ret = init_srcu_struct(&kvm_gmem_freeze_srcu);
+	if (ret)
+		goto err_cache;
+
 	ret = kvm_gmem_init_mount();
-	if (ret) {
-		kmem_cache_destroy(kvm_gmem_inode_cachep);
-		return ret;
-	}
+	if (ret)
+		goto err_srcu;
+
 	return 0;
+
+err_srcu:
+	cleanup_srcu_struct(&kvm_gmem_freeze_srcu);
+err_cache:
+	kmem_cache_destroy(kvm_gmem_inode_cachep);
+	return ret;
 }
 
 void kvm_gmem_exit(void)
@@ -1014,5 +1045,64 @@ void kvm_gmem_exit(void)
 	kern_unmount(kvm_gmem_mnt);
 	kvm_gmem_mnt = NULL;
 	rcu_barrier();
+	cleanup_srcu_struct(&kvm_gmem_freeze_srcu);
 	kmem_cache_destroy(kvm_gmem_inode_cachep);
 }
+
+/**
+ * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
+ * @inode: The guest_memfd inode.
+ * @freeze: True to freeze, false to unfreeze.
+ *
+ * This API is used strictly during the live update / preservation transition
+ * window to prevent host userspace and guest-side faults from making any
+ * mapping modifications (such as fallocate or page fault allocation)
+ * to the guest_memfd page cache.
+ *
+ * NOTE: Currently It is only checked at fallocate path. Page fault path NOT
+ * touched.
+ *
+ * Synchronization Strategy (Sleepable RCU):
+ * To avoid high-contention VFS locks (like inode_lock or filemap_invalidate_lock)
+ * on the vCPU page fault hot paths, this subsystem implements a lightweight,
+ * system-wide Sleepable RCU (SRCU) mechanism (`kvm_gmem_freeze_srcu`):
+ *
+ * Though currently, the freeze is checked only in fallocate, but it might be needed
+ * to the fault path as well in future to completely freeze the inode.
+ *
+ * Global vs. Per-Inode SRCU:
+ * A single system-wide global static `srcu_struct` is used instead of a per-inode
+ * SRCU structure to completely prevent unprivileged users from exhausting the
+ * host's per-CPU memory allocator. Because `init_srcu_struct()` allocates per-CPU
+ * memory via `alloc_percpu()`, which is not accounted by memory cgroups (memcg),
+ * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
+ * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
+ * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
+ *
+ * Flag Modification Note:
+ * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in `GMEM_I(inode)->flags`
+ * that is mutated dynamically at runtime (all other flags are creation-time flags
+ * which remain strictly read-only), there is no possibility of concurrent bit-
+ * modification races. Therefore, a standard `WRITE_ONCE` is fully safe and
+ * does not require complex `cmpxchg` synchronization loops.
+ *
+ */
+void kvm_gmem_freeze(struct inode *inode, bool freeze)
+{
+	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
+
+	if (freeze)
+		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
+	else
+		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
+
+	WRITE_ONCE(GMEM_I(inode)->flags, flags);
+
+	if (freeze)
+		synchronize_srcu(&kvm_gmem_freeze_srcu);
+}
+
+bool kvm_gmem_is_frozen(struct inode *inode)
+{
+	return READ_ONCE(GMEM_I(inode)->flags) & GUEST_MEMFD_F_MAPPING_FROZEN;
+}
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index c528b046dd69..028c348a1023 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -29,11 +29,16 @@ struct gmem_inode {
 	u64 flags;
 };
 
+/* Internal kernel-only flags (must not overlap with UAPI flags) */
+#define GUEST_MEMFD_F_MAPPING_FROZEN	(1ULL << 63)
+
 static inline struct gmem_inode *GMEM_I(struct inode *inode)
 {
 	return container_of(inode, struct gmem_inode, vfs_inode);
 }
 
 struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
+void kvm_gmem_freeze(struct inode *inode, bool freeze);
+bool kvm_gmem_is_frozen(struct inode *inode);
 
 #endif /* __KVM_GUEST_MEMFD_H__ */
-- 
2.54.0.563.g4f69b47b94-goog


