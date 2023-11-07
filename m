Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA17DC04A92
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QoX/5HNKeH4/0mC6f1LyvmVmvIFPumfXn/p4aVKrvG8=; b=bLQrk8WH2evx3g
	pLtTwh0jkmo6zEcqi6z59O0S2rrQ6RwNp+u9fBUNGrbMptldrpLekfwa3Y3cq54B84VOTePT5MOdp
	154xAuenOQ5Z89Ku8pfqgLr5jYfvhOnv+QUjnnOB+HDwsQ7VCg9TUN+P4wKKy2DcX9quMBQlraZ67
	oBUJg18/6HyC3ekA25+96igzUTvjh2f6571LH9Emof1pBl9VMzcHp/PC/lJJ2wt/yIdlwxMdZzxlt
	wGcGgy+5Oi2AkIGARMglcJs9N5iC7gorFa1os7C6nyu9w2FszjDTYt/EiF/87vooj5zni0AQxeyNy
	U/h0UuD5nyrWhP7RfdnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVT-001fNA-17;
	Tue, 07 Nov 2023 13:52:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MON-001e9O-1d
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CB34B6124E;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4443C433CC;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=HyioLOoDvEBlATC3oUAVjYFRl9dq5W388xrlI9Ieu7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dn3M4HvKkjtyOupwzP4sIZWAwCALy859slH0KnCgTN5CdSgpZKxWPkn65BoLsQney
	 tPXqoCp9skDVl9TUhpPRpkjdo5MN/0Xyj53pLAASHA1nC9PQBmOhKQqjxeYu9BYgiA
	 6nUK30sA/pZ3vS7RNg1f4xktLOjs5307/gWTlzX3w7JCsRYO4hK3smycruJy3P7KEg
	 Ce+rBE2YT9BI91Ii/uQIJuckQGFpKtb+xRT8lE7pbAtUJycz03QaBk89DLwsbOrd4n
	 UUqxwXA0WjStS21UQV1JXD8mYnCfATh3SJj7XH9xNpm49TTBO6U3ydmzsGz3/ZxYZI
	 On5wUPzNwdYlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076FC4167D;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:08 +0100
Subject: [PATCH 08/10] kprobes: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=nWjRp5Vrg+ud1dRdeeTsGHswKVu3speo5CXD0Ie/3Hk=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9mTiQpxRe8y6VA8N5Bbiyy39SasyxFgAphe
 ZwWlNmkRsKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZgAKCRC6l81St5ZB
 T62EC/4159LGg/eYZHLJVsZ2/BLea8risszfgK97VlpM7eCImzw4TtFhVxNhEHusGqjuHcBH6RY
 1vZGowqSOZ1o8rEfFB1c/bruJOKWPnOG/M415s6KqNDj5uC+/nAh/HL0j6AfmVFf68tJnJxb2CZ
 JGX3gUezJ8yWN0RptnEkfPzi4Vx8oRsmhlNPTpH0LJDbWxRThzYJ8cqXWwN5r8z46p1HX6cX5sA
 Yj1uIQNEMZB1yP0rGNT5S9XDF2PmGnsYhshb6i3flRvhCk6B7tOxwW3j98FnAdQ5IooNThQBpiS
 rPyJ7dIh88osA++zi3/J/afB5X41ozKSvkWa5Bs3ADPt09HyC35Vo4UYsugNeCdRk9oIfy2CCUW
 1EYCVgoZrQcxKm8I0mFm+IGIhzrVCLUiplB7TW8z56HQNzL14aFqLXU7tZvfqKJDq/NQ7jC7vU7
 7Eur3LqdGoxAYbANkcrwRpIeJK2KdzsIAsyzEKZ1ClSQksjY6HO5BxjSGe5ODuZmNaaA4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054519_631189_6AFB7B06 
X-CRM114-Status: GOOD (  12.82  )
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

Remove sentinel element from kprobe_sysclts

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0c6185aefaef..d049b602dd41 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -968,7 +968,6 @@ static struct ctl_table kprobe_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init kprobe_sysctls_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
