Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CAC88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+u7ApoOuOF8zgpGLaZZqOsYtXtnXCzj3vZ61f6s8LvY=; b=UNKgR7Jm8TuOFfP6nafQZ/82g0
	Qi9cvO2cbrXPSzYwvvPcHceXl7MCBT5SMASBjZTvyOMgnIWxw87A5GUhU5wXl6jsvUnhBSG5iDRAq
	Jaqy7zvSVlBcZCWnMZxBsaOSN/zX2pC20piGEclSNrBVgqN2WYV9P5D6+DeFz41YHT62vIVXJftH5
	v4V5Kjibo3TCja8fjz9cnBN4OXcj4NSgsgLHxiogIT4GiHYdd+lBzmgfRweHnoBPPaBPcc2WsVDba
	zCDeJd7+CDNEpYGGaESuC+jxx/Jk3DicBGaGOSCnpEMxzaTj8ikrY9u+BOlJBskEj9n8c60SC2VYt
	ANPeTI1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rsc-00000006N7U-3iuh;
	Tue, 15 Sep 2026 12:03:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rsc-00000006N6V-0cFg;
	Tue, 15 Sep 2026 12:03:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84F70409F3;
	Tue, 15 Sep 2026 12:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53111F000FF;
	Tue, 15 Sep 2026 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473797;
	bh=+u7ApoOuOF8zgpGLaZZqOsYtXtnXCzj3vZ61f6s8LvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THnhYqifnsYIWurKEUAhE5a21iMJPlZD91gXsYeEKbrZccsHcRXVqGfm5oAHxQqOd
	 e1wuKKqVeBYXyc2aFoavHWSkhBnSVerlDl5LdiePK1NOkSeaQW/idnPwhZZFr9qO2U
	 cg7uUETVS3OG1gBkYBAm+yUoWRGRSH3/1l1cbZ2tR32pl+WFSqQtvnmtWPmcEO4Q+L
	 BxuqA3mh6TGj2Aku0WcupA4zXl8/Qqfs3dDrK1fqU5kv2LzDSbBcXV0J8UBqa9cxEY
	 w/xfA2bcbpba0mU4z3odT8FBDfF8Id5jJPBmzjOTZnLPQ12i2X8SrT2BDKLxXvMAyA
	 ptXGYIc0ZxCJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 22/50] net: install SCM_RIGHTS descriptors when
 recvmsg() returns
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, linux-um@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux.dev, "Oleg
 Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, kexec@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-22-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-22-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:03:14 +0000
Message-Id: <20260915120314.E53111F000FF@smtp.kernel.org>
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

> scm_recv_one_fd() allocates a descriptor, writes the number into the
> control message and installs the file right there, one descriptor at a
> time. Everything that recvmsg() does after scm_detach_fds() can still
> fail though. When it does the syscall returns -EFAULT while the received
> descriptors are already in the table and the caller has no way to tell.
>=20
> Reserve the descriptor with fd_prepare() and stage the file with
> fd_stage(). The number is written to userspace as before, but the file
> is only installed when recvmsg() returns success and dropped together
> with the descriptor when it returns an error.
>=20
> A control message that doesn't fit still gets only the descriptors it
> can report and MSG_CTRUNC.
>=20
> IORING_OP_RECVMSG reaches the same code from io-wq workers and the
> SQPOLL thread. io_uring requests commit their reservations before the
> completion is posted.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D22


