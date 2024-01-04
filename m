Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C76C47DA7
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gAFzzz0JsXmkO9BZTAJ5/kxdGKx7FgpORhbWU2qT8wM=; b=V0nXIz5EehjSgJ
	2o1S8N3FVa2EeXhM+nYghhrRWti4ap0x2QnbHiojCrW2Q307nBb7LzJbc0cjD0qCdjr9dPokdQYUw
	v1UrhP3UtHMid8KOtrsmKvysZsCmVyMdfXFtlT2qcQ8EjpNonazR5X73mO/elC5a/u2j9VFkJbKll
	MdZQGgh2UGPdfCBi/Ns3Rs3dgP8k05+BhpkmwxFRU7SHz47S37Xq0mC69kFPac6FGmDpjz9EBqTRk
	PuimIRnadpSaFP3G9Vsps8/tWBk6tLJZXNc9dT9zGv6L+ZOitHFatOSxF5viymruh49/hpObx4dWg
	P4qT5ZLYyxTp/ZC+ptWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvw-003EDH-1u;
	Fri, 12 Jan 2024 15:59:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPFE-00EQVo-2S
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:02:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7A48ACE1BAA;
	Thu,  4 Jan 2024 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD6AC433BA;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380566;
	bh=M0lJ+zooV1Yyo+14mKPEjenw2FnX5TBeXLD/QG0EKrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tzKw1YP7iIwTgszbYEuQZQ8dX1nOccWY8M8SGP2Nzp/8LWeIPOGNOr2NNzsoFe9Do
	 j05IBQDEhuUS2ubHJ5bizSVvzoRJ17h4yzKH75+VO9hik5kXjhUm4A3h3koKADRHct
	 U+1NakhR+RiLo8W62Qt5qJwvlywtfKPnZzlVgK2qRBTKNMB0y8gwrSxvYmfdZaepNA
	 hjxHw25riuL0BfKnHW+SchCTLxkgE03cq1ntsNYrLlJDpGACxysJ0+QMD3WIPD0fDO
	 xU0K5MV2RNIBrUAQapXUgekoxrBZP1PMfyIV2r/cSuP8mxcMYAHXXeM3WrKFsWkaCZ
	 a8bxTIquTzCbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F5CC47079;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:30 +0100
Subject: [PATCH v2 09/10] delayacct: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-9-836cc04e00ec@samsung.com>
References: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
In-Reply-To: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
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
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiRDJVGlokeBPAeSnBuaNAX8JsMtOXt+W+FM
 Cp0ZHKNzvCJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkQAKCRC6l81St5ZB
 T0exC/0WOlxgdQAPTkUXH2DLj25puL6IGH5/b/8KTxvl+60NCnIK0wEAFPYJnXwxHEsq+TClWFB
 XpCPnd/DbI+DlCwtnb9PaX/0XnOscIW1ghf0w7khP8fPvWHC0bkY33+Kfbi6tS+ntWvPH7ZZvrc
 evDRhuly4KSc4ohC8Qdrdsgmk0yPVg4SKRo4fFUCF0dtwxlt5J1kE22Z6nJ2hG13egE8+T+82xp
 19Q1JuQuRLHTKzQKqCi1oDxg/XxKIhTZfkS0Vb/9A1DACIS0YLWyMF6lcMcsRfo85Pufe0dOs0k
 H/XDH5JXuHJ1UBeFP1FrRnkIpYr0jkkR6UqYKd3IEzPaz42VXre2MEOIm576M0styOzXhtMTT8D
 ZhJ4mU72oirOt4qo/lmElvXNlIVaD5zsg2WMJgsN2F1r2nmMqo4yGcr2ICMGmjSkqGludZyJFzn
 h+Xn942NzRutgaffrzpd4F8smoC9HOBtKsdbTXiQolKnk7JyhFRKWosghv6n9hJ5OzOO4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070253_165872_DA3751F2 
X-CRM114-Status: GOOD (  13.35  )
X-Mailman-Approved-At: Fri, 12 Jan 2024 07:58:48 -0800
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
