Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15921C4167B
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKHsAxbPD0IUX3yVDKe1rg+b7Fq+FQZQTrxq3XGWBNk=; b=frBYZSr7n1cGV+
	0zYbk4CikJ0fCZJ7vY1II3hKfe5whrbo+sRX9xq8biudGJceBGI2uS2g/Wgd7QKElNiv2IpcZfF3u
	tiGZ30kNdc5LRpJmVyFC8BTba9XDX+ksgw9HM1MHhadpyMyfpZ6UzsGgsgo3RRmG7208J4V5k/3Jw
	Y141nlkxtbOiX95fNFHlVBke5NIlSuw8RfDizdXGjuoW4QpszbM+Px7K+ES6Q6YewbqhSkw3NbcaS
	k/Y2YfJ9/jHaRe7Ab3ANlyCKv0KDpDPKu2JcI6SI/WO+5E9hMBDyjRreRI1NVWLtlSuS7Uv0Y3yat
	IYfxsyLU93sWkPZKeBqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVR-001fML-1E;
	Tue, 07 Nov 2023 13:52:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOK-001e5S-0q
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 85DFAB816FE;
	Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 592FCC433C8;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=rqfXn0wJQ1JNhGTxqjEEY6h7Zs0nkvvzH0tVRgYOztM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l+Sng+/axabqmNBtBMSVeYZTFMKrg5e+qpIyAtpm8wfvAbfIrBP7QdfaTaEAcgvBI
	 8PQrfa+R6aRpRgYuDF9RYFYmRvwtr9h4Xab0VW17HjuVUM5ywnrzNbkAb+HNRWNMV6
	 jprA4r75WFPH6EJRen7UH7IPBMhxh9xoHgZhTjABSskqE94imUa5BQnCsHofmAP5G0
	 MldPhm4x5Lqh1lLYP83GlAOaBHg3nAyp0q6bRp9Y/nAgly35X/LbeMNV38WwjNoMh/
	 SspqAZ3bduZRZRiEz6Ie35kPi/jv6S0zS0xiQTU+dDLiQhaGFNZBbh9ijUuldsfM15
	 MbNGIdrXBoOsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C1C4167D;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:01 +0100
Subject: [PATCH 01/10] kernel misc: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-1-e4ce1388dfa0@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 Eric Biederman <ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
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
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=6862;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Vf2nfm8EIVObj93St9fzf/hBCa2RYMM8qEK/8uD5INs=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9lNHckPwtCPajlFgcDWUDNDUAbwHFBmrxX0
 nRNFS3XDpyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZQAKCRC6l81St5ZB
 T1YMC/4woW0SrQv/4J7HMtbVEvvvjnhtpdDR8lmEcclHb2E63th3zuS0lf3ImuQ5V9YIyNAu6Ok
 BRITievAwQz5uTypXdY6QR5EK//TKhEv5X+FkL0F2i/Iz2EnWc1boKqoj+azCzURfmyVx+iwYgW
 utfj0hJS3RAgf9jv0vJTdIveJ62gdM1I8UnTDfIy3gLoj//GyUw3eUtVH9glB/QVPELK7ajMLZC
 Zgr/DOgkAXLlccpdPwwfzhVEwlBuHIZb/0mVmYSTt6D8QTFp2Mh8zNmHFQafQrZRCvbfVkyOzop
 uj9jy+Kw+weezMlFnS86F9kNWvuH97Lt+KEkBmj4havydzEgjgLEOvNpZkO7MAurvqaATeloEBR
 qIasKrQUtbC45m6UVuNvYVB03O43R9/wS6T/xkZIeUt4nJAOo8T/+IoBURAx6y3HZFdPLKmFibz
 xgMrhdUrS1X9CSmq1m3XLszAepwWZm17nCplDVT7lUeF4NJzhp0EiSR9gJsjHbprdm3ko=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054516_595432_46DA4F4B 
X-CRM114-Status: GOOD (  16.34  )
X-Mailman-Approved-At: Tue, 07 Nov 2023 05:52:34 -0800
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
index 1a9f929fe629..20d09f437262 100644
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
index edb50b4c9972..aebe885e5b2f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -90,7 +90,6 @@ static struct ctl_table kern_exit_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
 	},
-	{ }
 };
 
 static __init int kernel_exit_sysctls_init(void)
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d2..a81cb511d954 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -313,7 +313,6 @@ static struct ctl_table hung_task_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_NEG_ONE,
 	},
-	{}
 };
 
 static void __init hung_task_sysctl_init(void)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..d7e883864f82 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1005,7 +1005,6 @@ static struct ctl_table kexec_core_sysctls[] = {
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
index ffa037fa777d..5ae3e6ba88c9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -99,7 +99,6 @@ static struct ctl_table kern_panic_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_douintvec,
 	},
-	{ }
 };
 
 static __init int kernel_panic_sysctls_init(void)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 619972c78774..3978b98f6e6b 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -312,7 +312,6 @@ static struct ctl_table pid_ns_ctl_table[] = {
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
index 3bba88c7ffc6..a7828365d2aa 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1272,7 +1272,6 @@ static struct ctl_table kern_reboot_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 static void __init kernel_reboot_sysctls_init(void)
diff --git a/kernel/signal.c b/kernel/signal.c
index 09019017d669..89476890e3a1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4800,7 +4800,6 @@ static struct ctl_table signal_debug_table[] = {
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
index 354a2d294f52..64f3613c224a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2043,7 +2043,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
-	{ }
 };
 
 static struct ctl_table vm_table[] = {
@@ -2249,7 +2248,6 @@ static struct ctl_table vm_table[] = {
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
index 5cd6d4e26915..0f546d17c544 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -924,7 +924,6 @@ static struct ctl_table watchdog_sysctls[] = {
 	},
 #endif /* CONFIG_SMP */
 #endif
-	{}
 };
 
 static struct ctl_table watchdog_hardlockup_sysctl[] = {
@@ -937,7 +936,6 @@ static struct ctl_table watchdog_hardlockup_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init watchdog_sysctl_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
