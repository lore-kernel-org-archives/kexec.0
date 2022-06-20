Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830EDC433EF
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LoX1jikKytvGpRKaaNwoD3AE2RmB7y0/9DVc1Xz3WMs=; b=NCECeImpFXrR4V
	2OKJcd1x4O2y8zr11IDSATVrYqOxZ+uLKuqXBiGwLB/NmyAQtXT75Xed2NMvcm6Ir8yBimePu4SlA
	r6DoozagKsMG4grDjH9F3Fx6nJtUaeNMUJ1MH+BCpaauLOPsyJzG2ebqyZiMLcN21tYEMkW9wXCPL
	reGqwQvJIyPYLYcm2cG/hbITQ/dzu9zVe05vhDpkJgpydXjNKkEIQkzXKVxXage6ntO+YxtMkgjn8
	2ir93TdfaDNE+ZXNBcC151EiyBpMRVX6ahp8jZgUid5uS3pDoTHSfRPqAP3dKiHkYjJbBFQLIOykz
	Bhtkybq+0InE6iQwRK6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3FNr-00041G-Ny; Mon, 20 Jun 2022 11:15:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3FNm-0003vl-R9
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 11:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655723745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C/YAxTMPWaMMeJDgal3C/TOrHv5lxTWth0EeXUfR+Y4=;
	b=bJ+SMBbJE4SuPnQ081xJKJsQD9GKA7vFNKO6UuVgLJ3N4sFAyj1KIHPztX96KmajnYf12i
	jb8aUaiimgmby7A/3nePBgLtFBOyQ+tDxcz4y90FxBJOUkmWvbmXzYbEUnyc4RZ+eeLXT6
	C0t4qLR9n+232OW1ZmykldeABNKcYx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-0xAxTFxxN723NBSIzYcPow-1; Mon, 20 Jun 2022 07:15:43 -0400
X-MC-Unique: 0xAxTFxxN723NBSIzYcPow-1
Received: by mail-wr1-f69.google.com with SMTP id i17-20020adfaad1000000b0021b883a2892so1183100wrc.22
        for <kexec@lists.infradead.org>; Mon, 20 Jun 2022 04:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/YAxTMPWaMMeJDgal3C/TOrHv5lxTWth0EeXUfR+Y4=;
        b=ovDtq8rYdzvhVtZg31ZSksxP3h5/wI5nApNVaUkTpXTzqrR/WJS7dJxjNyJGGW/dnS
         CF4hS0ADCBH93lHJtXvNSQYr8roBvv4FtWLe4cto4gKIrq9O7mdTzJw2w1H1WA5pLDDn
         K+8jEajq07owMI6ISMjrqs7io8Doo0I4WI9L+W/lbb8c/ZNuYhnvuGcmGtGdifGQx1iI
         hVMJc6FGCkaeZAqkNQ65YJfL3dCQpvTXpfm1MQnjaW02tX7OAAea4hqnYQpdBp6y2l0I
         AGN5e4CMKCbukGWV730xI7kM8hT5kOGGGjmlxJ07L/GtVts6CpLQMuCWq/OjWsehdXts
         ZbYg==
X-Gm-Message-State: AOAM5312pRIGy58OFrQW9xQCSoT41wFD5KOSbxStI9tZ7yT8bVyV/MM+
	a3L9PwMI+QFrtZNRYTm1eMpfSEOUN9D/mFDhB4sLK+x49mbARQRB1g0uB83LMLw3EEah3SKbig7
	qEkaXeD8TwPACZHvG4mIW
X-Received: by 2002:a7b:c113:0:b0:39d:86c0:3ebe with SMTP id w19-20020a7bc113000000b0039d86c03ebemr34444009wmi.38.1655723742440;
        Mon, 20 Jun 2022 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj82MNWSq7B7gWuB4AL33FUyV5eqkbqmeNRvPdUZPxtW8cOlQhltFmvUoqFG3syv3hfXYfRg==
X-Received: by 2002:a7b:c113:0:b0:39d:86c0:3ebe with SMTP id w19-20020a7bc113000000b0039d86c03ebemr34443984wmi.38.1655723742182;
        Mon, 20 Jun 2022 04:15:42 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q185-20020a1c43c2000000b0039c3056c3dfsm21613089wma.27.2022.06.20.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:15:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Date: Mon, 20 Jun 2022 12:15:20 +0100
Message-Id: <20220620111520.1039685-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_041551_005098_2FFF01AD 
X-CRM114-Status: GOOD (  25.86  )
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

This prevents an NMI panic() from executing the main body of
__crash_kexec() which does the actual kexec into the kdump kernel.
The warning and return are explained by:

  6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
  [...]
  The reasons for this are:

      1) There is a potential deadlock in the slowpath

      2) Another cpu which blocks on the rtmutex will boost the task
	 which allegedly locked the rtmutex, but that cannot work
	 because the hard/softirq context borrows the task context.

Furthermore, grabbing the lock isn't NMI safe, so do away with it and
use an atomic variable to serialize reads vs writes of
kexec_crash_image.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Fixes: 6ce47fd961fa ("rtmutex: Warn if trylock is called from hard/softirq context")
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target
---
 include/linux/kexec.h |  1 +
 kernel/kexec.c        | 16 ++++++++++++----
 kernel/kexec_core.c   | 36 +++++++++++++++++++-----------------
 kernel/kexec_file.c   | 11 +++++++++++
 4 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..5849a15ae3dd 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -369,6 +369,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern atomic_t crash_kexec_lock;
 extern int kexec_load_disabled;
 
 #ifndef kexec_flush_icache_page
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..73e0df2c608f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	/*
 	 * Because we write directly to the reserved memory region when loading
 	 * crash kernels we need a mutex here to prevent multiple crash kernels
-	 * from attempting to load simultaneously, and to prevent a crash kernel
-	 * from loading over the top of a in use crash kernel.
-	 *
-	 * KISS: always take the mutex.
+	 * from attempting to load simultaneously.
 	 */
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 * See associated comment in __crash_kexec().
+	 */
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
+		ret = -EBUSY;
+		goto out_unlock_mutex;
+	}
+
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
@@ -165,6 +171,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
+	atomic_set_release(&crash_kexec_lock, 0);
+out_unlock_mutex:
 	mutex_unlock(&kexec_mutex);
 	return ret;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..f957109a266c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -933,6 +933,7 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
+atomic_t crash_kexec_lock = ATOMIC_INIT(0);
 int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
@@ -964,25 +965,26 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
-	 * running on one cpu from replacing the crash kernel
-	 * we are using after a panic on a different cpu.
-	 *
-	 * If the crash kernel was not located in a fixed area
-	 * of memory the xchg(&kexec_crash_image) would be
-	 * sufficient.  But since I reuse the memory...
+	/*
+	 * This should be taking kexec_mutex before doing anything with the
+	 * kexec_crash_image, but this code can be run in NMI context which
+	 * means we can't even trylock. This is circumvented by using an
+	 * atomic variable that is *also* used by the codepaths that take
+	 * the mutex to modify kexec_crash_image.
 	 */
-	if (mutex_trylock(&kexec_mutex)) {
-		if (kexec_crash_image) {
-			struct pt_regs fixed_regs;
-
-			crash_setup_regs(&fixed_regs, regs);
-			crash_save_vmcoreinfo();
-			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(kexec_crash_image);
-		}
-		mutex_unlock(&kexec_mutex);
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1))
+		return;
+
+	if (kexec_crash_image) {
+		struct pt_regs fixed_regs;
+
+		crash_setup_regs(&fixed_regs, regs);
+		crash_save_vmcoreinfo();
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(kexec_crash_image);
 	}
+
+	atomic_set_release(&crash_kexec_lock, 0);
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..3faec031cfc9 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -337,6 +337,15 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 * See associated comment in __crash_kexec().
+	 */
+	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1)) {
+		ret = -EBUSY;
+		goto out_mutex_unlock;
+	}
+
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -406,6 +415,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
+	atomic_set_release(&crash_kexec_lock, 0);
+out_mutex_unlock:
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 	return ret;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
