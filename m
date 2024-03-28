Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23DBCD11DD
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DIetiKxS+Aaml8tSsPOnrjOi5s0L51V0/nOmg+ibfIk=; b=M9qPxWyhFWbEX9
	BirXAxY4pS4v4oGGLRZMZC1UyY+Ihta2cogS6AEp7bckyO6BQmHLIhZ/6KzeRplx0VZXyGD9Vbc6E
	IO2ulcHhTGIe6qVYkWPU2ZFIfDuOONny6Nmx+Hc5xGIBmH4rZesNkfrLBNlb5rE9/cGKHtOZ8a/HT
	gU2nkjJXvBRTVM8UYvB1DdBtGwXJ4t1xyGiE2tfJRQIq9WK3fzH5HCA1UIY4PTwUjTGtXSrsKjBMI
	X1D6SeyG2vOl42+BgqqPTCzQ9oyh4uNv7rHTem11uKIlHFC9V5bwwzA6mm66WjwqWhKyqKQfDZAuc
	X59ett2jPhiJ5Ws6Jmfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGn-0000000Ew0H-2J3M;
	Thu, 28 Mar 2024 17:10:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvS-0000000EZen-1Ug2
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B566617B4;
	Thu, 28 Mar 2024 15:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D555BC32796;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=QsSLkxrYhUVqWpP8CUeoYlHeoCpNTEWsJfd/CbMZCLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bqIkT9A8miIjGRIsO5FxO6WM+mLxihwoAA8t78Xpnj9RD0KbfJ9WdYRma13L6ITC/
	 XaoGbHF847ihU1FcmetLZSvSXI02qe9Z0AF/oOUsMqpKBBSJYcZYyAY/71rYgf0JQu
	 EsO12QV5cI8vwYHomFbGv/kh0NuC7m5jaWuoxJVeEy2lObrLGIqVxwJlAqE1Hznb69
	 8a3NbeQjdODnhyuXC9a7KJv/DcFDoWC/BxwKx47EfmAorORXqEfE9QnUQkRRUHlB8J
	 t7ivo/j0FASUakZvLtG2XMITF3f8qD7Hcd1FSQzAH8TfR3zaCp5Jz5F0pGe2BUmdWB
	 DwQhlx/xjNwgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2ACD128A;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:10 +0100
Subject: [PATCH v3 09/10] delayacct: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-9-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=i6rZdV8sO6keniVz/tdr/tgncwQ879+rgbNywApATf4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE6p4PaxshghascUKUubW96pCKfCYMXWK
 /aBSiIGgBYe9IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBOAAoJELqXzVK3
 lkFPT5QL/jFMK8C8aAUdHmCMTOc9tNhM631bX9/8b8lUvEasqWg0CLuygFHjzAxdGGUi6f2nMno
 kUA+T74QXcgNWEfjN8VdVP/NO4Hz21SVA+aCZP0vFbtKHAWBkHmYwmnWX0fPlkGMJCrUunVQyKT
 /67OzmNJMzHHhjA/5fn7WKriT/aSjVsfwMvG4vmTR6pFuRckh3PfzYN490bT09jtp1LM5eUpmG8
 v+ea5g4zkwWid2odf83OnRVh4vdoUz5SuApM5ocoFDK7fQ6gmTKXpn9+d22D/KNKyXUPTutUE6b
 B+0o078nrfEIiOgvo4renClDzc1apR/G+d1RNpqmV8CYDBGy1C/udE8mtdW8dL14nv07BW4TQ75
 7DrHQJXonF56KDikz3C/7owWHYyRwwWaSoa3lP3hankVdZGw4kpt1l5d4Zc7t/LBDUip5/4gAew
 VC1fPxiZoxYHw1Y5wWleWrZgF2lyeO69C7f9SD9OUdRUvMTemIC3m7QuHy3ZmGO6//TXewH9oV6
 tI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_084423_204781_7B26FACE 
X-CRM114-Status: GOOD (  12.75  )
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
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
