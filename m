Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D959ECD1283
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gLJMi4ZvxKccJ2tyqeQiqTi/063zzOcnXxhD9eqaM0c=; b=CArMMpzlXyJaib
	rf3PktG8yyrVZngua5PABIBk7LiYJVGvJSM88nUU22JQEVk0SYYG2ZxSV+2j8m4C2K+uj942tyx8r
	xtzNI2ZN6JL3LCrp7Td/OGDdybV7cy+Gtk29TYJw3qkPzqfMmKc86iN13064YnHIIKUerC6uFtVRV
	buTLXNgDSLAKe5RkAP0/2m4CalZT3X1GLB8f3nh91tsyVu7AmobVZda2bzb5aVP51MbI5eTTKAvRS
	weFBoaab4WY84IYdflx//HvhVJmWD10D/602L/RLsGuX2HhMzSBLWVF5Qn7HLeoJzzEfctiDaVF/u
	V52UwkayXYNDm3T34u/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGo-0000000Ew1D-1WuX;
	Thu, 28 Mar 2024 17:10:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvR-0000000EZd1-2kFz
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F17D2CE2BEE;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2326BC433C7;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=TafjZyOBrAQcoCaSUtdYESxekOuvHr9fiXUccrxPgwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HhV4INsjdFJMH6CkQK7wFPjJVZRrr+YmZymoFqUgEZF5ogabkNva4TWh7CEGqCcHi
	 e91bE02jndeBDQ+6vJen9iGftuHvAo4TsIhXFesDKdT/bP41R2xcYxzdQD1oUDXWSu
	 /fOiBBZMlct2HMTZRapG1lSYwzJMNOlSU6rGAKKPZtNi/sFxr3e8Vt0kriyXBC0xHQ
	 qmMsIafYP+ifNnbaIIMVhRwlYtljtn3Qb/GvTjrHGC2MW8WEQbhc8d+dyQK4HYMq5+
	 PDcVPs5TmPnpFOgrfMv6p/4AmkqyJo/FymJQvILQQE5WHa4geTEkDpVoHM6ZvdaPUQ
	 CpoX+ks17ZmRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09051C54E67;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:02 +0100
Subject: [PATCH v3 01/10] kernel misc: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-1-285d273912fe@samsung.com>
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, 
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
 Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=6862;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=zWKI2WbaiCqgirqHNbxUlm2EzrR5vOXaQIBnSoj9n8I=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEmsxck3BZWQhrNuiOjNH90xMk8HtDVGf
 4kmwH1mB7F9MYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBJAAoJELqXzVK3
 lkFP3BIL/2qan7wwTLiJJK+4lWqvrNXeD6XVMQUVhJtRLXL+CPRQoLNPbRRC4OvDwc8yNZNatF4
 ld3yf1GSwjtf46wrjxjMplEeTX+nurnvzT2U3eW2QGyX5DaEL3lgERQv3sWRVEKrLUgu2I/vYW7
 VJsS9vhCxPe9mpYJ2HwyI2bjznXUAdrAXD0HOs5IQBSs/9XvkeEi0DqmurgQj2bJ0iE9+CrBxiH
 BZZOvtt16bBbGVWswY9fPpl+E7JGQux6ItNHqflJEnZZiao9nSkp0h+R9/AXraU3roVJCp0KjNF
 JdnqCXg0QRUWaLt2JIqoNBIdzgHEXGi6sBjuV3UYvQwe2jHGHQN8CkTRVJ7osHofLfKFrsC3sFG
 F+IUVvGCEr0d1d5GytO8pwCKYI9wJ9rkHd2RZxqYoS2wurnyTpy8G3MDgXWZGjCCwchmTw0oJc7
 zd2YmTAyHk0irG9owIuVestvStFPauK191lfx3T73bNHl549m8ATBMjHk7Fdt/xIhg6pT1AsZi4
 y8=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_084422_384619_0E8A9518 
X-CRM114-Status: GOOD (  16.22  )
X-Mailman-Approved-At: Thu, 28 Mar 2024 10:10:25 -0700
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
Reply-To: j.granados@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove the sentinel from ctl_table arrays. Reduce by one the values used
to compare the size of the adjusted arrays.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/acct.c           | 1 -
 kernel/exit.c           | 1 -
 kernel/hung_task.c      | 1 -
 kernel/kexec_core.c     | 1 -
 kernel/latencytop.c     | 1 -
 kernel/panic.c          | 1 -
 kernel/pid_namespace.c  | 1 -
 kernel/pid_sysctl.h     | 1 -
 kernel/reboot.c         | 1 -
 kernel/signal.c         | 1 -
 kernel/stackleak.c      | 1 -
 kernel/sysctl.c         | 2 --
 kernel/ucount.c         | 3 +--
 kernel/utsname_sysctl.c | 1 -
 kernel/watchdog.c       | 2 --
 15 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 986c8214dabf..179848ad33e9 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -84,7 +84,6 @@ static struct ctl_table kern_acct_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 static __init int kernel_acct_sysctls_init(void)
diff --git a/kernel/exit.c b/kernel/exit.c
index 41a12630cbbc..cd3aa9042f1a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -94,7 +94,6 @@ static struct ctl_table kern_exit_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
 	},
-	{ }
 };
 
 static __init int kernel_exit_sysctls_init(void)
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2fc2727d654..1d92016b0b3c 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -314,7 +314,6 @@ static struct ctl_table hung_task_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_NEG_ONE,
 	},
-	{}
 };
 
 static void __init hung_task_sysctl_init(void)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 0e96f6b24344..9112d69d68b0 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -948,7 +948,6 @@ static struct ctl_table kexec_core_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= kexec_limit_handler,
 	},
-	{ }
 };
 
 static int __init kexec_core_sysctl_init(void)
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 781249098cb6..84c53285f499 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -85,7 +85,6 @@ static struct ctl_table latencytop_sysctl[] = {
 		.mode       = 0644,
 		.proc_handler   = sysctl_latencytop,
 	},
-	{}
 };
 #endif
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 747c3f3d289a..8bff183d6180 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -100,7 +100,6 @@ static struct ctl_table kern_panic_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
 	},
-	{ }
 };
 
 static __init int kernel_panic_sysctls_init(void)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7ade20e95232..dc48fecfa1dc 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -307,7 +307,6 @@ static struct ctl_table pid_ns_ctl_table[] = {
 		.extra1 = SYSCTL_ZERO,
 		.extra2 = &pid_max,
 	},
-	{ }
 };
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
 
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index 2ee41a3a1dfd..fe9fb991dc42 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -41,7 +41,6 @@ static struct ctl_table pid_ns_ctl_table_vm[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{ }
 };
 static inline void register_pid_ns_sysctl_table_vm(void)
 {
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 22c16e2564cc..f05dbde2c93f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1295,7 +1295,6 @@ static struct ctl_table kern_reboot_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 static void __init kernel_reboot_sysctls_init(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 7bdbcf1b78d0..01c4c46a51a8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4840,7 +4840,6 @@ static struct ctl_table signal_debug_table[] = {
 		.proc_handler	= proc_dointvec
 	},
 #endif
-	{ }
 };
 
 static int __init init_signal_sysctls(void)
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 34c9d81eea94..d099f3affcf1 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -54,7 +54,6 @@ static struct ctl_table stackleak_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init stackleak_sysctls_init(void)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 81cc974913bb..e0b917328cf9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2034,7 +2034,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
-	{ }
 };
 
 static struct ctl_table vm_table[] = {
@@ -2240,7 +2239,6 @@ static struct ctl_table vm_table[] = {
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
 #endif
-	{ }
 };
 
 int __init sysctl_init_bases(void)
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..e196da0204dc 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -87,7 +87,6 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_fanotify_groups"),
 	UCOUNT_ENTRY("max_fanotify_marks"),
 #endif
-	{ }
 };
 #endif /* CONFIG_SYSCTL */
 
@@ -96,7 +95,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 #ifdef CONFIG_SYSCTL
 	struct ctl_table *tbl;
 
-	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
+	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
 	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
 	if (tbl) {
diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index 019e3a1566cf..76a772072557 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -120,7 +120,6 @@ static struct ctl_table uts_kern_table[] = {
 		.proc_handler	= proc_do_uts_string,
 		.poll		= &domainname_poll,
 	},
-	{}
 };
 
 #ifdef CONFIG_PROC_SYSCTL
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index d7b2125503af..4e472d416525 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -950,7 +950,6 @@ static struct ctl_table watchdog_sysctls[] = {
 	},
 #endif /* CONFIG_SMP */
 #endif
-	{}
 };
 
 static struct ctl_table watchdog_hardlockup_sysctl[] = {
@@ -963,7 +962,6 @@ static struct ctl_table watchdog_hardlockup_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init watchdog_sysctl_init(void)

-- 
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
