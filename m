Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB86C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=; b=Y5zb9lubkHBKYsKQK2I8+OEfhd
	rubx9S2blqVvc0O2L2Ze7xFENsZJ/SjKnYgu3VpG/KPnc5FUradFGSBFwQduOMxzXGP/NevUNEFgt
	OF83khJNL7LA0CswM84MuBkA7El70JhwS53WZHoYF3+DRQe3jEcZWz1MFyLSRlrd8HRFwJTMWD8aU
	5UnU2xRmDKYr00T9KIZoOBJPIux10R2BTm8vc3W1zFk789joNBN2D7NmFsPeHz42A+8NL7ouCt9Ax
	X8gP5OhcGgvtYSfFbCViBKJ0D2IGLukOhGuiBcpf8Y+vqcfwRtaHnTStM/gjhnzdtc00v8YLaU9MN
	rEHh8KRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S6c-00000006SFl-2teP;
	Tue, 15 Sep 2026 12:17:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S6b-00000006SFR-0ZYZ;
	Tue, 15 Sep 2026 12:17:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D8E1F43247;
	Tue, 15 Sep 2026 12:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00241F00898;
	Tue, 15 Sep 2026 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474664;
	bh=DwzX8JNIUuVMxDXzFkUeKbOg0dKKxVjarPGggP7ls3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+YTN+mc0FREo7pxVue32qEB7jpbaic9tPuOqusrLGz+h61wQ9mk1jbsp4T4uum+o
	 PyFcrywxhBL6lkrZRNcnpslokzefZeAzR3ILqmBsMGWMqYv8jIXs9vvVcxYbK2/0GC
	 eaxftvggM2rbYvLpD33hv5D2hCTVmB4HxTZAux7lFOj7n37ELzTfsQdzy7w4+7zax2
	 OOhtkPuMszdn+0PFv34fTrYHBBJ5CYYMe8NNjn6CDmjHaFQhZDHc4EM+U9KZ+/UGbq
	 UKCjWQKVffzLeaWI/mu8BEh57NXEGpdr4xo0iEchfSB7vEOpEOZ5gcwVOziN4Vzm0b
	 J0urwnVYa8Mjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 42/50] drm: stop unwinding descriptors by hand
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, linux-openrisc@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>, linux-csky@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-alpha@vger.kernel.org, kexec@lists.infradead.org, kvm@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, "Jann
 Horn" <jannh@google.com>, linux-m68k@lists.linux-m68k.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-hyperv@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-42-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:17:42 +0000
Message-Id: <20260915121742.F00241F00898@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D42


