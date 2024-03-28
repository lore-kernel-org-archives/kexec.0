Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BE7CD1284
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:
	Message-Id:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ntbi+WpLFTQ/pwokcEMcOFB41cOZmhonwvPDqgPfFZI=; b=Nwg2wBNFGT5+ym
	EnXws7KaSqf1Dff855h/7hts/lGWCrR1AE3uwNx0MKi9KWznL31d4wH9/IcoJjcn71baO3CizMBdN
	9ifGkc1hfYuSCqVok6z9kSFleOjl8QUIXsPfHjaa4evvgdj0GQmdtP5K/qkQO0yUOQhukx6wOynZN
	w+ZyAhp6t92mpfqgL4VVLc17jKPdVcOvJ4y5EiDD8exu9qVrMi2DDK5jUMQzwQoMknbhsTTuufuH1
	m0UPeSHBtOLNVT/phZDA+DCLVgVLN4RqCGuDOvG1/LCN6O+WEMFlJ9ERMduzrDcBnKzYFdf2JZKaJ
	1xdmBeynZcEvbRNr2yLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rptGk-0000000EvyZ-2q6a;
	Thu, 28 Mar 2024 17:10:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprvP-0000000EZbR-23Jq
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 15:44:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A15B0617A6;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 323F1C43390;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=b4/dj6SehevGFMXDVnAFfclsIoj8TxLZ3oIJqymWnsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fuJ3G6+oLkrT+l9nrSjFcpYUg/kDqfa2cFXvmbfSHDXZf9E7Adrk6HFRgV3XcR/M+
	 eNDCw7OSJI5AjnfJX5kt8EQev8Ikj14zHQRaRWc54CD3JQsdcmKXVj51nOlIYXnLRU
	 l3EDWjZTVFnEOA2vLjFhGX3cOrqQj+lkZ9VYwmVy4Gwi+bAVvRyyWnWFrP8yQqF+nl
	 iw9v68QEsS4zwpif5Qd679ElBRqIs8LHPa8CACnVouk6qf0YaQt+e+EpEMcq0tm2eS
	 dirMaphuDGRLsK1gXJN1h9NAAZwNJ3ar7bqXgvEhC1xUp6LJP5ydXPVeD61QsFvEph
	 ME46HcDI8o1pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26ACD1284;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:03 +0100
Subject: [PATCH v3 02/10] umh: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-2-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Us+pauVKvQYKYTVROgr9cx41Gi3l/GyUdGrp/t6hxLg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEo0dt9WmTAEh/wL1ITZW04WdbDyjokxC
 /hAdi1zrFkFlYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBKAAoJELqXzVK3
 lkFP2wIL/AjBsBaPYsbMjtmBVzxSkZWgD9fmjt+7K/jC87ZalaRJ0c3/FNzw5+SffsVLuX3Umam
 qKZ2njDL6pcTXXADXT5KEOxekjS+VwD7aR6CJh4cHUg5O6GyMAIETih91ek5+2/9mWQCVDry7kH
 kxcCeiGmcFIVWBXiHZ/HkD2Qp55C6O2o5NhW7nAORb1gKInoZLg2k5A0BBvWCC/2mU7ikg5WAXL
 YuvDzOUjNHNeCpU7+wJkuwEBCYoT7Xo6hdaf0o1eagGogaqyMysQMr5D8EDnXT2PFeI0Hu/9PSQ
 Cxt4kXwJrO2c4tNcUXHBR2pFGXdGVcUsdiwbsmjSNKzKwl9bQawr/Fhjq+0KeqC6Y3Eiyp4t3Dn
 u1VvIKLTGvrLixdIraVdZaIyMDH6GbhfbdXQ7B3FdTm1m3+pOYvPIod+FuhsP1OYlFjlbKksK3Y
 fbHNyShkqi5Eok7GgWo8ptBSsCWGjC962+XAMX9rnbtFs+1sECVQMEMVVNxt1y2KGGDYgldIqC5
 RQ=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_084419_698089_5D909176 
X-CRM114-Status: GOOD (  12.96  )
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
2.43.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
