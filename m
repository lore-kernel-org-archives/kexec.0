Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C850EC982C4
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=; b=GnnQMCFbfjBAY6zb+tV0Qui8oV
	ECpbzlz1ulFWf0MY9ef50nHvU6WuUr1xLs8olVoVxYXjPlAczXiYWpolCABchMqQsGQlpCJF4WdPT
	HglMKpXO2Y/5NB83M1TD2cpBXTUk40gyU15K52f+Fk6GSIzWBUbM/frS6H1ydLZ1c/N+VJjY9ZX8D
	7mESSzOQoilyKf9niZ8tK65o8WBvvgRE+U1MGxbJ+DyS/YjxxUIm92s4lKc3FUsdfcbOannjC3wRG
	rrWxoyMB0dn5dzK+fT/O8foZwLTS4NS0StjseBpMEQmv0MUw7K1C+9uQbSnD3hY5954/XErUVO58o
	8FMns6CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3u-00000006RCd-3oIJ;
	Tue, 15 Sep 2026 12:14:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3t-00000006RBY-2XH9;
	Tue, 15 Sep 2026 12:14:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57C3740450;
	Tue, 15 Sep 2026 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398E91F000FF;
	Tue, 15 Sep 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474497;
	bh=ejtHf7OrVCONiSGbsU0Szkqhw/V3NKRKJBvDExa4qrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQ3aDU0Q8GsPtoMGWFzUtgXPVhQk5j3tT2hP5/IYPK7pNnGp/W35LdJkurCxq/UDj
	 jXECYSMyRfHDZKzN98Ln98DAG1rH6aAR4ISmzyGlU1rsDvw5Q93DNzrkBW2qSN7IRC
	 YJr9cCfLCK65yz/lnkKU0h/88SazD0WGxzlXFRwUnZmmA1pIC11CPHPte6Jw/NVEZ8
	 jp0yJWYB7+6Cgap52rqfdYHOC0u+j0XckjkUTQa+uZ9aKsrGomUpcl6BdIHpYiyzm/
	 Rqj2wKLDgmWRUAKCkxgoX9x9LTH43+wakiVHy5v4VFxVPQvMYbRVfHWWmjs+K15B5a
	 6EBFBzK+SsdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 34/50] sctp: install the peeloff descriptor when
 the syscall returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, "Eugenio
 Perez" <eperezma@redhat.com>, io-uring@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-parisc@vger.kernel.org, virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-openrisc@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-34-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:54 +0000
Message-Id: <20260915121455.398E91F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D34


