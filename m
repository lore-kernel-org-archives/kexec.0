Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18C606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jVXbhcM7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ho1IxxDl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mixQF06bt60+GSa1+/+xgJtkVkATow9hbfa1bHpCroQ=; b=jVXbhcM70d8+NydeaWlchrXJfi
	+cRQcdECso712Es0Xk8XfKsjscs1GqmaPQ3AaH7TwzZSRl9f6wXj3rNtUynN05/4wzU6YfiNU3tDT
	lnWyZkegCeXBWmIWW5h4fGJITh8niRTnO9komoVPNmAi9di9tLSw7KOcQHLVgr4Iwpo1YUIq98mpV
	SHm0FN578bxtGzrFwqC6q0GmjyUcbgXxnDE8rBkeu3c4ZRuRz/xVA3ksfaFWoX6Qxpp8NUxI7bd8c
	NxYh0OB3QqF9nhLf+3+KqJ9cIxod6I1FIlyIlAfDI49lTAUjlHMrM9rvQfs5Q4sLd22Hg0wQ8r3lg
	GUSnyerA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYrL-00000007qGM-0qEW;
	Wed, 18 Nov 2026 06:09:31 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTYrH-00000007qFp-3uIk
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:09:29 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so362361a12.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794982167; x=1795586967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mixQF06bt60+GSa1+/+xgJtkVkATow9hbfa1bHpCroQ=;
        b=rVd4ZynOawqwHXeOTfcbufgmQ+bvkpY+pI6SUEogUnGi6vQHBm2EULk6NyxQPxZeAr
         2mQtkHE5tYOgEXnioiv1yB0Xhyr4a2oc1XQYQOZGX8ZGgUUJYCZAiXYNjqRStk+ic72s
         Qwrr4C+W29gFNy6zxm81dnQCX2t1/lnrnGtsUPwErFfFMrUarbwELD1c4TZDOsAUk3kC
         jbny54LRQ069M5TmAaQ4puiQe9Qe7PbvngNmINenZRIFhgA3GDCYKqKbpdlhkQmS8Zvz
         15qhZ8Ui47wQJsyiy4Hd451fKvR5XnwCGnT/Ujd068DKJ4A4cZb3i7jWvlUf80H8jOSM
         jNDw==
X-Forwarded-Encrypted: i=1; AL+hErHuAN5/uI3pwRw7IVJqnHVUnHhSBfPsspqgbgQp7niuOnBLtxDUChu5VAB0QdTIB1AJS0dqzg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+ZR5gL4aLmy9smAl4wkPlLJRuayquoZu+90IAyzwCRwGAnQmlE
	wA1YZwUTK+vQYgtdWd3IWfFLKlZESm+yLYYk84OH1cIsdJNV2p0fsZZIwzJGktWPVREjabaiIl+
	x76ymUHkHBDUFnFezVGI5uBTR6VSFt1iZgRzM+SHO30Qiabi/gwglEQGjG6PlidsX/sN0ugM1GM
	LB8RGVpppglU9uMviAka1pumPkLG/pIna4mLCFb23pZlpnxcMs3nimxoeS1RLzWrVqxGtVRBKwR
	zUa7dCUtjiO
X-Gm-Gg: AZFdTZfcpdfsjLtm7bUgc0lnQSlW90TJDRVj/m6MfrmH96TYGQYow4M8BYZ0dVU1DM8
	9FTr3kxSV16+1uUE5Iib591A1Skc7r2DrFFniDcPpBC0i8HU5Qj8+flHuKOEIAuiM3K9zQikndS
	ZiFxmFhyH2XZIIIlcOsDHOCei6D7FvKuqZQbifWNgW/FZQ33bHKKV3EGiE03hiW6LqU6eUT+o5J
	D3dDAvD/IfgXQTWD7td0fw4RfzxjMTwsiThfqGNhsxa0sf8+bjyygTfIEtVJg6ymBY8WXYrK/W8
	3NujaIlUQmvssNdhb6zR2gSNFZ01UVVqE1b0Ccma8DBpAcjCJGvLSl2h8Lbk8VnJHJqmzJNwVmX
	KKFgn8RAP/boP3pXs0m0vZgNApgNPdDP7Xd31UDXtK2TwGxwlpPTW4kiGFACr9SygSOtAjbuxev
	CqMD5YAgCGq+Ku5hmJ2btreQOQtXeaLLPV
X-Received: by 2002:a17:90b:2fc8:b0:3b0:abb7:3fdc with SMTP id 98e67ed59e1d1-3b3d07cb164mr1651816a91.60.1794982166752;
        Tue, 17 Nov 2026 22:09:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abb84cacsm3692787a91.1.2026.11.17.22.09.26
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:09:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7d2cba05824so428152137.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794982165; x=1795586965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mixQF06bt60+GSa1+/+xgJtkVkATow9hbfa1bHpCroQ=;
        b=ho1IxxDlO0MnZ10FyL1QA3Id1MeiQSvBog67zYBB4Y7MvO0XoWnDZP8MxS+YaFKYSm
         dHhBJRxKmaLcos7Kx6h0RPQaPsLQwiLHm6ZIvVTUmGIluxmfGVg8SaQIIj7wXgbvatX0
         Tw5Cqp2DsQ2rAwgJDZYmjlVQIHjkxMGT2DO1M=
X-Forwarded-Encrypted: i=1; AL+hErEW/FU5bf5jgtY2IjsswYhVxKYMZiLN7BNHBn+vqioJGAu/68MnlTV1jVz190BLc4rA2SZWUg==@lists.infradead.org
X-Received: by 2002:ac8:5e53:0:b0:535:a5f9:7523 with SMTP id d75a77b69052e-55d5a7dfdb3mr23883351cf.66.1794981718851;
        Tue, 17 Nov 2026 22:01:58 -0800 (PST)
X-Received: by 2002:ac8:5e53:0:b0:535:a5f9:7523 with SMTP id d75a77b69052e-55d5a7dfdb3mr23882931cf.66.1794981718214;
        Tue, 17 Nov 2026 22:01:58 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:01:57 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v4 1/4] panic: Add a platform panic notifier list
Date: Wed, 18 Nov 2026 01:01:48 -0500
Message-ID: <3d156f7b5ec4f3d6f91e288a38f87d2368f1365f.1794980455.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794980455.git.zack.rusin@broadcom.com>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_220927_982082_7C1DC78A 
X-CRM114-Status: GOOD (  26.87  )
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

Also call it from __crash_kexec() if a crash kernel is loaded, since a
fatal oops can enter kdump without panic(). Call it before taking the
kexec lock, so a callback that panics can still enter kdump. Run the
list at most once, including when a callback panics.

Add disable_panic_notifiers_platform_list to skip these callbacks
when debugging panic or kdump failures.

Suggested-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v4: Call the list before kexec_trylock() in __crash_kexec(), and only
when a crash kernel is loaded, so a callback that panics on a direct
crash_kexec() can still enter kdump (reported by Sashiko).

v3: New. Replaces v2 patches 1-3 (pre-kdump list, crash-core call and
panic_pre_kdump_postpone) with the platform list Petr suggested: one
early call in vpanic(), one in __crash_kexec(), a shared guard and a
disable switch. The guard is a plain bool, because calls are
serialized, normally by panic_cpu.

 .../admin-guide/kernel-parameters.txt         | 12 +++++
 include/linux/panic_notifier.h                |  3 ++
 kernel/crash_core.c                           |  8 +++
 kernel/panic.c                                | 51 +++++++++++++++++++
 4 files changed, 74 insertions(+)

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
index d0bd2d0cf899..704a39875ea5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -126,6 +127,13 @@ static void crash_cma_clear_pending_dma(void)
  */
 void __noclone __crash_kexec(struct pt_regs *regs)
 {
+	/*
+	 * For crash paths that bypass panic(). Run before taking the kexec
+	 * lock, so a callback that panics can still enter kdump.
+	 */
+	if (kexec_crash_loaded())
+		panic_notify_platform();
+
 	/* Take the kexec_lock here to prevent sys_kexec_load
 	 * running on one cpu from replacing the crash kernel
 	 * we are using after a panic on a different cpu.
diff --git a/kernel/panic.c b/kernel/panic.c
index 91e48d33b7db..bb27c14ef9f0 100644
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
@@ -577,6 +582,47 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 
 void __weak arch_do_panic(void) {}
 
+/**
+ * panic_notify_platform - run early platform crash callbacks
+ *
+ * panic_notifiers_platform_list is for platform callbacks that need to
+ * run during a crash without requiring crash_kexec_post_notifiers.
+ *
+ * vpanic() calls this before kdump and before stopping the other CPUs.
+ * __crash_kexec() also calls it for crash paths that bypass panic(),
+ * if a crash kernel is loaded.
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
+ * context. Other CPUs may still be running. Callbacks must limit their
+ * work and must not sleep, allocate memory, take locks, wait for other
+ * CPUs or invoke kexec.
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
@@ -669,6 +715,9 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	kgdb_panic(buf);
 
+	/* Before kdump and before stopping the other CPUs */
+	panic_notify_platform();
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
@@ -1217,6 +1266,8 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
+core_param(disable_panic_notifiers_platform_list,
+	   disable_panic_notifiers_platform_list, bool, 0644);
 core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
 static int panic_print_set(const char *val, const struct kernel_param *kp)

