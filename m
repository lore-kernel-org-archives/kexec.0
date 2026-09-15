Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5863C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=; b=y6DlvlFFRR02dv3b7rpqXxRvC1
	8/88e81ciBgqKrs9mkRuVA+J6m9xHQbUaic7yvL+utaDzJykO2eH8n5u35AHSr6TSd0aBxspL3tii
	o1abeHo5qn58QqHtcJbeYBYHMvxRnMUYsf7MOqELBzCoBXD9wMF+kdhaKHW2VWtWhmZLIS7iozWiW
	pZoL0SzdP/8DmyxUlUzAE1CsqtzVJgWKvJFu9+9i48VWNvglD7mi83bamEHyiHw6nAWtMuoTDd27v
	bVI6EGAW2HYtv62zApvdFNU35QTuehQ6FYi/aObKExHpXBod+G6ppuJVwRNlhi2S9WvdqAT6oBjKQ
	tMW9tf1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S2C-00000006QT8-3xVc;
	Tue, 15 Sep 2026 12:13:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S2C-00000006QSj-1gK9;
	Tue, 15 Sep 2026 12:13:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 86C3F60261;
	Tue, 15 Sep 2026 12:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCF61F000FF;
	Tue, 15 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474391;
	bh=rcP1Zt+r+c8i7P9HMLnfG+KSwnTlxlPDfufoMKFt0yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxoLtCbZ5g8NJT38V2nXx3kQMXq8zz7wa261boot03y/1mmOb8uEpnb4HgvVzXqbE
	 Lc+BLr2MEwB+7zjlCcD9Q9qeYqKVACCOsKFW9yMVpHmTXMqtHVkiNOOQlElz6DH2cL
	 qfBphOZ3delbUDrFqm1dV52+sHB7JppWyVGvQVAhcP+Vcr7mTyrRaVGoKVuRlWxgrA
	 a0ZQjTcB9Fxaqpd6c2a/Z1vb/mAmnfz0/bCd8zDO3h3sznLEIo6QHFgrENGMHDk9qf
	 flDXJ4YX6mmlM4kAG/dg8PRmGwgcbH40eS5i4n9wiRd9k9l8mEd5AlXPVBescbcVDo
	 rqQ5leD9k9+dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-hexagon@vger.kernel.org, io-uring@vger.kernel.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Jann Horn" <jannh@google.com>, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>, linux-alpha@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:09 +0000
Message-Id: <20260915121309.7CCF61F000FF@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D36


