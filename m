Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD09C4332F
	for <kexec@archiver.kernel.org>; Thu,  9 Nov 2023 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hXOWRVAZUrcCUkJuZGTFVndTn1K3WYDkGexiGqdXFFU=; b=N8JjBSPaKIV7/N
	UekPB9uOyy3wQWVoMU+AW5pOeKoxEUYGOQGZoyqBMDP5D+EYz96ishUAerMdh7wnMZOOq3TTW1/7k
	1whmHHe4yl+lh1qkm5tcks6TZnqqtYX4ChDcueX7UEVgD0xRGRspBR+VUwUj6FImNY6+m53jQz4XB
	prnegsasketncgvxVLf6TcR/Vj0tseZ74mNF83Q2IQZuKAr4jOXM5GSdpxdmaQEkSaFPAH7jpoYvN
	Ee4mpHYmE4qoRMfd7O4GqILHr6v9Z6RZo99wxYNbShLBwc+fnH276bfrQYQ91UmwQ6WAWuR8tD4wX
	1e/Id0klL+sR6zQe349A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r17oQ-006i16-0V;
	Thu, 09 Nov 2023 16:23:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lOp-004IfW-21
	for kexec@lists.infradead.org;
	Wed, 08 Nov 2023 16:27:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5BAE3CE112D;
	Wed,  8 Nov 2023 16:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87BC433C8;
	Wed,  8 Nov 2023 16:27:19 +0000 (UTC)
Date: Wed, 8 Nov 2023 11:27:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: <j.granados@samsung.com>, Joel Granados via B4 Relay
 <devnull+j.granados.samsung.com@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, willy@infradead.org, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Mark Rutland <mark.rutland@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
 <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20231108112723.275ae223@gandalf.local.home>
In-Reply-To: <20231108192949.f19832c76d1cf18c5d614e72@kernel.org>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_kernel-v1-3-e4ce1388dfa0@samsung.com>
	<20231108192949.f19832c76d1cf18c5d614e72@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_082727_832647_5067BFA9 
X-CRM114-Status: GOOD (  15.16  )
X-Mailman-Approved-At: Thu, 09 Nov 2023 08:23:21 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 8 Nov 2023 19:29:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 07 Nov 2023 14:45:03 +0100
> Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org> wrote:
> 
> > From: Joel Granados <j.granados@samsung.com>
> > 
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which
> > will reduce the overall build time size of the kernel and run time
> > memory bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > 
> > Remove sentinel elements from ftrace_sysctls and user_event_sysctls
> >   
> 
> Both looks good to me. (since register_sysctl_init() uses ARRAY_SIZE()
> macro to get the array size.)
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Agreed.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
