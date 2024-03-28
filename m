Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC7DCD11DD
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=28rVqX230fLhdjQxsEpQAg6fSo/qyUdcGAL5hkcGEN0=; b=L7OJTDWrFZ9Hm0
	uI0DRsNw45ZPEdtM83TWMkIUtk6C4/ciM3WAS7VmQVq9jygsFGfOVvK4bXvxclFQq0pvcMg/6ozx3
	pJQreKCIyjqMsSoWLZB6oP+2OBSJAOewPvApcVzbg6E78VoEAmbnR2+g0k0ugPKvk+cLKNF/NQibB
	jcaBmEeYJW5pt2KrS91Tj4AqsrIbe7j8zrje4nUv3o+B9Df+y78lqL/EeTPBTBN2r8FE/OAa2dXPA
	tq45Ta0MN8JBbkKmRH5d6fhxxlMkUEmPck17GjVcowaJApKwhesfDoUMvnop5ymi/8CSpPNVfL0Rq
	GLD48+tQuEu+PCO1rq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGw-0000000Ew8r-0BrZ;
	Thu, 28 Mar 2024 17:10:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvb-0000000EZn9-45d4
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=ErjQN5E9uvUaOlKOW2u3aiVFyzbzhdLraLNh2giu0q8=; b=MF45DbSUHJQt4wUCVY11209H3C
	yr0ePgQv628QSBClCJaryHnNcy14NQG7XuYhqNRHg3UBoPYu12x0oGI/V/5k5MiJKXrGAfd9eao9y
	UyezoWwE4V0Kag/Pi7saMW8iLrCquHHItDFgXTSqt+4MIEUu6SlK3k3ZFHtJdHZv50sEiTUpJIL5v
	9NWyUJI009Klo+SrVGHZ4Cu4Qv/05NafYyDLr+Iq5/mkYcDrOdi5vEXpsEFUGR3QxTo3PwhUbxjra
	j1gPNSMYE016PyaW0qZISxl12ACsNz8qpwdXpQHpkQLZ2qNgJVh/EFHcw7iUdkkfW5JR+5OtV4w7W
	c6/CmigA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvW-000000012A1-0lbT
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 36135617AE;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E039C43330;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=V9eApfrx/luUPTr0ui9HIhkRp0aZQ7q1nffr8rRLCu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Th2X6ibvVdQ+kgNVc65KbGnF7WOCx3uMpiu8utEkAUXEGRRyiJ3LbFumLPaz3pwRm
	 hcw4QdtEZZuBdny5UnP4IaNjE7dVBkQCCEdiObTSlwHmPC7kom1wsZymTk2r/jHMak
	 dncXWL3zaqzj7Qbr7PHgWpgppPhXFHvwYxZi1ZDQcjru8Hu65ql3UUvqT77YNsHI/e
	 Iw8CpuIG4z8NiKPFFQ5Bjt7RoAXs54ourHz77o36j2YkJUX5lMkxEX7NfG9IDOkTxm
	 CKkvDgPkYHnfHpKMepZQh9d5AmD8z4/9xbnYX+CBXGKyqJQMfByDIF2BwOcJV20P/+
	 35HeG/vANiIlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34012C54E64;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:04 +0100
Subject: [PATCH v3 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-3-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=1araE0kn/61sWG3kWH8OhE3BK5Hy2HOuryBQQ689H28=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEpW98gjG1D2aFsgWF2O5xiJynGheSz82
 sXxRtohHqsNOIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBKAAoJELqXzVK3
 lkFPCzUL/0SG+3ODZAcC8VOhC+0GoOi4kE7faOWvyEi+zuJjGTMcwSwNf4IntNxUSlKxLruqmu/
 sXS4rISd6LajFHPlALx1lSwYZelfgle5kubkTKxbxuV4A4EpjxsYLKDFRoFS9tmt60X7MzNuPrv
 2ARWH2eTismjVuHNYgaovyHiC3/nZ7Eq0vltmN6f9/mtI49KNhKAy6wgXicwxtfN5J5aRPKDmKF
 +Crd6eRk4VyjwwB2aR2w++kmDsP6Cjnha4ho87e4AWqV/7W9HLnSNaPkAilDaK+ZwdYvCX/6rhb
 nSA1+bIMwy8cuyKK461nhWqG3gxm1jyfzvwyM3bhD6Z4yl22JmRQg2TxIPM6rEulBpeOGoNfhm8
 60+H0uxestVapnhLqg3gSUklk+b5Qv4YsJ9XowjlmPrCMKeLBtb6t8Wxpm+72Jba9Nba9Gyx7wB
 6nHOXmVGMy7L5w1LCv/2Im1SpQ9JngLB+Gni4XCGVVQhaq/cxpd2dV7EQKFfhCDOo17ZGL+oWK6
 +0=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154428_753996_05CFD54B 
X-CRM114-Status: GOOD (  12.70  )
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

Remove sentinel elements from ftrace_sysctls and user_event_sysctls

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/trace/ftrace.c            | 1 -
 kernel/trace/trace_events_user.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..6cec53aa45a6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8270,7 +8270,6 @@ static struct ctl_table ftrace_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = ftrace_enable_sysctl,
 	},
-	{}
 };
 
 static int __init ftrace_sysctl_init(void)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..304ceed9fd7d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2833,7 +2833,6 @@ static struct ctl_table user_event_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= set_max_user_events_sysctl,
 	},
-	{}
 };
 
 static int __init trace_events_user_init(void)

-- 
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
