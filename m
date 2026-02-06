Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117A9ECD9BD
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlidvMVPyGYjUTDy8RPNhG4pUvV+uC5PBA6dgmirYZQ=; b=bnhsOb4VO4NQ/3ZKE/7EA/qCpj
	sSDuwEfjj+jQwSBpDawdsEgpZ9LaMoH51SY00v7TUO6ydr1AlDP6fhDDkdjvVJuanj+xRmnS+QuZ0
	Yc5e0uO+bMs0dGMCBlfvySmgf6DgzmmIXVG2YmmhC+P/KGrOb7RhiMTYczHcJ88BWVn+4FavzNeCm
	qO7DT8k8edVMuIM3QgXqP8dl1wbyL79CzRyXbAgA3xPZ7ay4Gs4o0vr/IBN6D6/1uDFb71wvN/Row
	Kpl5p3roikwRFH5oHvuvX7X3lpmzZwqA2953XYXdxv2HBSoDV0KY/JWkTVBSVKbmTXOcQ5OChKb+P
	SSXx1CRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBMm-0000000AkDU-31U1;
	Fri, 06 Feb 2026 02:14:40 +0000
Received: from mail-dy1-x1349.google.com ([2607:f8b0:4864:20::1349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voBMi-0000000AkC4-40Ho
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 02:14:39 +0000
Received: by mail-dy1-x1349.google.com with SMTP id 5a478bee46e88-2b75222e9easo8689496eec.1
        for <kexec@lists.infradead.org>; Thu, 05 Feb 2026 18:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770344075; x=1770948875; darn=lists.infradead.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlidvMVPyGYjUTDy8RPNhG4pUvV+uC5PBA6dgmirYZQ=;
        b=h4DAaPUvqdzYCY27RpJMLkK2WYXF67xWP9zhX50p+TDnfNoUck6K8b+nvyW0lLBdSu
         TYVZAT8ENg8/f7NIRQ+rgOZqLfMyiTXiNstU9pQ3ZDuC5GE9po32L80FIjgWResLyGAg
         QD73Gdy5/Ef577WzUN2Em3MBl6Xp2bFHLaxo5/ZIi2622eIQ508O7DwTAEnk+COSkEIw
         fpoAJ6E510N+lb4J98r7F2zL3PsrJGpsu/UgfVM7rRiE6CHDiDyfAm0Mf44oSkFnPJRp
         h0JcuwuQ5QOzE7Q4yvKHdsM8oL+SO9kguHqJXgsA5BJIei9l9e1y4pOjFU+pIs/EyT43
         QaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770344075; x=1770948875;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlidvMVPyGYjUTDy8RPNhG4pUvV+uC5PBA6dgmirYZQ=;
        b=veXNqbbG2LWNMw4tVi30o2OY+VfrdSB8iub9QxHDOIJV1mvRuf2vYiVJTc3580BX8E
         kyREgvH9yLvjNrjGGMee/7cWFIaxroIIGuR7dDFGW8Fn+q2iPUnqHLzEvcIqTtamq4SA
         xqEvRZuiSfiTKhqY/e90KQpOzAIKnEDqt01tO3yuVM+g7AAPo0Urf8aaeiprN5OfcXHp
         xRifpizNi0/Z53u47pKWLmtzxgEua5yaR6wi89hh3YzuRhsKSRQtUi0EEnpJLpqXE+Ae
         HBwrnYIWidgnbGpbkQsuGC7RzlOO7Bra1Fx0eBVTSnHLykaNptA7idzrP7NRgkIZHg2T
         T70A==
X-Forwarded-Encrypted: i=1; AJvYcCXecCpCa42MTj4Ui8FC1JhD/beIJP7J63kTR62DC7EnuJ+hYK1jXEGw8ytbO/voEcN1uE1Uaw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxMuJUevJ6I6chH5GLSpKq19Y0mSJ/T1vZk7vg1EHb71z1hovk/
	NcvuuVFk8B4sRSBpQpAuYIVZZ2fZcnTYCsQ2DqKBk4TwJ9W49PQ69iAKOWzWCHn/HOtE6wiuAP3
	AMp3Zr3rXNdTzOw==
X-Received: from dykh9.prod.google.com ([2002:a05:7300:5709:b0:2b7:75b:cf5a])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:dc0b:b0:2b8:26b8:3444 with SMTP id 5a478bee46e88-2b856482b73mr508138eec.19.1770344075153;
 Thu, 05 Feb 2026 18:14:35 -0800 (PST)
Date: Thu,  5 Feb 2026 18:14:28 -0800
In-Reply-To: <20260206021428.3386442-1-jasonmiu@google.com>
Mime-Version: 1.0
References: <20260206021428.3386442-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206021428.3386442-3-jasonmiu@google.com>
Subject: [PATCH v9 2/2] kho: Remove finalize state and clients
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_181438_307756_92E31C27 
X-CRM114-Status: GOOD (  30.71  )
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
 tools/testing/selftests/kho/init.c          | 20 --------
 7 files changed, 13 insertions(+), 131 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 6dc18ed4b886..cb9a20f64920 100644
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
+    KHO producers can register their own FDT or another binary blob under
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
index 2cf781a5cdc3..c09755a76d72 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -68,8 +68,7 @@ early_param("kho", kho_parse_enable);
 
 struct kho_out {
 	void *fdt;
-	bool finalized;
-	struct mutex lock; /* protects KHO FDT finalization */
+	struct mutex lock; /* protects KHO FDT */
 
 	struct kho_radix_tree radix_tree;
 	struct kho_debugfs dbg;
@@ -80,7 +79,6 @@ static struct kho_out kho_out = {
 	.radix_tree = {
 		.lock = __MUTEX_INITIALIZER(kho_out.radix_tree.lock),
 	},
-	.finalized = false,
 };
 
 /**
@@ -1244,23 +1242,6 @@ void kho_restore_free(void *mem)
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
2.53.0.rc2.204.g2597b5adb4-goog


