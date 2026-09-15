Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D1C982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=; b=k1voR3HHvqr2JBRFmcVPgiCQgz
	r9pruah7k1ZkIczlxoA5Rn4fKmxpS3BFG99E6lk+/X+DJUdoDgEGjeAMur093SkblbXfdsR32goZ0
	S5fpyDF80JEQ7Bli59wmWQDdo3aVIVP1svXQtdgoLaHjCZklw+UEsCuMMf3V1z/gFIr191rhEyKTT
	+djVSERAPoOUj8xbfQLW89XRnU7Atx1am1JMoC8aglIE2r90CVndq8Lzgt9J/54BKxAQGk38uQ2At
	vefU8O60Ori7YnmBdUiqGx6uJks4gqCwomK20ShRiu5KZ3QTzf/Sb7R0TDqoGmEqbi/vSH0fTIZr4
	Fr3sPWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RgD-00000006Iqo-0sR1;
	Tue, 15 Sep 2026 11:50:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rg9-00000006Ioh-3hCa;
	Tue, 15 Sep 2026 11:50:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C0B741256;
	Tue, 15 Sep 2026 11:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B31F000FF;
	Tue, 15 Sep 2026 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473025;
	bh=+t+FFRs/FSCskcUDJ5SBPkwP/MmkDDT89W6QZ8CQfY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K53ZeQCFgiRlmkmUKqyt03ueVesYZEQr8ZHRmEnHJr7bteBPMY+FhF3KYLtuCparh
	 nKgFz0/6jbq1bui4jC+jYX4ySwDgwyBFWSGcoZrPkCnnSxGxTvfC6BSUPgQq6hQvNN
	 +1Spfhekga2XDw3G/J02TP4WSUtA8F4az2wYUgLljPdaWE7BVEbc0aUoQxQBuF0+j7
	 SIyPhVaxFVjk05zS3THf3p+jtDoLWiEkH1QK9B2j4QqMORMMx/IRGI5cyQTCspKNmd
	 5UGZ+jgOkWGk3ahuQaW3stL2pre2KPKFH28rNWpoqvzsKrFKXAxDwAFKyj9oMjB17X
	 ecSlXehy4baoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 03/50] alpha: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-mm@kvack.org, bpf@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-sh@vger.kernel.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jann
 Horn" <jannh@google.com>, virtualization@lists.linux.dev, linux-alpha@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-3-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:50:23 +0000
Message-Id: <20260915115023.DF7B31F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it once the untraced system call has stored
> its result. A task that reserved descriptors calls syscall_trace_leave()
> and joins ret_from_sys_call with the flag gone.
>=20
> We mirror the traced error path where the switch stack is set up and the
> return address and the syscall restart state are placed in callee-saved
> registers.
>=20
> Btw, let's remove alpha... It's a pain.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D3


