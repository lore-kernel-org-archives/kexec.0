Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121E9C04E85
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gAFzzz0JsXmkO9BZTAJ5/kxdGKx7FgpORhbWU2qT8wM=; b=RP9yjfW1lmDD7N
	+J3ODY0YRBgWjDRN8U6vf+6ez/YJAVWks0NRt07k8Q5MLRsPPjVLj+8kx2khydNWLwngSPwrpFkDt
	yQQP9jVa7Pqql7j644VEAobJisWbf7ZHCDNZ3YPuJvK7Q9PXI46ZDx7MvFy1FR29g7HcSmYz0cv63
	39ehSL65NdyQ0RsN4JJXEvXqWY5FaRkYoVA6FuiMhfv2Vw3BydagAgj+nBek7LhWNcH/jIMQiJNJo
	pC3g+AF8/Jez9NhbxjoxZ5Pj1m4hx+eQ6MSwsAgHWVjfPtwuESRHuFm3oizR18MwEbYglUzjzpzk7
	1QUZ39i49TBB89KxDjvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVV-001fOs-1O;
	Tue, 07 Nov 2023 13:52:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOb-001eIy-27
	for kexec@bombadil.infradead.org;
	Tue, 07 Nov 2023 13:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=ahGTOiTGe575TnhVywvyUARIdMfBIeQ0+tpUlDJzXjM=; b=LJ0a4EMg2Rn4rsDAB1S2V7gJnH
	+NPrBYWs0Mm+6lNN9bi1/1drCw82YmQB2auEq+Q+i3v3Z3guEWTScO5t5llkr3eVeftTxHycmhXsK
	8Y0BYflhs53hTtJCf8Zy5XVoqG3hrKwQOf1rvYw68CmvgdXFN81eJODN+IMDgwYwmiCnDcNLUBBlj
	KHJdRvxUur/0H/h4hg6XTBiKpuAbSSOfcxHZcuEWpkG52kxdJ3P4wck01HxgC4JWCPZc7rr7bbeIp
	oxD8m/mTxTKIbuT7RFK2XT7xp3B68ZCvDDlVRH3yklzjenRKa2scyWh6apZuPD4halBl+w32wj5Kj
	U5oKz1dw==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOW-00C21Q-09
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 59D5DCE0EC7;
	Tue,  7 Nov 2023 13:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF1B1C116B4;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364714;
	bh=M0lJ+zooV1Yyo+14mKPEjenw2FnX5TBeXLD/QG0EKrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gcd4baVecj0rYm+kcoZY1O0HGeYbQ0hlN+4/+T3oDK/8gCNsuRtzLupOsBFfNYERG
	 pcPfqh1fkuFOnLIwE1aGPonqjN5dHwagylp4HWzruyI9NiJfrzOhoXZISfsg1MePpH
	 pNqmB/aZZTJtI6kTtT4IZ2x9fJiqL1X4eck+BFtGlO8PgXjGcmNDgosvs0iE0NlnOy
	 btazr9EbYq9gspeIMF9UL7JIjuiHGZFx1UGzWWpL28M1nY5o40ZmKyWp+q6uw+iqOS
	 VHT8GDdK0C5GstipK+1Wp/Q7SHKohfAu/u64iNTL1Hw5SfB10UDBR+vvUWCi7U2Tu/
	 OPit+ijMsqrGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FCC4167B;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:09 +0100
Subject: [PATCH 09/10] delayacct: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-9-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=PJ/c6fiwMnA0nSEp9ZYMYlywMQK/R+6xe3ijDcw/ADA=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9mvhR18IXVFt7zs/Yo8tKkBRu/V4Z9U1LWM
 uOzT984axqJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZgAKCRC6l81St5ZB
 Tzr2C/4v6uGi7l5ZwtLL3n6tVWPjdCcfbWz5uSlBczQ5ruXpwp9yVZYJNSiwhoNkWuHlhUQvQo9
 jqJzr71i98vbNXH1oEiFqFDp3xoArCnRiDFA02s3AaIqqomXcfE2GpEeFGALRmMtvkUSol76uJL
 NiDMS4jTU4UMuJo8KDqgWuNIPGUGpqum2CLbCbXh6Y4OY0P1uUrj2X6cKHqyflXGEbuNEmNXLOL
 a3Q570tQhzm6YlECqA39UYcG/smTJjEMeCkvtTS/4yFlQ/Yp4JWoJl6nUyC/Wm8h7NPeeb+mN0/
 IjkacI6GySs8GFKLvqOPGqfKWe0sq2vPlDcAONobKe5v9f40p2UKM7QixIe8jjs8GwMNqsOgYFY
 WcCvETwK5LltSI6cG1T/blqFg6nVoq2r5tsrpJbJOT4leSJ9imQhcokmWXEfATqRptW1/AXzGWu
 WU8UbmzKfdo4mIjQByvUw+U0aQAbpo9vCguSktma4jMXmFwlJX9PkuXJfQctSS1NgyPak=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_134528_847925_3D1962D9 
X-CRM114-Status: GOOD (  12.93  )
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

Remove sentinel element from kern_delayacct_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/delayacct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..e039b0f99a0b 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -74,7 +74,6 @@ static struct ctl_table kern_delayacct_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{ }
 };
 
 static __init int kernel_delayacct_sysctls_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
