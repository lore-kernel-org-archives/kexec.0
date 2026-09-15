Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2825C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=; b=UnXUMqxDSG/Q9RhQNjosEO0Kre
	8y3EDJe8QfDsSYxDL5MkTJJH6Dtq9itDMTPCfZFfCJaKfy/VsYT9QSGLj9d2PbC9dJKpribfdlp+2
	9iJm0K4xezNnCP2KaK0IOCp2//A6Uiq9cmLw3n17Hvp6+WGK7sROn+vERKl3SZCzMkUXzcZGMFsX6
	zddP4I3dvtPU/ZlmEJZgeuuhFPyb4VAm3CtIbt0/zZX4xB4GKVkoFiFrj8cMYYGxADnLSiXMjfmsO
	S+jaeEA3l3Lh2GJxuRoiyOjt4DBTg3Ho6kF+PCEvVZ3CAveI3viEjc3Y4l/3aj+LzdPbvCZqVTkYX
	NyrS4igw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rrk-00000006Mf7-3S5M;
	Tue, 15 Sep 2026 12:02:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rri-00000006Mdi-1P7e;
	Tue, 15 Sep 2026 12:02:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 196F94141B;
	Tue, 15 Sep 2026 12:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2CE1F000FF;
	Tue, 15 Sep 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473742;
	bh=qcYOVYEeSBwNAHSV3oGOxIoOYP16KGnVjnu+hbqVsEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/BEG6N0RGxUq5W/HXCadDNiWy6mZwl9CV9CowG89trZuBhbvX/vWsAwHcKt0jPgW
	 SJ2ml9rORw02KpW+BBtA/RAwgHeaOMkDEM/bw2FOM3cvOGpK4o5aTZomhO8RUcQ5S/
	 HUGzy85d+v2Rl885i1mtVPRNCYfGq7VMLkzir6Qo74z8OfaWUxRKM2kqLaxvoO35hD
	 g2OjURXxrNOf5LxE5EULxkvtM4dwb4/ru0HDhvJo0tuYkl76FUzGi2h5pCD/fdlSaR
	 IpwMuTLI+Jg1YfgtVCyH+xGpSt50Q2kgFNlZVyEcwXh9ZMIlgJii4H6dAqtEZuqtWP
	 6++8DIfAg5DTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 20/50] file: warn when the descriptor table is
 unshared with slots
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jan Kara" <jack@suse.cz>, "Jens
 Axboe" <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, kexec@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, virtualization@lists.linux.dev, linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-20-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:02:19 +0000
Message-Id: <20260915120220.2B2CE1F000FF@smtp.kernel.org>
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

> If the fdtable is unshared or the task exits we can't install
> reservations. The reserved fd isn't reserved anymore. execve() would
> leak the reservation into the child.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D20


