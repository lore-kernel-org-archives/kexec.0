Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECE5CD128E
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EGowjR11lHJCjVAiqkb0TIj3jbUwfaYYNIJ03rBsRVA=; b=zGTW3cYw42hH3d
	JRGrBf2qwlgjZuD7MP9lCdZgcjb7dai6RV2viSZ01qSFWVovvF2NZbePpyhCVuQrWlbgPpJUHz9pa
	bzb+5/xnHy8DxuJ7et53Cuayk4Odcvxq0tPpFJhc5SRrMPpMbgiWvcWaJDrCaw2awJv48ixQuDTxX
	VPKGo93ZMFKwWBVJVLWNgdDqY0MckUiy5nrYQaW0aMUjwxaZ5EPMN+0AT/oGkGuMY6Zr8EKH2TO/R
	hWKaUs7OXG4yZihgWwLjmyvWZXbS2fGdEGH4N2M/2zt5xhdI8qnomw0my63pbje+N4UtC0AVBMuL4
	8IbtwrgOXI0oizU49cDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGp-0000000Ew2y-1DjU;
	Thu, 28 Mar 2024 17:10:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvZ-0000000EZjx-0wSY
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=GLWxvSkQQ3agaeYDzn+mW8Xor6tyDJkYGhUYUIiFoDM=; b=J/D0MmSxjfxcrDgxPxSItXsebg
	yAbE8J+XMJEaivKpEjgbE64+bmywA/t+bJkD9pGPZpmR6HZe8MdPaJUlV4Ax6f6LIPbtUtV2S2+Kl
	jMuBAU68on93VdMKXUHZQuudHw7Z4yB9IyNIoHL5W4xd/p74j2uiTrZU/jPW5FhnoS6IReyI7WSIK
	0eOh1vFR3mE2isZhKhNC+ah2k4z2KA+xDVxHEEckn+9VaguZg3sMlaFuYezCzBwUFg02am6TVsW9p
	O1nR7Lm1AaPueNhWYaMToxvaaQ76f95UNKS7nF7ytWO3OIG1ML4eyD/p53aZwqyVyXpif/ZGW61Jp
	DgZp7Ubg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvV-00000006eEQ-1w2g
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAAB7617C3;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0B07C43399;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=OXbTyJl1vxc5TRrI32eYdOeapjZ52ijf4K6v5tuEd7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHjHtUB/CL+hgc6AU4LraLMdcpGt7+AWeVSexEK3/rodPd6YNAVXSjAkP+Yh76B0P
	 IacIso8zESjrg3Kdi8KPWUOQSzLQRr6F4vKVzeBuRGIheNyXslnvt3iPl0y55YC4Gm
	 OSDLdS9oazkN8/BcHrDPh1nfTkCFzQ0KFE07Jz4FGC46SaHJ6MvJe/AcmRIog3fAWQ
	 zuVe3SpvIITQN0ARO3msWdaPNLDjWoxDKiQcINA2rMETyEnzBNHi6e1CeBKWV+4p0o
	 fnVV1+na6klELlIxTqAu38AdcdcUZIHfC10oM349nj4lh3rH8MnqN+i2tfXzzVfYM4
	 zNvaFuZBBr3Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A98CD1288;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:08 +0100
Subject: [PATCH v3 07/10] printk: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-7-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=dEvSs5Sk09Mr38w6TQjFck2BDsVi8Y4KzQNb8dQHQ2k=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE1nrrtIzi/mbTRBEt4ncdh/MX4YK+/zN
 V1PrbBTKAfDkokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBNAAoJELqXzVK3
 lkFPNWsL/3Vy959WXECEg0VHaMhwRrdeyk3YtyYiGM7YxZsqt43CPCmlwvOEGQSSNRe1pS5OSMs
 as4xeTTv4VMjZ8J2nmraoc0S/8dF5jnJUIt36P+mLuUuANd4o6Vj5TtZACS2XscOBqTR1cAn5fW
 fMOpEQ1Qibjc3TKzJa4nWCI1s2sQZdd5pmM6Z6bTS6xkoEC0M+mOj3xt/S+8Xt4QCjBqSZsXkMR
 7Er9xP7PA6naseg7YghqEaY5h/1ELMr+jA+csTHCkKXTtwzySlij4bwqhgZQz1iLXfik70NXeeQ
 Stj2pa/YCAGbF9OIHb6NTcbeiwGBweGC2BsLkn9+pE0Gh+OmOfGbkApG5e9Ugcf8deJxVCBIPGN
 pJXIl3EVZHAKah/Gw2pcPZJsStYJ23zXwRNG5yc8db2L2ivpaMfUlVk8Hj8MN/nJ47F8MFJVlp0
 VMmcsLlYqBx/9NDO/CcWbF6+c2zvD5PSszPypQOR7kOGo6DboCX7ux3FMIrrDqgjTGoEtK6hqh5
 +4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154425_775364_CBB65E1A 
X-CRM114-Status: GOOD (  11.44  )
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

rm sentinel element from printk_sysctls

Reviewed-by: Petr Mladek <pmladek@suse.com>
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
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
