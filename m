Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A662C4167D
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m5948zQONqyjfwHNhuZ4SqEN5LU7y0UsA+GsRcNSilA=; b=yf6IuQlcK1NAfs
	2hVaSKDcImi3w9r8KXHKw+U1vI4xu8zvYKdNYNIOBl31q/hNTR4JX9LatQxSuHA9qiuo8KZxeprLZ
	HmPsdp8VssEdt1UXj1YXIHN9EzSmdB7DoxQhqMZJ+F2+6V6tdwjPySxmxUsVudVKrl4P3TLQKvxL+
	N0SfpJm91jTdw4GVSJpVfNa0k4QCpqYQyowxmL4gu7p+/D39hLCkLEoAav3MIPxgyehtJsxrElxcu
	BnbEKE9IPk37jgm0YXy8fC4dUGLj9s2/3ZmplUF3Nx063SfHDx5iklXqDkjeYhrFnosznaY1buKzt
	Ic7yGV9Mf1BI49x3tBfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVQ-001fLy-04;
	Tue, 07 Nov 2023 13:52:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOJ-001e5Y-30
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5AFCE61227;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCC1C433BC;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=76OiXqny0I5FAtIEkgtQeFpTLfwhsiR4xIiHIe8GjjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hKEfTY6pgMSlSjVhFtW2zT+w6cS35Y3lUAQMKJ+cTa31bkazEsF1Y3Y1qGbIC4NmB
	 Spn25qW1CXJoB7N0wE7jNp4MAf1uaVYs9fjn2kWaSjtVSuylzwtb0qdcr8dT3o+hUs
	 KM6cHJFF/cfIWZKK1r47Nnudi4be4dyAE3oJX7na/NzE2BTbt6nwo5bec4IoYQYygU
	 oOVvL9JGyAcN5ZvGqqcIkDZG1kNRuzD5q5hMQSBfF24k9RIW7DshcXlRvJRLNmNAaD
	 t5JhUQfJoJYbQ5f6mOcV4XrlWTDt0ZH+l8QBm6INZpg+LgfirtwvDtTrdP5+oxbbj1
	 sc8RD/Vhi9W/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A5EC4167D;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:04 +0100
Subject: [PATCH 04/10] timekeeping: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-4-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=rOgjyk+y2sTTf7UpdfCg7T7N07f0Drf2bm8cuUCjmf0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9lo4lHq3W7DTuFj5cG9c2hzwCA1qpfvT7ET
 DbdUecCRu2JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZQAKCRC6l81St5ZB
 T4l5C/0crurghG7p8vkJdWnAocoHgECRX54CsB63XQcpAUcwN6D3li2qOQ9xTGuPXbQ7gAqbJ4z
 iDEag+GTNufuTyGWM9fOV/cr750yQYoRv2CUBrmWmt774ir7jMqweCCXAk+Lk4hNjmCPHCwU0Kh
 ls61PcywEqFj6ebTD/ux6pFErLrNVI4Cd1XXbyZKY98lGZFmS41eBEgN3KbacG4g6PZXipFGqr1
 kKRa3xzpUR5ZOsF8eeWMeHY3vkAl/YtF7Zt1dwFsOPiqcvYA/0SM+BMVdHDH//iZmWLhahKwD/W
 vvEwSFu2i/AKoccgpVJJfFJQ+/LHD9/RFb2V7qoXgo/8tTYAT3s6VkPjuHXRdCDEwVPbY8Z07N3
 Oi+9iP4azjPvUTcmYcOHqPRaD4OPmqv6UNbce12jqoHR8WNscwxkNs9mXgDI4/pM9gN61UL2n8N
 GFYoJeOf9EJS0IDLS3Q6VRC2XVLIfaTyAxkQtYLPpE2/KEdCoLpn+nxRsQWqKzmXkTWYc=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054516_061589_4886FBF7 
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

Remove sentinel element from time_sysctl

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/time/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..475826ad78df 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -260,7 +260,6 @@ static struct ctl_table timer_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init timer_sysctl_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
