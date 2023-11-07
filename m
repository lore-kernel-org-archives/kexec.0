Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C9C41535
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DyC+QZ5wqRNBjh+RV6Yxj6yA39GvxvAFAvBYV3v79c8=; b=V77ODq8fyxpXb8
	r9wvhak56yfV2l4qOgFNuVX6iEWu04eOkpT2mjldwuXWIEjGe++tc4v9C8VAOv0lNTtttskJo7Hz+
	9LouU/rnfdbFNK2oxaHsfpYx2KOG2pA7lCJ2coVILc054TEFBAgKWcO546lM1uSy8NNw57zmztX9y
	OSAy92w3YbjORSos8CgHpKCdCBP5AELtCumofSs/AHLHtUmDpHmxBtd7jVuqNMlnXSZEw25nHeBz4
	FG1SbIUKaKX1TBjAdCiBkC9Q2a1UbfVz+smDwZtDI9uxMPmMdIYH2iruDtHsB8nl844IzBcQAfDIO
	F/PreeJPWi7fOW0KTHbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVQ-001fM7-1X;
	Tue, 07 Nov 2023 13:52:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOK-001e5W-1i
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D80961221;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E356C4339A;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=F68T4yfrZvNl4UBjQrVTXao7+5rzaoz2/YnsMWP1cC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gwW3nrmH/jScRF9ZgobtAhHY2i7GnLDmZtx6UzCa6ueJv4S66qLHauESjFZY209Q+
	 p5xHR+bKPEcPivArka4cBl9qD5D6nN4xSe6OVdd/Bd0SIuaA33Ix0Cit0KAG3GJWkK
	 cW5+ObipKfhKv9fIt5aDx5PnT4RH56eJAjN4sSLZFNH0A1Fi5oV7nqh0M5QykYCRRr
	 T+klSwSBFAy76K4BpXjnq/UsVPwRzF/HL5AhqvHaQegBGgbHENtnRfuSbOgkeyJiYp
	 BQXKROp+HUIevqdPtsqLJCoOL9e5VpJ/tKHAzki68agYxjUZaUou/b5TSUy4icMHdI
	 2I8PUCgYHj8BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD4C4167B;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:02 +0100
Subject: [PATCH 02/10] umh: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-2-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=BUKRurk0Zl4Mt0SVqAIUyLoFVcmRKbH7eHtjelFkSI0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9lcW9AmjwigCno82d6PhTWBQFCkXtSTlV+D
 nPugtASnw+JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZQAKCRC6l81St5ZB
 TwBrC/9/Wb7yecBzhIwzrTHkjxuZp3chfur5fai6ChpKZaue8itex6vgk42QMT+bOlLcfrBaSo5
 FTDb9BSWWGce7umGXo4+65/4K7D3BMMq3cCJJxuxm8UbjpvGQcmu0rrwSilCcOXGf+k1LT6ziAX
 D9H1aM+sxShKYzS8MJlKidfv9DWB3DQyxaFpDvTF1FUFZrwSYas9aU7S61zs+1TsuljPyR9DzRS
 9kLny2FTp68YRKbS32PW23eXo0SDluChv0FWktpYxwno2RW4zDS/og5A2Ts3odgh17yTE5hDB+a
 okgwUE7lLNVM3Hkci8cLJZqJVvcS1ebGZ0Fqc+wuy8gsc+CWbjl0Xwx3MAsuKRHI1+CNDmy+k+c
 iWvwHof0r40mPPqeCpot5ZFBtTwHCoYVOoNjVxj+3tmp7lRLVj3sCVt2CytnlFpyMJrJKl1TjNt
 mHgShWxfmi0w8kbkfbGFqME1EU5gQ0alTPdIP4qb7c5NlFNimiaifvjhmGsCW+YJ2OniU=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054516_702394_44D45C3A 
X-CRM114-Status: GOOD (  13.02  )
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

Remove sentinel element from usermodehelper_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/umh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 1b13c5d34624..598b3ffe1522 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -560,7 +560,6 @@ static struct ctl_table usermodehelper_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_cap_handler,
 	},
-	{ }
 };
 
 static int __init init_umh_sysctls(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
