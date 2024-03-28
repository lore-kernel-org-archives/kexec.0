Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E2CD1283
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B14XTf7VgjyzjNZG44nRRBcFtVrghWIBtLKJCJMtnCo=; b=USUgLKHnzNWYYt
	Ufn++CQ3L4uGX2hQWoLvpescgQYN2WMr1ua+bgTfV98m0r5LO+8dMVJUvrO04aYyUyq88SfUPO2h0
	4hnrM5uXhqO9vIvErDtLUa/fB/t+pFjWul2JeVnaSpkb8Yt6Smcn75LeyaePop4gADH8joP5V4iDO
	WgkyIaqa3D9P7LgjvhjA07yINtaNyueBw5SgKXiullpt64aYbJwzMeBrf2SDDcnbg6jjGPWS4Vftw
	FiTkIBI+SWnMC6xsn9BesiZT7MKo1U0DbmUvoCvA4iRJYg6rEOo4FCGKAifnQcrdaRe030qKx0hUO
	crN4MqnE7Nr5/XU73FMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGu-0000000Ew7K-2M4M;
	Thu, 28 Mar 2024 17:10:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvb-0000000EZn3-37xZ
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=9z5EG7W9Rezjei/4VkSPWpN6wvNYNS8/ELI//jWguv4=; b=hN0Uif2viMjXFrNxFBkOhX/eXg
	ZpFT+cRClReLOUavH90Q98594iknY0ON+CMtKAIDfxetaOvjvyBEj8WcwJfWvVTBfnjD1ad/TWXqx
	jTj0l+Ct7ZPM+LhXBrLB6QPlT+RJKqX95dZtu7c5Pv26FT7Hk1U9TB3nyZQSjMRL91CUN2FzGOIis
	Hi8KhuCOTboqLd8u7fRlnbg9nfiXaQfZ671GNsOwqLBGTGNlGDdfGYqbOb9Cfz1y+W7YZwFDOJsrY
	Gv0+MT20hF8z8se/ZW1CWVRnAZNEob9E4lt0dyUD4zFbOvfCq1Q2tcHW8xqcRWfAFq5UrtRNkwtOr
	8IgXPyvg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvW-00000006eEU-2u0I
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6AD9E617A9;
	Thu, 28 Mar 2024 15:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06321C4E66A;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640658;
	bh=MHDLw01aV7Y2y8q4FVOlVqqv1r/NUfwe173AEwvrpiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dKPD2wS418NUIbqJZhZ08bU1j9gcAOSF+5V8WUweINfFYLrG796kBAdHGPno8ouFE
	 cfg24Z9mXJ4mMIMNgO8ptj6Bs31eL4WdrAlLq79VvMQkyDbGokebYEivh6+U7hgz+O
	 lIgOraJK97jRcAkwbE0TQg2/DZ5tmtDQIYiutkDEgAGumoSAunQQsm0kNazW6mIHCu
	 Qyn78HeyB3+aN6GcZbukSEEdRLmtZnjTx82OpkUxA0Bnzf+amJOOL7QEeZX23WU0dK
	 llOxfI/qQ3r3tmo4wOcYVa2SqwdBtA4BPLXM5Jm2hxMKM0AI85vAEBwc6teCx4TZR3
	 9goN7McNdwdsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1065CD1284;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:11 +0100
Subject: [PATCH v3 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-10-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=EHedMAAx8mJbivlU9QHUO7qJGc32TBFT3ByM4xDoG9I=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE408xMhw90vhF81FOWcLfCE8LWhQfflT
 61/EIF6yCrZ3okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBOAAoJELqXzVK3
 lkFPfZQL/3zdbAgEIU2dcwe2erodBotsa3e1HOBR1lR9Kv1mef/Eai0SkALWcSc5dDfORlh8Bpq
 PH8ootjUW/DunAVLKXTQn4VMu6CLt820UZOwAAUShG8wiPlD4fPaiCI3bJT2Gmei+/UblaMVCdT
 7zSXlcmiXsNQpLq8wzHqy1pX7aghk8yJqVPHjwRh/RQdcVvFeabeB6ftt/HC5jB4xRGKOC2oRuT
 t1YyA9E3vlnRld0l3Uz4poLLs6b+/Hl1CYRdcR90Vamvfh2vrhHNkhSZalYTcUe6Zt35Kda6JmY
 h+Bn9Q93xvC9r8Ehl48JR/4OnKrelkTK5nibpYdaTr+qdGNmJMIlGTaIfwjxFPnT9wQwxHgSore
 qY5gbsjMkHcpBf/cSrodl7fYS+2m8r1N6uxoFO+qx6jK8BEHEkPUSly2nhgOStdKvBxcMqJo15Y
 /UHtNHyB50pyHMxZlSDGfg/qGcL5XYwLqrGyHpObIk+F5IXwU2yUuRmWXIZcFjiMMdWAeEM4C85
 rE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154426_997742_5D55D4C5 
X-CRM114-Status: GOOD (  11.88  )
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

Remove sentinel element from bpf_syscall_table.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..c7e805087b06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5979,7 +5979,6 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
-	{ }
 };
 
 static int __init bpf_syscall_sysctl_init(void)

-- 
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
