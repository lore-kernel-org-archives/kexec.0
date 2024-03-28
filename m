Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C783DCD1283
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ck3y6EMhe/nxwDpqUImT2BALN2EFm/Fsq6RDGlIU7k=; b=IS3EwDw9DJx6m/
	VvjVP6JDyPYc5rMhY/0m05sFozbljO40lggGrGyHCepkGBkVZTNBoNR1NkW5rp1cSEnstcMdP2wD3
	tRrqGYembZ6aInkeNfwM9CZbViMVQnNVbKyk6sjfEz8caCPwR7xIA6hGo1ciHYxerLSIpBGTP7BYr
	iP6R73LAMNxLz81f4YvR/J21KFCtgdKlcOylAF1J7D+EmhmAihntPnlGliqMMd11aOK/YYKMqNbDP
	hJofoch9+qtRoAspFMYQ89gMmcXbIEfoOuSpJfLvQJXA8L+czyRhC2uCnN7K5J2O9yQzXbj2nep49
	wzlDJ52lbPO7G/WJSP8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGl-0000000Evyu-17ie;
	Thu, 28 Mar 2024 17:10:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvQ-0000000EZcx-29GE
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C51A5617BC;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7374CC32789;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=Vmrqd4VYI97OX3UoCRBO0aGzHn3DZ65T4UmGRZ9kf5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JCVwTnQ+x7gybO4HcOo69NZ4FlqWk4zA3JdUdqZDX0g8e4t5lS1pSfnnOtljB7lbZ
	 4uZ4qBh3wMZTIjxqZdo7aoKzj5Bc/RliVaWhWz/YuQs2vjfXPG++EeQmgSvos57t5G
	 3/6W7MS/J8Hw8BkLc24wAWOvIWqmFtlsI5fbgJ/ZAexYRUVqqYPktqArS0OXeWMGMd
	 W+mSGYs//YQt73CcooHjN2l9P3FQDHg3Hyy7J+P704G5/6cPM1e2PPFiNWF68/s8d2
	 z8UWN/MkH3D6cfPLZu2PlIKTk3+uGLNVzRsY3kmkUnuDJRJvT5MrnyRtr/RBrGsRGe
	 IqA9E1nAN97cA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65602CD1283;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:06 +0100
Subject: [PATCH v3 05/10] seccomp: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-5-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=a55RZNGRyCcB6UX1xGlETtlXB9b6LmLpywnhMBEQ5pU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEsh4Mgom4fbM//0WTCWMwTNRwVc+hUKT
 bWZpFJoow2pAokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBLAAoJELqXzVK3
 lkFPn+UL/3RnBt3ZmbhogGz7i5z9kb5DzhirswdhfPwdZKJcT+COv1HuJLrH3qwxMuZZTmz1PA7
 mIeYXNNDG1/pPSZJJ6LgIp7SX+zGrTIF/9dTN/LZWZ14CvacGSErEAPf+4BI3dk5s0wQ4oPPkwx
 wEDzqfAv6Qi8Sx2/8PNIdVIkayEp0VCoR7oYAEH9EPhp2z+mvAo/IIsWE++pFR5w60EZ2yhUXzt
 PbrUIE55/dlkiEkv0uHHNJgBS6IB/a94tRe5C50He/6nfRvpRLt+yNlY+/xQms4LwBseWOtm9Q/
 qStfIDZCT9L9++Ccz4RnqTxPW/+O3DTkc/jenpOYzZdcwsm1rXMh8/6l6h7iEktJA0G2EWfRhR5
 o8Xijj9xK4Z/KTTbtkK9HL7BU555npI0wKswG5B9vAAUIDkC194D9+/XYYLZGUyrwYPF3bQmlLP
 yp+QgLvZs8R5uVRGCsWxhRdttwnfxF2iqNNE3cMVLgOFTkb3p8c5Efs8fHOvcvBHFPm1cJdfPw7
 kY=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_084421_115746_5F12EB4E 
X-CRM114-Status: GOOD (  13.07  )
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

Remove sentinel element from seccomp_sysctl_table.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/seccomp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index aca7b437882e..7ed72723fb8a 100644
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
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
