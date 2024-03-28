Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4A1CD1284
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pUnoPmr3KWOOURi6C7HDsTRSBHFNNf8p1vfXQLZnRT4=; b=ZJQwD7l6aRxvEA
	I5EaAjc06Pq79Q2LPC2fPMELhX5oKuwggBoQvdvQM0oc4+nAS3IXk4zL59ZAVsW42E3rVRkBOYidv
	4jtsyyqueCtjc7vZovSTM6Ey+apQpwBVzymESw3Oia4FBEV7XvxnTCbji/S6zC7Gr71Kg1+Cjddik
	Q1YemKfnJYz9mM94x49jvDe+njAZZAvcGkc4N0hl0fQsaao1uJgT/iYpDw7xMTMdSgM5Uss2J7H5C
	wUrdP+E3ZfP7IqCrVKSSgflY22UpksjQEfemOd/TklmbW+FgOx8/LNG/ZlIn0HuTAzPcgX4CFktEu
	znrcetI/iE0xO/hM53cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGq-0000000Ew3j-0rCc;
	Thu, 28 Mar 2024 17:10:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprva-0000000EZmN-3aOi
	for kexec@bombadil.infradead.org;
	Thu, 28 Mar 2024 15:44:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=TIK/EGwTgGfOVfH8sRSjBAsQm3qPy3Z4h7yuS+Of9WI=; b=sQKnsr/Zl5tkjTpDCsY8pNM1nu
	vJXx1QsoihB+FPMArF6CSdwFoyOoaDrdxqB1+pRFh5FHMVfvae8bxtV2iPSPbKZGoX8hjXpiq7jKl
	ItmFFs4wLS2s0AaWS6pGq8ckyPgKzjuP/RdCEDbMAAij12wwJpXmSV/H81KCz14mY7Zn0K2ixprC5
	Ijd4tVuUxlA6wkPbXcXxdU3oRfW/mRyxyPioUJTr/+OYev3bb129sD2hJhW2dIDu9uKCwZFo3Gxm7
	rMz7vRgZuwS8ilD+1s3uhOMslFeH9xNDkiw7EvQWgIiRVxO5nyWn6vXiOFzPqe4F9bz+A/GWh+uby
	Hf3q+6sg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvW-00000006eEX-2wAV
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 69FCCCE2C05;
	Thu, 28 Mar 2024 15:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C379DC32795;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=1Xslj0bX+o+qcDYU8onEa8pSqJ8mESqy3GAr/e912mw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BIL5/EU4crSIA+hN8ZBW3uB6/An+v9CpA4pRL+5bJxzh8fqIlDhbwPpVI+8dFW4It
	 t0Nuf6FE6eVHfuzGpZGUQmKLbOrrwL+HaWmyuG9SqdtR532MYEL7tuFssiVtXjpLel
	 wu80FmMxkVdEd4To7zzHYGohvCICq4OlvRAGRIz0xb2/2NfoxKW7kEhLXSEi06B/u1
	 76cuf+jau+dyv0fm46kBT2ykBh2u+1osu6yZR+YiBL3uMO/h+/aLKW6Z2kLXxqB9g9
	 K367J1KukI8v8wj/hDsXbx3AQ9T3wypfISSDg383nD7yRDxAMsbsPPdf537tFFG+bR
	 Iy4rNTq2DIU5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3ECD1284;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:09 +0100
Subject: [PATCH v3 08/10] kprobes: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-8-285d273912fe@samsung.com>
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
 bh=W9k8f49EwG/feirGtDw1FHGcG6plJdUzpOL5hpVCueM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE0ZcrBDVAp4O3SfOrgyc8WUlGwe1ykjS
 ABM/79ogIBhtIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBNAAoJELqXzVK3
 lkFPIp4L/2jEVev1Ry+FHuhUOpPE5D5ElBE2orb/y33yGm7mtGXFzKAMW8bq+PtlQw5Pu4SBw3g
 ujwQmB3s4n3ZRJ2YfYwPdHaPKJNFYvJbf24y9Aa58BDtW92sRNapggll7sLkDoWHaUehAMmC3ht
 LV89vSfFhng6Bzrz/MoTAtl8qyy1IM1RF7ASwOu1Q1jgEgyMw5/xpYlDksNUd/HP3GEjOl27I/U
 IfF77tqPAX4oGhcI5ZI8l/2Js13SrNFOspXDoD3ctfuVJQ8mD5E4+uUrSaWyIqlMOMVCzvcSM8L
 7kkRm8s1XoX/pwKolO2w0dr2q3M5Wzm7L/ycTsrKH0sAqSS5DAXZ3aFwUmg0Xbs25N7LMsVNQ4/
 l1BPYwsVLL7928+A+Ly/vfxMheOUkkSS5fiMY7kMh1cdoU4JqjjruiM0SeFQFjXwmSl7mVBt2GV
 /b/2YR1FuOR2ptrzCF46iDCBOkpZZ4CyiuHZE1kNBenIZZDgZgZQ5alrbrswjTB0PEIzApN/2I4
 BQ=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154427_269442_1CB8F1F8 
X-CRM114-Status: GOOD (  11.65  )
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

Remove sentinel element from kprobe_sysclts

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..85af0e05a38f 100644
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
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
