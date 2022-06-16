Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5385C43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tPL1FjcytjpE1O2xalrQiIi+dxMkIa8LOdhMIDnBwsw=; b=i0Xd/iUV2+LMGI
	R/QObAC+/PUEoitHnxRlcSgNas+Ch4E1WpwftctqeUMAmU0/Nl4kYNXpM7qU2WTGeJbY0gyXxj2NO
	avzAK889vsk6aOnVvkkVU5N3k5q+pRt0ohOkWvbkTkaqVBj6D8/v9LGnq+HCDa4PT+DI95RLBZlEr
	KZTTl3A5+11fTjNqzYUEZ+V5SvOhtsByVqIcg6ukpBJ1mti8CrYGVmeWu0bTy+zdIqWy3r+lEFfxH
	Ay8PTVhMYlUohX+J1fBLqVJ59+lHVJsfNYrDURnA49rmhH5cWZx8ffbYpJjW6mTitUKq5Vr808OqN
	wQduYyyJUFmY4+4b6suQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1olh-002JRY-HH; Thu, 16 Jun 2022 12:38:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1old-002JQL-Kn
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 12:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655383111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J1U4+ccxioO2o2if5tY8m8K+V+bkZR3b9CE1FcjFWgs=;
	b=jNi/8EaPSW9PsG7Sr8rvvxoW4N8VvFjJwrNLbHF74eFI/NbQFh2WF7FdkaZFWv+Yyr6p6j
	pFAiK6Sda9oX67FzyUj36Jw0a+EvkkCsik+Ptow4Yp9WghQI7dBP+8X/YattYAItCqUe1Z
	kGcRnfgG1IRbJ83HlhHK4MqT+FGXzZY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-viccf7_qOiiHfmYB-fnVMQ-1; Thu, 16 Jun 2022 08:38:30 -0400
X-MC-Unique: viccf7_qOiiHfmYB-fnVMQ-1
Received: by mail-qv1-f71.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso1494657qvr.4
        for <kexec@lists.infradead.org>; Thu, 16 Jun 2022 05:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1U4+ccxioO2o2if5tY8m8K+V+bkZR3b9CE1FcjFWgs=;
        b=pfg+Y3qJ2qUdoaydIut2VFgwaZedA0+gjFaAc9enE/D3qlXzXpHEUZ18Hgs65jzuEh
         EPRr0XTjEJ0gyE6DkVMTRwNMbBv3c/4FsDGoZW+S3lSYjgONUUez/oJJ1W5jjNy7Ftws
         xUV3A0YbcXXA/mtdoLxWFc8+f2MXAQP5d4shXiCqVmWadSeFU6ymbBHnml5mYHB2mjV7
         fPJsFtOqgnP4UBb8XFID0vkz0LIyq8x9vELForqRtUVL/t14n1jJG90TgyiUIrNQMND1
         1HmAx5sHL5P1fcBVqNnENCZ2cIUaEEUIG0+RdMKSOwtrSlE+UbKpbF1aO3zZwMsklH7U
         BFKw==
X-Gm-Message-State: AJIora+f6M1zMVJOV1h5m1RbxIjPsCOz5FTz4YyO0ham4PTjQUwKi36A
	2EbhtpQdy5s3g+SeeG11kUmIaZnRT4EPv/PxMHqmvwKPePNWP3qhlT2dO4/44bC3wdTFjsAglv+
	Oi4qYQsiLrnZNFnUScBwi
X-Received: by 2002:a05:6214:2484:b0:46e:55b5:9f56 with SMTP id gi4-20020a056214248400b0046e55b59f56mr3859048qvb.71.1655383109545;
        Thu, 16 Jun 2022 05:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twCUpPOsmHv4Nb/H9nsJ9UF88b4sWMLdzmeyX1akaa3jENfxyDO4SaAdIKpO9aT3IGPmk2fg==
X-Received: by 2002:a05:6214:2484:b0:46e:55b5:9f56 with SMTP id gi4-20020a056214248400b0046e55b59f56mr3859025qvb.71.1655383109264;
        Thu, 16 Jun 2022 05:38:29 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id y3-20020a05620a44c300b006a75a8fd54asm1863828qkp.84.2022.06.16.05.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 05:38:28 -0700 (PDT)
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
Subject: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
Date: Thu, 16 Jun 2022 13:37:09 +0100
Message-Id: <20220616123709.347053-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_053833_888792_17F4A7DE 
X-CRM114-Status: GOOD (  27.46  )
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

Use a pair of barrier-ordered variables to serialize loading vs executing a
crash kernel.

Tested by triggering NMI panics via:

  $ echo 1 > /proc/sys/kernel/panic_on_unrecovered_nmi
  $ echo 1 > /proc/sys/kernel/unknown_nmi_panic
  $ echo 1 > /proc/sys/kernel/panic

  $ ipmitool power diag

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
Regarding the original explanation for the WARN & return:

I don't get why 2) is a problem - if the lock is acquired by the trylock
then the critical section will be run without interruption since it
cannot sleep, the interrupted task may get boosted but that will not
have any actual impact AFAICT.
Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
isn't NMI safe so this needs changing.

I've thought about trying to defer the kexec out of an NMI (or IRQ)
context, but that pretty much means deferring the panic() which I'm
not sure is such a great idea.
---
 include/linux/kexec.h |  2 ++
 kernel/kexec.c        | 18 ++++++++++++++----
 kernel/kexec_core.c   | 41 +++++++++++++++++++++++++----------------
 kernel/kexec_file.c   | 14 ++++++++++++++
 4 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..89bbe150752e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -369,6 +369,8 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
 extern struct kimage *kexec_image;
 extern struct kimage *kexec_crash_image;
+extern bool panic_wants_kexec;
+extern bool kexec_loading;
 extern int kexec_load_disabled;
 
 #ifndef kexec_flush_icache_page
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..1253f4bb3079 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -94,14 +94,23 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
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
+	 *
+	 * Pairs with smp_mb() in __crash_kexec().
+	 */
+	WRITE_ONCE(kexec_loading, true);
+	smp_mb();
+	if (READ_ONCE(panic_wants_kexec)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (flags & KEXEC_ON_CRASH) {
 		dest_image = &kexec_crash_image;
 		if (kexec_crash_image)
@@ -165,6 +174,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 
 	kimage_free(image);
 out_unlock:
+	WRITE_ONCE(kexec_loading, false);
 	mutex_unlock(&kexec_mutex);
 	return ret;
 }
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..932cc0d4daa3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -933,6 +933,8 @@ int kimage_load_segment(struct kimage *image,
 
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
+bool panic_wants_kexec;
+bool kexec_loading;
 int kexec_load_disabled;
 #ifdef CONFIG_SYSCTL
 static struct ctl_table kexec_core_sysctls[] = {
@@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
-	/* Take the kexec_mutex here to prevent sys_kexec_load
-	 * running on one cpu from replacing the crash kernel
-	 * we are using after a panic on a different cpu.
+	/*
+	 * This should be taking kexec_mutex before doing anything with the
+	 * kexec_crash_image, but this code can be run in NMI context which
+	 * means we can't even trylock.
 	 *
-	 * If the crash kernel was not located in a fixed area
-	 * of memory the xchg(&kexec_crash_image) would be
-	 * sufficient.  But since I reuse the memory...
+	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
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
+	WRITE_ONCE(panic_wants_kexec, true);
+	smp_mb();
+	/*
+	 * If we're panic'ing while someone else is messing with the crash
+	 * kernel, this isn't going to end well.
+	 */
+	if (READ_ONCE(kexec_loading)) {
+		WRITE_ONCE(panic_wants_kexec, false);
+		return;
+	}
+
+	if (kexec_crash_image) {
+		struct pt_regs fixed_regs;
+
+		crash_setup_regs(&fixed_regs, regs);
+		crash_save_vmcoreinfo();
+		machine_crash_shutdown(&fixed_regs);
+		machine_kexec(kexec_crash_image);
 	}
 }
 STACK_FRAME_NON_STANDARD(__crash_kexec);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..4bb399e6623e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -337,6 +337,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	/*
+	 * Prevent loading a new crash kernel while one is in use.
+	 *
+	 * Pairs with smp_mb() in __crash_kexec().
+	 */
+	WRITE_ONCE(kexec_loading, true);
+	smp_mb();
+	if (READ_ONCE(panic_wants_kexec)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -406,6 +418,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
 		arch_kexec_protect_crashkres();
 
+out_unlock:
+	WRITE_ONCE(kexec_loading, false);
 	mutex_unlock(&kexec_mutex);
 	kimage_free(image);
 	return ret;
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
