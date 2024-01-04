Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC8CC47DB4
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ha9atcS3zbiuzRaZmtc/imeARhCtqbLuRL/FZTc1t1w=; b=QkXyWk8i0/Nykx
	MKL6DEcsd841Bw2i++p++3JH/4yQ+7AQZPhbQmZNhf4rIHXCFh9qhy8OwuoqddGgIjLdUfih0SPSc
	m3VdtkGcSJEcZdpW8j5dXdQ2d9ulekc+njzd+VGYjL7cWF9IkfIbYNJRx2Vzu88vsLvq+rz1P/VC7
	DmVSf/XixZ1SIc1dYAqyHkTWafFNYuuekzWaI0xMund3ArDIMLytRkeEscKpQxIqVyIaR3DYBDmh5
	uxjFeA68e2q+al6hqcI3WJuKBCBicO55XrvUMlxalIYPnxwnCWL048fKQHf0HT8SQldyi53vMKmOW
	Y3IpxAnH4oPXdLMM2Jdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvt-003E9x-1y;
	Fri, 12 Jan 2024 15:58:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPF9-00EQRQ-0j
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:02:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8A15B61811;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92CFCC4AF5D;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=rztlto8eEbJ+Snp+e1X4/9BzW9/7AlNu0SuQr3dKr6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rJosMr+ehRG/C2guKa2lmEkTDfQWd5W3U8g4xdyzMBtPGAGdQ7oygvRVw4wbnDsZu
	 JNrnyz6Dj4Gu6JGXLwUspUakqNyqgz9W4Ccv12H6B3OKBRctIO+0f78d3X1j1i3lNw
	 WCr2OvgIh036faAKWZ194es1Mutt698yFao/RVeMwiIxmMGbdf952Fh8w6Evj4KPVO
	 lTuJ9dFErNeMw0BNsU2RTSwEJrCwh6XpmUOuTS2ckb1FFr5SRuwceBkM+5dgxuIc3V
	 I0fOOcrPU/9c14wJHoAkkwvdcYpasKSPKgRwvVDBE7rWPyhe/lPWCee6EcPHfT/ytf
	 VQJg3rP96OqHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F24C47079;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:26 +0100
Subject: [PATCH v2 05/10] seccomp: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-5-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=z6EeWSeb/wAILeyqvWIX8FMlRbwGB4xwjlfltNsIiys=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQF0oBNt6LJkb+zVY5GGJCeSKg2G1eOlNY/
 U9hMugX/3qJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 T7e6DACU+v+qIRdOgR0Vmu/bybMMTZLCFfSEqP2vKHZSh37Ah76SyGQpohwFYIlyBeOBBnPNVyJ
 w8p0UWOfIBTtC+RGTtt2n0ijQHCmzEUBwd2OS+8KyEGACtGvfQ/HTz0ohTLF+dkeSuN36ne0Pc/
 5e7X+WCLZT9/SrcD0xsDhmm1eBnRUVHbBwQVfRVipKlX1xm3KrnZmSfeC5RrFvx0C5HJrJeJ/lA
 /hKTvsd4Lz3IMWylzkkAgqXGSjXjftqgJUEkAHGjptsRIAFAOuOvPq/UN6RctFRocbfHGq4y2is
 jGLLoDYRoLk43HuSXfJlB2y+a4pRp77W8ZH2uzwJkinqJpEMfHIHKB4zlq/sXgYIpyt0m7FMEK+
 diaryq9MeBCXKGs6k1+XLcyj/vWSI1KAYrB2xLVuKd2dsT+dFwovPvTkPayLoVRQusHMPEWXJAg
 /b49Ubys+BjHCNculOLNQoH4Nm+SfvkyVDsf6IrMme51A2DKU3QkWmvfzwebLsO9PnjAE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070247_350350_3448F149 
X-CRM114-Status: GOOD (  13.57  )
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

Remove sentinel element from seccomp_sysctl_table.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/seccomp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..b727b4351c1b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2445,7 +2445,6 @@ static struct ctl_table seccomp_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= seccomp_actions_logged_handler,
 	},
-	{ }
 };
 
 static int __init seccomp_sysctl_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
