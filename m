Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED680C47DA2
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m5948zQONqyjfwHNhuZ4SqEN5LU7y0UsA+GsRcNSilA=; b=INEWX6GReX7mPI
	vdrBHXmCkMqAWBY4hoIeGo6MFqK0vhvf6oZkUuGvqEobVObrHkqX7kdVVuC2uk8g6VHvqn3hMhQx3
	Z3tLB7+QKhOkTx5rx6V6JK1NkT4I6k9Kqb7bwup7saCUTPjaJvoHEC7fw1QRPGFpf5I5CnFsP6hsz
	VrXipeUlLmbxQ2TfVeF7TkGEpG3uhwhy7gDCbe64erXM/hIH29Br6HiLEpZMVvpmfjCHywS8i7vFI
	SdfN4RQ89JGnaBSLKnkxllcHcHdk6tG2odapXx18rBN6RgBcD+B1wPgWH7aq6cUNnMbVOziLg2vNa
	w99qtdlomZ2Z1s3Rkxhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvs-003E8V-1G;
	Fri, 12 Jan 2024 15:58:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPF9-00EQQz-06
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:02:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4DA5E6182E;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78ED9C433BC;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=76OiXqny0I5FAtIEkgtQeFpTLfwhsiR4xIiHIe8GjjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LIsXFBB97dNIR6T+s1NkUbkQvnDWu7qABrhOgeDu4bURrQDFmDdugT/qe4EalTSXu
	 foMcISTUIzWUV2FsxqWR1/HcpEplm7HfB+jUds0jiUTauTvG5IYtPr118enbkNy//L
	 LFf6v5RD0cdCDG0ufbeqK6gWoIeRVvS6QyOrGCw4R2mCGoy47FNkMz6gYhS/b5Y0+m
	 ot3EoYiVFIL2qudYErJyOEgzNfmRAlUAf56EQItn48xgKhPwmtpZMwfJqoM5DKXJVz
	 IscBJDMf7i7nUO0yXPINQmK3xz6AsF9cQGM42mn9cyRbQcJDA5xeoloOVlLR8npHNG
	 jTTgU6jxW/t6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F230C47073;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:25 +0100
Subject: [PATCH v2 04/10] timekeeping: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-4-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=rOgjyk+y2sTTf7UpdfCg7T7N07f0Drf2bm8cuUCjmf0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQeefs10L9U9C6E9ObjWbvyDIljOI9DQ+SH
 mJVo12IrSyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 T7OtDACWjrpqcR5DbGc48ai3Fu0II5BMzsCkwdkvgpsLPPoXZJd8Skx95KGSKIeQnsNc11MPKkq
 L1YS1lrX1fMo+5Vs8mHNUwYne2u3EDkcY+jaVW68W6LhkpYNrhlh/9+3S/5Q1T7y7v4o4PQqUHS
 4h4ybQ/0wIK3nsbGeZWFsccqSN66LDB/3YFHZraXHOEugCtIz8c4L1GnRaVfg8qKTPaGGmzbPxi
 jXEE1jiI4BgsFViTAbgHKntquCgG19U5eFsXfIoKre11wGggdq8JT9UidiPajbH6E2FI/JIUQxv
 6EfjtOoF8+BTsnLuSPSN2Og7sGF+M5WFX0rRKGautby6LT9Kf2f2x03U4Sdiou6vV7fyVniWVVe
 Va8vDlewMZo+ksIJl1jrxvBc9dTEJwaNpIh4KLjFAQkQBb2fIW/YkUSXRo6ZuRSgFBEzYVgVM41
 pcpVje8m1dgYFE0mTmV5L0MChWeCvmR89eUA8+W82cRb5gFlFO3QmHkXVUPdbPI70btPI=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_070247_163226_0D8CB61D 
X-CRM114-Status: GOOD (  13.26  )
X-Mailman-Approved-At: Fri, 12 Jan 2024 07:58:47 -0800
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
