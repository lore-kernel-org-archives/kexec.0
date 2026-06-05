Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693E3CD8C87
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1s9Gl9n+JDRxm+uLKvGaoj9Iw7+lf3bKjXDLeITLpkQ=; b=kmf0IDA3uedi5T9AqsBTAtN2iB
	1co7i2uyhINnc2iNYcqxZEcujAxmOo3rQmz+XYRepAvdW9xhC4gqMGeQzzTHquJuyBj89JdfObNYP
	G72mm9HDCF7KhgHuAjpGmpOOvLLWeQHgVFs8ydi7SQWiyzMPTSUxuplw1tvgV0K1PyBecB+EGYFHz
	OG17rKMKTtGf107sVy5LQbFm102M7a8Rtatap5A8I0TD10VdCr6ksrUl3QSvwDbE7XXe5gU2kFKOn
	GwTpUphxNcYyF/4b9vWt4JRJzPmn23PwNcq6kaIQ4pxs9Jnznb4QrUByh+MLkSQneOtFd0WhEF5Ho
	enjJh0pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2Q-00000000xI2-2GVo;
	Fri, 05 Jun 2026 17:08:54 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2N-00000000xCf-0f1K
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 17:08:52 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-beb6d964066so23389566b.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679327; x=1781284127; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9Gl9n+JDRxm+uLKvGaoj9Iw7+lf3bKjXDLeITLpkQ=;
        b=Jwmfd/SWTcsvSIKMcTRUeCCq/ddrb1iQ07uDTHs6jfjYdxzbrQLH/Yot8K+W4e4tQK
         W/WYmxGgYOBfTHaXRmsZ3bwtZcFVb2QwRFDd+ewFaqVzJyR8b9HIhDHdMtPVGUv6BKgl
         DRW2YJXg+J1QHjtyw/aVH4bzpGCMhx/R6y2UyqjNpe5Bwkx+XSm5j0L8NyJXJxEN8UnX
         NRPR5s2IO/gelc0of1vkeuMMveGS5bgemvvMgQ5f7TZmYWA2bYZIf2T+wjbrp4umfvcz
         KUYE8qcwTXt8N8dKhsSsyiWoEcIBuVzmEnnksvfoBO9pX/pP3O2xRZHbBaPR9gZcumMy
         MTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679327; x=1781284127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9Gl9n+JDRxm+uLKvGaoj9Iw7+lf3bKjXDLeITLpkQ=;
        b=FWGNteHiDxW4GapMV2/P31HhsvMLP2RcvH2N1DSSty0np4RdxxtdXvaWb+d6/ussWJ
         Pu35kjS/ORB1UFhGm9EZRX4/uyKTcUL+iT101hUEM0sSOjn5ljWO6Rzm3CEmkh0C/AcU
         KiqchoccEIIgykVCgXpxp0ZQ4ZgnviLOFr4a62QF2fjVN9iJWDYuADwyZczDHAMykd9E
         seBOGNQuucpqWqYbTbbZzTT3qBhul8edLPszA5l8BM5k7WVwvtVvt+FGmcj6NIV8jssY
         rXWK5DsLUuEkdU4qSvrgV1tUhNNRAB52Px5dVpaVt7zOCHwC8nimG4Q8leE209hZzvTa
         OVIg==
X-Forwarded-Encrypted: i=1; AFNElJ+1hILOIV8wW+aVMOlkovNHb6UWS5lcepz9ULhmg0O9+m6XEwSIBd4t78VZGb6k712j7I+NWw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZgjwthULIGnqm1JALOxhtRPB9jIU6PzIoR021dCUOPGOfspwv
	ydFJ8Y4ETCv4kq3w9juhPKboV1KJenn7aTxSLLXTqPO4RdgNsVqELXdG2AV3+oHzbqDgsvhcQpr
	h9SPosxPM9h0te2rVOw==
X-Received: from edty21.prod.google.com ([2002:aa7:ccd5:0:b0:691:5097:3e07])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f59b:b0:bed:6e53:bb1a with SMTP id a640c23a62f3a-bf3749d1646mr252719466b.48.1780679327271;
 Fri, 05 Jun 2026 10:08:47 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:30 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <769d0adac847d638fceb3fce093755a74e686582.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 05/10] kvm: guest_memfd: Move internal definitions and
 helper to new header
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
X-CRM114-CacheID: sfid-20260605_100851_360155_9A72DB81 
X-CRM114-Status: GOOD (  20.10  )
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

To support guest_memfd memory preservation with LUO, guest_memfd luo
code needs to access guest_memfd internals and reconstruct guest_memfd
file instances from a preserved state.

Extract gmem_file, gmem_inode, and the GMEM_I() helper from guest_memfd.c
into a new internal header virt/kvm/guest_memfd.h.

Additionally, split __kvm_gmem_create() to expose a non-static
__kvm_gmem_create_file() helper. This helper returns a struct file
instead of a file descriptor, enabling file creation and initialization
without installing it into a file descriptor table.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 virt/kvm/guest_memfd.c | 68 +++++++++++++++++-------------------------
 virt/kvm/guest_memfd.h | 39 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 69c9d6d546b2..6740ae2bf948 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,38 +7,12 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include "guest_memfd.h"
 
 #include "kvm_mm.h"
 
 static struct vfsmount *kvm_gmem_mnt;
 
-/*
- * A guest_memfd instance can be associated multiple VMs, each with its own
- * "view" of the underlying physical memory.
- *
- * The gmem's inode is effectively the raw underlying physical storage, and is
- * used to track properties of the physical memory, while each gmem file is
- * effectively a single VM's view of that storage, and is used to track assets
- * specific to its associated VM, e.g. memslots=>gmem bindings.
- */
-struct gmem_file {
-	struct kvm *kvm;
-	struct xarray bindings;
-	struct list_head entry;
-};
-
-struct gmem_inode {
-	struct shared_policy policy;
-	struct inode vfs_inode;
-	struct list_head gmem_file_list;
-
-	u64 flags;
-};
-
-static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
-{
-	return container_of(inode, struct gmem_inode, vfs_inode);
-}
 
 #define kvm_gmem_for_each_file(f, inode) \
 	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
@@ -556,23 +530,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags)
 {
 	static const char *name = "[kvm-gmem]";
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
+	int err;
 
 	f = kzalloc_obj(*f);
-	if (!f) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!f)
+		return ERR_PTR(-ENOMEM);
 
 	/* __fput() will take care of fops_put(). */
 	if (!fops_get(&kvm_gmem_fops)) {
@@ -611,8 +579,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return file;
 
 err_inode:
 	iput(inode);
@@ -620,7 +587,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	fops_put(&kvm_gmem_fops);
 err_gmem:
 	kfree(f);
-err_fd:
+	return ERR_PTR(err);
+}
+
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+{
+	struct file *file;
+	int fd, err;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	file = __kvm_gmem_create_file(kvm, size, flags);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+	return fd;
+
+err_put_fd:
 	put_unused_fd(fd);
 	return err;
 }
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
new file mode 100644
index 000000000000..c528b046dd69
--- /dev/null
+++ b/virt/kvm/guest_memfd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_GUEST_MEMFD_H__
+#define __KVM_GUEST_MEMFD_H__ 1
+
+#include <linux/kvm_host.h>
+#include <linux/fs.h>
+#include <linux/mempolicy.h>
+
+/*
+ * A guest_memfd instance can be associated multiple VMs, each with its own
+ * "view" of the underlying physical memory.
+ *
+ * The gmem's inode is effectively the raw underlying physical storage, and is
+ * used to track properties of the physical memory, while each gmem file is
+ * effectively a single VM's view of that storage, and is used to track assets
+ * specific to its associated VM, e.g. memslots=>gmem bindings.
+ */
+struct gmem_file {
+	struct kvm *kvm;
+	struct xarray bindings;
+	struct list_head entry;
+};
+
+struct gmem_inode {
+	struct shared_policy policy;
+	struct inode vfs_inode;
+	struct list_head gmem_file_list;
+
+	u64 flags;
+};
+
+static inline struct gmem_inode *GMEM_I(struct inode *inode)
+{
+	return container_of(inode, struct gmem_inode, vfs_inode);
+}
+
+struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
+
+#endif /* __KVM_GUEST_MEMFD_H__ */
-- 
2.54.0.1032.g2f8565e1d1-goog


