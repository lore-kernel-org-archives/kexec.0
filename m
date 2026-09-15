Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013ABC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQgIYhua5CTViS1X9ZXXGfaSPT/5dqgeOOlUNrKnxWw=; b=ctnpFZVlhy/wsy5DVr+U2LSoQc
	L3hGuAZtFFGAOUTSNniz/2pU0740CdjDwfM4RSwzMlYLWbDgIrRhew32MbwzZ1+ihIdfs8bMkJcOu
	qyP7lgSVGRoeZ/6a/dRAfMkXWf4rcVf4HdfGk7CzK9MElrzDvCNyK2bhAruLvCwy93shGYMDEuJUw
	IQeo7DTilZWgvwSl8WLKOj/D8nvW7pbwwwgf9frwPc6aF2EW0FNKTTIpobynQOAUp9ZVLQ1aMO+S7
	TYryRMY576tE16nv9GFkrkVbh8ifM5DehWAzDXgjC5Algq9r57qOoKn7udL4Xt7uVX1vJE6ianZ2o
	hWJA9+4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RpL-00000006Lfo-3yqC;
	Tue, 15 Sep 2026 11:59:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RpK-00000006LfQ-3dFh;
	Tue, 15 Sep 2026 11:59:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 30ED7600D1;
	Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604F1F000FF;
	Tue, 15 Sep 2026 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473593;
	bh=DQgIYhua5CTViS1X9ZXXGfaSPT/5dqgeOOlUNrKnxWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNkc1SOOx+a0MtActP/scxfu+EOEc0okpYmMq9u2IvQ6wdxXtOCmaRwTaDfxAYQfu
	 KNpmxdQzkwQyaCWqsjPY6fMZbe5ub33vKaPoYJ07B7Q1LWFwdlgiCUvB0QQ8c2qsi1
	 FMsSTqEgiIP1sEOamGDSgZSCZ6TfAMEjISixK2R8eaJA2XnzylLgQ4fdlCaNZFxShP
	 J8hVTu3MQPl0lwmGSaxF9w8s3KltrNP5jpWzkNN2BlxuRXTG4UWjQZqj2E6RzHxSaN
	 2Rs03FwwuFJXXN68mTYzdZ8pV7LyInc7Ptt8ORor8BsaOlsL4d3xo27nPcBZv3oI95
	 0hW/vFstsi8gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 14/50] parisc: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, kexec@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-alpha@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, "Jann
 Horn" <jannh@google.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-14-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-14-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:59:51 +0000
Message-Id: <20260915115952.1604F1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] parisc: syscall fast path exposes uninitialized pt_regs to ptrace
--

commit 38a139df8c7c61e11fc9314b5f43e371c71a8356
Author: Christian Brauner <brauner@kernel.org>

parisc: commit fds on syscall exit

This commit adds TIF_FD_SLOTS and tests it in syscall_exit once the return
value has been saved. A task that reserved descriptors calls
do_syscall_trace_exit() to commit descriptors and then continues with the
usual checks.

> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index e04c5d806c105..c5807cf6fbd8d 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S

[ ... ]

> @@ -1765,6 +1767,16 @@ syscall_do_signal:
> =20
>  	b,n     syscall_check_sig
> =20
> +syscall_do_fd_slots:
> +	mfctl	%cr30,%r1
> +#ifdef CONFIG_64BIT
> +	ldo	-16(%r30),%r29			/* Reference param save area */
> +#endif
> +	ldo	TASK_REGS(%r1),%r26		/* struct pt_regs *regs */
> +	BL	do_syscall_trace_exit,%r2

[Severity: High]
Does this expose uninitialized kernel stack memory to a tracer?

When a process executes a system call that reserves a file descriptor slot,
it enters via the fast path which only saves a minimal set of registers to
TASK_REGS. If TIF_FD_SLOTS is set, the fast path directly invokes
do_syscall_trace_exit() here before all registers (like %r3-%r18) are saved.

> +	nop
> +	b,n	syscall_check_resched
> +
>  syscall_restore:
>  	mfctl	%cr30,%r1
> =20

[ ... ]

> diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
> index 1d9e210702e1f..f142766792afa 100644
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c

[ ... ]

> @@ -381,6 +382,9 @@ void do_syscall_trace_exit(struct pt_regs *regs)
>  	int stepping =3D test_thread_flag(TIF_SINGLESTEP) ||
>  		test_thread_flag(TIF_BLOCKSTEP);
> =20
> +	if (test_thread_flag(TIF_FD_SLOTS))
> +		fd_slots_commit(regs);
> +
>  	audit_syscall_exit(regs);
> =20
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS

[ ... ]

>  	if (stepping || test_thread_flag(TIF_SYSCALL_TRACE))
>  		ptrace_report_syscall_exit(regs, stepping);
>  }

[Severity: High]
If a tracer attaches concurrently while the process is blocked in a file
descriptor allocation syscall, setting TIF_SYSCALL_TRACE, won't this call p=
ass
the incompletely initialized pt_regs from the fast path to the tracing
subsystem?

This could allow an unprivileged user attaching a tracer to their own proce=
ss
to read uninitialized kernel memory via PTRACE_GETREGS. Also, tracer
modifications via PTRACE_SETREGS to these uninitialized registers would be
ignored because the fast path does not properly restore them before returni=
ng
to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D14

