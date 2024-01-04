Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B9C4725D
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DyC+QZ5wqRNBjh+RV6Yxj6yA39GvxvAFAvBYV3v79c8=; b=kh4KDom4LYBj5d
	T/5H/9fJ+5DGnd9mtXj94MKyjrq1xcNpGwi2CW2hJkUGeHfCEJMhFt26WbjFpL64pyG+OeoZnF1Jp
	+l/Kd+npv1N4d9kDn/mwjCwBKA3+S+y8qPh2BTMyfe56GjHPkztaJ//8v53rjyNMJB5Jj80IWwa7N
	mjKkpvy9D0EFv1ZKAcZqe0CPjR4yYKKhEVIK9eiypeyqQvWg7KLoWENNYhs84nZFB97Z9NKK5TeYY
	IgsrLV4A/QGN2PeSmNjoxHVCYvpIOZEhjW/d1o6ESnFqRThob3gBMh8GlnKJyYkqq11PA+ZVlkEDr
	9QE2Ije9QPcW9Cx1QUbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvv-003EBc-0z;
	Fri, 12 Jan 2024 15:58:59 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPFA-00EQRw-00
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 5908AB818C9;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FAC2C433CD;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=F68T4yfrZvNl4UBjQrVTXao7+5rzaoz2/YnsMWP1cC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oaoRz5GiNYa5bYC4deGDtkgORzDYuZk8/+xSsgC6uEEfqrRQEWxuSvzNbIcJgYNRO
	 5II7A22TwTEu+xw/JvB60IDbpOlcgCm+51YdXBjS+7yap+fL8vmrqHDoPoTQ9eL+Ub
	 XsD3ZNfOKZ0lixbMFXbPmwsx4igi8pVq+Rq8RcaFj75cUuRq+TT6io5hp3BHM59JKr
	 bHIWs9f+tMw1nkDnXMdUSWmmiyce9skuPzQpN0s6eeFNidA9eKXPffWB8YmQJrXs4j
	 N5p64LY2deHe0yGc+Pfb+vT+rfyEd6i+bKGrut2S7u6K+5TFNvFuWmipiW7jkQzm9D
	 n2G1MCUhPBCgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B09DC47074;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:23 +0100
Subject: [PATCH v2 02/10] umh: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-2-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=BUKRurk0Zl4Mt0SVqAIUyLoFVcmRKbH7eHtjelFkSI0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQynlD07SyzoCEvZyaTpPLTS0Jzw1bQSZvP
 5UavKIH+mqJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 TwHOC/9M6CH39Pyho/yoy4pmOkgcdI96sfOfD//REIIsW0L3jlYqDJq0RWkCKG4sW7EWH4CCelA
 E2F0Fs488M5wUZq/hsDEQMKP43Fidwd0LxD39SwlCSYptvHVU6PPNTD2PBHnyvYJJQ6tS+o22JP
 Afmj8uAA9+w3OfbQWxNfCifSGLBSPbSwiN9SOIdBz1YcLL4Tt7e86FswNGxtpWhDZM0C5aoElqC
 ToOri3VRMj8jq4NUSwkbeTDG6RPXTvm2J/J+uqmHHeE8p1kTWUuQPfUpkfF1abJLfFccFNjr4UY
 d+/QGLugW3Xsy8gjkaFnHGpprRPSDScy+1CDB+yWSYE4I2v874plQu1fiKUEAd2ftBqvo2p0vVk
 WnMSTJktp0zAWwJXb+OIjGiU4OVnckLAJN8qPdMH8jUPLQoYtAnD9JTkm2wkkZF3rszil97zrbJ
 NAq+PlfYIT6xntDB3fA6kfeFaYLpTopQTpPF4FaA0vSaYvBmCMwXqfQKNnnUbs99dlGAs=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070248_301234_1804E7BD 
X-CRM114-Status: GOOD (  13.46  )
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

Remove sentinel element from usermodehelper_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/umh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 1b13c5d34624..598b3ffe1522 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -560,7 +560,6 @@ static struct ctl_table usermodehelper_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_cap_handler,
 	},
-	{ }
 };
 
 static int __init init_umh_sysctls(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
