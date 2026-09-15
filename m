Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF0AC88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XROzleDAWNHKip4xHBVteIb0cCuN7FAQoMQU9zewp/g=; b=pGhvlni/ia1MM1ywA6klfvkGrF
	1ozLrReRP6jvsbsKz8VY/YfAetUmjG7GF9gDoEKj2LBB0Otsm8OGhjbPKe9a0+pfI0oSPAz6yNL+s
	2W5Zgap/om7D1yIZX7Rc9IX5DQRPW/n/mMDyEmWc10NIIUKrYnt161+JtqXLs3/UjcwUe90ngcU/z
	JwSctL9T583RfNvgbljKq7hN35J5apxNQRSGIG1o6HTpl6kjUktk3w0h4GksDyvW7M1icObn9sWYo
	5VMjuTCTL5+RIGkXrkczys+dPyT05rCKW9ydoMzbjUWRf4Z7QchpKHTZqsdAiJyxUIrtVocGO7vyR
	FAM62Dzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RpP-00000006LjG-27LX;
	Tue, 15 Sep 2026 11:59:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RpN-00000006Lgs-1PMB;
	Tue, 15 Sep 2026 11:59:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A98B602BE;
	Tue, 15 Sep 2026 11:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93C1F00893;
	Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473596;
	bh=XROzleDAWNHKip4xHBVteIb0cCuN7FAQoMQU9zewp/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LuDfDBIpgc+rUudqugD7YWLMIYTyPSh1djqeFTSZvIqwl+MCFr2F9Jod5sQ3BdeBH
	 Fs4P2kaC4Rq/e2WctPCUaANEEugIP/+ZEAefkQjg3r930Bx3+wPmgnd43osNu5U8C9
	 EyuNiUbu78gNfTdrTeVFFD2nhC1r5SHLm94AIfGff4/9p19OhtUCSOkAUYL8ijEd9H
	 l9DN/Fa9wQdaggqiklG21wysLrbu7J9tNRHYcAgnuhIFYUQdGWbvPhv23a8BBnteix
	 dj3Dz8036WkGhtwkv8ziLkCVxCa1RZBk5Y1nQhcVea1ZYeF0cF/u11/S008mj3HeiR
	 /EId/I6+w1CIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 05/50] ARM: commit fds on syscall exit
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-openrisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, bpf@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Jan Kara" <jack@suse.cz>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-hyperv@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, kvm@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jann Horn" <jannh@google.com>, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:59:54 +0000
Message-Id: <20260915115954.7B93C1F00893@smtp.kernel.org>
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
- [Low] arm: redundant TIF_FD_SLOTS check due to bit-shift overlap
--

commit bdf52635177f575c1b58cdb7e902386551a36647
Author: Christian Brauner <brauner@kernel.org>

ARM: commit fds on syscall exit

Add TIF_FD_SLOTS and test it where the syscall return path decides
between the syscall work and the plain work pending slow path. A task
that reserved descriptors goes through __sys_trace_return_nosave
where syscall_trace_exit() commits them before audit and the ptrace
exit stop.

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-commo=
n.S
> index 88336a1292bb7..59a70d90b0b61 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S

[ ... ]

> @@ -83,6 +83,8 @@ ENDPROC(ret_fast_syscall)
> =20
>  	tst	r1, #_TIF_SYSCALL_WORK
>  	bne	__sys_trace_return_nosave
> +	tst	r1, #(_TIF_FD_SLOTS << 16)	@ r1 holds TI_FLAGS << 16
> +	bne	__sys_trace_return_nosave

[Severity: Low]
Is this newly added check reachable?

The preceding tst r1, #_TIF_SYSCALL_WORK instruction appears to intercept
the branch because it inadvertently catches this condition.

In ret_fast_syscall, r1 is loaded with TI_FLAGS << 16. TIF_FD_SLOTS is
bit 5, so shifting it by 16 places it at bit 21 in r1.

_TIF_SYSCALL_WORK naturally includes bit 21 (_TIF_SYSCALL_AUDIT). Because of
this bit-shift overlap, the first test against _TIF_SYSCALL_WORK will
evaluate to non-zero whenever TIF_FD_SLOTS is set. This means the branch to
__sys_trace_return_nosave is taken early, making the new tst instruction
unreachable dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D5

