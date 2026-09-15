Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C209C88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=; b=Z25VjutocSMUf7Ik0KCfAv6+1L
	r8t22p41YRwxAEMfO2xMbURzBP5uDAqlzKaTOPB/19GC0k/B0oUUOd94BQovXl4hl0mRtGcUmuUiT
	NbuY6G2rLGoxFYeJwGsiQI2DDHq/LN+3hVJrMagqvPEAbH86wmuQb6HVqh6qQL5U4otSytcrvQeN1
	B4QbkWOXM72+pOJRaM23g4cqnaUBm/AxxMU/5kzeOGagJgtRN5u8qUOCsiDs8u50+iXCwd+OkQKC6
	vtknynDPox9zIBTlZdTegGo84wXnMnr1sMfimOt7r2ktQuip35WdP5GvzW3MF/R206akYV6OFRJzU
	Eny92sJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RyG-00000006Ouw-0A6R;
	Tue, 15 Sep 2026 12:09:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RyF-00000006Oud-1Fek;
	Tue, 15 Sep 2026 12:09:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AB47260261;
	Tue, 15 Sep 2026 12:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C511F000FF;
	Tue, 15 Sep 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474146;
	bh=1io9HoRsGAc1uikZZU6WOsyCYXG2ohuKM/nD/zRqcpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8RCCHlVffAYpevobrB+HSSxJIDFQlpru+XuUbTtHjJ+eV1oIVuSwd7MGNhXxoQvE
	 0qXqjr2rait3fVxBCZ9NQmO10kK0KaPG6zwH9T5vPB8yCS66JjHDMs4as+k8T2Fk4v
	 e4FlPeCJiND/Nr5uQ9QzHHTvsCip6NFVrnbNCMKMQ1YJSo+H5BqiKdvJCfjdetXK15
	 IA8lwnZJYwWVEQfsXuIfAhEX4i1LbTqySG8jJzvB5s5qUpYo7CHSb+i+lKJf2KL3TS
	 6U9uLcqyT7Zv3ZiC4C+YKYpQCQ/wJlBcsNSQOQuLTJt3AVMsq3rQldu3icesMHZkog
	 thX6VB3gqrvHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 30/50] drm/vmwgfx: install the out-fence
 descriptor when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-alpha@vger.kernel.org, linux-gpio@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, virtualization@lists.linux.dev, linux-csky@vger.kernel.org, io-uring@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-sh@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-30-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:09:04 +0000
Message-Id: <20260915120904.95C511F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D30


