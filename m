Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC5BC43334
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vo+hn7G0ipeJ+2xBR+L2oPlaViBZ2epF8bSPDEueqX4=; b=dcHfenQvwFiusk
	+zIOPCPhipNrC2HmmoV0vs7BPqSsTUlfkRS1Bp5GEBF0UUgWKvodQPY6CaAy2e3jam4hY0BvyL28T
	QenjLEjn6BGtlEnFyuaEcfIttYLpxsRlZHB9I6w1C/EnO4Rb+e9jyGXp0TfWIM6UzEhZcZ0oenS0p
	ocugOXpuMK2NUQ+eUbKn1Ze/Tqybp4vKRF3rPcFwIWjZwUWjpFoypwi4gMDb9+smIW0xBpRZuYo/l
	2pMhG2gq5aYWwZ1S67s1ecYLqRqBD+1BQhR2+WhH0TSgocMhFHMSxbrdqgAIBnb90PgZnksDsXCJz
	DkIhcZkmV3azJUD+PRVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xr4-000nYO-0Y; Thu, 30 Jun 2022 17:21:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xqz-000nVl-N3
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 17:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656609678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4I+MH1BitjShuNkM5CAAnuV26uY5raJYeW45VTPEJk=;
	b=V0XAPXJ1/281PtWaRKbZL33oovIVJqBb6PCUDnBUD02BfLlt20sS4j3q+ba9JYHH6Adfgs
	JjtkGmBo+FlTtjdjqIy0z27Kx7npERqfM595w3v/Q7FErPrLcoUODXVlWd7V/uM/7eOPU8
	xXdDVnidJJaPyscmj97/+vacYycz8IU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-wL81Aco3NUOVkxY-H5CAsQ-1; Thu, 30 Jun 2022 13:21:17 -0400
X-MC-Unique: wL81Aco3NUOVkxY-H5CAsQ-1
Received: by mail-wm1-f71.google.com with SMTP id r132-20020a1c448a000000b003a02a3f0beeso1693296wma.3
        for <kexec@lists.infradead.org>; Thu, 30 Jun 2022 10:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4I+MH1BitjShuNkM5CAAnuV26uY5raJYeW45VTPEJk=;
        b=NjtZ9+4yD+kuBxbjR5nRnJxkg77feD9LUEJIRuBM/WpIMU7xbrMDj/twT4WasOs1hv
         m/H220lXaQIy3nkbYAxttzjp0UWkN3biGuNzmLEW38birplwg1rcPmqt9vjpH3rb+G+u
         CPfrozIcw/xXCW11XxsIRzdDsp6Sx4htg3Vpekpyj4C1bX8HA8+bpx5MqJnuos6l9ftR
         CLpYwFNuhKhV6OTrGlDw0ZrGvDYVq7TwUXK1U/8l6WX7CLNuvurj1wNKoTGTOOiauVMi
         93jGVrcn6aATszdDdFBuFha4Cz9AWjmwd/HQb0WwmKW+eUnPGrVi3pEKGnob5kT0Kx/n
         BVyw==
X-Gm-Message-State: AJIora+5QGpSlUCerW2y0MPlcfwBIx5YQEatn2MHSj5X8+7SVKECirqt
	8zSDYxIHbtz2Hnis034qQMP5GM6UQ3oMYbChFyXHSXTVZLH3Ajroz2ve20ndIjtoxkexlU99C6h
	KHiyjUmMlBNsnz31Lfhfe+vdUi6GO3ThLzKDYnQXGXXa19ZIVacNWXBuFvNaGtWiMwIVkw+Cq
X-Received: by 2002:a05:6000:1147:b0:21b:93db:701a with SMTP id d7-20020a056000114700b0021b93db701amr9196217wrx.447.1656609676042;
        Thu, 30 Jun 2022 10:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vDjX7DBkTEc4uBQnlR8uyyjkl4TbNFruSL7iNye5iA5L4+fSkC52vbubuSOh3YfA0NmC/V2Q==
X-Received: by 2002:a05:6000:1147:b0:21b:93db:701a with SMTP id d7-20020a056000114700b0021b93db701amr9196183wrx.447.1656609675731;
        Thu, 30 Jun 2022 10:21:15 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm4065122wmg.17.2022.06.30.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v3 2/2] panic, kexec: Make __crash_kexec() NMI safe
Date: Thu, 30 Jun 2022 18:20:41 +0100
Message-Id: <20220630172041.4100123-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220630172041.4100123-1-vschneid@redhat.com>
References: <20220630172041.4100123-1-vschneid@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_102121_865970_45B7194B 
X-CRM114-Status: GOOD (  25.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Attempting to get a crash dump out of a debug PREEMPT_RT kernel via an NMI
panic() doesn't work. The cause of that lies in the PREEMPT_RT definition
of mutex_trylock():

	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
		return 0;

This prevents an nmi_panic() from executing the main body of
__crash_kexec() which does the actual kexec into the kdump kernel.
The warning and return are explained by:

  6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
  [...]
  The reasons for this are:

      1) There is a potential deadlock in the slowpath

      2) Another cpu which blocks on the rtmutex will boost the task
	 which allegedly locked the rtmutex, but that cannot work
	 because the hard/softirq context borrows the task context.

Furthermore, grabbing the lock isn't NMI safe, so do away with kexec_mutex
and replace it with an atomic variable. This is somewhat overzealous
as *some* callsites could keep using a mutex (e.g. the sysfs-facing ones
like crash_shrink_memory()), but this has the benefit of involving a single
unified lock and preventing any future NMI-related surprises.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 20 ++++++++++----------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..cb8e6e6f983c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -93,13 +93,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	/*
 	 * Because we write directly to the reserved memory region when loading
-	 * crash kernels we need a mutex here to prevent multiple crash kernels
-	 * from attempting to load simultaneously, and to prevent a crash kernel
-	 * from loading over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
+	 * crash kernels we need a serialization here to prevent multiple crash
+	 * kernels from attempting to load simultaneously.
 	 */
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (flags & KEXEC_ON_CRASH) {
@@ -165,7 +162,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return ret;
 }
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 16370926b21a..b03859a0fbaa 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -46,7 +46,7 @@
 #include <crypto/hash.h>
 #include "kexec_internal.h"
 
-DEFINE_MUTEX(kexec_mutex);
+atomic_t __kexec_lock = ATOMIC_INIT(0);
 
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
@@ -964,7 +964,7 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
+	/* Take the kexec_lock here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
 	 *
@@ -972,7 +972,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 	 * of memory the xchg(&kexec_crash_image) would be
 	 * sufficient.  But since I reuse the memory...
 	 */
-	if (mutex_trylock(&kexec_mutex)) {
+	if (kexec_trylock()) {
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
@@ -981,7 +981,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
-		mutex_unlock(&kexec_mutex);
+		kexec_unlock();
 	}
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
@@ -1013,13 +1013,13 @@ ssize_t crash_get_memory_size(void)
 {
 	ssize_t size = 0;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (crashk_res.end != crashk_res.start)
 		size = resource_size(&crashk_res);
 
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return size;
 }
 
@@ -1039,7 +1039,7 @@ int crash_shrink_memory(unsigned long new_size)
 	unsigned long old_size;
 	struct resource *ram_res;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	if (kexec_crash_image) {
@@ -1078,7 +1078,7 @@ int crash_shrink_memory(unsigned long new_size)
 	insert_resource(&iomem_resource, ram_res);
 
 unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return ret;
 }
 
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 {
 	int error = 0;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 	if (!kexec_image) {
 		error = -EINVAL;
@@ -1226,7 +1226,7 @@ int kernel_kexec(void)
 #endif
 
  Unlock:
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	return error;
 }
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..42b95bf58daf 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -334,7 +334,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	image = NULL;
 
-	if (!mutex_trylock(&kexec_mutex))
+	if (!kexec_trylock())
 		return -EBUSY;
 
 	dest_image = &kexec_image;
@@ -406,7 +406,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
-	mutex_unlock(&kexec_mutex);
+	kexec_unlock();
 	kimage_free(image);
 	return ret;
 }
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..74da1409cd14 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,7 +13,20 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
-extern struct mutex kexec_mutex;
+/*
+ * Whatever is used to serialize accesses to the kexec_crash_image needs to be
+ * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
+ * "simple" atomic variable that is acquired with a cmpxchg().
+ */
+extern atomic_t __kexec_lock;
+static inline bool kexec_trylock(void)
+{
+	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
+}
+static inline void kexec_unlock(void)
+{
+	atomic_set_release(&__kexec_lock, 0);
+}
 
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
