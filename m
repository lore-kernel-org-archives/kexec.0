Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4036C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=; b=19hBun6jOCK2P4acWYU1xRkxOK
	H92w8nHuYi7RoweveyfAMYq1nDV3K6uhbHt1ClvYjpQjTs436BlbvVFoVLzTpwRaWZCUHBREGjZYA
	3xHhV5kV3pIeVir3JVCWWluB6EHJ7xqCXDPm6jW5sGlR26ewVbgsEkuAK5MB9MulFSEFJ7z8To69P
	ocELjm1ld0r8nsQW8FyBO9Eq3W21IP4wtHpafYbnKLXxUKJEeeFN2tZ/nLMpLsetmOU/CTtWvy8rU
	EyCwMq85w3BleKKp0/SdSixBGYM2uyrrmUqjjRf3APs0aT7x8ZkZnKCMAOWRiJhIoe/LQfEZfrHof
	Wua8kwzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RrN-00000006MQU-1lUT;
	Tue, 15 Sep 2026 12:02:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RrG-00000006MOq-41AW;
	Tue, 15 Sep 2026 12:01:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B04684040D;
	Tue, 15 Sep 2026 12:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79231F000FF;
	Tue, 15 Sep 2026 12:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473714;
	bh=yaVzdP8lM5NkwsIfqLJMk1LB9QIq/dT8qJrlL2t7nR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l52++faImdy1ik2llOoUzxFM8W+OJ2XgjjuOa2l8s+lX7brqaeHpAYmZ4NzMpai4G
	 ug3NGNC5p0QWw1N5SrcuH1JNzc0OyB6fZWD/NF1d6szX9grpxtdkUDi4tpXooy6x+p
	 JBH3hHZryEmAGb6mrRF6PVK9CJEilmARd5Me/4O9iSahRnJEixJ4iyWa0Fy2QMNHa/
	 679PRfPUgFWQNItfWZewH2Q2HBpXsprj9rAD8pmB/m3WtcE/OlAB27TA7JatQQXEIi
	 yV560hB9vQUixGJJc7XE9I7TKlEm3Q7gGxUx/GBKXr8HLMxp8z5pfujIabo5IiT+sh
	 wkx7+O51PlMkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 24/50] file: make FD_ADD() a standalone
 immediate install
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-arm-msm@vger.kernel.org, linux-um@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, sparclinux@vger.kernel.org, "Jann Horn" <jannh@google.com>, "Jan
 Kara" <jack@suse.cz>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-hyperv@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, io-uring@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "David Airlie" <airlied@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux.dev, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-24-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:01:52 +0000
Message-Id: <20260915120152.C79231F000FF@smtp.kernel.org>
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

> FD_ADD() was built on FD_PREPARE() + fd_publish(). Give it its own small
> macro that allocates the descriptor so it stays an immediate one-shot
> for the hot descriptor-is-the-result paths (open, socket, accept, memfd
> etc.).
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D24


