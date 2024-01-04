Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F3C47DA9
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VTbvaRvCLsD8ujERYxe4fReG6yeKrJY7o2YnY9F7/cE=; b=04W1uVu+kAl9iJ
	d/ZpF7uw4FasTF5lEVNCpuToV1Z9TSyq3Uz7nw8xFoyYcuqArdwNfIuBtTDNDxiTp/L47+gzktFww
	XPJ4WRKZKLklC1ovlGMw9R3Zv+1Lv07Eq9mmS8fTcoWHdDsvT0viXLeeqkSxoZmX2xxVDiiwrdnsc
	rSuo5JljmC+t2K+IX+ujJgV1yA6H0icg0tmY9uPdma5YIczQQSotm0XKmIPKj9mz9Dx7vkyCKkhcE
	Y6tCuLIkbymCC+5rRRTWtOzJopo5CTJ7ksTzxl3qVz1Y2q9bYSlBVxGlDZTOioHpPkwBJU0o8vLVc
	MdcQKwqVzGEWFI5hcCvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJvx-003EEB-1w;
	Fri, 12 Jan 2024 15:59:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPFP-00EQc5-2m
	for kexec@bombadil.infradead.org;
	Thu, 04 Jan 2024 15:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=/B4dbJPP2KYaIzkQrQyxcbPhHbedbZhNk1lOzt3zwL0=; b=Kxd0prR3CpS/ArZ5bD8oT9Qnh8
	skKgJro8YQv1xMaIgaLuOLS8QYKP9QMGhGRhZK+acE0QG4pBgvAPzpNFldqxKx5DLrkm4cVb6UJn/
	4XnQBTKOQioatrxK1z4MX0OfKrytFwvoiyL9EZfr1BjdcXnFZhhPyKBnxWpoTIsIwUIXvWzBLFU/3
	dlBXtO/wCIOre+9zfO3wXsFwT5X80UIblnZuXhi+jaPAOXnkJ8OYVjYEbsxilg6+7G9SR8cgpcSLR
	IzgbGMfk+dqo2L4zB8oF5vz9aklP7jYSRI7MTpLEBwS9cIcPSlXWOyigatfO96A3NMUxfMKt/g37n
	VJl8mGSw==;
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPFM-0062Pv-03
	for kexec@lists.infradead.org;
	Thu, 04 Jan 2024 15:03:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 97D7BB8191D;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66FA8C433AB;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=2ickuhWADD9IxCGKb1fYeXbFIjF9zMg4rP1V5pxGMmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gklngGQ1aLNM0gz+K/bgVHMHs2tbn7Gx6WBtO/jezsDdOB0LnPUgN37wF17so7rrH
	 YfLZdwSwCOW1ZNyZttvPsoGQBtT/pxcfsMwGtCuXv5Pzl/4iO/M7pKzz1VTYisLuKH
	 loIbDpj8S+3MiSUWQw87IIzLCXbUAWBs+cDCudq7rWuVWzvR2Qh0xt2E8ONwgCSgNH
	 /UqZtBMSoXCbJqYDjAd2W2RA+GgdU2zSJaiRNGaASZfU4IbGVSNMsz2OKr0UsWg7Tt
	 RvQ/HqWjD97TpEk7JqFVkk1sh0BeC9aibrZgtPew0SrPlKwdEBjWtOTyVnXxxFqZDK
	 17/2Rt9p1DFTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B7C4707C;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:24 +0100
Subject: [PATCH v2 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
MIME-Version: 1.0
Message-Id: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-3-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=I9hNdzlwwvGhli848fLvwLS5D8HcBUTWZ1m3n0fKYkE=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQ+iIfUGpB6FEaBvtcGH6q/CsuMZch60gJQ
 GICfiR4okWJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 TxGhDACSRjgkbQ3wyuVeDzSykMrr5lCOo9YiD3YURRMPSxtcjn2ZwMGtvvb9K01XglDnxom8qpf
 gkhHSC6F/JUcVQRlFec9ZrsljdYBKC07mRU3OUdovVNtj+X19130gU+RwSZzyGEIebnVoGWTC3u
 QXIQ8LdsMdFcPySwC1GF7gr2FfmN26XY8D66vwgagg0sdathOv1qvd0X0+rkEZil+FEii16d9h0
 Rn50vRm5eZKB7m6Ujtn+lqnIMCFGjEV4+cNDr0qjos40HXX0j2na5VJMeA7lNnZYOsGxEGc0+jb
 WtcsNHjV+Kezh3JdK+buz/bfvW0VEZZF+9rrrZhmNKJ/3RB6rEFab08nh0NNeOxMqbFxnFgzz4B
 eMc7OZoq/3a4GnDYtZvmosVz5RjQSfkIEMUyob4C5jqeq+kRdlpa0TkwGj0DXmK+hTR9Ka+dc0B
 43l0TNu/GDEm1Ptt+VDnmGRclsw4zk+hK5stlbFKJLJYHJG4L5c2PMsnmMfE/VkbbYzx0=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_150300_238214_F0BF48C5 
X-CRM114-Status: GOOD (  13.30  )
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

Remove sentinel elements from ftrace_sysctls and user_event_sysctls

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/trace/ftrace.c            | 1 -
 kernel/trace/trace_events_user.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..fd40d02a23c7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8264,7 +8264,6 @@ static struct ctl_table ftrace_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = ftrace_enable_sysctl,
 	},
-	{}
 };
 
 static int __init ftrace_sysctl_init(void)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..b15a103bb11d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2746,7 +2746,6 @@ static struct ctl_table user_event_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= set_max_user_events_sysctl,
 	},
-	{}
 };
 
 static int __init trace_events_user_init(void)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
