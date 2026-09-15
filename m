Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE46BC88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5q8YTazTS0g58MAO23KPqH00t77+r0Qm1szy+uSGx8=; b=24IZGmM/dqTnbc5UQMe/KEj9FX
	Vzhm7+01rXDLHno0pHLVuoSqkHTkUpgQmAsxrczz4W3fKEiO3XMO34ZA/xka5Bo5YiaRwftwah2VG
	OAaulWdNFFa3XSfKbefF6l0epi2rDe6btaBCt3iWa9H1g+t4A2G72pg1pc9dQJVnzRR/j4x8qkp14
	VpczfEK/HrZffuzO2TqAWR6mge4IR9xQ7TyfKEPFJzNQDi20JsliJWedlRLVTwQWh263bgQXLQSqu
	ZSPJMiFJxPET3SqmnhPv3dXkVTofrRdhTpCjaUx0E5v2s4tc9TvGbAu4ZihieMttZbPBBES86Evyi
	OZNuVAcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rki-00000006K5Z-2jj0;
	Tue, 15 Sep 2026 11:55:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rkg-00000006K4h-14v3;
	Tue, 15 Sep 2026 11:55:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 05F6A44503;
	Tue, 15 Sep 2026 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148F91F00893;
	Tue, 15 Sep 2026 11:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473305;
	bh=z5q8YTazTS0g58MAO23KPqH00t77+r0Qm1szy+uSGx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuWOcXAxSUf8U369yMDLM5CrTH3NJo6vFF48Zf7qsB7e9dLLAU7rmbvFKGtSwEN54
	 mrXyu8/sUo7qSyMhvbEGo+56h3zo92SZrUdXQDVHKmZsSL1yip9FieQwDFx3xFr6W4
	 tBOqKBhe78D3RbDLNy/MZGAQn79PhMCfv5ZbZLoxyQiJCVFGpeYe2T3W8SPiGli1OE
	 NJ9s1R/i1hoZ9yPqcd3D1GgTWMiPLPMS4hdNI6X7OCZH/p2PAhMdHWisK0u0w1/QXC
	 YOxwO8oP0q6Czx2WnOyHnYHMCetkSnm/+kFJHxdJpz1jYA9qFglwCwZ6hc4JzfujT3
	 h2LUQd6qFe6SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 01/50] file: install files on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, kvm@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org, linux-alpha@vger.kernel.org, kexec@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, "David
 Airlie" <airlied@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev, "Jan Kara" <jack@suse.cz>, linux-hyperv@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-1-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-1-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:55:03 +0000
Message-Id: <20260915115504.148F91F00893@smtp.kernel.org>
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

> So we've spoken about this idea quite a few times over the years that
> we could reserve fds and files on a task and then install or a clean
> them up on syscall success or error and get rid of most of the
> complicated cleanup dance that we have.
>=20
> My original approach to this had been to implement FD_PREPARE() based on
> cleanup guards and use scopes to make this happen. The other idea was
> what I'm illustrating here. It is overall equally robust and makes the
> install fd and file pattern work even if it there's a ton of cleanup or
> setup work happening in the middle. This is particular evident in the
> conversions of various dma/drm code later in the series.
>=20
> So this lets the syscall path do the install. fd_prepare() allocates a
> descriptor like get_unused_fd_flags() does and records it in a slot on
> the task. fd_stage() attaches the file to that slot and returns the
> [ ... ]
> fdtagble with outstanding reservations. Kernel threads never return to
> userspace so nothing would commit. Anything left at exit is a bug and
> gets warned about and dropped.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D1


