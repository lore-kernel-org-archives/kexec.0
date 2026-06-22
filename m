Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A4CDB477
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrCK2iLTFuPkCKKXsEtILhMjhO8cYkJcRVq4TpiCh/Y=; b=k0jFTCemKV5JKodN2qVpUPWMHH
	2FMf57NT5WSh8QuMCZx0HC4kB9Z6nG5SsQimERYG0kMCQ++G+V5jzo+Z97UHn4n7AONowy8VjWfpb
	jSFduLAYLItF0/TdsbPy0eRwF0cQ0r2ObJkKrYMUQ6uStv/4H7HoT8T2AZVBRRYqy8REFIww8/hfW
	bSl8oyNq5/7Q2thNcFJz2FBRPb/pILLPcbC5nUM0WyMVKBzF7DOFvFYLwlBiYXfJsSG6RSKM/PYvK
	kv6QnFXay8j2V6S+xuOdCwqTItRy9p6yPdyBC6ZmiE2py8filW0KSpUIVTVueBXP9j0IAqE2Vv/w8
	BEyyD0IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhm-00000005JJS-0ATF;
	Mon, 22 Jun 2026 18:49:10 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhj-00000005JGi-220o
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:08 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-695bbac451bso5137279a12.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154145; x=1782758945; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrCK2iLTFuPkCKKXsEtILhMjhO8cYkJcRVq4TpiCh/Y=;
        b=jc2FR8i0ae/6oa33lUaXD+UfYnTmwYMo7A0wV6nwy8RuUAahYqLRtq3K6wR6IF+UuZ
         SoZlEV5+w36997LIe9xnwHJIrnEG+JV3q+mh2vtW0Y+C282j0HuuM/98z/7oWOlm3aLg
         0NcNWpyKMrlXCBxYir0vapf4GS4dPt7r4ki62EX5RQlaTgJ4yX969xBmDxNmvDNQmS3k
         EBUb70M9t22RzTSKHb1NjIMEQVzfhDVXj/zd8XgGWtivZy1tr3+U1BYi5wXp+QExZXzQ
         qrntyYHqln1dP8lfyEQbGU3w5k4sJLDVCxN/mRQJhGvdvo2JcjbbbEUz/HH4H4pbFrHT
         WW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154145; x=1782758945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrCK2iLTFuPkCKKXsEtILhMjhO8cYkJcRVq4TpiCh/Y=;
        b=G/iH8QxgpKRiqTdm1zKrwkZliCwS/FeLVEYyI2NPy0b1KOhAOSg23WjRCdLxuOc+Bd
         7zFO+VB7JfzZvFaJR5glqtImQbflHkrHuyF70pnUhF2ENHI27tIZcaSDxfOKCpDKk94s
         nrAidDzbs+/zNZfEs4/HMhl7rnHzhWPCDNmqLPgBW1PyjrfTqNG2nHfcEWT4dOps6pBa
         5SC24uXzfK/eMA4sAkK67n8LyWHJiNfPHvC9biyzvRcQDrpKNIz7hVQjGSQ2lrG/avxa
         izA25iwyHb10r13mYpnDqmNQiwthwC8XmHVmWJVmWDS2QC0EjaMu5P5SRNWBnDxWW8Br
         xJdw==
X-Forwarded-Encrypted: i=1; AFNElJ9/3pd4juArZbz/AU+YWMdz8SJTvq/xR8Gje+3qyMZYJDafCvl0pDj5zahy2YAXR8Yu4ubtpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyS/vt4JD7kfE59IP+JniEvxxartcxdK5G3MVbIXyuRRe63pUVJ
	RM3HV2acPfz9gkacwdb23pCAiCkA7GhbGFC/RQu1Ytnku4E8KiZ9btjkd2Kt2nt11DP3jsEQKTf
	uXUDP1GzHUPt2AaJmPw==
X-Received: from edsl17.prod.google.com ([2002:aa7:d951:0:b0:695:f6a4:adb4])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:35ca:b0:697:bd1d:116d with SMTP id 4fb4d7f45d1cf-697bd1d14acmr2221698a12.27.1782154145133;
 Mon, 22 Jun 2026 11:49:05 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:46 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-5-tarunsahu@google.com>
Subject: [PATCH v3 4/9] kvm: guest_memfd: Move internal definitions and helper
 to new header
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_114907_557161_44A53B81 
X-CRM114-Status: GOOD (  20.87  )
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
index 8669068..fe1adc9b 100644
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
@@ -557,23 +531,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
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
@@ -612,8 +580,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return file;
 
 err_inode:
 	iput(inode);
@@ -621,7 +588,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
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
index 0000000..c528b04
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
2.55.0.rc0.786.g65d90a0328-goog


