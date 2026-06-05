Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118CDCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVr8ACkrUKM/95aQGMpWS2mbVNjU7wBFEcPhhv7u9U8=; b=qxsukkegRsvmc5DTejbC0ttku4
	eeluy5FVE53KP52S8l2fA4NxBYZjEG37qS7WO72bTAAFpI8HkQTkryGv4Iynmgc75RDB9wCTH04YS
	OB9uQr0OGuICzVPEhnv0lXbdk1GWjWtuzDPbCiNjmQ8EC5qF7FHahdU/V/cHCpk5w8vKPTlk1KKhB
	u1rG0Z9+bBHzft4cRecZyvsOPu04Zf4wvrxVUwXE5ZqgZAJSrlhSzmHVXBIRxxCVUb0Pw8PTpzWwE
	aJAO4PshQbLhii42Rqx8coTaLINMRJu06LpkrUxjdWLZOUpmZ8T1JlR+wTcCsdPmfMWvpTjvvk2Dy
	i1rCogUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2R-00000000xJy-3tMb;
	Fri, 05 Jun 2026 17:08:55 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2O-00000000xDm-26LT
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 17:08:53 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bed16fc8424so204255166b.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679328; x=1781284128; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVr8ACkrUKM/95aQGMpWS2mbVNjU7wBFEcPhhv7u9U8=;
        b=jXxw7llexECY1O99G9R8tUUurJojhlKasRoQNjWKb5opPitQpxWciuQRnO7/ciGyIm
         YteXuAAhLsZ6FD/91Fc8bN/3A7InDsgEtIXUyxp7LC9oDHW3bEhhP1fz6cRbM5pO8Ek/
         LSLUocp5sFhio/Ynw7JokZdj0BYSU3Rw17UmWCyUjf+Z5HbNfQRj8awHnF5mDMwH92y5
         tMtymSa5vzZR6GyuM8n0+V0n9iMjF/BbHzTFmhcsOjw/5hUh6hh5+3aLWlLw99GFcFQM
         SeY6FrZRZxgiBh7Sc75JAcmdEJGXauuPnasD6CG63j4uI9Y8hhgjJ1xVrLB8ySQUimNY
         XuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679328; x=1781284128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVr8ACkrUKM/95aQGMpWS2mbVNjU7wBFEcPhhv7u9U8=;
        b=OoKa/aubpYVQZsk1mdpy8S5L7TmD+//+6Sfyp9l4hcAjm6H2N5HJownPHxN/96wUYg
         VPMdfQhz2SJTsBzFAgN9JC2RXVABJFd+SkKP2osy13Sx3rNWwVjiKAf3FV16DrawyjFs
         7CdLHGy1hOY1Mgul1t95HkZvSYuhmnHCpas2i35TO7ngXGAVhYf2dZAtXZYCBEqvzVQU
         we527YSo9fxOXCxeML07oiySl+oMGcDF0iC7F4quZO2nvIA6RXF5v6IKJGMqyxkICYmJ
         0+5g1vOil2kvXjz9mb29PtZWfOUbxJ2KKMz5T/6tJOcluUySDZ+sbtXRG4lC0c7BN6Uf
         eeUA==
X-Forwarded-Encrypted: i=1; AFNElJ8+8JEACAl9GXOPscSYfczRD4MB5BoEUBYrXgmDYZYUpKWzlig+CFByVycse9EgiXf0GbXnBw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw62SHM/RzL7/VQyOVhf1N68XumEJbhSYGFsH4Kni0T7fzGipsh
	Y890ZzH79nJ9iU9Q1/Pn3kkXgwzwnqtbfL6G/rxTEsFlKn7WcAqrFHDiCUPgVr0UO22E6NrKZHN
	dTOfrvvkPV0RJggEk+g==
X-Received: from ejcaf14.prod.google.com ([2002:a17:906:998e:b0:bec:8aca:9459])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:948e:b0:bf1:a59e:653f with SMTP id a640c23a62f3a-bf371e4379dmr240039766b.28.1780679328253;
 Fri, 05 Jun 2026 10:08:48 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:31 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing and
 unfreezing mappings
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_100852_606307_8C947C77 
X-CRM114-Status: GOOD (  24.74  )
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
the fallocate call and any new page fault allocation. This will avoid
gmem file modification when it is being preserved

Used srcu lock to synchronise the freeze call, where write blocks
until all the reads are free. And reads are re-entrant.

Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
must handle this properly as every new fault will fail.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 117 +++++++++++++++++++++++++++++++++++++----
 virt/kvm/guest_memfd.h |   5 ++
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6740ae2bf948..b94639cdf312 100644
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
@@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	if (!IS_ERR(folio))
 		return folio;
 
+	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
+	if (kvm_gmem_is_frozen(inode)) {
+		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+		return ERR_PTR(-EPERM);
+	}
+
 	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
 	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
 					 FGP_LOCK | FGP_CREAT,
 					 mapping_gfp_mask(inode->i_mapping), policy);
 	mpol_cond_put(policy);
 
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
+
 	/*
 	 * External interfaces like kvm_gmem_get_pfn() support dealing
 	 * with hugepages to a degree, but internally, guest_memfd currently
@@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
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
@@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	if (!ret)
 		file_modified(file);
+
+out:
+	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
 	return ret;
 }
 
@@ -944,7 +972,9 @@ static void kvm_gmem_destroy_inode(struct inode *inode)
 
 static void kvm_gmem_free_inode(struct inode *inode)
 {
-	kmem_cache_free(kvm_gmem_inode_cachep, GMEM_I(inode));
+	struct gmem_inode *gi = GMEM_I(inode);
+
+	kmem_cache_free(kvm_gmem_inode_cachep, gi);
 }
 
 static const struct super_operations kvm_gmem_super_operations = {
@@ -1001,12 +1031,21 @@ int kvm_gmem_init(struct module *module)
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
@@ -1014,5 +1053,61 @@ void kvm_gmem_exit(void)
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
+ * Synchronization Strategy (Sleepable RCU):
+ * To avoid high-contention VFS locks (like inode_lock or
+ * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
+ * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
+ * (`kvm_gmem_freeze_srcu`):
+ *
+ * Global vs. Per-Inode SRCU
+ * ======================
+ * A single system-wide global static `srcu_struct` is used instead of a
+ * per-inode SRCU structure to completely prevent unprivileged users from
+ * exhausting the host's per-CPU memory allocator. Because
+ * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
+ * is not accounted by memory cgroups (memcg),
+ * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
+ * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
+ * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
+ *
+ * Flag Modification Note:
+ * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
+ * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
+ * flags are creation-time flags which remain strictly read-only), there is
+ * no possibility of concurrent bit-modification races. Therefore, a standard
+ * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
+ * synchronization loops.
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
2.54.0.1032.g2f8565e1d1-goog


