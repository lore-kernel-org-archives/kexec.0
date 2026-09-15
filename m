Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B756C88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYRIdKp/FfwNNqSNi/pBExuEJpqL4OpkJpzESq5stW8=; b=BMlZjDZw75xNdZASlklQleOQ8v
	y0hBevh/tp9Y0z9ZTDUt1XbCe5EQbjZulzir/HlxwZn/mGNB+JyYqrk3GZKPHflptnUwGIuoFGoRF
	hlR4a30lVfTFUR8Pmslyn9iGslAEzk0CQY4pXxebpq8rlOwdLLV9gsZ5Jheo20dw5QBmKwnKchX7S
	CE7u+kiFFoLc5JPu0HqJIDe1N0lcTFH56XjCYU1XPc52qv3sNj4y5hM//ZkQVExV+ExPanZDe3Ils
	g0uSStHJhKP0u70qwnVbUaM1lkTwV1x95g/zYllujd4Kl6gmQNQklsFcnyV3nhVwe1PspxOmV7RHY
	TwqbI7vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rdu-00000006HpZ-2nZ8;
	Tue, 15 Sep 2026 11:48:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rdt-00000006Hob-3xvp;
	Tue, 15 Sep 2026 11:48:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 617DF6025F;
	Tue, 15 Sep 2026 11:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC01F000FF;
	Tue, 15 Sep 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472885;
	bh=EYRIdKp/FfwNNqSNi/pBExuEJpqL4OpkJpzESq5stW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEA46w/jL9NKEBXKdpDRVvgUVpdw6hOUBCW8wQyHI6NwDPC4Am8sCmr7j0WvoKK5v
	 Bi5VQmzbc0sNbBRMKVoi5XBwnkMmxH9tNMHqDw3ItnBUybU4feNnNWv7cT2bB8AjBd
	 dY6wMyYKrW4Ezf2ZF1yg1nT3JYwFHCkXSv5QxKi4ShZMZv5F2iT044OEtU+pEb+idW
	 Tog3ab9yFoO5+qKuA6KwBgJKAx/c448Pa5xlXvcd0f4KIxP8erzSA5JNQBA/bgLLZB
	 IGHhr6D+xE3ldAUlwnI0HynOJtRl8do+l5clEE47V/0XL01LM1u7vq8zJwzIFJqQrv
	 ilAIi+rTQ2iFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 10/50] microblaze: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-openrisc@vger.kernel.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Jann Horn" <jannh@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Jan
 Kara" <jack@suse.cz>, dri-devel@lists.freedesktop.org, linux-um@lists.infradead.org, virtualization@lists.linux.dev,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:02 +0000
Message-Id: <20260915114803.44BC01F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS to the syscall work mask. The return path rereads
> the flags after the system call and calls do_syscall_trace_leave()
> for any of them which commits the reservations before audit and the
> ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D10


