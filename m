Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC3FC47258
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SvsCBX3TTH900ggcnpLhrL52JEV38At4h2PEq/OFPhk=; b=S0grm8UarDWOoB
	oeMTVTnYQZefNq7lc20zmYAbd+ngv1C3hTsEff/bFtZfCPsS38NiWUct277LaBMAzPXT1c6yZBwzk
	RCrTY4r4xsawaKBN7ZrLCD5y6mYXvZ3/caAiKtMQUkAWddjsa9EJMPg4PNhhBcCcYxKXb2VSVosvb
	N8dcRGWM+MS55gJk3FrYJCK+w2ut5qAApvIC9E+KVVhYX9x8joWqWDyr0UvpJYlHNJ4O01hr2v23P
	dF4L1zZLp7fi8TPf6vayyL9Bt+V/3F2z9yIm6OcKXREsFUpa3vzidZl64cHqFGEh5ng3BOAF0WCw0
	9B6jMoQIg1lwtoJd60vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvv-003ECd-34;
	Fri, 12 Jan 2024 15:58:59 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPFE-00EQVl-1o
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:02:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0F2C9CE1BA5;
	Thu,  4 Jan 2024 15:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E38F5C4339A;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380566;
	bh=hlpr7Rh+WCSWMT4vZxE5w8t1/XHYkmxcty9BVrgA5A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UAp4wTISxqEeHyNEIjRiawNX/l+jcpNqpcCxfYCi/uyU6IpNgqfxDEPdXp8jQAPTE
	 rXiYkApR4Ein2T0t660Tdj94d+UCiO2acXlwYbybyM6K3TllUro6YsWElcBkP/xWV3
	 pkCrArgmNm6HKQR839uwOOY/10AOmGfdLpUlAfxZocE6kAqaits9ONytq+bV1rAvaS
	 Gr4DhA6wptyBsiklIax2dzI2lTyfNPQ7zNZOw64eMKy3GwGrorYldRSVwUrutAwy8i
	 ITR6FKGdNa67spj3UFTuMbRbp3CFHszYot/VKygldUe4+2kPFb7fZ1D54re89YcsiZ
	 t0kJYZsqtPEMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB0C47074;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:29 +0100
Subject: [PATCH v2 08/10] kprobes: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-8-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=FiYzuIbbWeXBQHZeA3GrFUV/zI9p1hTad6YxElqrdyM=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiRzlHx++7qX5DJLAjyT9FV57SLtpIJfK542
 Gd/fl1eMi2JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkQAKCRC6l81St5ZB
 T2v5C/9aZCwJBbBJFZCxSxXP12RwuKG4iNRsSt+9zCv6OMNW2X4kB43sueFjA4qzWwZnSovZeGg
 wQOvlrexE2JP73SoWmkYIAwxcbZaeHKZ9APA5fFKcA+C9pHJHuXxUy3CyCn4mcNyHNwAuMGmX02
 OAJ0EJhIPn/wnL2DziGAJxmUnEofZIElsAUyyb1UP3OmA1DkABVq4o24Ns6M1pZzk6EZMijmhiW
 AqCbdpycbAnHN6p8d2C9hdzknOznMMq0g3SKI3VcbGgWDIpXsFKeJujblUsj+sHhsFKDxx+41Ls
 pIgXKhdZWSxsHu84PjQ9xRBF+pgxfgHK7mRJmLRt1jctCQ6rs+FmqVT4QdVfNzbD8JvbdZnWv3k
 4clJTrKL/x5kAgVSbrsBWMD5TNk383518cCzwncVCZ9MAp20BaTLB5kSM4jw3NbR5RB8Wgb/Bh3
 b4MUj7eKVgRiW464WC5sJkDVqZh9v4b8JwcX50ez3xZdpcNbAyFCH8nz4Zs/a6X1N0QOE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070253_160236_1A76D682 
X-CRM114-Status: GOOD (  13.44  )
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

Remove sentinel element from kprobe_sysclts

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a0ee40bf66..1e0ea688cf7f 100644
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
