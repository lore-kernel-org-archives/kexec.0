Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63034CA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0N74TVpylEcqJv/7BbWevY9i5i91Vy455vcjAtMshTM=; b=x5xM4OEKgUq9tu
	pz1QLnWK40m6QjDhgAPza+Q8+5fA3xO3co6AyYjP881gJkXkQWXMX2BQRHApl+RqJOa+aANBMXuUz
	E70VbIEer7V0GDdXCc96G97F9kO+pqDNrwjmdXS/qW3X5pC1alv3p0I5OtGgi2d823v/QXXVdf5jE
	/vjQ71aJh4rXI32EP/hqh0Bfo2kHtA0evPiT38QSru844i/bxP4Qlc1J9eHvdyIfw3Ew6LwLwL6AK
	Laa0t/Gs91quu4LudbxG6MuR0d8LDAo75iOfc2riSATEDc5wgZAp3hVaj9Jdi96mkpUL9Kx6KUHCi
	DkjwX0rKt1qLsbtFmhjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaY-00000001FR7-1bHs;
	Mon, 28 Sep 2026 17:56:30 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaV-00000001FPl-1ewg
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:28 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-873a4edb243so1031282b3a.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618187; x=1791222987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0N74TVpylEcqJv/7BbWevY9i5i91Vy455vcjAtMshTM=;
        b=0iwz8zzoYQro+zUYncpaCyhcQJXRTpMMua10OF5uZ33k3b2Cl6dNEL5B3z/QQm7wUw
         XXAs5yktJF0Vry2Pm0qDV8vvhidiEsNr0ipneFuTq5HQ76DRhiLQip0LnmgwmqiGvSD9
         DYzaVeFbH1zfzF0EDd6eU/Ndt5vDbA6k9C/kdqxoCM7svkORg6BgxOma20zceFbIG6Gj
         /TfVR78+1Nfw5eCnWELAn5EAAf6C94b4rCSkLjPOs+J0iV+Wk3n1edWOZ/Kf3LrOGzKb
         OjHz8pLq+l2sGjPGKzsxExiaX1qpoB9bee4CkLRXMmxrY61iY5k/itJvMdnpkw3nJLfJ
         YF3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxX732/cN+y6JCO+rfN12hUhhR+WtRVZpRgv/PEUXqWbPq1+6uxUf3fQfpy6AlI1DfGqW/ydw==@lists.infradead.org
X-Gm-Message-State: AFuF++nAO0VR1q7tkbGm+1tN7NbFlRShYD+oDuOv5cmOpuWTQHX4n3z8
	v8rC7omEhTaQeVn7ZXSiXoLil7JX1rFu++8GsFiyrj6hITllrtefuvmw7cZTToCEFIWAHoppZSC
	FG080WQ/mub30FY7tcObYqYzAnT4h3B0GPoIERH7Ukww8CjpDNbHYRFhx4PbpYtL9diApgpV0bg
	4YmzHVnbHZf6Ve7vvcF/SRVMq2dAx/hTGrprw+Md48Vfg7yKT0tSJLqwDR5vfnJzkG1iSGo4xNu
	kT7pIF/3pQP
X-Gm-Gg: AYBFou0I8bPT9UeVc59Zb/8o7K46lnhqucbLC/MAngT2tRTofbAn3GHnLepaT4dOAf9
	XFFS8Z4lpeFwc5bOgthcLgWCg7SKIej4mJjmowUhzi7kCahkamQVX/St/q+T+4sJ+hl4BOdsCvz
	1rqjqlM7aqcSoMBlgzcGq4W/aW4u6v8w8Gn/Pc/hStV2nCqCU9v/Oe8hViEjjQQMiB6KeOg5V4e
	bwhXeTILmRg5ftKvmF1i/HmZnetDNXu8zgnskpw3xz3oB5Wxf+QGJVONMl0F3ah/D6DHmsJsDtI
	CM80fdn6kJRCm4fNTnld9Hzi6rO+hdYL7+Jq/mPS81AUAAumiMUL+khpcJbxhz+TcUox2E2PZ/l
	heG1kcqwJ7Tndqt9ILvm7+dNYtvNmmMAEPz/tVV9ZqLJ89V+4XjFHL7McUS/TFOrZwWvicOxp3G
	VcP7VM+OwLYrqewNQ+TrRCgOqm8am2kF2K
X-Received: by 2002:a05:6a00:1d92:b0:879:ffd9:1283 with SMTP id d2e1a72fcca58-87e9c543eb7mr10205516b3a.2.1790618186519;
        Mon, 28 Sep 2026 10:56:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-87fee6d5ce2sm5601762b3a.7.2026.09.28.10.56.25
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so6243277eec.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618184; x=1791222984; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0N74TVpylEcqJv/7BbWevY9i5i91Vy455vcjAtMshTM=;
        b=UcMS9By0dygOYbTbeCmFxBqXPsdBtz4omliGnzwjbX7f/HhNioNHSh8oCCKGnhvvtN
         XzXUI1DiphsZ/AbD8PTp8EQ7s53OH/M3ExArkZfEqOBZaivhp47ZrS+1L7IQLJnHkm8H
         P1t7zgY+yqdOO3y5GHDwq3DmqTMoG9j8bzfEA=
X-Forwarded-Encrypted: i=1; AKwUvByYFfBjFy1eKou8oRuXckNnhQEpGXjtJS2NfX0HeLKmTXdhpQLBmIY2FC+uR5F4n2yfyJRiIA==@lists.infradead.org
X-Received: by 2002:a05:7301:1501:b0:343:fdea:9a4 with SMTP id 5a478bee46e88-343fdea2578mr7436624eec.28.1790618184375;
        Mon, 28 Sep 2026 10:56:24 -0700 (PDT)
X-Received: by 2002:a05:7301:1501:b0:343:fdea:9a4 with SMTP id 5a478bee46e88-343fdea2578mr7436577eec.28.1790618183717;
        Mon, 28 Sep 2026 10:56:23 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:19 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Date: Mon, 28 Sep 2026 13:55:37 -0400
Message-ID: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105627_452470_0CD57A0C 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Provide an escape hatch for debugging kdump failures that may involve
pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
invocation in crash core without consuming the once-only guard.

When enabled, the chain runs before kdump only when
crash_kexec_post_notifiers is also enabled. Leave the late panic call
unchanged so callbacks remain eligible if that path is reached.
Skipping the callbacks may prevent hypervisor crash handling.

Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
New in v2: optional postponement policy suggested by Guilherme.

 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 include/linux/panic_notifier.h                  |  1 +
 kernel/crash_core.c                             |  3 ++-
 kernel/panic.c                                  |  2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..3d722df30838 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4904,6 +4904,20 @@ Kernel parameters
 			This option should only be used for systems with the above
 			constraints as it might cause the panic operation to be less reliable.
 
+	panic_pre_kdump_postpone=
+			[KNL] Defer pre-kdump notifiers to the late panic path.
+			They run before kdump only when
+			crash_kexec_post_notifiers is also enabled. If panic
+			reaches the late path without entering kdump, they
+			can still run there.
+			Intended for debugging kexec/crash-dump failures.
+			Skipping these callbacks may prevent correct crash
+			handling by the hypervisor.
+			Format: <bool>
+			Default: 0
+			Writable at runtime via
+			/sys/module/kernel/parameters/panic_pre_kdump_postpone.
+
 	panic_print=	Bitmask for printing system info when panic happens.
 			User can chose combination of the following bits:
 
diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
index 3ad390764a41..655ee5c77181 100644
--- a/include/linux/panic_notifier.h
+++ b/include/linux/panic_notifier.h
@@ -11,5 +11,6 @@ extern struct atomic_notifier_head panic_pre_kdump_list;
 void panic_notify_pre_kdump(char *msg);
 
 extern bool crash_kexec_post_notifiers;
+extern bool panic_pre_kdump_postpone;
 
 #endif	/* _LINUX_PANIC_NOTIFIERS_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 5d9fe9e00f39..d6b2293dd0fe 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -140,7 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 
 			crash_setup_regs(&fixed_regs, regs);
-			panic_notify_pre_kdump(NULL);
+			if (!READ_ONCE(panic_pre_kdump_postpone))
+				panic_notify_pre_kdump(NULL);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
diff --git a/kernel/panic.c b/kernel/panic.c
index d78e90abb192..65d86594e038 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -62,6 +62,7 @@ static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
+bool panic_pre_kdump_postpone;
 int panic_on_warn __read_mostly;
 unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
@@ -1243,6 +1244,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
+core_param(panic_pre_kdump_postpone, panic_pre_kdump_postpone, bool, 0644);
 core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
 static int panic_print_set(const char *val, const struct kernel_param *kp)

