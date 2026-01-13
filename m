Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C00D29DCC
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 05:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ZdzwmCXe3gMoHyDDRR+IMK5xDno+0lJCEG1fStGGwY=; b=xzR7nAZHKKUv8sojvBPZSBtIlf
	FrpRxQIE0NPzywtjoZ6oImtuLQCrNNgdnHP3yhw6L1tqUegXiMjKekMx6LL4aKJs2Mly0HRfGbCQ5
	dzMROTyEU5z2ImEm9mIOQotW+Cj0tZchHFKkwFJmvLKY5oHaQJxH4iXA7Nq0ewiGOL4gA/E/l7/dT
	azbf6AnvYGMjT5LchS+HCWK+1slgbWhtvgZ05+yT2suKzZWVw5KofST0w8Zc7QZw/llj4FJeFL1cN
	oXtGBgY8xSWw4TyphjYICXBvX36fKYSwMQIi8+L0/gZqFJErrnCxfktYhJfwljY/LyTVPvWW4loJ/
	jUo0bU1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX46-00000006YhE-2IjA;
	Tue, 13 Jan 2026 05:35:38 +0000
Received: from mail-dy1-x134a.google.com ([2607:f8b0:4864:20::134a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfX43-00000006Yex-1dpV
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 05:35:36 +0000
Received: by mail-dy1-x134a.google.com with SMTP id 5a478bee46e88-2ae26a77b76so7748525eec.0
        for <kexec@lists.infradead.org>; Mon, 12 Jan 2026 21:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768282532; x=1768887332; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZdzwmCXe3gMoHyDDRR+IMK5xDno+0lJCEG1fStGGwY=;
        b=qBj0qI/4YxZ3r3/jPcW2ReP300W9W0JDrB6gFUnbrzHulHl0MpVtScZjynsF4GDhab
         j5XDMVDW5FMiZyYnnQxhUgs1/G4R2dbJYXEPtRPggQDdJhE2j51N0hSW1utIxUeUgUjH
         2cp+4J31f8FRot1irM2tyQncVJNiinKbjOwNAZ9rJdHrKxK/abH0WLLiesjspnbEmSan
         sfJA2pFp8h3kw7FLivzKqeONQe+zqIucRqrzX1G0LYNLHtoF6KixZf4eHSVUcDo9IPhq
         bGwbsW/0KrpdkjSzbaUzQXc/ChK1Y980ZK1wMMtDKCG2vYF9GDTbxen2Kkytg6HVuB8i
         AYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768282532; x=1768887332;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZdzwmCXe3gMoHyDDRR+IMK5xDno+0lJCEG1fStGGwY=;
        b=CJFrEPcfmV2ksFQ76FQRyG/wmPF12og6pmYcZ6Mv1GjMGP8CZGO1J9JApn/0j7nOvA
         lS2BkIG6sBtCzE1vn8swDdS4Bmwo0qWBHkRcc7AeTnat+LmJIYVJXBHJiu35KL3XjYmR
         JBZGLk1+vZ9j/epM24kMaul+MUSACWZND3Rknuzqh+DnYf7DpiCKaY18lD5EoPNafO4d
         6U5/4NmMkfY/QE5N+XWv9V09EcgoCjGI+bso4nkzlUrMsIYijk/lQPxXOMOKFtOVpWp0
         jAEs+EZUVz5STfYZKB2WGoNFZn1n0o9LEFb+7etuL1F99Ir7AEDwo5V8TNZSsP8oCfuj
         7cYA==
X-Forwarded-Encrypted: i=1; AJvYcCUnsQ5Q7bOMz9YEeYCnZudPFnSPamsWnvzHK2uL+MM9RzCe61xm+cp83PG6NDeJGEwr5TT2mA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzzlx0H5hDEG23Tcr2wg+sDTF84nQCbBDR83oyJrt8Zaflqk7rk
	JxeTIMPajwKp5lOMvcNiMYD/2aY/59uFe454pb/GFQlSqAf0QH8zTeAkDWe4y12BAhf2XpBGJj0
	vEV6UyCjCDnnoxQ==
X-Google-Smtp-Source: AGHT+IHQKmij8n+nGpsHN7+O5LBztfLAEM8Fv+Jj9CZ6VEsfpurzRy3SztANuDZc53cc5UcB+fuJCx6tqK2Jpw==
X-Received: from dlbrf6.prod.google.com ([2002:a05:7022:f206:b0:11d:ccc4:4c98])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:b14:b0:11f:391c:d01f with SMTP id a92af1059eb24-121f8b8d709mr17436261c88.38.1768282532012;
 Mon, 12 Jan 2026 21:35:32 -0800 (PST)
Date: Mon, 12 Jan 2026 21:35:23 -0800
In-Reply-To: <20260113053524.84186-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20260113053524.84186-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113053524.84186-3-jasonmiu@google.com>
Subject: [PATCH v5 2/2] kho: Remove finalize state and clients
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_213535_479759_2ACB7192 
X-CRM114-Status: GOOD (  32.73  )
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

Eliminate the `kho_finalize()` function and its associated state from
the KHO subsystem. The transition to a radix tree for memory tracking
makes the explicit "finalize" state and its serialization step
obsolete.

Remove the `kho_finalize()` and `kho_finalized()` APIs and their stub
implementations. Update KHO client code and the debugfs interface to
no longer call or depend on the `kho_finalize()` mechanism.

Complete the move towards a stateless KHO, simplifying the overall
design by removing unnecessary state management.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 Documentation/admin-guide/mm/kho.rst        | 53 +++++----------------
 Documentation/core-api/kho/index.rst        | 12 -----
 kernel/liveupdate/kexec_handover.c          | 21 +-------
 kernel/liveupdate/kexec_handover_debugfs.c  | 23 ---------
 kernel/liveupdate/kexec_handover_internal.h |  3 --
 kernel/liveupdate/luo_core.c                | 12 +----
 kernel/liveupdate/luo_flb.c                 |  2 +-
 tools/testing/selftests/kho/init.c          | 20 --------
 8 files changed, 14 insertions(+), 132 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 6dc18ed4b886..454b378cf239 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -28,20 +28,10 @@ per NUMA node scratch regions on boot.
 Perform a KHO kexec
 ===================
 
-First, before you perform a KHO kexec, you need to move the system into
-the :ref:`KHO finalization phase <kho-finalization-phase>` ::
-
-  $ echo 1 > /sys/kernel/debug/kho/out/finalize
-
-After this command, the KHO FDT is available in
-``/sys/kernel/debug/kho/out/fdt``. Other subsystems may also register
-their own preserved sub FDTs under
-``/sys/kernel/debug/kho/out/sub_fdts/``.
-
-Next, load the target payload and kexec into it. It is important that you
-use the ``-s`` parameter to use the in-kernel kexec file loader, as user
-space kexec tooling currently has no support for KHO with the user space
-based file loader ::
+To perform a KHO kexec, load the target payload and kexec into it. It
+is important that you use the ``-s`` parameter to use the in-kernel
+kexec file loader, as user space kexec tooling currently has no
+support for KHO with the user space based file loader ::
 
   # kexec -l /path/to/bzImage --initrd /path/to/initrd -s
   # kexec -e
@@ -52,40 +42,19 @@ For example, if you used ``reserve_mem`` command line parameter to create
 an early memory reservation, the new kernel will have that memory at the
 same physical address as the old kernel.
 
-Abort a KHO exec
-================
-
-You can move the system out of KHO finalization phase again by calling ::
-
-  $ echo 0 > /sys/kernel/debug/kho/out/active
-
-After this command, the KHO FDT is no longer available in
-``/sys/kernel/debug/kho/out/fdt``.
-
 debugfs Interfaces
 ==================
 
+These debugfs interfaces are available when the kernel is compiled with
+``CONFIG_KEXEC_HANDOVER_DEBUGFS`` enabled.
+
 Currently KHO creates the following debugfs interfaces. Notice that these
 interfaces may change in the future. They will be moved to sysfs once KHO is
 stabilized.
 
-``/sys/kernel/debug/kho/out/finalize``
-    Kexec HandOver (KHO) allows Linux to transition the state of
-    compatible drivers into the next kexec'ed kernel. To do so,
-    device drivers will instruct KHO to preserve memory regions,
-    which could contain serialized kernel state.
-    While the state is serialized, they are unable to perform
-    any modifications to state that was serialized, such as
-    handed over memory allocations.
-
-    When this file contains "1", the system is in the transition
-    state. When contains "0", it is not. To switch between the
-    two states, echo the respective number into this file.
-
 ``/sys/kernel/debug/kho/out/fdt``
-    When KHO state tree is finalized, the kernel exposes the
-    flattened device tree blob that carries its current KHO
-    state in this file. Kexec user space tooling can use this
+    The kernel exposes the flattened device tree blob that carries its
+    current KHO state in this file. Kexec user space tooling can use this
     as input file for the KHO payload image.
 
 ``/sys/kernel/debug/kho/out/scratch_len``
@@ -100,8 +69,8 @@ stabilized.
     it should place its payload images.
 
 ``/sys/kernel/debug/kho/out/sub_fdts/``
-    In the KHO finalization phase, KHO producers register their own
-    FDT blob under this directory.
+    KHO producers can register their own FDT blob another binary blob under
+    this directory.
 
 ``/sys/kernel/debug/kho/in/fdt``
     When the kernel was booted with Kexec HandOver (KHO),
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index 002bdf0beb2e..0a2dee4f8e7d 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -71,18 +71,6 @@ for boot memory allocations and as target memory for kexec blobs, some parts
 of that memory region may be reserved. These reservations are irrelevant for
 the next KHO, because kexec can overwrite even the original kernel.
 
-.. _kho-finalization-phase:
-
-KHO finalization phase
-======================
-
-To enable user space based kexec file loader, the kernel needs to be able to
-provide the FDT that describes the current kernel's state before
-performing the actual kexec. The process of generating that FDT is
-called serialization. When the FDT is generated, some properties
-of the system may become immutable because they are already written down
-in the FDT. That state is called the KHO finalization phase.
-
 Kexec Handover Radix Tree
 =========================
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 2b5d91f66cd8..1c9fc91e6fcc 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -69,8 +69,7 @@ early_param("kho", kho_parse_enable);
 
 struct kho_out {
 	void *fdt;
-	bool finalized;
-	struct mutex lock; /* protects KHO FDT finalization */
+	struct mutex lock; /* protects KHO FDT */
 
 	struct kho_radix_tree radix_tree;
 	struct kho_debugfs dbg;
@@ -81,7 +80,6 @@ static struct kho_out kho_out = {
 	.radix_tree = {
 		.lock = __MUTEX_INITIALIZER(kho_out.radix_tree.lock),
 	},
-	.finalized = false,
 };
 
 /**
@@ -1196,23 +1194,6 @@ void kho_restore_free(void *mem)
 }
 EXPORT_SYMBOL_GPL(kho_restore_free);
 
-int kho_finalize(void)
-{
-	if (!kho_enable)
-		return -EOPNOTSUPP;
-
-	guard(mutex)(&kho_out.lock);
-	kho_out.finalized = true;
-
-	return 0;
-}
-
-bool kho_finalized(void)
-{
-	guard(mutex)(&kho_out.lock);
-	return kho_out.finalized;
-}
-
 struct kho_in {
 	phys_addr_t fdt_phys;
 	phys_addr_t scratch_phys;
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 2abbf62ba942..430c9521d59c 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -75,24 +75,6 @@ void kho_debugfs_fdt_remove(struct kho_debugfs *dbg, void *fdt)
 	}
 }
 
-static int kho_out_finalize_get(void *data, u64 *val)
-{
-	*val = kho_finalized();
-
-	return 0;
-}
-
-static int kho_out_finalize_set(void *data, u64 val)
-{
-	if (val)
-		return kho_finalize();
-	else
-		return -EINVAL;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(kho_out_finalize_fops, kho_out_finalize_get,
-			 kho_out_finalize_set, "%llu\n");
-
 static int scratch_phys_show(struct seq_file *m, void *v)
 {
 	for (int i = 0; i < kho_scratch_cnt; i++)
@@ -198,11 +180,6 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 	if (IS_ERR(f))
 		goto err_rmdir;
 
-	f = debugfs_create_file("finalize", 0600, dir, NULL,
-				&kho_out_finalize_fops);
-	if (IS_ERR(f))
-		goto err_rmdir;
-
 	dbg->dir = dir;
 	dbg->sub_fdt_dir = sub_fdt_dir;
 	return 0;
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index 0202c85ad14f..9a832a35254c 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -22,9 +22,6 @@ struct kho_debugfs {};
 extern struct kho_scratch *kho_scratch;
 extern unsigned int kho_scratch_cnt;
 
-bool kho_finalized(void);
-int kho_finalize(void);
-
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 int kho_debugfs_init(void);
 void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..84ac728d63ba 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -230,17 +230,7 @@ int liveupdate_reboot(void)
 
 	luo_flb_serialize();
 
-	err = kho_finalize();
-	if (err) {
-		pr_err("kho_finalize failed %d\n", err);
-		/*
-		 * kho_finalize() may return libfdt errors, to aboid passing to
-		 * userspace unknown errors, change this to EAGAIN.
-		 */
-		err = -EAGAIN;
-	}
-
-	return err;
+	return 0;
 }
 
 /**
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 4c437de5c0b0..22f6409875c9 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -630,7 +630,7 @@ int __init luo_flb_setup_incoming(void *fdt_in)
  * data handle, and the final reference count. This allows the new kernel to
  * find the appropriate handler and reconstruct the FLB's state.
  *
- * Context: Called from liveupdate_reboot() just before kho_finalize().
+ * Context: Called from liveupdate_reboot().
  */
 void luo_flb_serialize(void)
 {
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 6d9e91d55d68..88a41b6eba95 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -11,7 +11,6 @@
 /* from arch/x86/include/asm/setup.h */
 #define COMMAND_LINE_SIZE	2048
 
-#define KHO_FINALIZE "/debugfs/kho/out/finalize"
 #define KERNEL_IMAGE "/kernel"
 
 static int mount_filesystems(void)
@@ -22,22 +21,6 @@ static int mount_filesystems(void)
 	return mount("proc", "/proc", "proc", 0, NULL);
 }
 
-static int kho_enable(void)
-{
-	const char enable[] = "1";
-	int fd;
-
-	fd = open(KHO_FINALIZE, O_RDWR);
-	if (fd < 0)
-		return -1;
-
-	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
-		return 1;
-
-	close(fd);
-	return 0;
-}
-
 static long kexec_file_load(int kernel_fd, int initrd_fd,
 			    unsigned long cmdline_len, const char *cmdline,
 			    unsigned long flags)
@@ -78,9 +61,6 @@ int main(int argc, char *argv[])
 	if (mount_filesystems())
 		goto err_reboot;
 
-	if (kho_enable())
-		goto err_reboot;
-
 	if (kexec_load())
 		goto err_reboot;
 
-- 
2.52.0.457.g6b5491de43-goog


