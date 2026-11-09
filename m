Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB4606D805
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v0Eov0c7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PTXuVHEp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yEI9QPdZb9fIemVNbuPAWIjNG/F4NymByZojuYSSaiw=; b=v0Eov0c73n3+anPgcQU8IY6O9L
	bKUi+/gYxN7fHItUFMFpKfs9W76aFf3pgF15oY1h8YNwYGpkmHbB98fCj6R1oGlo7Edhi2Qzu2Kod
	hpQukWAxDRd+q1YDF/ChOeyIwFnD00x9Oiuwp9Y59prpKn/oQQy3Cusmo0yYZc8BvKlcOBm1cCgTZ
	TJQu2VHo4OXxWK/Cgy9D/MxCEpFLkyrcpN8mIYbuy0BRmp8nIHw5fjfHP+sNhWwCQ/BwTqGiy56Qp
	JNjdgai+KCJETb+Wsb8lFcJed6hnJdJ9wMrv8thCMJ4/hlIZZSTKmXLj8AyGVtMuGDz03fxwsNEWP
	YagxDqdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEe-0000000HS5v-178t;
	Mon, 09 Nov 2026 05:48:04 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQIEZ-0000000HS3z-2fic
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 05:48:01 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso139760a12.3
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203278; x=1794808078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yEI9QPdZb9fIemVNbuPAWIjNG/F4NymByZojuYSSaiw=;
        b=fQ9zi1k/VBH3DAH034CaH761tAaY0fqtj4fH9Qcq3dFOcuVGOaIpIGbA6HZ21X1FdP
         Gr+rCJyr/IhavmzMaCHahB7/QsnpKZnhYefeZ7unlg6L0fewXBGocdk/Iq14vdqhR7fW
         r92HwSli6x1ItTTga+Q2NyPGkhi3szh53BAkaUk5stsBHFbFqWRwqR5QWjoLeQGE3Koo
         BL+SUfHBMVJ6+v62G2KcrN4qItdKdPtK7eXGFbwN9m3dJlgjZWWZfkOdy8m5Op5OJvsC
         Pcd1CykPfr/ZLX2TG/vy2bjUOgBw1w/3/BWIHswLdvLJNZbLMrioqXALd0dHzCgVPATS
         ohsw==
X-Forwarded-Encrypted: i=1; AL+hErEQOfhxpGS9+cFLD2P7S2LCkWPJHTtImLJ227O+4QkposVbZE2+hgujNv5UfSYVXOWp4za77Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z+4W8XiD9+uK4tfbPjtdXhw1jb6KzZI9nB06jy4D96c1YNLQudl
	xWHFLfNc2be8ElMR0lHC2/uQO1MpUY2HwW913/IXFpTKS5MKMGCHXvSeypTSfuQsvcimeR7NEZ/
	4W6oqkIHnJziCMwQyKdzmUO4BhZeBoIeu2q3MEltNArU7KD3gRLpyVQCX538Mq7I/Ecv/KvWe+g
	itdA4yy3GLsLfzK3Gp887LMJ1agbW+sT3AyO/jQQ/KuBK7Hwn4UPlwpTn/KPHBnoDxn/Ox1pM24
	FmlZsp5j9my
X-Gm-Gg: AYBFou3owigDAx640O31SXFicUgJ7ZF9ToXYT0CNricObmXn1ML4xFd5zb2MP4XSfq1
	GLhe9PCJ79Os6p7NB+ShYdEMuV9QUWgXblt0WsS2dWwPQ/+W5Al2w5TI4xLv4XlUk4/H8pC4Ofk
	YGTrKBVyc5A3Ib/kwq3lwST1mhxmHc+KAsUSrBY5ByilPrhtokJSTxAdokFY1Gykf2vjCgU2FAA
	+NzuWcpi3YDOsoX0Ci9aWVvfDBSN1aGzspWukzo/73fxSpnW+XcaG4RwwbFQGBk3wn/u7WweokF
	hkr4RbnUWitW9ziKza5dhtMFVNg2kPf5Il7MWaxGWqWX0VxiVOJKng4HKft8EVYNECWBuixcAZ9
	IbP2rwXUz4pDNyoqZDWUGdGSTxnqq6VfMqQ5+NQZU6W4U/FhMMZu6WF54iBQE8zAp+rqxIKWhE/
	3g6yWs+NPC4aZTGOz/0IKEJ6I4tkiCTfyd
X-Received: by 2002:a17:90b:5683:b0:3b0:d551:ab2 with SMTP id 98e67ed59e1d1-3b12d5ac42fmr2769439a91.51.1794203278512;
        Sun, 08 Nov 2026 21:47:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1278ae5b0sm2908136a91.3.2026.11.08.21.47.58
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:47:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b25dc2aa8bso1437970c88.1
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 21:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203277; x=1794808077; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEI9QPdZb9fIemVNbuPAWIjNG/F4NymByZojuYSSaiw=;
        b=PTXuVHEp+GVq16tGm7zmGaqxqhsDnrdms1Ks9HjyxQ0QRaQEeqshbrzDw8BXYjuxU6
         3oqmJvaW2S/hP+EN9+GJnIL+5DLIVV2jMIx1VffPgjKIS5HgBVyFgX/nMBlDafy2npfg
         hnwXEEgDS4h6odHK2kaysB4iXYSJUT/4tvoz8=
X-Forwarded-Encrypted: i=1; AL+hErHZPCYkN5g1I0z25Q+3yycWuWHUQnRLmRNF1gyERp9TAPWOC1C9nBNtFo1Q2MkSxyoEG9Kclw==@lists.infradead.org
X-Received: by 2002:a05:7022:29b:b0:143:8860:afa1 with SMTP id a92af1059eb24-1b39fee1560mr4997724c88.46.1794203276150;
        Sun, 08 Nov 2026 21:47:56 -0800 (PST)
X-Received: by 2002:a05:7022:29b:b0:143:8860:afa1 with SMTP id a92af1059eb24-1b39fee1560mr4997658c88.46.1794203275273;
        Sun, 08 Nov 2026 21:47:55 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:47:54 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v3 1/4] panic: Add a platform panic notifier list
Date: Mon,  9 Nov 2026 00:47:37 -0500
Message-ID: <42090fa4453561ebc35f35cc563ec79933eebe75.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_214759_684515_6E6DF4F6 
X-CRM114-Status: GOOD (  22.71  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Bradley Morgan <brads@mainlining.org>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some platforms set crash_kexec_post_notifiers so their crash handlers
run before kdump. That also runs every other panic notifier and kmsg
dumper before the crash kernel.

Add panic_notifiers_platform_list for platform callbacks that need to
run early and are safe while other CPUs are still running. Call it
from vpanic() before kdump and before stopping the other CPUs,
independently of crash_kexec_post_notifiers.

Also call it from __crash_kexec() after saving the registers, since a
fatal oops can enter kdump without panic(). Run the list at most once,
including when a callback panics.

Add disable_panic_notifiers_platform_list to skip these callbacks
when debugging panic or kdump failures.

Suggested-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v3: New. Replaces v2 patches 1-3 (pre-kdump list, crash-core call and
panic_pre_kdump_postpone) with the platform list Petr suggested: one
early call in vpanic(), one in __crash_kexec(), a shared guard and a
disable switch. The guard is a plain bool, because calls are
serialized, normally by panic_cpu.

 .../admin-guide/kernel-parameters.txt         | 12 +++++
 include/linux/panic_notifier.h                |  3 ++
 kernel/crash_core.c                           |  3 ++
 kernel/panic.c                                | 50 +++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..85ddcad397bf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1308,6 +1308,18 @@ Kernel parameters
 			MTRR settings.  This parameter disables that behavior,
 			possibly causing your machine to run very slowly.
 
+	disable_panic_notifiers_platform_list=
+			[KNL] Skip the platform panic notifiers. They
+			normally run early in panic(), before kdump, and on
+			crash paths that enter kdump without panic().
+			Intended for debugging panic and kdump failures.
+			Skipping them may lose platform crash handling,
+			such as a copy of the kernel log on the hypervisor.
+			Format: <bool>
+			Default: 0
+			Writable at runtime via
+			/sys/module/kernel/parameters/disable_panic_notifiers_platform_list.
+
 	disable_timer_pin_1 [X86,EARLY]
 			Disable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs.
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 41e32483d7a7..1eaf1ffba0bc 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 
 extern struct atomic_notifier_head panic_notifier_list;
+extern struct atomic_notifier_head panic_notifiers_platform_list;
+
+void panic_notify_platform(void);
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf899..10b4384294c2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -139,6 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 
 			crash_setup_regs(&fixed_regs, regs);
+			/* For crash paths that bypass panic() */
+			panic_notify_platform();
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
diff --git a/kernel/panic.c b/kernel/panic.c
index 574ee5a12f92..99af1da9d9a5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -62,6 +62,7 @@ static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
+static bool disable_panic_notifiers_platform_list;
 int panic_on_warn __read_mostly;
 unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
@@ -82,6 +83,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+struct atomic_notifier_head panic_notifiers_platform_list =
+	ATOMIC_NOTIFIER_INIT(panic_notifiers_platform_list);
+EXPORT_SYMBOL_GPL(panic_notifiers_platform_list);
+
 static void panic_print_deprecated(void)
 {
 	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
@@ -577,6 +582,46 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 
 void __weak arch_do_panic(void) {}
 
+/**
+ * panic_notify_platform - run early platform crash callbacks
+ *
+ * panic_notifiers_platform_list is for platform callbacks that need to
+ * run during a crash without requiring crash_kexec_post_notifiers.
+ *
+ * vpanic() calls this before kdump and before stopping the other CPUs.
+ * __crash_kexec() also calls it for crash paths that bypass panic().
+ * Calls must be serialized across CPUs, normally by panic_cpu.
+ *
+ * The list runs at most once, even if a callback panics. Setting
+ * disable_panic_notifiers_platform_list skips the call without marking
+ * the list as run, so a call made after the switch is cleared can still
+ * run it.
+ *
+ * Callbacks receive a notifier value of 0 and NULL data. They must
+ * return NOTIFY_DONE; NOTIFY_STOP would skip the callbacks after them.
+ *
+ * Context: Callbacks run with interrupts disabled, possibly in NMI
+ * context or with the kexec lock held. Other CPUs may still be running.
+ * Callbacks must limit their work and must not sleep, allocate memory,
+ * take locks, wait for other CPUs or invoke kexec.
+ */
+void panic_notify_platform(void)
+{
+	static bool done;
+	unsigned long flags;
+
+	if (READ_ONCE(disable_panic_notifiers_platform_list))
+		return;
+
+	local_irq_save(flags);
+	if (!done) {
+		done = true;
+		atomic_notifier_call_chain(&panic_notifiers_platform_list,
+					   0, NULL);
+	}
+	local_irq_restore(flags);
+}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -669,6 +714,9 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	kgdb_panic(buf);
 
+	/* Before kdump and before stopping the other CPUs */
+	panic_notify_platform();
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
@@ -1217,6 +1265,8 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
+core_param(disable_panic_notifiers_platform_list,
+	   disable_panic_notifiers_platform_list, bool, 0644);
 core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
 static int panic_print_set(const char *val, const struct kernel_param *kp)

