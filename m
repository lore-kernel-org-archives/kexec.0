Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E83CD11DD
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X53tSDtWC2GX3yFqB8AgzsSF2HdgK6rIUagJfv8veX8=; b=UMLRP36AfRNk/N
	aUwHws/oIlE4UvXtARJmYrvcciqN2PgF9lwDL6FOLLXG4Y/ksT3pNEK6bN8CMRa3Wlr6vC0hTBs/h
	7K16lMPWUhtVGu6iUJ+iJlpWR152eNK6WgTv5+iYqeyjE82bPj9w27eXX7Vw3MYa5MdrwChjUdyP+
	ERg+8uUryJiFUNnbCaIOHrWKbxCHShtJs1qeQyxJCIennvslCS9kGlDu3JM69wOib2UgAoGfKJUf0
	skvP4eLn8rHRdmW4s4HXX5tQz3m6bRrC4q1MFulF6reuCBkCUo3PHRWrMHXtRIZoE4J773LQoh1/U
	hrQkxROOBSkayjnSphcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGs-0000000Ew4k-2kGi;
	Thu, 28 Mar 2024 17:10:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvb-0000000EZmk-1Q3z
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=KhTeGdyS0b/NRabMTntWlNdoYEgPPIe9nuuFAYemqEQ=; b=Ksj4GKPVf8Q+c9P/iJZl9jB3C+
	weXRXlk4BhgX/CUJoz4LnBq0NhBbCVxxT0jcwpkxU+pJMyhrFOCmpWDFo7PDAqrwBevUrCo8/qOsS
	dUk/udadvV2JxkY148A7bHnkoZaZ3EcaLq4umVCo2Bu2BozThEIZ9mUsbKHSTO5vdu7meEKk4tK+/
	Qes4H5gpw4bIWhhvTt+mEhmF5Pv7tIgtiX0boPCsggbyrE9yUjNWJgkbZQp4VZmncRFhSLviaGPg1
	2j/KacbMgF34q/WrRbhPzrlzLNpB7Qz6tCMDocsgv6yKC+EFZ5b244wpCDZeB8MbYj34X6Qp9HVzl
	CGR0IHBw==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvW-00000006eEV-2rqk
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B99F5CE2BF8;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C601C32790;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=gVjX7kZuMI7PWnIkwvFQDdKgNrPSlsBI7m23GDAWKj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VD9M4KpRgRABtXgErWUIa5WvPi+7lEpxfkfoIeX1VZ4mxRQUKk6QQjkTBW5uqmK0d
	 +hBvwjIWMDCYtZ/SEu0kQolGCuVJFFrylBR4ocX+dD3MlW+lbH4tEcKu7vH7FI1o9R
	 DrKg13bZQ+Wg2kTVNKlgtp9reWd3bSGbYoi0sx1X58ILgJLOl8y1Eqr00HIiMa6cSv
	 eH9g+lOUkqBottzJ5Iq5PBSIoi1dVdFQlet01MGS3uvwm+3R8lB0JyZOd3M4+tIaQx
	 P2j9zdse9frbejoPJsG6LrbLjKrHYgvqb6FdVHIlo4oBMbZCc/qhqA0NFofIvQxDDN
	 yOibrbrT809eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817DBC54E64;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:07 +0100
Subject: [PATCH v3 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=TWh9TuMajQbwpEGtTF+wfs10qNacRT/Hf3NmiG1BMFM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEynYXoIAQWrn9RSkVuN1oDKcT6K7ddL9
 r175YqnwQi9PokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBMAAoJELqXzVK3
 lkFPw8YL/058ijl6P2cbK5F3qXxT46bTWrEthlZGmGZ8GJYJxt4w4xxd8ws4Wje+Aw1nnq65B80
 PgTw5N2evkT4xbVdmzguiAFOV2R1xjsSqXAsiymjn6+12byqwBZ2CL/yUesbGlhNF9ZpEYkvomR
 UFyGDVpV6/obod0u2yJq5mBZgdOauAyG669hxOqBNQPyOJ5yqK5kg9tIEJmgCjXYxhQ9fpOpVKa
 hAee3Iiqo6anJN8l+RYFDKloqMYTAtd4mZ8eNWvvdB/VRSetLQV7tB4FSJK2SvuW7rqVdjKzKgw
 RcBa68tzq10aY9o2fwzevUDqXyocoLnKC+QGKO8wFVvSsJ5qjeDwQFFMd/g7t7uLtz52CtsGGGo
 VJeEgdMZd9AIieQae0ZN5MBM6IW51BVFgsChVRzlNYdLygWCLaLEfQDVtwGEDQPeRXQhD4iz7ox
 0ACl102QmSZ4bmC7+wBUg57bX1BYOZlkcp4j8IzzwEJHPPr4lX6HjUkbhb2mTj9INErNAkTEym3
 jI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154427_351573_45DD079B 
X-CRM114-Status: GOOD (  11.91  )
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

rm sentinel element from ctl_table arrays

Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/sched/autogroup.c | 1 -
 kernel/sched/core.c      | 1 -
 kernel/sched/deadline.c  | 1 -
 kernel/sched/fair.c      | 1 -
 kernel/sched/rt.c        | 1 -
 kernel/sched/topology.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 991fc9002535..db68a964e34e 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -19,7 +19,6 @@ static struct ctl_table sched_autogroup_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init sched_autogroup_sysctl_init(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..7ce76620a308 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4741,7 +4741,6 @@ static struct ctl_table sched_core_sysctls[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 static int __init sched_core_sysctl_init(void)
 {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..c75d1307d86d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -43,7 +43,6 @@ static struct ctl_table sched_dl_sysctls[] = {
 		.proc_handler   = proc_douintvec_minmax,
 		.extra2         = (void *)&sysctl_sched_dl_period_max,
 	},
-	{}
 };
 
 static int __init sched_dl_sysctl_init(void)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..4ac2cf7a918e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -157,7 +157,6 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 
 static int __init sched_fair_sysctl_init(void)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..aa4c1c874fa4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -56,7 +56,6 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = sched_rr_handler,
 	},
-	{}
 };
 
 static int __init sched_rt_sysctl_init(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..42c22648d124 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -322,7 +322,6 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init sched_energy_aware_sysctl_init(void)

-- 
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
