Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D899CC04A68
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDzVhl2aJ+288cdDWC57d8hXraRE2XfgL8VX8HUxRqA=; b=oTmr0oEgf9Kz4L
	QjL+xFBBQ332Nxak+NFsSvq/sro7PawpX2Dwm3ySqzDz/WOxqhHApLSHo+A7ZGDht0WkPkb+BHnC+
	2xD7JVpOKkYHfo5mpvt+sLWI81JKIdKSGk7AD00ajVlaTJgWrZgPA61CDo8z/4rIRs0MBX1LlZlHu
	wpSrtxgC7HSp5FJkWzF6cM6xea3fc28fe2NmOza4mmfCAqjTZ/bTRQUibHY9f853R3EPdnpTinWuk
	hk/hk6i+ZGGqeZrv0ex26NuGU5N8Luz+XMmFU5uZfJsNkmcm8qx3wotcgNxhteYx+Y5U0r5gCB8h9
	RqShHUjK5abmgKEV8hVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVT-001fNa-2s;
	Tue, 07 Nov 2023 13:52:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MON-001e9P-1h
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DA56361251;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E709C116B6;
	Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364714;
	bh=qwSXhaWEmixJwqWSMH3MjGwCx8gW/xJ5LMhTeY8N37c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cELQPunZr+QxIp/71qTIrYa6HCziailKodMK+NbHbf1iEXKlEjK8rvV1WrhF/NVaZ
	 B7FDmbVz9dh5mdS4GA7RqBNhNQoId93tvOPevu3xSa5mrLzXUB8M1wWO/iMQ0AFfRs
	 yYMf7mNeEIFVKSA/LKD3nh/KpXdzk/6ocAebbi4MQLXy5sSNCnd9yX197UePbA5CAL
	 4pS2Xyh1d6ZUXwJ3p08s4j6uI2lTDGwesaYKo6BeB54bG4ciuekyCLLVtaBOTlMjy+
	 KSADba/YAVCg2i45UCbNAmUHidcML0hd+mr4b/LPgTpp86t17UkVQoWDMZgS8YaRXC
	 uM6nEawX/kXZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7BC4332F;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:10 +0100
Subject: [PATCH 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=5yAM9vjgw7Y3iEKSRDwgsfEUNzgbP7A1qp4Iomp+9Rw=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9nV+EKn4+sR2DS4tZ3BKgI/sF7yqN7tDACZ
 iMVXqJI5ymJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZwAKCRC6l81St5ZB
 T2DXC/wP7wywT8y+9hh45MC6AtzUWy1pNcmg0ZDiAX+kO6B4AS676JoI8W97+2AvSIUss34djxy
 rXTIXEdlHOGk6i0aZDX9pBcNWDykFV5r5R3XwopCL9VrGzONl25nKRSZ7mfj41HCvESbEGCwAmc
 tP5ue7NQTJbLbEmJQyHM+4net9sagAvtYkjsh6OEGUV3xpP82MjMhJ0TcZTc9xMMcSlaUOJNJ9m
 dcZxctXezLOfwam0iIDt4A0sDsTM2MjQ/xbfKZhKwKKE7SEMpBojsAKoYNyVOqpjNzeafgIdy0O
 N3QUkJ/LLv29i2746+VnMD2ZxPBq3+tsENJ7QjIlGikLUXnDaHuGyBcSG2T2B7DAZX12/PSGZJ/
 o9MHPDKZVOC1nbOyq/3dE04DsNMS8L+xGH3N6LhH81/WgpltJn8x6WWg/tKVEwwiGFowLLQ3klm
 I8W9nWkU+DYbYhzF3k7D8C9HUxl9ZuZWOtgetfT2/BVOXK6Pe+7mUTx4Vrra6Pf+uDhBQ=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054519_671696_A5F4426C 
X-CRM114-Status: GOOD (  13.13  )
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

Remove sentinel element from bpf_syscall_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index eb01c31ed591..1cb5b852b4e7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5679,7 +5679,6 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
-	{ }
 };
 
 static int __init bpf_syscall_sysctl_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
