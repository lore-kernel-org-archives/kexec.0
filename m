Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F836C982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=; b=A2U8JWazBW5lUDHHjbTGugStTk
	3BfI0kVztOgMyKZYipelLoMOiVRCOAD8Bd2DjgUotRiEd/AOvVPhHdRTk/CXBjSNGZMW0LS3+xIqg
	LC76OyADshtmuTvRoSYC78v+Fvk5KqoAkf7L5AeqsgH0yRO/cm/6KibjbiF/Tk4Xlj/oCgSoOuzI3
	OUxOHnMR4aBbDp00SvPANh0gK1n9LptAGVpjauLH/CkOKcqrrLW5gKavI7R5rDVrIboiNsO+CRleI
	aSSZ9gQ71HMnrCvA8OqVZyxHXwd07T+neR19YyUWJ6RwNupNkMei4gIXa8ZGcBuFsNLVrArTnXV8R
	jH/y3H3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S8Y-00000006SqG-0Pdf;
	Tue, 15 Sep 2026 12:19:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S8W-00000006Sps-2MSF;
	Tue, 15 Sep 2026 12:19:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5176C4069F;
	Tue, 15 Sep 2026 12:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B431F00893;
	Tue, 15 Sep 2026 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474784;
	bh=s+9PDH0CZ1Vr08YyoCof+UTThGpQ93yPbrI7mSCf5jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0z6lytA0Lb7PeCTJJ9wan77NmP+WaqiiLFqlwKeXKPuaHqeXDGZgjSEE5Nqy5ZTD
	 uXplubyhODu8Q/NNq14/kXJbT/9AFQwToWT9BIY9E7L4zCHdhq4qOYWiAgbLHBLAxF
	 XtT+b1kvKyB39r1HyAihRAZd/uoRrMfxf0YZCrLmFzS7pKcK/CRl1fiGl+0H5LKWhV
	 PlUaIzcMF+cm9TI4V6HSienMOrDlPf4JHELixv0sjOAXsqO+TJlLMDqNaOXk1sfBNv
	 cjEFW+zAMBlSevojGz84ZSkbXhlbmUkgsft9l8Pqsgamb08/hqshJfCjYTrtd+Gp+Z
	 XZIjfnkZC6SUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 50/50] Drivers: hv: mshv: stop putting
 descriptors back on failure
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-hexagon@vger.kernel.org, sparclinux@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, virtualization@lists.linux.dev, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Oleg Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org, "Jens
 Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-50-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:19:41 +0000
Message-Id: <20260915121942.11B431F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D50


