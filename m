Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2528BC0018C
	for <kexec@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JkxDrlR43+7t0fq7EkPEmq8+2zvBtssvg5yX9VcwAe0=; b=XRCzk9ie1AxIxj
	buEkw+KbdELd2Tdo54jyKFrn/4ZBasvOhnwmezqBUrv4hECaq1FWyIAGeeDV7Cm47busL3DBOVTy4
	3cm/wAegfv5Yu8eShOOHRWjCGrRXNAFTRDFj/T6ELEdJhFtiq7JuzzD03J+RkHh4qrU8XUB7WgiZY
	wVI3eT8UaPpphYOzm+Y9epd5fsll288oaC05/NpADSh+8lgjpKYxNs9kOB+M72iZG4zJvJBSjT7QR
	aZismELvMGnKw8NkpC5BvQtlyAwlTnD/XEBMZ0NH2vuYtcpV/0loUeYyUR4m58wV6r/FkjZvTz9PN
	Jy2m2LjhnkN5iNpsOXYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MVS-001fMq-2j;
	Tue, 07 Nov 2023 13:52:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0MOL-001e7u-2k
	for kexec@lists.infradead.org;
	Tue, 07 Nov 2023 13:45:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B7F5361245;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E6EC116AF;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=MEly15joX3iGPNe4Bqgq2fyROyUdrn2/gZnJBP4EApw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fxl0cKLNml8AzZg3nbyxZUINPRnwD9eHc/uU472w+YRwp3RIhHI7WifpQgV/3eJ+f
	 8G1kJ+E/rmPKkdB8gj6hRuC3Pn9Y2IUA8Lyv0x4RcRSFEVKZNcN3PXD8LisIB1zJxP
	 qqbrkrO+pCdvQhSId+wC1XboCtdIQfdnAmdVcclQv1ekOySKNNF3bJOxoO/BB0Pymc
	 Q0M49xS4Epq7U92tZWGUAmLrxUupTGSkI3TRsvIG94Ax2Id84sMudbn4DYknPaCvdk
	 /Fyn+3JGdwtjRWwC4z9oa7hbMt6LFStqwIIDYfPIe+00qoAJIwx633mwMPm7kXWyxn
	 kWqnCFfcqCK1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194DC4332F;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:07 +0100
Subject: [PATCH 07/10] printk: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=4F7FfvA5YIYVfM3aTH/t6RzZ+sHqLku1lqY0e/c0V1o=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9mSKxvYgMV+EZ9fAXhr9RqLxPpdn0SBoshU
 cESPw29PkqJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZgAKCRC6l81St5ZB
 T5DFC/9BuvcmChEcZ6WGOaVO1nSJgybOZgQryx5Pjk1ep8Z8kkFbQOvz9rq5RAcFej2KwBaRNsP
 KmdFgK16LHM23jK1tneJG7PdCGtjZ1de1I/55cMWNQ7xR+D9eV0muryi36FGrL6kaDPk/giYWTo
 1ii/PseR44gfIGj1OPNHPdeqCRJEQX5bGOtqM0u0oZkX7qPjD3skvNlBVd/fZZVr53rl7kJqUkP
 qbi56CUNGIEjzRRQqszRHrgLtXd0DoExFlNIVwVu42kCYtGhUoXPeH+VZjVuao3QRsoWUy1u3FJ
 Qh5L/ryAR9bWATY4nBhZ92paw3gr6zYl9BKB13NxYUHMENYMwj4/Fqb+tVTGie9FS4drplN0DIy
 9w4GSs2m9PvIlpAgRMWVPgFNAT/+ca+Sk0FrwGKaaZDDg0UUGmyG6usqHs4MYK68kdn6/qkfwea
 LNg5nV/tvgW8pkqw3xhBTf6W10DHUHyw8OfXeh7VxJPm2tNKgw2lIzdkrExZWEZys6ytM=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_054517_990531_93567179 
X-CRM114-Status: GOOD (  12.61  )
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

rm sentinel element from printk_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/printk/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..3e47dedce9e5 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -76,7 +76,6 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{}
 };
 
 void __init printk_sysctl_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
