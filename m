Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BCCD128D
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hz2MddlwNiYKgj9PsoCVnbUceeSHUR95+nAxXDm4QiM=; b=KpN8DWIg7tW6Gr
	3aRRYu1qkGKaDmf9lNwGhKv0apKMJ35AIeZOMn7sd8yFRZ0/Ufv8Xn2WrWtxRWZSz45XvjrUGJqW/
	4HJkxifB8USHP4ifOMi/b9+gi6JSd/ac9m+6OcKdhdJvBhd03JPTULW69RQtvCG7gOfhcRqcz/ERz
	3Mu+2TU6HSXQk/635BpBpDC4njwtijprALp9Bd9DbEQI8raibcYw5shFL3OvpOsqQVT0NiSL1TkvQ
	kKgaeNwEMW4G0/kcx5JVMCyYlTq0zrI1rvgs348XRJEJzUKD88oTiJZomor0jUPlGUXBzS5hBiUbd
	K1SGx3uCNofdA81ZeTZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGt-0000000Ew6c-2DnM;
	Thu, 28 Mar 2024 17:10:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvb-0000000EZmw-20wv
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=WFDxUZ7npLkvwczOPkbyBhJjAJJ+257/MLFgPRhg4Ng=; b=aJIDnqrRJHn/tV0jOecZbFZfBi
	7IWWnPrcOMHrfL8HMc4karCtMFYrB8vnt0I246aUpOIWuyzOAxpgH6QJ1vkuP1lS4wELhr5Tgd8NC
	iNcpstecvfX2QL44sVKcr9WxNNzYT2j0WoS2uQyQun0Xh7+pt3lrXpR7DgQfyNuDEjCdMQaDuSZYl
	/lwV3SX2YONn6CuQpDfDdv+D4a2UspO6YRZVGfzgdddAuk+8KMkV6G7oz5keoYW7VZBX6dagSOlij
	IsMxyOjiQXPVLxSTZUupxrc7ZlgE+SN8NfdIW+ehMwdhWkdtvZSElRgF7RQ1xxH0D7ajUfDJaxpJo
	frOGhS7w==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvW-0000000129y-0jRY
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33DE7617A5;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 570A2C4167E;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=m54DIObMwh/oz5+MbWMsGWkY8mPKrW5ppEQGy+WuUHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=blI9ymBLAdeCz65Zk6FER0mdzRf4BJX5XXCfQm+xq0oDX0Kles1Tm7BO2x0eLXc6E
	 z4WuXotOFLuPpzxm/EuKtkcq1sf4l66nOd86iQ1qLEwLo52/Hc3WHIvF9tXtiRuyp7
	 G4i19vbIOJQ+jyVwJlKqc/RO1Md83z0HjDJ7tUl9pr/pBTVMAE4TgEEjzimybB19N4
	 gHypPOB5fkcKfdZszZIBjD3OBf2+ALf0ZP/cZRQ8EbcIFG+7LxDp7N/+sJoR5MK7+O
	 e58AioddtRH0bcp6vOJ6wnT7zKVAmmb5R3vnMFMaWVsmDIRLI31K6qRhzBHNZg4+tL
	 nAVEZkfaeHUsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45913CD1288;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:05 +0100
Subject: [PATCH v3 04/10] timekeeping: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-4-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=lyDve8Ip2KotGee+CC44snEs+zn3osht1uA6DiUuFwM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEvKQgW+speYF787yYEHJDVSSH0tynerp
 0z73pdqmzw2W4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBLAAoJELqXzVK3
 lkFPUf0L/2YxDsRniEfrTN5jngDVulSOxiSB4qlNJo3EzgiFbMwGXq7qj0iTqrS6bzM/zQHQelM
 z6gGiMM/+yQqVBtt6i2wdHtGwRnjt/nOKL92syZf1XmUfb+DsmS3DsDC7HkhkySpWOEQLXPlh/Y
 vUKou/EVCej3uXWn3Sl9vZCixhu8HctQUpDljEkp3s/xydB+H6sl4c2TLRxDTAPYYbNP9MxMRxK
 LkPyLkmy7JCPkBw7vwDDId4ex2xU1aj5niZoIT3wH1FjULTg62tRugiLtaGtuoiqklfXBw7gc7q
 53t3OF7HpFn26CSo5aJ3mgJZ97lfhYYtS2ji1qpRV9QdPw8k1cgbwYjnMeZvLRecFt7EabhMVOg
 +mi6NtJgoTt0zZjsuM8IeSGvTk96fszBpJuSQMJeUv+k0PnWx3KTP0gZl6nQNSt0eTxRFAYy67P
 5Ugy64D77ah5RGxSUFzdEH9ayB60lVGT8bjRQn/Ix3kzI07osOgMD3M7f6SBTzAbLj7ghOBbLo6
 Ww=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154427_449889_68B55302 
X-CRM114-Status: GOOD (  12.71  )
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

Remove sentinel element from time_sysctl

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/time/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dee29f1f5b75..9d107f4b506c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -312,7 +312,6 @@ static struct ctl_table timer_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init timer_sysctl_init(void)

-- 
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
